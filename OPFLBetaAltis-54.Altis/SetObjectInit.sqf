if (!isServer) exitWith {};
_object = _this select 0;
_initString = _this select 1;

_object setVariable ["OPFL_UNIT_INIT", _initString];
_object setVehicleInit _initString;
processInitCommands;