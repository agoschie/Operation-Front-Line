private "_flagObject";
private "_sizePercent";
private "_zoneMarker";
private "_borderMarker";
private "_tagMarker";
private "_flagName";
private "_markers";
private "_shown";
_shown = 1;

_flagObject = _this select 0;
_sizePercent = _this select 1;
_flagName = _flagObject getVariable "FLAG_ZONE_NAME";
if (_sizePercent == 1) then
{
	_shown = 0;
	_flagName = "";
};
if (isNil {_flagObject getVariable "FLAG_ZONE_MARKERS"}) exitWith {player sideChat "ATtempTED SIZE UPDATE OF NON EXISTANT MARKERS";};
_markers = _flagObject getVariable "FLAG_ZONE_MARKERS";
_zoneMarker = _markers select 0;
_borderMarker = _markers select 1;
_tagMarker = _markers select 3;

_zoneMarker setMarkerSizeLocal [_shown * _sizePercent * OPFL_ZONE_RADIUS, _shown * _sizePercent * OPFL_ZONE_RADIUS];
_borderMarker setMarkerSizeLocal [_shown * OPFL_ZONE_RADIUS, _shown * OPFL_ZONE_RADIUS];
_tagMarker setMarkerSizeLocal [_shown * 0.5, _shown * 0.5];
_tagMarker setMarkerTextLocal _flagName;