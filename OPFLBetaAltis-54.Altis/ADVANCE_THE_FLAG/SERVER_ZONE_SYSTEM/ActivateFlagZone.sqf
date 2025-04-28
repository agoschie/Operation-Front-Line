private "_flagObject";
//private "_zoneSide";
//private "_zoneName";
private "_wait";
private "_timeCycle";
private "_mapUnits";
private "_initialTime";

_flagObject = _this select 0;
_initialTime = time;
//_zoneSide = _flagObject getVariable "FLAG_ZONE_SIDE";
//_zoneName = _flagObject getVariable "FLAG_ZONE_NAME";
_wait = 1;
_timeCycle = 0.5; //only numbers that any number can be divided by into a whole number


while {_wait == 1} do
{
	if (!(_flagObject getVariable "FLAG_ZONE_READY")) then
	{
		if (time >= (_initialTime + OPFL_DEPLOY_READY_TIME)) then
		{
			_flagObject setVariable ["FLAG_ZONE_READY", true, true];
		};
	};
	
	_mapUnits = AllUnits;
	[_flagObject, _timeCycle] call OPFL_Server_ScanFlagZone;
	[_flagObject] call OPFL_Server_UpdateVisualState;
	
	sleep _timeCycle;
};	
