private "_return";
_return = [];
if (isNil "_this") exitWith {};
private ["_magazines", "_weapons", "_kitName", "_kitTag", "_return", "_limit", "_buildings", "_special", "_description", "_altPrimary", "_altScope"];
_return = call (PKS_KIT_TABLE getVariable format ["KIT_STUFF_%1", _this]);
_return deleteAt 7;
_return;