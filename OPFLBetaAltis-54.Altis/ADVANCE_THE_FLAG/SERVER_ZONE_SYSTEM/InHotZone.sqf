private "_flagObject";
private "_side";
private "_hotZone";
_flagObject = _this select 0;
_side = _flagObject getVariable "FLAG_ZONE_SIDE"; 
_hotZone = false;
{
	if ([_flagObject, _x] call MSO_fnc_inArea) then
	{
		if ((_side == west) && ("ColorRed" == (getMarkerColor _x))) then
		{
			_hotZone = true;
		};
		if ((_side == east) && ("ColorBlue" == (getMarkerColor _x))) then
		{
			_hotZone = true;
		};
		if ("ColorYellow" == (getMarkerColor _x)) then
		{
			_hotZone = true;
		};
	};
} foreach OPFL_HOT_ZONES;

_hotZone;