if (isServer) exitWith {};
if (isNil "VRS_VEHICLE_LIST") then
{
	VRS_VEHICLE_LIST = [];
};
private "_index";
private "_args";
_index = _this select 0;

if (_index != count VRS_VEHICLE_LIST) exitWith {};

_args = [] + _this;
_args set [0, -1];
if(_index < 1) then
{
	VRS_VEHICLE_COUNT = _this select 1;
	_args set [1, -1];
};
_args = _args - [-1];


{
	VRS_VEHICLE_LIST set [_index, _x];
	if (!isNull _x) then
	{
		_x call (VRS_INIT_LIST select  _index);
	};
	_index = _index + 1;
} foreach _args;