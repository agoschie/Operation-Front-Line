//this function should only be called in non-scheduled environment due to race-conditions
if (_this getVariable ["GSC_SZP_DISABLED", true]) then
{
	_null = _this addEventHandler ["HandleDamage", {
		if (isNil "GSC_InSafeZone") exitWith {false};
		_return = _this select 2;
		if (([_this select 0] call GSC_InSafeZone) || ([_this select 3] call GSC_InSafeZone)) then
		{
			_return = false;
		};
		_return;
	}];
	_this setVariable ["GSC_SZP_DISABLED", false];
};
