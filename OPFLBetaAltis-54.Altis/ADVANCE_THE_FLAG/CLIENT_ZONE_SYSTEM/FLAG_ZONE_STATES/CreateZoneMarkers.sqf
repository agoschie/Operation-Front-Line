private "_flagObject";
private "_zoneName";
private "_markerTag";
private "_markerBorder";
private "_markerWall";
private "_flagName";
private "_color";

_flagObject = _this select 0;
_zoneName = format ["%1_ZONE", (_flagObject getVariable "FLAG_ZONE_NAME")];
_markerTag = format ["%1_TAG", _zoneName];
_markerBorder = format ["%1_BORDER", _zoneName];
_markerWall = format ["%1_WALL", _zoneName];
_flagName = (_flagObject getVariable "FLAG_ZONE_NAME");
_color = "none";

if ((_flagObject getVariable "FLAG_ZONE_SIDE") == west) then
{
	_color = "ColorBlue";
};
if ((_flagObject getVariable "FLAG_ZONE_SIDE") == east) then
{
	_color = "ColorRed";
};

_null = createMarkerLocal[_zoneName, (getPos _flagObject)];
_zoneName setMarkerShapeLocal "ELLIPSE";
_zoneName setMarkerBrushLocal "SOLID";
_zoneName setMarkerSizeLocal [OPFL_ZONE_RADIUS, OPFL_ZONE_RADIUS];
_zoneName setMarkerColorLocal _color;

_null = createMarkerLocal[_markerBorder, (getPos _flagObject)];
_markerBorder setMarkerShapeLocal "ELLIPSE";
_markerBorder setMarkerBrushLocal "BORDER";
_markerBorder setMarkerSizeLocal [OPFL_ZONE_RADIUS, OPFL_ZONE_RADIUS];
_markerBorder setMarkerColorLocal _color;

_null = createMarkerLocal[_markerWall, ([_flagObject] call GSC_AxisIntersectPoint)];
_markerWall setMarkerShapeLocal "RECTANGLE";
_markerWall setMarkerBrushLocal "SOLID";
_markerWall setMarkerDirLocal (markerDir "BP_AXIS_CONNECTOR");
_markerWall setMarkerSizeLocal [([([(markerPos "BP_AXIS_CONNECTOR"), (markerPos _markerWall)] call GSC_2dDistance)] call GSC_FieldWidth), 5];
_markerWall setMarkerColorLocal _color;

if ((_flagObject getVariable "FLAG_ZONE_SIDE") == west) then
{
	[(getPosASL _flagObject), 
	 (getMarkerPos "BATTLE_POSITION_EAST"),
	 0,
	 "ColorBlue",
	 format ["%1_CONNECTOR", _zoneName]] call GSC_DrawMarkerConnection;
		  
};
if ((_flagObject getVariable "FLAG_ZONE_SIDE") == east) then
{
	[(getPosASL _flagObject), 
	 (getMarkerPos "BATTLE_POSITION_WEST"),
	 0,
	 "ColorRed",
	 format ["%1_CONNECTOR", _zoneName]] call GSC_DrawMarkerConnection;
};

_null = createMarkerLocal [_markerTag, (getPos _flagObject)];
_markerTag setMarkerShapeLocal "ICON";
_markerTag setMarkerTextLocal _flagName;
_markerTag setMarkerTypeLocal "Dot";
_markerTag setMarkerSizeLocal [0.5, 0.5];
_markerTag setMarkerColorLocal "ColorGreen";

_flagObject setVariable ["FLAG_ZONE_MARKERS", [_zoneName, _markerTag, _markerBorder, _markerWall, format ["%1_CONNECTOR", _zoneName]]];