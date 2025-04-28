private "_wait";
private "_CONNECT";
private "_DISCONNECT";
private "_SET_TARGET";
private "_SET_OFFSET";
private "_REFRESH_SAT_LIST";
private "_FIRE";
private "_timeCycle";
private "_lastCreateTime";
private "_leadingSpawnTime";
private "_currentTime";

_timeCycleTraj = 0.25;

_lastTimeTraj = 0;

_wait = 1;

//states
_CONNECET = 1;
_DISCONNECT = 2;
_SET_TARGET = 3;
_SET_OFFSET = 4;
_REFRESH_SAT_LIST = 5;
_FIRE = 6;

_lastCreateTime = (EMP_SAT_GROUPS select 0) select EMP_SAT_GROUP_SIZE;
_leadingSpawnTime = _lastCreateTime;

waitUntil
{
	_currentTime = diag_tickTime;
	if ((count EMP_SERVER_EMP_QUEUE) > 0) then
	{	
		call EMP_ServerEMPQueue;
	};

	if (EMP_TIME_SPACING <= (_currentTime - _lastCreateTime)) then
	{
		[] call EMP_CreateSatGroup;
		_lastCreateTime = (EMP_SAT_GROUPS select (EMP_GROUP_COUNT - 1)) select (2*EMP_SAT_GROUP_SIZE);
		_isEMPty = false;
	};

	if (EMP_GROUP_COUNT > 0) then
	{
		if (EMP_ARC_TIME <= (_currentTime - _leadingSpawnTime)) then
		{
			[0] call EMP_DeleteSatGroup; //put in first index  
			if (EMP_GROUP_COUNT > 0) then
			{
				_leadingSpawnTime = (EMP_SAT_GROUPS select 0) select (2*EMP_SAT_GROUP_SIZE);
			};
		};
	};

	
	false
};
