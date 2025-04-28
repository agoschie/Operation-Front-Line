_ZONE_LIST = [];
_AMERICAN_UNITS = [];
_RUSSIAN_UNITS = [];
_zonesIndex1 = 0;
_zonesIndex2 = 0;
_americanUnits = 0;
_russianUnits = 0;

if (false) exitWith {};
if (OPFL_MAX_FLAG_ZONES < 1) exitWith { diag_log "OPFL ERROR: *MUST HAVE AT LEAST ONE MAXIMUM FLAG ZONE PER SIDE*";};

_wait = 1;

_americanUnits = {west == [_x] call GSC_Side} count AllUnits;
_russianUnits = {east == [_x] call GSC_Side} count AllUnits;

if (_americanUnits < _russianUnits) then
{
	
	while {_americanUnits >= ((ZONES_PER_SIDE + 1) * floor (0.5 * OPFL_PLAYER_CAPACITY / OPFL_MAX_FLAG_ZONES))} do
	{
		ZONES_PER_SIDE = ZONES_PER_SIDE + 1;
	};
}
else
{
	
	while {_russianUnits >= ((ZONES_PER_SIDE + 1) * floor (0.5 * OPFL_PLAYER_CAPACITY / OPFL_MAX_FLAG_ZONES))} do
	{
		ZONES_PER_SIDE = ZONES_PER_SIDE + 1;
	};
};

_zonesIndex1 = ZONES_PER_SIDE;
_zonesIndex2 = ZONES_PER_SIDE;


	
{
	if ((_zonesIndex1 > 0) && (!(_x in _ZONE_LIST))) then
	{
		_ZONE_LIST = _ZONE_LIST + [_x];
		[_x, west] call OPFL_Server_CreateFlagZone;
		_zonesIndex1 = _zonesIndex1 - 1;
	};
} foreach OPFL_SQUAD_LIST;



{
	if ((_zonesIndex2 > 0) && (!(_x in _ZONE_LIST))) then
	{
		_ZONE_LIST = _ZONE_LIST + [_x];
		[_x, east] call OPFL_Server_CreateFlagZone;
		_zonesIndex2 = _zonesIndex2 - 1;	
	};
} foreach OPFL_SQUAD_LIST;

_null = [] spawn OPFL_Server_FlagZoneThread;

//[] call OPFL_Server_UpdateFBL;
//{
//	_x setVehicleInit "this setVariable ['R3F_LOG_disabled', true]";
//} foreach OPFL_FLAG_ZONE_LIST;
//processInitCommands;
OPFL_ALL_FLAGS_CREATED = true;
publicVariable "OPFL_ALL_FLAGS_CREATED";
publicVariable "OPFL_FLAG_ZONE_LIST";
