private "_flagObject";
private "_trackerScript";
private "_flasherScript";
private "_flagName";

_flagObject = _this select 0;
_flagName = (_flagObject getVariable "FLAG_ZONE_NAME");

{
	terminate _x;
} foreach (_flagObject getVariable "FLAG_ZONE_SCRIPTS_LOCAL");
{
	deleteMarkerLocal _x;
} foreach (_flagObject getVariable "FLAG_ZONE_MARKERS");

[_flagObject] call OPFL_Client_CreateZoneMarkers;
_trackerScript = [_flagObject] spawn OPFL_Client_ZoneTracker;
_flasherScript = [_flagObject] spawn OPFL_Client_ZoneFlasher;
_flagObject setVariable ["FLAG_ZONE_SCRIPTS_LOCAL", [_trackerScript, _flasherScript]];

player sideChat format ["%1 IS COLLAPSING", _flagName];
_flagObject hideObject false;