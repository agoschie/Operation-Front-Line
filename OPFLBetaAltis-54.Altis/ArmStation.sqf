_armStation = _this select 0;
_delay = _this select 1;
_armDistance = 15;

_armStation setVariable ["ARM_STATION_DELAY", _delay];
_armStation setVariable ["ARM_STATION_DISTANCE", _armDistance];

_null = [_armStation, _armDistance] spawn
{
	private "_armStation";
	private "_armDistance";
	_armStation = _this select 0;
	_armDistance = _this select 1;
	if (!isDedicated) then
	{
		_armDistance = 15;
		_wait = 1;
		while {_wait == 1} do
		{
			waitUntil {((player distance _armStation) <= _armDistance) && ((vehicle player) != player) && ((driver (vehicle player)) == player)};
			_vehicle = (vehicle player);
			_action = _vehicle addAction ["RE-ARM AT STATION", "reload.sqf", [_vehicle, _armStation]];
			waitUntil {!(((player distance _armStation) <= _armDistance) && ((vehicle player) != player) && ((driver (vehicle player)) == player))};
			_vehicle removeAction _action;
		};
	};
};