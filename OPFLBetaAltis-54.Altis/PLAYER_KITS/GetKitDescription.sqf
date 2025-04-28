private "_return";
_return = "";
if (isNil "_this") exitWith {};

_return = PKS_KIT_TABLE getVariable format ["KIT_STUFF_%1_DESCRIPTION", _this];

_return;