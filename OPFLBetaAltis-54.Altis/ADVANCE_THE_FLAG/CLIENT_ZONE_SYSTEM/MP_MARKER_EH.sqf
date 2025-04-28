private "_flagObject";
private "_MOVING";
private "_STATIC";
private "_FLASHING";
private "_side";
private "_wait";

_flagObject = _this select 0;
_flagObject setVariable ["FLAG_ZONE_SCRIPTS_LOCAL", []];
_flagObject setVariable ["FLAG_ZONE_MARKERS", []];
waitUntil {player == player};

//Constants
_MOVING = 1;
_STATIC = 2;
_FLASHING = 3;
_side = playerSide;


_wait = 1;
waitUntil {!isNil "OPFL_ALL_SCRIPTS_COMPILED"};
waitUntil {!(isNil {_flagObject getVariable "FLAG_ZONE_STATE"})};
while {_wait == 1} do
{
	_lastState = (_flagObject getVariable "FLAG_ZONE_STATE") select 0;
	
	if (_lastState == _MOVING) then
	{
		[_flagObject] call OPFL_Client_State_FlagZoneMoving;
	};
	if (_lastState == _STATIC) then
	{
		[_flagObject, _side] call OPFL_Client_State_FlagZoneStatic;
	};
	if (_lastState == _FLASHING) then
	{
		[_flagObject] call OPFL_Client_State_FlagZoneCollapsing;
	};
		
	waitUntil {((_flagObject getVariable "FLAG_ZONE_STATE") select 0) != _lastState};
};