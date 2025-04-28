private "_ret";
_ret = [];
if (!isNil {PCS_RNK_RECORDS getVariable _this}) then
{
	_ret = (PCS_RNK_RECORDS getVariable _this) select 0;
};
_ret;