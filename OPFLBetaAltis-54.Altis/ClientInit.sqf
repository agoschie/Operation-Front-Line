//global client variables
OPFL_BPE_POS = (getMarkerPos "BATTLE_POSITION_EAST");
OPFL_BPW_POS = (getMarkerPos "BATTLE_POSITION_WEST");
ZONE_PERIM_LIST = [];
DELETED = true;
CLIENT_BUILD_TIMER = 0;
CLIENT_MAX_TIMER = 0;
Object_Markers = 0;
OPFL_PLAYER_PACKED_ZONE = [];

// highestSurface will place player on object, ie carrier on respawn
switch (playerSide) do {

	case WEST: {
		
		player addEventHandler ["Respawn", {player setPosATL ([(getMarkerPos "respawn_west")] call GSC_HighestSurface);}];
	
	};
	
	case EAST: {
		
		player addEventHandler ["Respawn", {player setPosATL ([(getMarkerPos "respawn_east")] call GSC_HighestSurface);}];
	
	};
	
};

//public variables
if (isNil "BEGIN_MISSION") then
{
	BEGIN_MISSION = 0;
};

if (isNil "RESET") then
{
	RESET = false;
};

if (isNil "CLIENT_REPOS") then
{
	CLIENT_REPOS = false;
};

if (isNil "UNIVERSAL_MESSAGE") then
{
	UNIVERSAL_MESSAGE = "none";
};

if (isNil "WEST_WIN") then
{
	WEST_WIN = false;
};

if (isNil "EAST_WIN") then
{
	EAST_WIN = false;
};

if (isNil "TIE_WIN") then
{
	TIE_WIN = false;
};

//initialize GUI
cutRsc ["SpawnText","PLAIN",0];
OPFL_WEST_FOB hideObject true;
OPFL_EAST_FOB hideObject true;

// Disable thermal imaging optics
{_x disableTIEquipment true;} foreach vehicles;
skiptime (((paramsarray select 0) - daytime + 24) % 24);

//find what squad your in
SQUAD = [player] call PlayerSquad;

//compile functions

//client scripts
_null = [] spawn PCS_UniversalMessages;
_null = [] spawn PCS_GameTimeClock;
_null = [] spawn PCS_AmericanScore;
_null = [] spawn PCS_RussianScore;
_null = [] spawn OPFL_Client_RespawnTracker;
_null = [] spawn OPFL_Client_PositionMarker;
_null = [] spawn OPFL_Client_GroupPositionMarkers;
_null = [] spawn OPFL_Client_PaintEndZones;
_null = [] spawn OPFL_Client_ScriptSpeedDetector;
_null = [] spawn OPFL_Client_TeamKillingEH;
_null = [] spawn OPFL_Client_FallBackMarkers;
_null = [] execVM "clientSettingsHint.sqf";
_null = [] spawn OPFL_Client_safeZoneKill;

// Client broadcasting UID to server, server sends back current weather
_null =  [[getPlayerUID player], "_null = _this spawn PCS_OPFL_broadcastWeather;", PCS_S_SERVER] spawn PCS_MPCodeBroadcast;