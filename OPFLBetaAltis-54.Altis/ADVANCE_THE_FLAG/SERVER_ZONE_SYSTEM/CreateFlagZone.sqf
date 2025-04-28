private "_side";
private "_ticketGainScript";
private "_zoneScript";
private "_flagObject";
private "_flagName";

_flagName = _this select 0;
_side = _this select 1;
_flagObject = "none";

if(_side == west) then
{
	_flagObject = (typeOf OPFL_WEST_FOB) createVehicle (getPos OPFL_WEST_FOB);
	[(getPos OPFL_WEST_BUNKER), _flagObject, OPFL_FOB_RADIUS] call GSC_RandPosAroundObject;
	OPFL_WEST_FLAG = _flagObject;
};
if(_side == east) then
{
	_flagObject = (typeOf OPFL_EAST_FOB) createVehicle (getPos OPFL_EAST_FOB);
	[(getPos OPFL_EAST_BUNKER), _flagObject, OPFL_FOB_RADIUS] call GSC_RandPosAroundObject;
	OPFL_EAST_FLAG = _flagObject;
};
OPFL_FLAG_ZONE_LIST = OPFL_FLAG_ZONE_LIST + [_flagObject];
_flagObject setVariable ["FLAG_ZONE_SIDE", _side, true];
_flagObject setVariable ["FLAG_ZONE_NAME", _flagName, true];
_flagObject setVariable ["FLAG_ZONE_PLANTED", true, true];
_flagObject setVariable ["FLAG_ZONE_CAPTURED", OPFL_ZONE_CAPTURE_TIME];
_flagObject setVariable ["FLAG_ZONE_SUPPORT", OPFL_ZONE_DEATH_TIME];
_flagObject setVariable ["FLAG_ZONE_CARRIER_UNIT", objNull, true];
_flagObject setVariable ["FLAG_ZONE_READY", false, true];
_flagObject setVariable ["FLAG_ZONE_ACTIVATED", true];
_flagObject setVariable ["FLAG_ZONE_DESTROYED", false];
_flagObject setVariable ["FLAG_ZONE_TOD", OPFL_MATCH_START_TIME];
_flagObject setVariable ["FLAG_ZONE_CARRIER_POS", []];

[_flagObject] call OPFL_Server_UpdateVisualState;

//_ticketGainScript = [_flagObject] spawn OPFL_Server_TicketGain;
//_zoneScript = [_flagObject] spawn OPFL_Server_ActivateFlagZone;

//_flagObject setVariable ["FLAG_ZONE_SCRIPTS", [_ticketGainScript, _zoneScript]];
_flagObject setVariable ["FLAG_ZONE_SCRIPTS", []];