call OPFL_Client_ReplaceSurrogateBP;
[] call OPFL_Parameters;
[] call OPFL_Client_PaintEndZones;
_null = [] call GSC_CreateHotZones;

//variables for both server and client
OPFL_CLOCK_START = !PCS_RNK_ON; //true
OPFL_BPE_POS = (getMarkerPos "BATTLE_POSITION_EAST");
OPFL_BPW_POS = (getMarkerPos "BATTLE_POSITION_WEST");
OPFL_WB = false;
OPFL_EB = false;

if (isServer) then
{
	//global server variables
	if (OPFL_ROUND_MODE) then
	{
		UNITIME = "ROUND MODE";
		OPFL_AMERICAN_TICKETS = "RM";
		OPFL_RUSSIAN_TICKETS = "RM";
		publicVariable "OPFL_AMERICAN_TICKETS";
		publicVariable "OPFL_RUSSIAN_TICKETS";
	}
	else
	{
		UNITIME = 0;
		OPFL_AMERICAN_TICKETS = OPFL_STARTING_TICKETS;
		OPFL_RUSSIAN_TICKETS = OPFL_STARTING_TICKETS;
		publicVariable "OPFL_AMERICAN_TICKETS";
		publicVariable "OPFL_RUSSIAN_TICKETS";
	};
	OPFL_MATCH_START_TIME = diag_tickTime;
	OPFL_ADVANCE_TIMERS = [0,0];
	OPFL_ACTIVE_GROUPS = [];
	OPFL_TICKET_QUEUE = [];
	OPFL_FLAG_ZONE_LIST = [];
	OPFL_RP_LIST = [];
	OPFL_FLAG_ZONE_QUEUE = []; //add to this array to queue a state change
	ZONES_PER_SIDE = 1;
	
	PCS_ON_DISCONNECTED_FNC_LIST set [(count PCS_ON_DISCONNECTED_FNC_LIST), OPFL_GroupDisconnect]; //disconnection handlers
	call OPFL_GroupManagerThread;
	
	//initialization scripts (order is sorta important here, not really, just like it this way lols)
	_null = [] spawn OPFL_Server_TicketClockThread;
	_null = [] execVM "ADVANCE_THE_FLAG\InitFlagZones.sqf";
	
	//respawn ticket usage will use its own event handler, unlike the public code system, for maximum net efficiency
	"OPFL_DEATH" addPublicVariableEventHandler 
	{
		if (_this select 1) then
		{
			OPFL_TICKET_QUEUE set [(count OPFL_TICKET_QUEUE), [west, false]];
		}
		else
		{ 
			OPFL_TICKET_QUEUE set [(count OPFL_TICKET_QUEUE), [east, false]];
		};
		
		{
			if((!isPlayer _x) && isNil {_x getVariable "OPFL_CIP"}) then
			{
				_x setVariable ["OPFL_CIP", true];
				_null = [_x] spawn OPFL_Server_CleanBody;
			};
			diag_log format ["%1", _x];	
		} foreach allDeadMen;
	};
	
	/*
	"TESTER" addPublicVariableEventHandler 
	{
		diag_log format ["%1", !isNull (_this select 1)];
	};
	*/
};

if (!isDedicated) then
{
	[] call OPFL_Client_SafeZoneProtection;
	//client trackers
	//_null = [[player, playerSide, (getPlayerUID player)], "OPFL_Server_InitTicketMsg", PCS_S_SERVER] spawn PCS_MPCodeBroadcast;
	
	player createDiaryRecord ["Diary", ["HOW TO PLAY", "OPFL is fairly simple.<br/>Everytime you respawn you lose a ticket.<br/>As you redeploy your flags closer to the enemy base, you gain tickets faster.<br/>The team with the most tickets by the end of the time limit wins.<br/>You cannot deploy your flag past an enemies flag, and you must capture their flags zone to send it back to their base.<br/>Get weapon kits from the ammo crate.<br/>The squad leader kit lets you build things and see all the friendly player positions on the map.<br/>The engineer kit lets you build things and repair vehicles.<br/>The medic kit lets you heal friends.<br/>HAVE FUN!"]];
	
	//global client variables
	OPFL_RP_READY = true;
	OPFL_LAST_RP_TIME = diag_tickTime;
	OPFL_RP_ANIM = 0;
	OPFL_PLAYER_PACKED_ZONE = [];
	OPFL_SCREEN_HINT_TEXT = "";
	OPFL_CHICKENS = 0;
	OPFL_LAST_TARGET = objNull;
	OPFL_FRIEND_BALL = "Sign_Sphere25cm_F" createVehicleLocal [0,0,0];
	OPFL_FRIEND_BALL setObjectTexture [0, "#(rgb,8,8,3)color(0,1,0,0.3)"];
	OPFL_FRIEND_BALL hideObject true;
	OPFL_FRIEND_BALL disableCollisionWith player;
	
	//public variable synchronization, so variables that are used by the clients and their functions are not nil
	UNIVERSAL_MESSAGE = "none";
	waitUntil {!isNil "UNITIME"};
	waitUntil {!isNil "OPFL_AMERICAN_TICKETS"};
	waitUntil {!isNil "OPFL_RUSSIAN_TICKETS"};
	waitUntil {!isNil "OPFL_ADVANCE_TIMERS"};
	waitUntil {(!isNil "OPFL_FLAG_ZONE_LIST") && (!isNil "OPFL_ALL_FLAGS_CREATED")};
	{
		waitUntil {!isNil {_x getVariable "FLAG_ZONE_NAME"}};
		waitUntil {!isNil {_x getVariable "FLAG_ZONE_SIDE"}};
		waitUntil {!isNil {_x getVariable "FLAG_ZONE_PLANTED"}};
		waitUntil {!isNil {_x getVariable "FLAG_ZONE_STATE"}};
		waitUntil {!isNil {_x getVariable "FLAG_ZONE_CARRIER_UNIT"}};
		waitUntil {!isNil {_x getVariable "FLAG_ZONE_READY"}};
		if (playerSide == (_x getVariable "FLAG_ZONE_SIDE")) then
		{
			OPFL_F_FLAG = _x;
		}
		else
		{
			OPFL_E_FLAG = _x;
		};
	} foreach OPFL_FLAG_ZONE_LIST;
	
	"OPFL_ADVANCE_TIMERS" addPublicVariableEventHandler
	{
		private ["_exit"];
		_exit = false;
		if (((_this select 1) select 0) == OPFL_DEPLOY_READY_TIME) then
		{
			if (!OPFL_WB) then
			{
				playSound "VoteRP";
				OPFL_WB = true;
				_exit = true;
			};
		}
		else
		{
			OPFL_WB = false;
		};
		if (((_this select 1) select 1) == OPFL_DEPLOY_READY_TIME) then
		{
			if (!OPFL_EB) then
			{
				if (!_exit) then
				{
					playSound "VoteRP";
				};
				OPFL_EB = true;
			};
		}
		else
		{
			OPFL_EB = false;
		};
		
	};
	
	
	if (!isNil "RTMS_SendRequest") then
	{
		[(call OPFL_RP_Object) call RTMS_CreateMenuObject, true] call RTMS_SendRequest;
		[(call OPFL_DeployRP_object) call RTMS_CreateMenuObject, true] call RTMS_SendRequest;
	};
	
	
	[PCS_UNIQUE, "OPFL_RequestAllRP", PCS_S_SERVER, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
	
	{
		[_x] call OPFL_Client_CreateVirtualFlag;
		_null = [_x] execVM 'ADVANCE_THE_FLAG\CLIENT_ZONE_SYSTEM\PickUpAction.sqf';
	} foreach OPFL_FLAG_ZONE_LIST;
	
	OPFL_WEST_FOB hideObject true; //hide the fob flags
	OPFL_EAST_FOB hideObject true;
	
	//respawn for carrier ships
	if (OPFL_CARRIER_RSPN_ENABLED) then
	{
		switch (playerSide) do
		{
			case west:
			{
				player addEventHandler ["Respawn", {(_this select 0) setPosATL ([(getMarkerPos "respawn_west")] call GSC_HighestSurface);}];
				player setPosATL ([(getMarkerPos "respawn_west")] call GSC_HighestSurface);
			};
			
			case east:
			{
				player addEventHandler ["Respawn", {(_this select 0) setPosATL ([(getMarkerPos "respawn_east")] call GSC_HighestSurface);}];
				player setPosATL ([(getMarkerPos "respawn_east")] call GSC_HighestSurface);
			};
		
		};
	};
	
	//stateless features and displays
	//player createDiaryRecord ["Diary", ["HOW TO PLAY", "OPFL is fairly simple.<br/>Everytime you respawn you lose a ticket.<br/>As you redeploy your flags closer to the enemy base, you gain tickets faster.<br/>The team with the most tickets by the end of the time limit wins.<br/>You cannot deploy your flag past an enemies flag, and you must capture their flags zone to send it back to their base.<br/> You must also locate their flag zone by using their randomized marker and flag line, once you begin to capture it, it will finally show up on the map.<br/>Get weapon kits from the ammo crate.<br/>The squad leader kit lets you build things and see all the friendly player positions on the map.<br/>The engineer kit lets you build things and repair vehicles.<br/>The medic kit lets you heal friends.<br/>HAVE FUN!"]];
	HUD_STATIC_FUNCTIONS_LIST set [(count HUD_STATIC_FUNCTIONS_LIST), [[], OPFL_Client_WestTicketHUD]];
	HUD_STATIC_FUNCTIONS_LIST set [(count HUD_STATIC_FUNCTIONS_LIST), [[], OPFL_Client_EastTicketHUD]];
	HUD_STATIC_FUNCTIONS_LIST set [(count HUD_STATIC_FUNCTIONS_LIST), [[], OPFL_Client_ClockHUD]];
	HUD_STATIC_FUNCTIONS_LIST set [(count HUD_STATIC_FUNCTIONS_LIST), [[], OPFL_Client_ScreenHintHUD]];
	HUD_STATIC_FUNCTIONS_LIST set [(count HUD_STATIC_FUNCTIONS_LIST), [[], OPFL_Client_RPHUD]];
	HUD_STATIC_FUNCTIONS_LIST set [(count HUD_STATIC_FUNCTIONS_LIST), [[], OPFL_Client_RPStateHUD]];
	HUD_STATIC_FUNCTIONS_LIST set [(count HUD_STATIC_FUNCTIONS_LIST), [[], OPFL_Client_WestTimerHUD]];
	HUD_STATIC_FUNCTIONS_LIST set [(count HUD_STATIC_FUNCTIONS_LIST), [[], OPFL_Client_EastTimerHUD]];
	HUD_STATIC_FUNCTIONS_LIST set [(count HUD_STATIC_FUNCTIONS_LIST), [[], OPFL_Client_ChickenHUD]];
	HUD_STATIC_FUNCTIONS_LIST set [(count HUD_STATIC_FUNCTIONS_LIST), [[], OPFL_Client_WaitingForPlayersHUD]];
	HUD_DISPLAY_FUNCTIONS_LIST set [(count HUD_DISPLAY_FUNCTIONS_LIST), [[], OPFL_Client_FriendlyNamesHUD]];
	HUD_DISPLAY_FUNCTIONS_LIST set [(count HUD_DISPLAY_FUNCTIONS_LIST), [[], OPFL_Client_FriendlyRanksHUD]];
	_null = [] spawn 
	{
		disableSerialization; 
		((uiNamespace getVariable "HUD_UI_DISPLAY") displayCtrl 23522) ctrlSetText getText (configfile >> "CfgRanks" >> (format ["%1", (PCS_RNK_ALL_STATS select 1) - 1]) >> "texture");
		((uiNamespace getVariable "HUD_UI_DISPLAY") displayCtrl 23523) ctrlSetText getText (configfile >> "CfgRanks" >> (format ["%1", (PCS_RNK_ALL_STATS select 1) - 1]) >> "rank");
	};
	_null = addMissionEventHandler ["EachFrame", {
		if ([player] call GSC_InSafeZone) then
		{
			if (!isNil {uiNamespace getVariable "OPFL_SPAWN_ICONS"}) then 
			{
				{
					drawIcon3D ["", [1,1,1,1], (uiNamespace getVariable _x) select 1, 0.25, 0.25, 0, (uiNamespace getVariable _x) select 0, 2, 0.04, "PuristaMedium"];
				} foreach (uiNamespace getVariable "OPFL_SPAWN_ICONS");
			};
		};
	}];
	
	_null = [] spawn OPFL_Client_OPFLWelcomeMessage;
	_null = [] spawn PCS_UniversalMessages;
	_null = [] spawn OPFL_Client_PositionMarker;
	//_null = [] spawn OPFL_Client_GroupPositionMarkers;
	//_null = [] spawn OPFL_Client_TeamKillingEH;
	[[], OPFL_Client_RestoreRank] call PCS_AddPerFrameEvent;
	if (OPFL_CARRIER_VLOCK) then {[[], OPFL_Client_CarrierVehicleLock] call PCS_AddPerFrameEvent;};
	_null = [] spawn OPFL_Client_FallBackMarkers;
	_null = [] spawn OPFL_Client_SafeZoneKill;
	//_null = [] spawn OPFL_Client_ScriptSpeedDetector;

	//flag actions on player, tell server to reduce sides tickets by 1
	_null = player addEventHandler ["Respawn", {
		player setPosATL (OPFL_RESPAWN_OBJ buildingPos (floor random 3));
		player setVariable ["OPFL_PLAYER_RANK", format ["%1", (PCS_RNK_ALL_STATS select 1) - 1], true]; //these need to be on every player!
		//[_this select 0] call OPFL_Client_AddFlagActions;
		
		//collisions to disable
		OPFL_FRIEND_BALL disableCollisionWith player;
		if (!isNil "OPFL_LOCAL_RP_LIST") then
		{
			{
				player disableCollisionWith (_x select 4);
			} foreach OPFL_LOCAL_RP_LIST;
		};
		
		if (!isNil "OPFL_GROUP_MANAGER_ACTION") then
		{
			(OPFL_GROUP_MANAGER_ACTION select 1) removeAction (OPFL_GROUP_MANAGER_ACTION select 0);
			call OPFL_AddGroupAction;
		};
		
		if (!isNil "OPFL_RP_ACTION") then
		{
			(OPFL_RP_ACTION select 1) removeAction (OPFL_RP_ACTION select 0);
			call OPFL_Client_AddRPAction;
		};
		
		if (!isNil "OPFL_LOCK_ACTION") then
		{
			(OPFL_LOCK_ACTION select 1) removeAction (OPFL_LOCK_ACTION select 0);
			call OPFL_Client_AddLockAction;
		};
		
		if (!isNil "OPFL_UNLOCK_ACTION") then
		{
			(OPFL_UNLOCK_ACTION select 1) removeAction (OPFL_UNLOCK_ACTION select 0);
			call OPFL_Client_AddUnlockAction;
		};
		
		if (!isNil "OPFL_KICKPLAYERS_ACTION") then
		{
			(OPFL_KICKPLAYERS_ACTION select 1) removeAction (OPFL_KICKPLAYERS_ACTION select 0);
			call OPFL_Client_AddKickPlayersAction;
		};
		
		if (!isNil "OPFL_FLIP_ACTION") then
		{
			(OPFL_FLIP_ACTION select 1) removeAction (OPFL_FLIP_ACTION select 0);
			call OPFL_Client_AddFlipAction;
		};
		
		if (!isNil "OPFL_AIR_DEPLOYMENT_ACTION") then
		{
			(OPFL_AIR_DEPLOYMENT_ACTION select 1) removeAction (OPFL_AIR_DEPLOYMENT_ACTION select 0);
			call OPFL_Client_AddAirDeploymentAction;
		};
		
		if (!isServer) then
		{
			//hint format ["%1", rating player];
			//uses its own pipe because it needs to be fast
			OPFL_DEATH = (playerSide == west); publicVariableServer "OPFL_DEATH";
			
			//TESTER = "FlagSmall_F" createVehicle [0,0,0]; publicVariableServer "TESTER";
		}
		else
		{
			if ((playerSide == west)) then
			{
				OPFL_TICKET_QUEUE set [(count OPFL_TICKET_QUEUE), [west, false]];
			}
			else
			{ 
				OPFL_TICKET_QUEUE set [(count OPFL_TICKET_QUEUE), [east, false]];
			};
		
			(_this select 1) setVariable ["OPFL_CIP", true];
			_null = [_this select 1] spawn OPFL_Server_CleanBody;		
		
		};
		
	}];
	player setVariable ["OPFL_PLAYER_RANK", format ["%1", (PCS_RNK_ALL_STATS select 1) - 1], true]; //these need to be on every player!
	//[[], "OPFL_Client_AddFlagActionsPlayer"] call PCS_SpawnAtomic;
	//call OPFL_AddGroupAction;
	//call OPFL_Client_AddRPAction;
	//call OPFL_Client_AddLockAction;
	//call OPFL_Client_AddUnlockAction;
	//call OPFL_Client_AddKickPlayersAction;
	[[], "OPFL_Client_AddStickyActions"] call PCS_SpawnAtomic;
	
	//HUD for flags
	private "_flagid";
	_flagid = 23600; //start of flag HUD id's
	
	{
		if (playerSide == (_x getVariable "FLAG_ZONE_SIDE")) then
		{
			HUD_DISPLAY_FUNCTIONS_LIST set [(count HUD_DISPLAY_FUNCTIONS_LIST), [[_x, _flagid], OPFL_Client_FlagHUD]];
			_flagid = _flagid + 1;
		};
	} foreach OPFL_FLAG_ZONE_LIST;
	
	//music and sounds

	_null = addMusicEventHandler ["MusicStart", {if ((_this select 0) != "FlagBeep") then {OPFL_MUSIC_IN_USE = true;};}]; //so flag beep is interruptable
	_null = addMusicEventHandler ["MusicStop", {if ((_this select 0) != "FlagBeep") then {OPFL_MUSIC_IN_USE = nil;};}];
	//playSound "MissionIntroMusic";
	/**
	_null = [] spawn
	{
		sleep 10;
		_temp = [];
		{
			if ((_x getVariable "FLAG_ZONE_SIDE") == west) then {
			_logica = [RTMS_OBJECTS_LIST select 0] call RTMS_CopyMenuObject;
			_logica setVariable ["CLASS_NAME", (_x getVariable "FLAG_ZONE_VIRTUAL")];
			_logica setVariable ["CLASS_DISTANCE", 20];
			player sideChat format ["HIDDEN: %1", isObjectHidden _x];
			_temp pushBack _logica;
			};
		} foreach OPFL_FLAG_ZONE_LIST;
		_logicb = [_temp select 0] call RTMS_CopyMenuObject;
		_logicb setVariable ["CLASS_NAME", typeOf (_logicb getVariable "CLASS_NAME")];
		_logicb setVariable ["CLASS_DISTANCE", 20];
		[(_temp select 0), true] call RTMS_SendRequest;
		[_logicb, true] call RTMS_SendRequest;
	};
	**/
};