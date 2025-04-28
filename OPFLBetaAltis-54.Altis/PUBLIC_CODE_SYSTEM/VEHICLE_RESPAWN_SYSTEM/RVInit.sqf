private ["_vehicle", "_init", "_rsTime", "_abTime", "_nearDist"];
_vehicle = _this select 0;
_init = _this select 1;
_rsTime = _this select 2;

if ((paramsArray select 6) != (_this select ((count _this) - 1))) exitWith
{
	if (isServer) then
	{
		_vehicle spawn 
		{
			sleep (5 / (1 + (random 100))); 
			deleteVehicle _this;
		};
	};
};

if (3 < count _this) then
{
	_abTime = _this select 3;
}
else
{
	_abTime = _rsTime;
};
if (4 < count _this) then
{
	_nearDist = _this select 4;
}
else
{
	_nearDist = 10;
};

if (isNil "VRS_INIT_LIST") then
{
	VRS_INIT_LIST = [compileFinal (_this select 1)];
}
else
{
	VRS_INIT_LIST set [count VRS_INIT_LIST, compileFinal (_this select 1)];
};
_vehicle hideObject true;

if (isServer) then
{
	private "_newVehicle";
	private "_type";
	private "_initPos";
	private "_initDir";
	_vehicle allowDamage false;
	_vehicle lock 2;
	_type = typeOf _vehicle;
	_initPos = getPosATL _vehicle;
	_initDir = getDir _vehicle;

	_newVehicle = _type createVehicle _initPos;
	_newVehicle setPosATL _initPos;
	_newVehicle setDir _initDir;
	_newVehicle setVariable ["VRS_INIT_POS", _initPos];
	_newVehicle setVariable ["VRS_INIT_DIR", _initDir]; 
	_newVehicle setVariable ["VRS_AB_TIME", _abTime];
	_newVehicle setVariable ["VRS_RS_TIME", _rsTime];
	_newVehicle setVariable ["VRS_AB_COUNT", _abTime];
	_newVehicle setVariable ["VRS_RS_COUNT", _rsTime];
	_newVehicle setVariable ["VRS_INIT_DMG", damage _newVehicle];
	_newVehicle setVariable ["VRS_NEAR_DIST", _nearDist];
	_newVehicle call compile (_this select 1);
	if (isNil "VRS_VEHICLE_LIST") then
	{
		VRS_VEHICLE_LIST = [_newVehicle];
	}
	else
	{
		VRS_VEHICLE_LIST set [count VRS_VEHICLE_LIST, _newVehicle];
	};
	
};
