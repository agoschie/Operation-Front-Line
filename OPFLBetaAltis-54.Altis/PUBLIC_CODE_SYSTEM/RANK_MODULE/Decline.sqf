if ((_this call PCS_IDToUID) != "") then
{
	"1234" serverCommand format ["#exec kick '%1'", _this call PCS_IDToUID];
};