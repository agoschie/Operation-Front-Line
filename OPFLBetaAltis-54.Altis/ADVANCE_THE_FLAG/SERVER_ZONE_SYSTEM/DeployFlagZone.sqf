private "_flagObject";
private "_carrier";
private "_isQueue";
private "_overLine";
private "_positionPlayer";
private "_dirPlayer";
private "_ticketGainScript";
private "_zoneScript";
private "_nearEBase";
private "_bpDistance";

_flagObject = _this select 0;
_carrier = _this select 1;
_positionPlayer = _this select 2;
_isAlive = _this select 3;

_isQueue = false;
_overLine = false;
_nearEBase = false;
_bpDistance = OPFL_ZONE_RADIUS + ((getMarkerSize "BATTLE_POSITION_WEST") select 0);
if ((count _this) > 4) then
{
	_isQueue = _this select 4;
};
if (!_isQueue) exitWith
{
	OPFL_FLAG_ZONE_QUEUE set [(count OPFL_FLAG_ZONE_QUEUE), [[_flagObject, _carrier, _positionPlayer, _isAlive, true], 1]];
};


_overLine = (([_positionPlayer, (_flagObject getVariable "FLAG_ZONE_SIDE")] call GSC_OverEZW) || (!([_positionPlayer, "BATTLE_FIELD_AREA"] call MSO_fnc_inArea)));

if ((_flagObject getVariable "FLAG_ZONE_PLANTED") || (_isAlive && ((_flagObject getVariable "FLAG_ZONE_CARRIER_UNIT") != _carrier)) || (_overLine && _isAlive)) exitWith {};
_flagObject setVariable ["FLAG_ZONE_PLANTED", true, true];
_flagObject setVariable ["FLAG_ZONE_CARRIER_UNIT", objNull, true];
_flagObject setVariable ["FLAG_ZONE_CARRIER_POS", []];
_carrier setVariable ["OPFL_DELETE_LOCK", nil];
_flagObject setVariable ["FLAG_ZONE_READY", false, true];
_flagObject setVariable ["FLAG_ZONE_ACTIVATED", true];
_flagObject setVariable ["FLAG_ZONE_TOD", diag_tickTime];
{
	terminate _x;
} foreach (_flagObject getVariable "FLAG_ZONE_SCRIPTS");
_flagObject setVariable ["FLAG_ZONE_SCRIPTS", []];

if (!_isAlive) then
{
	if ( west == (_flagObject getVariable "FLAG_ZONE_SIDE")) then
	{	
		_nearEBase = ((([_positionPlayer, getMarkerPos "BATTLE_POSITION_EAST"] call GSC_2dDistance) <= _bpDistance) && !OPFL_ROUND_MODE);
	}
	else
	{
		_nearEBase = ((([_positionPlayer, getMarkerPos "BATTLE_POSITION_WEST"] call GSC_2dDistance) <= _bpDistance) && !OPFL_ROUND_MODE);
	};

	if (_overLine || _nearEBase) then
	{
		[(_flagObject getVariable "FLAG_ZONE_SIDE"), _flagObject] call OPFL_Server_DestroyRepos;
	}
	else
	{
		_flagObject setPos [(_positionPlayer select 0), (_positionPlayer select 1), 0]; //[_positionPlayer select 0, _positionPlayer select 1, 0];
	};
}
else
{
	_flagObject setPosASL _positionPlayer;
};
[_flagObject] call OPFL_Server_UpdateVisualState;
[_flagObject] call OPFL_Server_DetectRoundWin;

_ticketGainScript = [_flagObject] spawn OPFL_Server_TicketGain;
//_zoneScript = [_flagObject] spawn OPFL_Server_ActivateFlagZone;
_flagObject setVariable ["FLAG_ZONE_SCRIPTS", [_ticketGainScript]];