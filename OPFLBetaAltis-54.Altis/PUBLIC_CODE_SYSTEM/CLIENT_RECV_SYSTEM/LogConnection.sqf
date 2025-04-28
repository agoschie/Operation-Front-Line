private "_uid";
private "_type";
_uid = _this select 0;
_type = _this select 1;

if (_type == "INITIAL") then
{
	if (PCS_PLAYER_CAPACITY > count PCS_UID_INITIAL_LIST) then
	{
		PCS_UID_INITIAL_LIST set [(count PCS_UID_INITIAL_LIST), _uid];
	};
};

if (_type == "FAILED") then
{
	if (!(_uid in PCS_UID_CONNECTIONS_LIST)) then
	{
		PCS_UID_FAILED_LIST set [(count PCS_UID_FAILED_LIST), _uid];
	};
};