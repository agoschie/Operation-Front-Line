private "_flagObject";
private "_side";
private "_AMERICANS";
private "_RUSSIANS";
private "_captureLevel";
private "_supportLevel";
private "_timeCycle";
private "_mapUnits";
private "_isDestroyed";

_flagObject = _this select 0;
_timeCycle = _this select 1;
_side = _flagObject getVariable "FLAG_ZONE_SIDE";
_flagObject setVariable ["FLAG_ZONE_LAST_SCAN", diag_tickTime];
_mapUnits = AllUnits;
_destroyedType = [];
		
_AMERICANS = {(west == [_x] call GSC_Side) && (([_x, _flagObject] call GSC_2dDistance) < OPFL_ZONE_RADIUS)} count _mapUnits;
_RUSSIANS = {(east == [_x] call GSC_Side) && (([_x, _flagObject] call GSC_2dDistance) < OPFL_ZONE_RADIUS)} count _mapUnits;
	
_captureLevel = _flagObject getVariable "FLAG_ZONE_CAPTURED";
_supportLevel = _flagObject getVariable "FLAG_ZONE_SUPPORT";
		
if (_AMERICANS > _RUSSIANS) then
{
	switch (_side) do
	{
		case west:
		{
			if (_captureLevel < OPFL_ZONE_CAPTURE_TIME) then
			{
				_flagObject setVariable ["FLAG_ZONE_CAPTURED", (_captureLevel + _timeCycle)];
			};
		};
				
		case east:
		{
			if (_captureLevel > 0) then
			{
				_flagObject setVariable ["FLAG_ZONE_CAPTURED", (_captureLevel - _timeCycle)];
			}
			else
			{
				//OPFL_FLAG_ZONE_QUEUE set [(count OPFL_FLAG_ZONE_QUEUE), [[_flagObject, west], 3]];
				//waitUntil {_captureLevel > 0};
				_destroyedType = [_flagObject, west];
			};
		};
	};
			
};
		
if (_RUSSIANS > _AMERICANS) then
{
	switch (_side) do
	{
		case east:
		{
			if (_captureLevel < OPFL_ZONE_CAPTURE_TIME) then
			{
				_flagObject setVariable ["FLAG_ZONE_CAPTURED", (_captureLevel + _timeCycle)];
			};
		};
				
		case west:
		{
			if (_captureLevel > 0) then
			{
				_flagObject setVariable ["FLAG_ZONE_CAPTURED", (_captureLevel - _timeCycle)];
			}
			else
			{
				//OPFL_FLAG_ZONE_QUEUE set [(count OPFL_FLAG_ZONE_QUEUE), [[_flagObject, east], 3]];
				//waitUntil {_captureLevel > 0};
				_destroyedType = [_flagObject, east];
			};
		};
	};
};

switch (_side) do
{
	case west:
	{
		if (_AMERICANS < 1) then
		{
			if (_supportLevel > 0) then
			{
				//_flagObject setVariable ["FLAG_ZONE_SUPPORT", (_supportLevel - _timeCycle)];
			}
			else
			{
				//OPFL_FLAG_ZONE_QUEUE set [(count OPFL_FLAG_ZONE_QUEUE), [[_flagObject, west], 3]];
				//waitUntil {_supportLevel > 0};
				_destroyedType = [_flagObject, west];
			};
		}
		else
		{
			if (_supportLevel < OPFL_ZONE_DEATH_TIME) then
			{
				//_flagObject setVariable ["FLAG_ZONE_SUPPORT", (_supportLevel + _timeCycle)];
				_flagObject setVariable ["FLAG_ZONE_SUPPORT", OPFL_ZONE_DEATH_TIME];
			};
		};
	};
	
	case east:
	{
		if (_RUSSIANS < 1) then
		{
			if (_supportLevel > 0) then
			{
				//_flagObject setVariable ["FLAG_ZONE_SUPPORT", (_supportLevel - _timeCycle)];
			}
			else
			{
				//OPFL_FLAG_ZONE_QUEUE set [(count OPFL_FLAG_ZONE_QUEUE), [[_flagObject, east], 3]];
				//waitUntil {_supportLevel > 0};
				_destroyedType = [_flagObject, east];
			};
		}
		else
		{
			if (_supportLevel < OPFL_ZONE_DEATH_TIME) then
			{
				//_flagObject setVariable ["FLAG_ZONE_SUPPORT", (_supportLevel + _timeCycle)];
				_flagObject setVariable ["FLAG_ZONE_SUPPORT", OPFL_ZONE_DEATH_TIME];
			};
		};
	};
};

if ((count _destroyedType) > 0) then
{
	_destroyedType call OPFL_Server_DestroyFlagZone;
};