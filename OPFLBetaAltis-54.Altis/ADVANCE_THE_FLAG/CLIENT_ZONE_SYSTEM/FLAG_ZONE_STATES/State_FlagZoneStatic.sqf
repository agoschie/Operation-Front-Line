private "_flagObject";
private "_trackerScript";
private "_tagTrackerScript";
private "_wallTrackerScript";
private "_flagName";

_flagObject = _this select 0;
_playerSide = _this select 1;
_flagName = (_flagObject getVariable "FLAG_ZONE_NAME");

{
	terminate _x;
} foreach (_flagObject getVariable "FLAG_ZONE_SCRIPTS_LOCAL");
{
	deleteMarkerLocal _x;
} foreach (_flagObject getVariable "FLAG_ZONE_MARKERS");

if (_playerSide == (_flagObject getVariable "FLAG_ZONE_SIDE")) then
{
	[_flagObject] call OPFL_Client_CreateZoneMarkers;
	_trackerScript = [_flagObject] spawn OPFL_Client_ZoneTracker;
	_flagObject setVariable ["FLAG_ZONE_SCRIPTS_LOCAL", [_trackerScript]];
}
else
{
	[_flagObject] call OPFL_Client_CreateTagMarkers;
	_tagTrackerScript = [_flagObject] spawn OPFL_Client_TagTracker;
	_wallTrackerScript = [_flagObject] spawn OPFL_Client_WallTracker;
	_flagObject setVariable ["FLAG_ZONE_SCRIPTS_LOCAL", [_tagTrackerScript, _wallTrackerScript]];
};
player sideChat format ["%1 PLANTED", _flagName];
_flagObject hideObject false;