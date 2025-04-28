if ((_this select 1) == "__SERVER__") exitWith {};
reverse PCS_ON_DISCONNECTED_FNC_LIST;
{
	_this call _x;
} forEach PCS_ON_DISCONNECTED_FNC_LIST;
reverse PCS_ON_DISCONNECTED_FNC_LIST;