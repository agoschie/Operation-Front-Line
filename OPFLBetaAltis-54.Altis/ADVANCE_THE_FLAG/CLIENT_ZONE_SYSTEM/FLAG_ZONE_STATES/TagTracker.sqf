private "_flagObject";
private "_markerTag";
private "_flagObject";
private "_wait";
_flagObject = _this select 0;
_markerTag = format ["%1_ZONE_TAG", (_flagObject getVariable "FLAG_ZONE_NAME")];
_wait = 1;


		
while {_wait == 1} do
{
	_flagPos = (_flagObject getVariable "FLAG_ZONE_STATE") select 2;
	if ((typeName _flagPos) != "ARRAY") exitwith {};
	_markerTag setMarkerPosLocal _flagPos;
	waitUntil {!([((_flagObject getVariable "FLAG_ZONE_STATE") select 2), _flagPos] call GSC_EqualPosArrays)};
};