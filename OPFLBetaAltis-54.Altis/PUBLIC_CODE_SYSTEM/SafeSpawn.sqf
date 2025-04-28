_null = _this spawn {
private "_client";
private "_clientServer";
private "_dedicatedServer";
_client = (!isDedicated) && (!isServer);
_clientServer = (isServer) && (!isDedicated);
_dedicatedServer = isDedicated;

if (isServer) then
{
	waitUntil {PCS_PEHKREH_READY};
};
waitUntil {PCS_PEH_READY && PCS_PEHA_READY};
waitUntil{!(isNil "BIS_fnc_init")};

[] call VRS_InitVehicleRespawn;

if (!_dedicatedServer) then
{
	waitUntil {PCS_PLAYER_EXISTS};
	waitUntil {"" != getPlayerUID player};
	_null = player addEventHandler ["Respawn", {(_this select 0) setVariable ["PCS_MY_BODY", true];}];
	player setVariable ["PCS_MY_BODY", true];
	waitUntil {!isNull (findDisplay 46)};
	_null = execVM "InitHUD.sqf";
	waitUntil {!isNil "HUD_DISPLAY_FUNCTIONS_LIST"};
};

if (_client) then
{
	waitUntil {time > 0};
	waitUntil {createDialog "PCS_RNKGUI"};
	waitUntil {!isNil "PCS_SERVER_INITIALIZED"};
	player sideChat "PCS: Server Initialized";
	waitUntil {!isNil "PCS_TEMPORARY_ID_ESTABLISHED"};
	player sideChat "PCS: TEMPORARY ID Established";
	//(PCS_TEMPORARY_ID_ESTABLISHED select 0) call PCS_SyncWeather;
	PCS_UNIQUE = PCS_TEMPORARY_ID_ESTABLISHED select 1;
	sleep (random 1);
	[PCS_UNIQUE, "PCS_InitSyncMsg", PCS_S_SERVER, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
	[] call VRS_HangForInits;
	player sideChat "PCS: Got VRS inits";
	waitUntil {!isNil "PCS_RNK_STATS"}; //wait for stats
	PCS_RNK_ALL_STATS = PCS_RNK_STATS; //place record "constant" variable
	PCS_RNK_STATS = PCS_RNK_STATS select 7; //only use chickens (we are observing changes in these)
	"PCS_RNK_STATS" addPublicVariableEventHandler 
	{
		playSound "GotKill";
	};
	waitUntil {!isNil "PCS_RNK_ON"};
}
else
{
	waitUntil {time > 1};
		
	if (_clientServer) then
	{
		private "_uid";
		_uid = getPlayerUID player;
		
		if (!(_uid in PCS_UID_CONNECTIONS_LIST)) then
		{
			[[_uid, "", "", owner player], "PCS_OnConnected"] call PCS_SpawnAtomic;
			waitUntil {(!isNil "PCS_TEMPORARY_ID_ESTABLISHED") && (_uid in PCS_UID_CONNECTIONS_LIST)};
		};
		PCS_UNIQUE = _uid call PCS_UIDToID;
		
		waitUntil {!isNil "PCS_RNK_STATS"}; //wait for stats
		PCS_RNK_ALL_STATS = PCS_RNK_STATS; //place record "constant" variable
		PCS_RNK_STATS = PCS_RNK_STATS select 7; //only use chickens (we are observing changes in these)
	};
	PCS_SERVER_INITIALIZED = true;
	publicVariable "PCS_SERVER_INITIALIZED";
};

private "_index";
_index = 1;
{
	private "_args";
	private "_script";
	private "_hang";
	private "_handle";
	
	if (2 > count _x) exitWith
	{
		diag_log format ["SafeSpawn: Not enough arguments for script %1.", _index];
	};
	_args = _x select 0;
	_script = _x select 1;
	
	if (2 < count _x) then
	{
		_hang = _x select 2;
	}
	else
	{
		_hang = false;
	};
	
	_handle = (_args spawn _script);
	if (_hang) then
	{
		waitUntil {(scriptDone _handle)};
	};
	
	_index = _index + 1;
} foreach _this;
player sideChat "PCS: Finished hanging for modules";

if (!isDedicated) then
{
	player enableSimulation true;
	player removeEventHandler ["HandleDamage", PCS_INIT_PROTECTION]; 
	
	player sideChat "PCS: Enabled movement";
};
//skiptime (((paramsarray select 0) - daytime + 24) % 24);
//_null = [] spawn PCS_TimeSynch;

};
