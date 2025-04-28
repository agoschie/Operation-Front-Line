private "_vehicle";
private "_hideCount";

_vehicle = _this select 0;

_vehicle hideObject true;

_this spawn
{
	private "_vehicle";
	private "_hideCount";
	_vehicle = _this select 0;
	_hideCount = _this select 1;
	sleep random 1;
	waitUntil {!isNil "PCS_TOTAL_PLAYERS"};
	waitUntil {PCS_TOTAL_PLAYERS >= _hideCount};

	_vehicle hideObject false;
};
