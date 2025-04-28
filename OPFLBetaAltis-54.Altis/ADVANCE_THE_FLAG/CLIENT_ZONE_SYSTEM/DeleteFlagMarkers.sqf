private "_flagObject";
_flagObject = _this select 0;
if (!isNil {_flagObject getVariable "FLAG_ZONE_MARKERS"}) then
{
	{
		deleteMarkerLocal _x;
	} foreach (_flagObject getVariable "FLAG_ZONE_MARKERS");
	_flagObject setVariable ["FLAG_ZONE_MARKERS", []];
};