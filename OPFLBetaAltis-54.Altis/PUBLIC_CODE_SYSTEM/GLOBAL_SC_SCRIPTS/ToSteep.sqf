private "_pos";
private "_testObj";
private "_data";
private "_return";
_pos = [((_this select 0) select 0), ((_this select 0) select 1), 0];
_return = false;

_testObj = "RoadCone" createVehicleLocal _pos;
_testObj setPosATL _pos;
_data = _testObj call BIS_fnc_getPitchBank;
deleteVehicle _testObj; 

if (((abs (_data select 0)) > 50) || ((abs (_data select 1)) > 50)) then
{
	_return = true;
};

_return;