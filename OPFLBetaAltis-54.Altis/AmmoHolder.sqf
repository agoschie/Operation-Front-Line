_armStation = _this select 0;
_ammoCharges = _this select 1;
_kitCharges = _this select 2;
_healCharges = _this select 3;
_userClasses = _this select 4;
_respawnable = _this select 5;

_delay = "1";
_armDistance = 15;

_ammoIndex = 0;
_kitIndex = 1;
_healIndex = 2;

_armStation setVariable ["ARM_STATION_DELAY", _delay];
_armStation setVariable ["ARM_STATION_DISTANCE", _armDistance];
_armStation setVariable ["ARM_STATION_AMMO_CHARGES", _ammoCharges];
_armStation setVariable ["ARM_STATION_K_Charges", _kitCharges];
_armStation setVariable ["ARM_STATION_H_Charges", _healCharges];

_acScript = [_armStation, _armDistance, _userClasses] spawn
{
	private "_armStation";
	private "_armDistance";
	private "_userClasses";
	private "_action";
	_armStation = _this select 0;
	_armDistance = _this select 1;
	_userClasses = _this select 2;
	_action = "none";
	if (!isDedicated) then
	{
		_wait = 1;
		while {(_armStation getVariable "ARM_STATION_AMMO_CHARGES") > 0} do
		{
			waitUntil {(((player distance _armStation) <= _armDistance) && ((vehicle player) != player) && (({(vehicle player) isKindOf _x} count _userClasses) > 0)) || ((_armStation getVariable "ARM_STATION_AMMO_CHARGES") < 1)};
			_vehicle = (vehicle player);
			if (((_armStation getVariable "ARM_STATION_AMMO_CHARGES") > 0)) then
			{
				_action = _vehicle addAction ["RE-ARM AT SUPPORT BOX", "AMMO_HOLDER\RechargeVehicle.sqf", [_vehicle, _armStation]];
			};
			waitUntil {(!(((player distance _armStation) <= _armDistance) && ((vehicle player) != player) && (({(vehicle player) isKindOf _x} count _userClasses) > 0))) || ((_armStation getVariable "ARM_STATION_AMMO_CHARGES") < 1)};
			if ((typeName _action) != "STRING") then
			{
				_vehicle removeAction _action;
				_action = "none";
			};
		};
	};
};

_kcScript = [_armStation, _armDistance] spawn
{
	private "_armStation";
	private "_armDistance";
	private "_action";
	_armStation = _this select 0;
	_armDistance = _this select 1;
	_action = "none";
	if (!isDedicated) then
	{
		_wait = 1;
		while {(_armStation getVariable "ARM_STATION_H_CHARGES") > 0} do
		{
			waitUntil {((player distance _armStation) <= (_armDistance * (1/3))) || ((_armStation getVariable "ARM_STATION_H_CHARGES") < 1)};
			if (((_armStation getVariable "ARM_STATION_H_CHARGES") > 0) && (!(OPFL_ACE_ENABLED))) then
			{
				_action = player addAction ["HEAL AT SUPPORT BOX", "AMMO_HOLDER\RechargeHealth.sqf", [player, _armStation]];
			};
			waitUntil {!(((player distance _armStation) <= (_armDistance * (1/3)))) || ((_armStation getVariable "ARM_STATION_H_CHARGES") < 1)};
			if ((typeName _action) != "STRING") then
			{
				player removeAction _action;
				_action = "none";
			};
		};
	};
};

_hcScript = [_armStation, _armDistance] spawn
{
	private "_armStation";
	private "_armDistance";
	private "_action";
	_armStation = _this select 0;
	_armDistance = _this select 1;
	_action = "none";
	if (!isDedicated) then
	{
		_wait = 1;
		while {(_armStation getVariable "ARM_STATION_K_CHARGES") > 0} do
		{
			waitUntil {((player distance _armStation) <= (_armDistance * (1/3))) || ((_armStation getVariable "ARM_STATION_K_CHARGES") < 1)};
			if (((_armStation getVariable "ARM_STATION_K_CHARGES") > 0)) then
			{
				_action = player addAction ["REFRESH KIT AT SUPPORT BOX", "AMMO_HOLDER\RechargeKit.sqf", [_vehicle, _armStation]];
			};
			waitUntil {!(((player distance _armStation) <= (_armDistance * (1/3)))) || ((_armStation getVariable "ARM_STATION_K_CHARGES") < 1)};
			if ((typeName _action) != "STRING") then
			{
				player removeAction _action;
				_action = "none";
			};
		};
	};
};
if (isServer && _respawnable) then
{
	_null = [_armStation, _ammoCharges, _kitCharges, _healCharges] spawn
	{
		private "_armStation";
		private "_armStationType";
		private "_armStationPos";
		private "_armStationDir";
		private "_ammoCharges";
		private "_kitCharges";
		private "_healCharges";
		
		_armStation = _this select 0;
		_ammoCharges = _this select 1;
		_kitCharges = _this select 2;
		_healCharges = _this select 3;
		
		_armStationType = typeOf _armStation;
		_armStationPos = getPos _armStation;
		_armStationDir = getDir _armStation;
		
		waitUntil {((_armStation getVariable "ARM_STATION_AMMO_CHARGES") < 1) && ((_armStation getVariable "ARM_STATION_K_CHARGES") < 1) && ((_armStation getVariable "ARM_STATION_H_CHARGES") < 1)};
		deleteVehicle _armStation;
		_armStation = _armStationType createVehicle _armStationPos;
		_armStation setDir _armStationDir;
		_armStation setPos _armStationPos;
		_armStation setVehicleInit format ["_null = [this, %1, %2, %3] execVM 'AmmoHolder.sqf'", _ammoCharges, _kitCharges, _healCharges];
		processInitCommands;
	};
};
/**
if (isServer && (isNil "DELETE_REARM_VEHICLE_AB")) then
{
	DELETE_REARM_VEHICLE_AB = [false, 'none', ['none']];
	_wait = 1;
	while {_wait == 1} do
	{
		waitUntil {DELETE_REARM_VEHICLE_AB select 0};
		_armData = + DELETE_REARM_VEHICLE_AB;
		DELETE_REARM_VEHICLE_AB = [false, 'none', ['none']];
		if ((_armData select 5) == _ammoIndex) then
		{ 
			__null = [_armData] spawn _VEHICLE_REFRESH;
		};
		if ((_armData select 5) == _kitIndex) then
		{
			_null = [_armData] spawn _KIT_REFRESH;
		};
		if ((_armData select 5) == _healIndex) then
		{
			_null = [_armData] spawn _HEAL_REFRESH;
		};
	};
};
**/
