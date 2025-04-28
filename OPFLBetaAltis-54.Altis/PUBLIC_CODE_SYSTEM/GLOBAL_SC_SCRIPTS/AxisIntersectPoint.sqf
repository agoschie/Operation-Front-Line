private "_position";
private "_center";
private "_rotateDir";
private "_xPos";
private "_distance";
private "_AIP";
_position = _this select 0;
_rotateDir = markerDir "BP_AXIS_CONNECTOR";
_center = getMarkerPos "BP_AXIS_CONNECTOR";
_AIP = [0,0];

if ("OBJECT" == typeName _position) then
{
	_position = getPosASL _position;
};

_xPos = ([_center,_position,_rotateDir] call MSO_fnc_vectRotate2D) select 0;

_distance = _xPos - (_center select 0);

_AIP set [0, (_position select 0) + (_distance * sin (_rotateDir - 90))];
_AIP set [1, (_position select 1) + (_distance * cos (_rotateDir - 90))];

_AIP;