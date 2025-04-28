private "_flagObject";
private "_virtualFlag";
private "_currentPos";

_flagObject = _this select 0;

_currentPos = [0,0,0];
_virtualFlag = objNull;
_virtualFlag = (typeOf _flagObject) createVehicleLocal (getPos _flagObject);
_currentPos = (_flagObject getVariable "FLAG_ZONE_STATE") select 2;
_virtualFlag setPosASL _currentPos;
//_virtualFlag setVariable ["OPFL_VF_POS", _currentPos];
_flagObject setVariable ["FLAG_ZONE_VIRTUAL", _virtualFlag];

_flagObject hideObject true;