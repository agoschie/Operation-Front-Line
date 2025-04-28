private "_flagObject";
private "_initTime";
private "_playerPos";
private "_flagPos";
private "_sizePercent";
private "_flagState";
private "_beepTime";
private "_visualState";
private "_sound";
_flagObject = _this select 0;
_beepFloor = 0.1;

waitUntil
{
	_visualState = _flagObject getVariable "FLAG_ZONE_STATE";
	_flagState = _visualState select 0;
	_sizePercent = _visualState select 1;
	_flagPos = _visualState select 2;
	_playerPos = getPosASL player;
	if (_sizePercent < 1) then
	{
		_beepTime = 0.5 * _sizePercent;
		if (_beepTime <= _beepFloor) then
		{
			_beepTime = _beepFloor;
		};
	}
	else
	{
		_beepTime = 1;
	};
	
	if ((([_playerPos,_flagPos] call GSC_2dDistance) < OPFL_ZONE_RADIUS) && (_flagState == 2)) then
	{
		if (isNil "_initTime") then
		{
			if (isNil "OPFL_MUSIC_IN_USE") then
			{
				playMusic "FlagBeep";
			};
			_initTime = diag_tickTime;
		};
		if (diag_tickTime >= (_initTime + _beepTime)) then
		{
			if (isNil "OPFL_MUSIC_IN_USE") then
			{
				playMusic "FlagBeep";
			};
			_initTime = diag_tickTime;
		};
	}
	else
	{
		if (!isNil "_initTime") then
		{
			_initTime = nil;
		};
	};
	false
};
	