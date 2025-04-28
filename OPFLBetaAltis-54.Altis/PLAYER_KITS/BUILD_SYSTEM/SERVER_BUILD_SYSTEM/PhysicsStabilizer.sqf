private "_delay";
private "_vehicle";
private "_vel1";
_vehicle = _this select 0;
_delay = 5;

_vel1 = [_vehicle] spawn
{
	private "_vehicle";
	private "_wait";
	_vehicle = _this select 0;
	_wait = 1;
	while {_wait == 1} do
	{
		waitUntil {(((velocity _vehicle) select 2) > 0)};
		_vehicle setVelocity [0, 0, 0];
	};
};

sleep _delay;
terminate _vel1;