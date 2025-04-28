private "_position";
private "_roofHeight";
private "_roofFinder";

_roofFinder = "Logic" createVehicleLocal [0,0,0];

_position = _this select 0;
if ("OBJECT" == (typeName _position)) then
{
	_position = getPosASL _position;
};

_roofFinder setPosATL [(_position select 0), (_position select 1), 2000];
_roofHeight = 2000 - ((getPos _roofFinder) select 2);
	
_position = [(_position select 0), (_position select 1), _roofHeight];
_position;


