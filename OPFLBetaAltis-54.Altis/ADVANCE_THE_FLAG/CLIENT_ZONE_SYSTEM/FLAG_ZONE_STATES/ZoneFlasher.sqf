private "_markerZone";
private "_flagObject";
private "_lastVal";
private "_wait";

_flagObject = _this select 0;
_markerZone = format ["%1_ZONE", (_flagObject getVariable "FLAG_ZONE_NAME")];
_wait = 1;
		
while {_wait == 1} do
{
	_lastVal = (_flagObject getVariable "FLAG_ZONE_STATE") select 1;
	_markerZone setMarkerSizeLocal [(OPFL_ZONE_RADIUS * _lastVal), (OPFL_ZONE_RADIUS * _lastVal)];
	waitUntil {((_flagObject getVariable "FLAG_ZONE_STATE") select 1) != _lastVal};
};