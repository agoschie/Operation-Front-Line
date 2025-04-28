private "_flagObject";
private "_flagName";

_flagObject = _this select 0;
_flagName = (_flagObject getVariable "FLAG_ZONE_NAME");

{
	terminate _x;
} foreach (_flagObject getVariable "FLAG_ZONE_SCRIPTS_LOCAL");
{
	deleteMarkerLocal _x;
} foreach (_flagObject getVariable "FLAG_ZONE_MARKERS");

player sideChat format ["%1 ON THE MOVE", _flagName];
_flagObject hideObject true;