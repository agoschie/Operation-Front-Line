private "_return";
private "_unit";

_unit = _this select 0;
_return = false;

{
	if (([_unit, (getMarkerPos _x)] call GSC_2dDistance) < ((getMarkerSize _x) select 0)) then
	{
		_return = true;
	};
} foreach GSC_SPAWN_PROTECTED_AREAS;

_return;