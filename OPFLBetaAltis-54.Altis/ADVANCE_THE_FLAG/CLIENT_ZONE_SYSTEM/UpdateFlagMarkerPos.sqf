private "_flagObject";
private "_flagPos";
private "_markers";
private "_zoneMarker";
private "_borderMarker";
private "_lineMarker";
private "_tagMarker";
private "_deployMarker";
_flagObject = _this select 0;
_flagPos = _this select 1;
if (isNil {_flagObject getVariable "FLAG_ZONE_MARKERS"}) exitWith {player sideChat "ATtempTED POS UPDATE OF NON EXISTANT MARKERS";};
_markers = _flagObject getVariable "FLAG_ZONE_MARKERS";
_zoneMarker = _markers select 0;
_borderMarker = _markers select 1;
_lineMarker = _markers select 2;
_tagMarker = _markers select 3;

_zoneMarker setMarkerPosLocal _flagPos;
_borderMarker setMarkerPosLocal _flagPos;
_lineMarker setMarkerPosLocal ([_flagPos] call GSC_AxisIntersectPoint);
_lineMarker setMarkerSizeLocal [([([(markerPos "BP_AXIS_CONNECTOR"), (markerPos _lineMarker)] call GSC_2dDistance)] call GSC_FieldWidth), 5];
_tagMarker setMarkerPosLocal _flagPos;

if ((_flagObject getVariable "FLAG_ZONE_SIDE") == playerSide) then
{
	_deployMarker = _markers select 4;
	_deployMarker setMarkerPosLocal _flagPos;
};