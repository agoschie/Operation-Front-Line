private "_flagObject";
private "_markerTag";
private "_markerWall";
private "_flagName";
private "_color";

_flagObject = _this select 0;
_markerTag = format ["%1_ZONE_TAG", (_flagObject getVariable "FLAG_ZONE_NAME")];
_markerWall = format ["%1_ZONE_WALL", (_flagObject getVariable "FLAG_ZONE_NAME")];
_flagName = (_flagObject getVariable "FLAG_ZONE_NAME");
_color = "ColorBlack";

if ((_flagObject getVariable "FLAG_ZONE_SIDE") == west) then
{
	_color = "ColorBlue";
};
if ((_flagObject getVariable "FLAG_ZONE_SIDE") == east) then
{
	_color = "ColorRed";
};


_null = createMarkerLocal [_markerWall, ([_flagObject] call GSC_AxisIntersectPoint)];
_markerWall setMarkerShapeLocal "RECTANGLE";
_markerWall setMarkerBrushLocal "SOLID";
_markerWall setMarkerDirLocal (markerDir "BP_AXIS_CONNECTOR");
_markerWall setMarkerSizeLocal [([([(markerPos "BP_AXIS_CONNECTOR"), (markerPos _markerWall)] call GSC_2dDistance)] call GSC_FieldWidth), 5];
_markerWall setMarkerColorLocal _color;

_null = createMarkerLocal [_markerTag, ((_flagObject getVariable "FLAG_ZONE_STATE") select 2)];
_markerTag setMarkerShapeLocal "ICON";
_markerTag setMarkerTextLocal _flagName;
_markerTag setMarkerTypeLocal "Dot";
_markerTag setMarkerSizeLocal [0.5, 0.5];
_markerTag setMarkerColorLocal "ColorGreen";

_flagObject setVariable ["FLAG_ZONE_MARKERS", [_markerTag, _markerWall]];