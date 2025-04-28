private "_return";
private "_timeCycle";
private "_flagObject";

_flagObject = _this select 0;
_timeCycle = _this select 1;
_return = false;

if (isNil {_flagObject getVariable "FLAG_ZONE_LAST_SCAN"}) exitWith
{
	//player sideChat "INITIAL SCAN";
	_return = true;
	_return;
};

if (diag_tickTime >= ((_flagObject getVariable "FLAG_ZONE_LAST_SCAN") + _timeCycle)) then
{
	_return = true;
};

_return;