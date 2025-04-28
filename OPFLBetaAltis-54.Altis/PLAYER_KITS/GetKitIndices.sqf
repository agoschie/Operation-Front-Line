private "_return";
_return = [];
if (isNil "_this") exitWith {};

_return = (PKS_KIT_TABLE getVariable format ["KIT_INDEX_%1", _this]);
_return;