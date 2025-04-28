[] call PKS_Parameters;

if (isServer) then
{
	PKS_SERVER_KIT_QUEUE = [];
	
	PKS_KIT_TABLE = "Flag_Altis_F" createVehicle [0,0,-500]; //MP table (logic wont work for some reason)
	PKS_KIT_TABLE allowDamage false;
	publicVariable "PKS_KIT_TABLE";
	//PKS_KIT_TABLE = "Logic" createVehicleLocal [0,0,0];
	
	//onPlayerDisconnected "PKS_SERVER_KIT_QUEUE set [(count PKS_SERVER_KIT_QUEUE), [[PKS_KIT_TABLE, format['%1', _uid]], 2]]; {if (_uid == getPlayerUID _x) then {'uid still exist' createVehicleLocal [0,0,0];};} foreach playableUnits;";
	PCS_ON_DISCONNECTED_FNC_LIST set [(count PCS_ON_DISCONNECTED_FNC_LIST), PKS_AttemptDisconnectKit];
	
	_null = [] spawn PKS_ServerKitThread;
};

if (!isDedicated) then
{
	_null = ["PlayerKitRefill", "PLAYER_KIT_REFILL"] call GSC_CreateSound;
	//globals for client
	uiNamespace setVariable ["PKS_AHL", []];
	
	PKS_BUILD_ROOF_FINDER = "Logic" createVehicleLocal [0,0,0];
	PKS_BUILDING_MENU_QUEUE = [];
	PKS_BUILD_ARGUMENTS = [];
	PKS_BUILD_HUD_TEXT = "";
	PKS_PROGRESS_BAR = 0;
	PKS_PROGRESS_BAR_RESET = false;
	PKS_PLAYER_IS_BUSY = false;
	PKS_AVAILABLE_KITS = [];
	PKS_KIT_SET = ["", 0, 0];
	PKS_SW_SCRIPTS = [];
	PKS_NEED_REFILL = false;
	PKS_ESSENTIALS =
	[
		"ItemMap",
		"ItemCompass",
		"ItemWatch",
		"ItemRadio"
	];
	
	//public variables from server
	waitUntil {!isNil "PKS_KIT_TABLE"};
	player sideChat "PLAYER KITS: Kit table found.";
	
	//load client kit data
	[] call PKS_ProcessKits;
	player sideChat "PLAYER KITS: Processed kits";
	 HUD_STATIC_FUNCTIONS_LIST set [(count HUD_STATIC_FUNCTIONS_LIST), [[], PKS_ClientBS_BuildHUD]];
	_null = [] spawn PKS_ClientBS_BuildTimeClock;
	_null = [] spawn PKS_ClientBS_BuildVisualizer;
	
	private "_kit";
	_kit = "none";

	if (playerSide == west) then
	{
		//_null = [[player, (getPlayerUID player), PKS_WEST_KIT_CRATE], "_null = _this spawn PKS_AttachKit;", PCS_S_SERVER] spawn PCS_MPCodeBroadcast;
		_kit = "WestDefaultKit";
	};
	if (playerSide == east) then
	{
		//_null = [[player, (getPlayerUID player), PKS_EAST_KIT_CRATE], "_null = _this spawn PKS_AttachKit;", PCS_S_SERVER] spawn PCS_MPCodeBroadcast;
		_kit = "EastDefaultKit";
	};
	PLAYER_KIT = _kit;
	PKS_CLIENT_KIT_QUEUE = [[[player, _kit], 1]];
	
	/*
	_null = player addEventHandler ["Killed", {
		call PKS_ClientBS_ClearBuildingActions;
	}];
	*/
	_null = player addEventHandler ["Respawn", {
		PKS_CLIENT_KIT_QUEUE set [(count PKS_CLIENT_KIT_QUEUE), [[_this select 0], 1]];
	}];
	PKS_CLIENT_KIT_QUEUE set [(count PKS_CLIENT_KIT_QUEUE), [[player], 1]];
	
	
	_null = [] spawn PKS_ClientKitThread;
	waitUntil {!isNil "PLAYER_KIT"};
};

[] call PKS_LoadKits;
player sideChat "PLAYER KITS: All kits loaded";

if (!isDedicated) then
{
	{
		waitUntil {!isNil {PKS_KIT_TABLE getVariable ((_x call PKS_GetKitData) select 6)}};
	} foreach PKS_AVAILABLE_KITS;
	player sideChat "PLAYER KITS: PKS fully initialized";
	PKS_INITIALIZED = true;
	
	_null = createDialog "PKSGUI";
};
waitUntil {!isNull (findDisplay 46)};
_null = (findDisplay 46) displayAddEventHandler["KeyDown","call PKS_InterruptAllAnimations;"];