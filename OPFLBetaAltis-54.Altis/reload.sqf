private "_refreshObject";
private "_armStation";
private "_i";
private "_delay";
private "_armDistance";

_refreshObject = ((_this select 3) select 0);
_armStation = ((_this select 3) select 1);

if ((!alive _refreshObject) || (_refreshObject isKindOf "ParachuteBase")) exitWith {_refreshObject vehicleChat "VEHICLE WORKER: I cant rearm this...";};
if (isNil {_refreshObject getVariable "OPFL_RELOAD_IN_PROGRESS"}) then
{
	_refreshObject setVariable ["OPFL_RELOAD_IN_PROGRESS", false, true];
};
if (_refreshObject getVariable "OPFL_RELOAD_IN_PROGRESS") exitWith {_refreshObject vehicleChat "VEHICLE WORKER: Currently rearming...";};
_refreshObject setVariable ["OPFL_RELOAD_IN_PROGRESS", true, true];

_delay = _armStation getVariable "ARM_STATION_DELAY";
_armDistance = _armStation getVariable "ARM_STATION_DISTANCE";

_refreshObject vehicleChat format ["VEHICLE WORKER: Rearming this is going to take %1 seconds...", _delay];
_i = (time + (parseNumber _delay));
waitUntil {(time > _i) || (!alive _refreshObject) || ((_refreshObject distance _armStation) > _armDistance)};


if ((alive _refreshObject) && ((_refreshObject distance _armStation) <= _armDistance)) then
{
	_null = [[_refreshObject], "_null = _this spawn AmmoHolder_NewReload;", PCS_S_SERVER] spawn PCS_MPCodeBroadcast;
	sleep 1;
	_refreshObject vehicleChat "VEHICLE WORKER: Done rearming!";
}
else
{
	_refreshObject vehicleChat "VEHICLE WORKER: I can not rearm the vehicle anymore!";
};

_refreshObject setVariable ["OPFL_RELOAD_IN_PROGRESS", false, true];