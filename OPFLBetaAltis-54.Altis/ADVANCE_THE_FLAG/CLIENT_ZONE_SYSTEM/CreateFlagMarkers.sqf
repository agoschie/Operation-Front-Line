private "_flagObject";
private "_flagPos";
private "_flagName";
private "_flagColor";
private "_sizePercent";
private "_zoneMarker";
private "_borderMarker";
private "_lineMarker";
private "_tagMarker";
private "_deployMarker";
_flagPos = _this select 0;
_sizePercent = _this select 1;
_flagName = _this select 2;
_flagColor = _this select 3;
_flagObject = _this select 4;

//initial markers
_zoneMarker = createMarkerLocal [format ["ZONE_MARKER_%1", _flagName], _flagPos];
_zoneMarker setMarkerShapeLocal "ELLIPSE";
_zoneMarker setMarkerBrushLocal "SOLID";
_zoneMarker setMarkerColorLocal _flagColor;
_zoneMarker setMarkerSizeLocal [_sizePercent * OPFL_ZONE_RADIUS, _sizePercent * OPFL_ZONE_RADIUS];

_borderMarker = createMarkerLocal [format ["BORDER_MARKER_%1", _flagName], _flagPos];
_borderMarker setMarkerShapeLocal "ELLIPSE";
_borderMarker setMarkerBrushLocal "BORDER";
_borderMarker setMarkerColorLocal _flagColor;
_borderMarker setMarkerSizeLocal [OPFL_ZONE_RADIUS, OPFL_ZONE_RADIUS];

_lineMarker = createMarkerLocal [format ["LINE_MARKER_%1", _flagName], ([_flagPos] call GSC_AxisIntersectPoint)];
_lineMarker setMarkerShapeLocal "RECTANGLE";
_lineMarker setMarkerBrushLocal "SOLID";
_lineMarker setMarkerDirLocal (markerDir "BP_AXIS_CONNECTOR");
_lineMarker setMarkerColorLocal _flagColor;
_lineMarker setMarkerAlphaLocal 0.5;
_lineMarker setMarkerSizeLocal [([([(markerPos "BP_AXIS_CONNECTOR"), (markerPos _lineMarker)] call GSC_2dDistance)] call GSC_FieldWidth), 5];

_tagMarker = createMarkerLocal [format ["TAG_MARKER_%1", _flagName], _flagPos];
_tagMarker setMarkerShapeLocal "ICON";
_tagMarker setMarkerTypeLocal "hd_dot";
_tagMarker setMarkerColorLocal "ColorGreen";
_tagMarker setMarkerTextLocal _flagName;
_tagMarker setMarkerSizeLocal [0.5, 0.5];

if ((_flagObject getVariable "FLAG_ZONE_SIDE") == playerSide) then
{
	_deployMarker = createMarkerLocal ["OPFL_RP_BORDER_MARKER", _flagPos];
	_deployMarker setMarkerShapeLocal "ELLIPSE";
	_deployMarker setMarkerBrushLocal "Border";
	_deployMarker setMarkerColorLocal "ColorYellow";
	_deployMarker setMarkerSizeLocal [OPFL_REDEPLOY_RADIUS, OPFL_REDEPLOY_RADIUS];
	_flagObject setVariable ["FLAG_ZONE_MARKERS", [_zoneMarker, _borderMarker, _lineMarker, _tagMarker, _deployMarker]];
}
else
{
	_flagObject setVariable ["FLAG_ZONE_MARKERS", [_zoneMarker, _borderMarker, _lineMarker, _tagMarker]];
};