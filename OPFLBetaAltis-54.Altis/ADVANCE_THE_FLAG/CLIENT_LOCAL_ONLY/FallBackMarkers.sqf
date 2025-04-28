if (true) exitWith {};
_null = [] spawn
{
	private "_wait";
	private "_fallBackObjMarker";
	private "_lastPos";

	_wait = 1;
	_lastPos = [0,0];
	
	_fallBackObjMarker = createMarkerLocal ["FALL_BACK_OBJ_MARKER", [0,0]];
	_fallBackObjMarker setMarkerShapeLocal "ICON";
	_fallBackObjMarker setMarkerDirLocal 0;
	_fallBackObjMarker setMarkerTypeLocal "FLAG";
	_fallBackObjMarker setMarkerTextLocal "FALL BACK POSITION";
	_fallBackObjMarker setMarkerColorLocal "ColorYellow";
	_fallBackObjMarker setMarkerSizeLocal [0.5, 0.5];
	
	while {_wait == 1} do
	{
		if (playerSide == west) then
		{
			_lastPos = getPosASL OPFL_WEST_FALL_BACK_OBJ;
		};
		if (playerSide == east) then
		{
			_lastPos = getPosASL OPFL_EAST_FALL_BACK_OBJ;
		};
		_fallBackObjMarker setMarkerPosLocal _lastPos;
		if (!([playerSide] call GSC_ValidFBP)) then
		{
			"FALL_BACK_OBJ_MARKER" setMarkerColorLocal "ColorYellow";
		}
		else
		{
			"FALL_BACK_OBJ_MARKER" setMarkerColorLocal "ColorGreen";
		};
		if (playerSide == west) then
		{
			waitUntil {!([_lastPos, (getPosASL OPFL_WEST_FALL_BACK_OBJ)] call GSC_EqualPosArrays)};
		};
		if (playerSide == east) then
		{
			waitUntil {!([_lastPos, (getPosASL OPFL_EAST_FALL_BACK_OBJ)] call GSC_EqualPosArrays)};
		};
	};
};

if (playerSide == west) then
{
	waitUntil {!isNil "OPFL_WEST_FALL_BACK_LINE"};
};
if (playerSide == east) then
{
	waitUntil {!isNil "OPFL_EAST_FALL_BACK_LINE"};
};
_null = [] spawn
{
	private "_wait";
	private "_fallBackLineMarker";
	private "_lastPos";
	
	_lastPos = [0, 0];
	_wait = 1;
	
	_fallBackLineMarker = createMarkerLocal ["FALL_BACK_LINE_MARKER", [0,0]];
	_fallBackLineMarker setMarkerShapeLocal "RECTANGLE";
	_fallBackLineMarker setMarkerBrushLocal "SOLID";
	_fallBackLineMarker setMarkerDirLocal (markerDir "BP_AXIS_CONNECTOR");
	_fallBackLineMarker setMarkerColorLocal "ColorYellow";
	_fallBackLineMarker setMarkerSizeLocal [0, 0];
	
	while {_wait == 1} do
	{
		if (playerSide == west) then
		{
			_lastPos = OPFL_WEST_FALL_BACK_LINE;
		};
		if (playerSide == east) then
		{
			_lastPos = OPFL_EAST_FALL_BACK_LINE;
		};
		_fallBackLineMarker setMarkerPosLocal _lastPos;
		_fallBackLineMarker setMarkerSizeLocal [([([(markerPos "BP_AXIS_CONNECTOR"), (markerPos _fallBackLineMarker)] call GSC_2dDistance)] call GSC_FieldWidth), OPFL_FOB_RADIUS];
		if (!([playerSide] call GSC_ValidFBP)) then
		{
			"FALL_BACK_OBJ_MARKER" setMarkerColorLocal "ColorYellow";
		}
		else
		{
			"FALL_BACK_OBJ_MARKER" setMarkerColorLocal "ColorGreen";
		};
		if (playerSide == west) then
		{
			waitUntil {!([_lastPos, OPFL_WEST_FALL_BACK_LINE] call GSC_EqualPosArrays)};
		};
		if (playerSide == east) then
		{
			waitUntil {!([_lastPos, OPFL_EAST_FALL_BACK_LINE] call GSC_EqualPosArrays)};
		};
	};
};