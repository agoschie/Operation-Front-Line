private "_flagObject";
private "_sizePercent";
private "_zoneMarker";
private "_markers";

_flagObject = _this select 0;
_sizePercent = _this select 1;
if (isNil {_flagObject getVariable "FLAG_ZONE_MARKERS"}) exitWith {player sideChat "ATtempTED SIZE UPDATE OF NON EXISTANT MARKERS";};
_markers = _flagObject getVariable "FLAG_ZONE_MARKERS";
_zoneMarker = _markers select 0;

_zoneMarker setMarkerSizeLocal [_sizePercent * OPFL_ZONE_RADIUS, _sizePercent * OPFL_ZONE_RADIUS];