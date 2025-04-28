private "_flagObject";
private "_markerWall";
private "_flagObject";
private "_wait";
_flagObject = _this select 0;
_markerWall = format ["%1_ZONE_WALL", (_flagObject getVariable "FLAG_ZONE_NAME")];
_wait = 1;


		
while {_wait == 1} do
{
	_flagPos = getPos _flagObject;
	_markerWall setMarkerPosLocal ([_flagPos] call GSC_AxisIntersectPoint);
	_markerWall setMarkerSizeLocal [([([(markerPos "BP_AXIS_CONNECTOR"), (markerPos _markerWall)] call GSC_2dDistance)] call GSC_FieldWidth), 5];
	waitUntil {!([(getPos _flagObject), _flagPos] call GSC_EqualPosArrays)};
};