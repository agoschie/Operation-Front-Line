if ((_this select 1) == "__SERVER__") exitWith {};
{
	_this call _x;
	_null = _this spawn {sleep 5; player sideChat format ["%1, RAN THE CONNECTED SCRIPT", (_this select 0)];};
} forEach PCS_ON_CONNECTED_FNC_LIST;