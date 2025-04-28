private "_flagObject";
private "_originalPos";
private "_isQueue";
private "_overLine";
private "_positionPlayer";
private "_currentPlayerPos";
private "_dirPlayer";
private "_ticketGainScript";
private "_zoneScript";
private "_sizePercent";
private "_redRad";

_flagObject = _this select 0;
_originalPos = _this select 1;
_positionPlayer = _this select 2;
_currentPlayerPos = _this select 3;
_sizePercent = (_flagObject getVariable "FLAG_ZONE_STATE") select 1;

_isQueue = false;
_overLine = false;
if ((count _this) > 4) then
{
	_isQueue = _this select 4;
};
if (!_isQueue) exitWith
{
	OPFL_FLAG_ZONE_QUEUE set [(count OPFL_FLAG_ZONE_QUEUE), [[_flagObject, _originalPos, _positionPlayer, _currentPlayerPos, true], 1]];
};

_redRad = [OPFL_REDEPLOY_RADIUS, OPFL_DESTROYED_RADIUS] select (_flagObject getVariable "FLAG_ZONE_DESTROYED");

_overLine = (([_positionPlayer, (_flagObject getVariable "FLAG_ZONE_SIDE")] call GSC_OverEZW) || (!([_positionPlayer, "BATTLE_FIELD_AREA"] call MSO_fnc_inArea)) || (([_positionPlayer, _flagObject] call GSC_2dDistance) > _redRad));

if (!(_flagObject getVariable "FLAG_ZONE_PLANTED") || _overLine || !([_originalPos, (getPosASL _flagObject)] call GSC_EqualPosArrays) || !(_flagObject getVariable "FLAG_ZONE_READY") || (OPFL_PINNED_ZONES && (_sizePercent < 1))) exitWith {};

{
	terminate _x;
} foreach (_flagObject getVariable "FLAG_ZONE_SCRIPTS");
_flagObject setVariable ["FLAG_ZONE_SCRIPTS", []];
_flagObject setVariable ["FLAG_ZONE_READY", false, true];
_flagObject setVariable ["FLAG_ZONE_ACTIVATED", true];
_flagObject setVariable ["FLAG_ZONE_DESTROYED", false];
_flagObject setVariable ["FLAG_ZONE_TOD", diag_tickTime];
/*
//it was possibly destroyed right when it was redeployed, so it puts a second back on the timer like you saved it at the "last second"
if ((_flagObject getVariable "FLAG_ZONE_CAPTURED") == 0) then
{
	_flagObject setVariable ["FLAG_ZONE_CAPTURED", 1];
};
if ((_flagObject getVariable "FLAG_ZONE_SUPPORT") == 0) then
{
	_flagObject setVariable ["FLAG_ZONE_SUPPORT", 1];
};
*/
_flagObject setPosATL _positionPlayer;

[_flagObject] call OPFL_Server_UpdateVisualState;
[_flagObject] call OPFL_Server_DetectRoundWin;

_ticketGainScript = [_flagObject] spawn OPFL_Server_TicketGain;
//_zoneScript = [_flagObject] spawn OPFL_Server_ActivateFlagZone;
_flagObject setVariable ["FLAG_ZONE_SCRIPTS", [_ticketGainScript]];