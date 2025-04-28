private ["_vehicle", "_player"];
_player = _this select 0;
_vehicle = _this select 1;
{
	if (!(_x in units _player)) then
	{
		moveOut _x;
	};
} foreach (crew _vehicle);