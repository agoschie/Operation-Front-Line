_vehicle = _this select 0;
_groundDistance = 10;
_wait = 1;

while {(alive _vehicle) && (!(isNull _vehicle))} do
{
	waitUntil {((((getPos _vehicle) select 2) <= _groundDistance) && ((driver _vehicle) == player)) || (!((alive _vehicle) && (!(isNull _vehicle))))};
	_action = _vehicle addAction ["RELEASE BUILD CRATE", "CLIENT_BUILD_SYSTEM\ReleaseBuildCrate.sqf", _vehicle];
	waitUntil {!((((getPos _vehicle) select 2) <= _groundDistance) && ((driver _vehicle) == player)) || (!((alive _vehicle) && (!(isNull _vehicle))))};
	_vehicle removeAction _action;
};