private "_flagObject";
private "_markerTag";
private "_markerZone";
private "_markerBorder";
private "_markerWall";
private "_flagPos";
private "_wait";
_flagObject = _this select 0;
_markerZone = format ["%1_ZONE", (_flagObject getVariable "FLAG_ZONE_NAME")];
_markerTag = format ["%1_TAG", (_markerZone)];
_markerBorder = format ["%1_BORDER", (_markerZone)];
_markerWall = format ["%1_WALL", (_markerZone)];

_wait = 1;
		
while {_wait == 1} do
{
	_flagPos = getPos _flagObject;
	_markerZone setMarkerPosLocal _flagPos;
	_markerBorder setMarkerPosLocal _flagPos;
	_markerWall setMarkerPosLocal ([_flagPos] call GSC_AxisIntersectPoint);
	_markerWall setMarkerSizeLocal [([([(markerPos "BP_AXIS_CONNECTOR"), (markerPos _markerWall)] call GSC_2dDistance)] call GSC_FieldWidth), 5];
	deleteMarkerLocal format ["%1_CONNECTOR", _markerZone];
	if ((_flagObject getVariable "FLAG_ZONE_SIDE") == west) then
	{
		[_flagPos, 
		 (getMarkerPos "BATTLE_POSITION_EAST"),
		 0,
		 "ColorBlue",
		 format ["%1_CONNECTOR", _markerZone]] call GSC_DrawMarkerConnection;
		  
	};
	if ((_flagObject getVariable "FLAG_ZONE_SIDE") == east) then
	{
		[_flagPos, 
		 (getMarkerPos "BATTLE_POSITION_WEST"),
		 0,
		 "ColorRed",
		 format ["%1_CONNECTOR", _markerZone]] call GSC_DrawMarkerConnection;
	};
	_markerTag setMarkerPosLocal _flagPos;
	waitUntil {!([(getPos _flagObject), _flagPos] call GSC_EqualPosArrays)};
};