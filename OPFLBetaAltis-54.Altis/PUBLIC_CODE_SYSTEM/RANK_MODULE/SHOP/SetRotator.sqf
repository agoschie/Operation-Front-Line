private "_lastTime";
private "_lastDir";
private "_rotator";
private "_rotateSpeed";
private "_endDir";
private "_dirLeft";
private "_timeLeft";
_endDir = _this select 0;
_lastDir = _this select 1;
_rotator = _this select 2;
_rotateSpeed = _this select 3;

//_endDir = [_endDir] call PCS_SHOP_NormalizeAngle;
_lastDir = [_lastDir] call PCS_SHOP_NormalizeAngle;
_lastDir = [_lastDir] call PCS_SHOP_TrimInfinitesmal;
_endDir = [_endDir] call PCS_SHOP_TrimInfinitesmal;

_rotator setVariable ["lastTimeLapse", 0];
_rotator setVariable ["lastDir", _lastDir];
_rotator setVariable ["startDir", _lastDir];
_rotator setVariable ["endDir", _endDir];
_rotator setVariable ["totalTime", 0];
_rotator setVariable ["Processing", false];
_rotator setVariable ["Finished", false];
_rotator setVariable ["rotateSpeed", _rotateSpeed];

_dirLeft = [_endDir - _lastDir] call PCS_SHOP_TrimInfinitesmal;
if (_rotateSpeed > 0) then
{
	_dirLeft = (_endDir - _lastDir);
	if (_dirLeft >= 0) then
	{
		_timeLeft = _dirLeft / _rotateSpeed;
	}
	else
	{
		_dirLeft = (360 - _lastDir) + _endDir;
		_timeLeft = _dirLeft / _rotateSpeed;
	};
}
else
{
	
	if (_dirLeft < 0) then
	{
		_timeLeft = _dirLeft / _rotateSpeed;
	}
	else
	{
		_dirLeft = 360 - _dirLeft;
		_timeLeft = _dirLeft / (-1 * _rotateSpeed);
	};
};
_timeLeft = [_timeLeft] call PCS_SHOP_NormalizeFloat;
_rotator setVariable ["endTime", _timeLeft];