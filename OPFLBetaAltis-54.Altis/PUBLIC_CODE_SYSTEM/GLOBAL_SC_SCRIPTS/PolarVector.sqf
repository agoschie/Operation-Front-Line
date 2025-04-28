private "_origin";
private "_distance";
private "_angle";
_origin = _this select 0;
_distance = _this select 1;
_angle = _this select 2;

if ("OBJECT" == (typeName _origin)) then
{
	_origin = getPosASL _origin;
};

_origin = [((_origin select 0) + (_distance * sin (_angle))), ((_origin select 1) + (_distance * cos (_angle))), (_origin select 2)];
_origin;