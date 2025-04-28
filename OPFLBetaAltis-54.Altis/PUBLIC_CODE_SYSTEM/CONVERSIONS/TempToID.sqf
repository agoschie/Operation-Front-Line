private "_return";
_return = "";
if (!isNil {(uiNamespace getVariable "PCS_FNC_TABLE") getVariable format ["PCS_%1_ID", _this]}) then
{
	_return = (uiNamespace getVariable "PCS_FNC_TABLE") getVariable format ["PCS_%1_ID", _this];
};
_return;