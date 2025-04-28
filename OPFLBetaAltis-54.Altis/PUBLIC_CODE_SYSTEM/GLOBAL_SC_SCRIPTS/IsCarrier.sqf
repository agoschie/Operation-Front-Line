private "_person";
private "_return";
_person = _this select 0;
_return = false;

{
	if ((_x getVariable "FLAG_ZONE_CARRIER_UNIT") == _person) exitWith
	{
		_return = true;
	};
} foreach OPFL_FLAG_ZONE_LIST;

_return;