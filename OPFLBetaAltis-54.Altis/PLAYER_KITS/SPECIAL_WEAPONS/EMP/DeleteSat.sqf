private "_sat";
private "_name";

_sat = _this select 0;
_name = "";

if ("SCALAR" == typeName _sat) then
{
	_name = format["EMP_%1_REF", _sat];
	_sat = missionNamespace getVariable _name;
};

deleteVehicle _sat;
missionNamespace setVariable [_name, nil];
