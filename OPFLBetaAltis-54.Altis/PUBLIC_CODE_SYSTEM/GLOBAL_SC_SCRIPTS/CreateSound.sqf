private "_name";
private "_nameSound";
private "_return";
private "_object";

_nameSound = _this select 0;

_object = "Logic" createVehicleLocal getPosASL player;
_object setVariable ["SOUND", _nameSound];

if (1 < count _this) then
{
	_name = _this select 1;
	missionNamespace setVariable [format ["GLOBAL_SCRIPTS_SOUND_%1", _name], _object];
};


_return = _object;

_return;