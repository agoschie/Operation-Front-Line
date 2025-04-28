private "_startDir";
private "_rotator";
_startDir = _this select 0;
_rotator = "logic" createVehicleLocal [0,0,0];
[_startDir, _startDir, _rotator, 1] call PCS_SHOP_SetRotator;
	
_rotator;