private ["_keyA", "_keyB"];
if (isServer) then
{
	_keyA = (8 + floor random 9) call GSC_CreateRandomKey;
	_keyA = _keyA call GSC_MapKeyToVarName;
	
	_keyB = (8 + floor random 9) call GSC_CreateRandomKey;
	_keyB = _keyB call GSC_MapKeyToVarName;
	
	[_keyA, _keyB] call PCS_HardKeyCompileList;
	
	_null = [] spawn (compileFinal 								(
																[
																	"KEY_B",
																	_keyB,
																	(["KEY_A", _keyA, preProcessFile "PUBLIC_CODE_SYSTEM\KREH.sqf"] call GSC_FindReplaceString)
																] 
																call GSC_FindReplaceString
																)
																);
};
TEST_OWNED_OBJECT = objNull;
enableSaving false;

[] call PCS_Parameters;

if (isNil "PCS_INITIALIZED") then
{
	uiNamespace setVariable ["PCS_FNC_TABLE", "Logic" createVehicleLocal [0,0,0]];
	PCS_ID_TABLE = "Logic" createVehicleLocal [0,0,0];
	PCS_CPQ = [];
	PCS_PER_FRAME_EVENTS = [];
	PCS_PENDING_CLIENTS = [];
	PCS_NEXT_FNC_ID = 0;
	PCS_PLAYER_EXISTS = false;
	PCS_FREE_FRAME_EVENTS = true; //incase compile final in array locks their memory offset in player exists event
	PCS_PEH_READY = false;
	PCS_PEHA_READY = false;
	PCS_PEHKREH_READY = false;
	PCS_CLIENT_IDS = [1]; //byte array
	PCS_CLIENT_IDS_INDEX = 0;
	PCS_SP = [1, 0] select (isMultiplayer);
	PCS_STARTING_LIMITING_PLAYERS = (playersNumber west) min (playersNumber east);
	PCS_LAST_AIR_DEPLOYMENT = objNull;
	
	PCS_UNIQUE = "";
	PCS_S_ALL = ["ALL"];
	PCS_S_CLIENT = ["CLIENT"];
	PCS_S_SERVER = ["SERVER"];
	
	//high performance states
	PCS_IN_VEHICLE = false;
	PCS_TOTAL_DEAD_MEN = 0;
	PCS_TOTAL_PLAYERS = 0;
	PCS_CAMERA_TOP = [0,0,1];
	PCS_CAMERA_CENTER = [0,0,0];
	
	//RNK configuration
	PCS_RNK_RULES_TIMEOUT = 105;
	PCS_RNK_WFP_DT_MULTIPLIER = 5;
	_PCS_RNK_PLAYER_MIN = 5;
	PCS_RNK_PLAYER_THRESHOLD = _PCS_RNK_PLAYER_MIN + 2;
	PCS_SHOP_ABAN_TIME = 240;

	if (isServer) then
	{
		//RNK initial states
		PCS_RNK_ON = (PCS_STARTING_LIMITING_PLAYERS >= _PCS_RNK_PLAYER_MIN);
		publicVariable "PCS_RNK_ON";
	};
	
	uiNamespace setVariable ["PCS_SHOP_VEHICLES_LIST_W", 
		[
			["O_APC_Wheeled_02_rcws_F", 1/20, 0, "MSE-3 Marid", 50, 120, "The Camel", "Gets you from A to B."],
			["O_APC_Tracked_02_cannon_F", 1/20, 0, "BTR-K Kamysh", 80, 120, "Glory", "A single squad and Glory defeated an entire company."],
			["B_APC_Wheeled_01_cannon_F", 1/20, 0, "AMV-7 Marshall", 50, 120, "The Frog", "On land or water, The Frog is always reliable."],
			["B_APC_Tracked_01_rcws_F", 1/20, 0, "IFV-6c Panther", 50, 120, "The Stallion", "A true work horse."],
			["B_APC_Tracked_01_CRV_F", 1/20, 0, "CRV-6e Bobcat", 20, 120, "The Alpaca", "All terrain, anywhere anytime."],
			["I_APC_tracked_03_cannon_F", 1/20, 0, "FV-720 Mora", 30, 120, "Shit Box", "Truly box like, and its got an autocannon."],
			["I_APC_Wheeled_03_cannon_F", 1/20, 0, "AFV-4 Gorgon", 80, 300, "Gorgon", "Like Glory, but on wheels."],
			["O_APC_Tracked_02_AA_F", 1/21, 1, "ZSU-39 Tigris", 80, 300, "Tiger", "Light weight and can shoot down aircraft."],
			["B_APC_Tracked_01_AA_F", 1/21, 1, " IFV-6a Cheetah", 100, 300, "Cheetah", "Slow but armored, remarkably paradoxical for its name."],
			["O_MBT_02_arty_F", 1/21, 1, "2S9 Sochor", 900, 600, "Henry Jr.", "Light weight piece of mobile artillery."],
			["B_MBT_01_arty_F", 1/21, 1, "M4 Scorcher", 900, 600, "Sir Henry", "Artillery in its most royal form."],
			["B_MBT_01_mlrs_F", 1/21, 1, "M5 Sandstorm MLRS", 1300, 600, "MLRS", "Huge Missile Penetration."],
			["B_MBT_01_TUSK_F", 1/21, 2, "Slammer Up", 100, 300, "Fury", "A main battle tank that can play rope-a-dope."],
			["I_MBT_03_cannon_F", 1/21, 2, "MBT-52 Kuma", 100, 300, "Death Box", "Death in a box, perhaps a pun?"],
			["B_Heli_Transport_01_F", 1/29, 3, "UH-80 Ghost Hawk", 100, 180, "Big Bird", "She is a big ole bird."],
			["O_Heli_Light_02_F", 1/28, 3, "PO-30 Orca", 200, 180, "Seagull", "A truly dirty bird."],
			["I_Heli_light_03_F", 1/28, 3, "WY-55 Hellcat", 300, 180, "Hellcat", "Wait, cats can fly?"],
			["O_Heli_Attack_02_black_F", 1/31, 3, "Mi-48 Kajman", 650, 600, "Big Brave", "A sturdy attack helicopter loaded with missiles."],
			["B_Heli_Attack_01_F", 1/28, 3, "AH-99 Blackfoot", 1000, 600, "The Black Raven", "An attack helicopter that hits from range."],
			["C_Plane_Civil_01_F", 1/22, 4, "Caesar BTT", 20, 120, "The Caesar", "..."],
			["I_Plane_Fighter_03_CAS_F", 1/28, 4, "A-143 Buzzard", 300, 600, "Buzzard", "The most basic Jet."],
			["O_Plane_Fighter_02_F", 1/39, 4, "To-201 Shikra", 800, 600, "Shikra", "As deadly as the name sounds."],
			["B_Plane_Fighter_01_F", 1/35, 4, "F/A-181 Black Wasp II", 1000, 600, "Wasp", '"Ride into the danger zone!" - Tom Cruise'],
			["C_Offroad_02_unarmed_F", 1/15, 5, "MB 4WD", 20, 120, "The Generals Jeep", "Fit for a true General, and if not a true gentlemen."]
			
		]
	];
	
	uiNamespace setVariable ["PCS_SHOP_VEHICLES_LIST_E", 
		[
			["O_APC_Wheeled_02_rcws_F", 1/20, 0, "MSE-3 Marid", 50, 120, "The Camel", "Gets you from A to B."],
			["O_APC_Tracked_02_cannon_F", 1/20, 0, "BTR-K Kamysh", 80, 120, "Glory", "A single squad and Glory defeated an entire company."],
			["B_APC_Wheeled_01_cannon_F", 1/20, 0, "AMV-7 Marshall", 50, 120, "The Frog", "On land or water, The Frog is always reliable."],
			["B_APC_Tracked_01_rcws_F", 1/20, 0, "IFV-6c Panther", 50, 120, "The Stallion", "A true work horse."],
			["B_APC_Tracked_01_CRV_F", 1/20, 0, "CRV-6e Bobcat", 20, 120, "The Alpaca", "All terrain, anywhere anytime."],
			["I_APC_tracked_03_cannon_F", 1/20, 0, "FV-720 Mora", 30, 120, "Shit Box", "Truly box like, and its got an autocannon."],
			["I_APC_Wheeled_03_cannon_F", 1/20, 0, "AFV-4 Gorgon", 80, 300, "Gorgon", "Like Glory, but on wheels."],
			["O_APC_Tracked_02_AA_F", 1/21, 1, "ZSU-39 Tigris", 80, 300, "Tiger", "Light weight and can shoot down aircraft."],
			["B_APC_Tracked_01_AA_F", 1/21, 1, " IFV-6a Cheetah", 100, 300, "Cheetah", "Slow but armored, remarkably paradoxical for its name."],
			["O_MBT_02_arty_F", 1/21, 1, "2S9 Sochor", 900, 600, "Henry Jr.", "Light weight piece of mobile artillery."],
			["B_MBT_01_arty_F", 1/21, 1, "M4 Scorcher", 900, 600, "Sir Henry", "Artillery in its most royal form."],
			["B_MBT_01_mlrs_F", 1/21, 1, "M5 Sandstorm MLRS", 1300, 600, "MLRS", "Huge Missile Penetration."],
			["B_MBT_01_TUSK_F", 1/21, 2, "Slammer Up", 100, 300, "Fury", "A main battle tank that can play rope-a-dope."],
			["I_MBT_03_cannon_F", 1/21, 2, "MBT-52 Kuma", 100, 300, "Death Box", "Death in a box, perhaps a pun?"],
			["B_Heli_Transport_01_F", 1/29, 3, "UH-80 Ghost Hawk", 100, 180, "Big Bird", "She is a big ole bird."],
			["O_Heli_Light_02_F", 1/28, 3, "PO-30 Orca", 200, 180, "Seagull", "A truly dirty bird."],
			["I_Heli_light_03_F", 1/28, 3, "WY-55 Hellcat", 300, 180, "Hellcat", "Wait, cats can fly?"],
			["O_Heli_Attack_02_black_F", 1/31, 3, "Mi-48 Kajman", 650, 600, "Big Brave", "A sturdy attack helicopter loaded with missiles."],
			["B_Heli_Attack_01_F", 1/28, 3, "AH-99 Blackfoot", 1000, 600, "The Black Raven", "An attack helicopter that hits from range."],
			["C_Plane_Civil_01_F", 1/22, 4, "Caesar BTT", 20, 120, "The Caesar", "..."],
			["I_Plane_Fighter_03_CAS_F", 1/28, 4, "A-143 Buzzard", 300, 600, "Buzzard", "The most basic Jet."],
			["O_Plane_Fighter_02_F", 1/39, 4, "To-201 Shikra", 800, 600, "Shikra", "As deadly as the name sounds."],
			["B_Plane_Fighter_01_F", 1/35, 4, "F/A-181 Black Wasp II", 1000, 600, "Wasp", '"Ride into the danger zone!" - Tom Cruise'],
			["C_Offroad_02_unarmed_F", 1/15, 5, "MB 4WD", 20, 120, "The Generals Jeep", "Fit for a true General, and if not a true gentlemen."]
			
		]
	];

	uiNamespace setVariable ["PCS_SHOP_CATEGORY_LIST", 
		[
			["APC", 2, 1201],
			["AFV", 3, 1202],
			["TANK", 1, 1203],
			["HELICOPTER", 1, 1204],
			["PLANE", 1, 1205],
			["ARISTOCRATIC", 1, 1206]
		]
	];

	PCS_M_ROOT = call {
		private "_arr";
		_arr = toArray str missionConfigFile;
		_arr resize (count _arr - 15);
		toString _arr
	};
	
	
	[] call PCS_InitConnectionHandler;
	[] call PCS_FunctionList;
	if (isServer) then
	{
		_null = _keyA spawn PCS_MPCodeEH;
		_null = _keyB spawn PCS_MPCodeEH_Atomic;
	};
	//_null = [] execFSM "PUBLIC_CODE_SYSTEM\FastCriticalProcessor.fsm";
	
	if (isServer) then
	{
		diag_log "PCS_RNK: running rank main";
		call PCS_RNK_RankMain;
	};
	
	//player exists event
	if (!isDedicated) then
	{	
		[[count PCS_PER_FRAME_EVENTS], {
			private "_index";
			_index = _this select 0;
			if(!PCS_PLAYER_EXISTS && PCS_FREE_FRAME_EVENTS) then
			{
				PCS_PLAYER_EXISTS = (player == player);
				if (PCS_PLAYER_EXISTS) then
				{
					diag_log "BEFORE";
					_null = [] spawn {waitUntil {!isNil "OPFL_RESPAWN_OBJ"}; waitUntil {time > 0}; diag_log "BEFORE"; player setPosATL (OPFL_RESPAWN_OBJ buildingPos (floor random 3)); diag_log "AFTER";};
					diag_log "AFTER";
					PCS_INIT_PROTECTION = player addEventHandler ["HandleDamage", {false}];
					player addEventHandler ["GetInMan", {
						//add stuff in here to automatically attach to vehicle upon boarding.
						params ["_unit", "_role", "_vehicle", "_turret"];
						diag_log format ["THIS IS LOCAL: %1", local _vehicle];
						_vehicle call GSC_EnableSZP; //script only successfully adds if its not already on it, thus every vehicle you use is safe zone protected
					}];
					player enableSimulation false;
				};
			}
			else
			{
				PCS_FREE_FRAME_EVENTS = false;
				PCS_PER_FRAME_EVENTS set [_index, -1];
				PCS_PER_FRAME_EVENTS = PCS_PER_FRAME_EVENTS - [-1];
			};
		}] call PCS_AddPerFrameEvent;
	};
	
	if (!isMultiplayer) then
	{
		_null = [] spawn 
		{
			waitUntil {"" != ((getPlayerUID player) call PCS_UIDToID)}; 
			player addEventHandler ["Killed", compile format ["(_this select 0) setVariable ['OPFL_UNIT_NAME', '%1'];", ((getPlayerUID player) call PCS_UIDToID) call PCS_GetName]];
			PCS_TEMPORARY_ID_ESTABLISHED = [[rain, fog, overcast], (getPlayerUID player) call PCS_UIDToID];
		}; 
	};
	
	["PCS_PERFRAMES", "onEachFrame", {

		//high performance state capture
		PCS_IN_VEHICLE = (player != vehicle player);
		//PCS_TOTAL_DEAD_MEN = count allDeadMen;
		PCS_TOTAL_PLAYERS = (playersNumber west) + (playersNumber east);
		PCS_CAMERA_TOP = positionCameraToWorld [0,0,1];
		PCS_CAMERA_CENTER = positionCameraToWOrld [0,0,0];
		
		{
			(_x select 0) call (_x select 1);
		} foreach PCS_PER_FRAME_EVENTS;

		{
			_ex = PCS_CPQ select 0; 
			[(_ex select 0), (_ex select 1)] call PCS_CallFnc; 
			PCS_CPQ set [0, -1];
			PCS_CPQ = PCS_CPQ - [-1];
		} foreach PCS_CPQ;

		if (isServer && isMultiplayer) then
		{
			{
				_uid = _x;

				{
					if ((isPlayer _x) && (0 < owner _x) && (_uid == getPlayerUID _x) && ((_uid call PCS_UIDToTemp) == owner _x)) then
					{
						PCS_RNK_RECORDS setVariable [format ["%1_SIDE", _uid], [_x] call GSC_Side]; //set side of ranked player
						PCS_TEMPORARY_ID_ESTABLISHED = [[rain, fog, overcast], _uid call PCS_UIDToID];
						diag_log format ["%1", PCS_TEMPORARY_ID_ESTABLISHED];
						
						_x addMPEventHandler ["MPKilled", compile format ["(_this + ['%1']) call PCS_OnKilled;", (_uid call PCS_UIDToID) call PCS_GetName]]; //persist the name
						(owner _x) publicVariableClient "PCS_TEMPORARY_ID_ESTABLISHED";
						
						PCS_PENDING_CLIENTS = PCS_PENDING_CLIENTS - [_uid];
					};

				} foreach playableUnits;
			} foreach PCS_PENDING_CLIENTS;
		};

		
	}] call  BIS_fnc_addStackedEventHandler;
	
};

PCS_INITIALIZED = true;