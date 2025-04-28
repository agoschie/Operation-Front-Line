private "_return";
private "_unit";
private "_markerSide";

_unit = _this select 0;
_return = false;
_markerSide = "";
switch (playerSide) do
{
	case west:
	{
		_markerSide = "ColorRed";
	};
	case east:
	{
		_markerSide = "ColorBlue";
	};
};

{
	if (([_unit, _x] call MSO_fnc_inArea) && ((getMarkerColor _x) == _markerSide)) then
	{
		_return = true;
	};
} foreach GSC_SPAWN_PROTECTED_AREAS;

_return;