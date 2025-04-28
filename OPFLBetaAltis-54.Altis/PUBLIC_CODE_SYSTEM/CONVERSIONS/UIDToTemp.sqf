private "_return";
_return = -1;
if (!isNil {(uiNamespace getVariable "PCS_FNC_TABLE") getVariable format ["PCS_%1_CLIENT", _this]}) then
{
	_return = (uiNamespace getVariable "PCS_FNC_TABLE") getVariable format ["PCS_%1_CLIENT", _this];
};
_return;