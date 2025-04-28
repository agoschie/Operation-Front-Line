if (isServer) exitWith {};
if (isNil "VRS_VEHICLE_LIST") exitWith {};

private "_index";
private "_vehicle";

_index = _this select 0;

if (_index >= count VRS_VEHICLE_LIST) exitWith {};

_vehicle = _this select 1;

VRS_VEHICLE_LIST set [_index, _vehicle];
if (!isNull _vehicle) then
{
	_vehicle call (VRS_INIT_LIST select _index);
};