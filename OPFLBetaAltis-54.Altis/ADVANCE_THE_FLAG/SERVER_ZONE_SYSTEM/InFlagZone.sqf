private "_flag";
private "_radius";
private "_units";

_flag = _this select 0;
_radius = _this select 1;
_units = [];

{
	if(([_x, _flag] call GSC_2dDistance) < _radius) then
	{
		if ((vehicle _x) == _x) then
		{
			_units = _units + [_x];
		};
	};
} foreach AllUnits;

_units;