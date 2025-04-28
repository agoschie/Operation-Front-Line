private "_flagObject";
private "_carrier";

_flagObject = _this select 0;
_carrier = _this select 1;

waitUntil {!alive _carrier};
_null = [_flagObject, _carrier, (getPosASL _carrier), false] spawn OPFL_Server_DeployFlagZone;