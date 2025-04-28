private "_deltaAngle";
private "_newTime";
private "_oldTime";
private "_totalTime";
private "_deltaTime";
private "_rotator";
private "_finished";
private "_processing";
private "_rotateSpeed";
private "_endTime";

_rotator = _this select 0;
_finished = _rotator getVariable "Finished";
_processing = _rotator getVariable "Processing";
//player SideChat format ["END: %1", (_rotator getVariable "endDir")];
if (_finished) exitWith {(_rotator getVariable "endDir");};
if (!_processing) exitWith
{
	//started
	_rotator setVariable ["lastTimeLapse", diag_tickTime];
	_rotator setVariable ["Processing", true];
	(_rotator getVariable "startDir");
};

if (_processing) then
{
	_endTime = _rotator getVariable "endTime";
	_totalTime = _rotator getVariable "totalTime";
	_rotateSpeed = _rotator getVariable "rotateSpeed";
	_lastDir = _rotator getVariable "lastDir";
	_oldTime = _rotator getVariable "lastTimeLapse";
	_newTime = diag_tickTime;
	_rotator setVariable ["lastTimeLapse", _newTime];
	_deltaTime = (_newTime - _oldTime);
	_deltaAngle = (_deltaTime * _rotateSpeed);
	_deltaAngle = [_deltaAngle] call PCS_SHOP_NormalizeFloat;
	_deltaAngle = _deltaAngle + _lastDir;
	_deltaAngle = [_deltaAngle] call PCS_SHOP_NormalizeAngle;
	_rotator setVariable ["lastDir", _deltaAngle];
	_totalTime = _deltaTime + _totalTime;
	_rotator setVariable ["totalTime", _totalTime];
	//hint format ["OLD: %1\nNEW: %2\nDELTA: %3\nANGLE: %4", _oldTime, _newTime, _endTime, _totalTime];
};

if (_totalTime >= _endTime) then
{
	//hint format ["OLD: %1\nNEW: %2\nDELTA: %3\nANGLE: %4", _oldTime, _newTime, _endTime, _totalTime];
	_rotator setVariable ["Processing", false];
	_rotator setVariable ["Finished", true];
	_deltaAngle = _rotator getVariable "endDir";
};
//player SideChat format ["END: %1 TOTAL: %2 END: %3 ANGLE: %4", _endTime, _totalTime, (_rotator getVariable "endDir"), _deltaAngle];
_deltaAngle;