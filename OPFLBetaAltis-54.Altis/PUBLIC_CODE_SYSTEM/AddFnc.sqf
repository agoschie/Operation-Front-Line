//NOT MULTI-THREAD SAFE
if (true) exitWith {};
private "_return";
_return = false;
if (isNil "_this") exitWith {_return;};
if (("STRING" == typeName (_this select 0)) && ("CODE" == typeName (_this select 1))) then
{
	(uiNamespace getVariable "PCS_FNC_TABLE") setVariable [format ["PCS_FNC%1", PCS_NEXT_FNC_ID], (_this select 1)];
	(uiNamespace getVariable "PCS_FNC_TABLE") setVariable [(_this select 0), PCS_NEXT_FNC_ID];
	PCS_NEXT_FNC_ID = PCS_NEXT_FNC_ID + 1;
	_return = true;
};

_return;
