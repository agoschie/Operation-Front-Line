if ((_this call PCS_IDToUID) != "") then
{
	PCS_RNK_RECORDS setVariable [format ["%1_AGREED", _this call PCS_IDToUID], true];
};