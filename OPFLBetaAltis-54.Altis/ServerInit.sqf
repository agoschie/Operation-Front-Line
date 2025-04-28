//global server variables
UNITIME = 1;
ZONE_LIST = [];
DEAD_ZONE_LIST = [];
BEGIN_MISSION = 0;
RESET = false;
ZONES_PER_SIDE = 0;
MOVE_ZONES = false;
GLITCH = false;
ZONE_SCRIPTS_RUNNING = 0;
CLIENT_REPOS = false;
OPFL_AMERICAN_TICKETS = 0;
OPFL_RUSSIAN_TICKETS = 0;
OPFL_CLOCK_START = false;
OPFL_FLAG_ZONE_LIST = [];
OPFL_BPE_POS = (getMarkerPos "BATTLE_POSITION_EAST");
OPFL_BPW_POS = (getMarkerPos "BATTLE_POSITION_WEST");

{
	call compile format["%1_ZONE = false", _x];
} foreach OPFL_SQUAD_LIST;


//initialization scripts
_null = [] spawn ServerFBPSystem_InitFBP;
_null = [] spawn OPFL_Server_FlagZoneThread;
_null = [] execVM "InitSortBalance.sqf";
_null = [] execVM "InitServerGameClock.sqf";
_null = [] execVM "InitTicketVictory.sqf";

BEGIN_MISSION = 1;
publicVariable "BEGIN_MISSION";

CLIENT_REPOS = true;
publicVariable "CLIENT_REPOS";

skiptime (((paramsarray select 0) - daytime + 24) % 24);

_null = [] execVM "InitTickets.sqf";