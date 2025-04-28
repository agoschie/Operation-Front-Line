_null = player addEventHandler ["HandleDamage", {
	_return = _this select 2;
	if (([_this select 0] call GSC_InSafeZone) || ([_this select 3] call GSC_InSafeZone)) then
	{
		_return = false;
	};
	_return;
}];

_null = player addEventHandler ["Fired", {
		_this call OPFL_Client_SafeZoneMsg;
}];