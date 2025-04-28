private "_vehicle";
private "_rsTime";
private "_markerPos";
private "_rsType";
private "_shapes";
private "_wait";

if (!isServer) exitWith {};

_vehicle = _this select 0;
_rsTime = _this select 1;
_marker = _this select 2;
_rsType = _this select 3;
_timeOut = _this select 4;
_shapes = ["ICON", "RECTANGLE", "ELLIPSE"];
_wait = 1;

if (!((markerShape _marker) in _shapes)) then
{
	_null = createMarkerLocal [_marker, (getPos _vehicle)];
	_marker setMarkerShapeLocal "ELLIPSE";
	_marker setMarkerSizeLocal [0,0];
	_marker setMarkerDirLocal (getDir _vehicle);
};

_resB = [_vehicle, _timeOut, _rsTime] spawn
{
	if (_timeOut <= 0) exitWith {};
	private "_vehicle";
	private "_timeOut";
	private "_wait";
	private "_startPos";
	private "_startDamage";
	_vehicle = _this select 0;
	_timeOut = _this select 1;
	_rsTime = _this select 2;
	_wait = 1;
	_startPos = getPos _vehicle;
	_startDamage = damage _vehicle;
	
	while {_wait == 1} do
	{
		waitUntil {(((count crew _vehicle) < 1) && ([_vehicle, _startPos, _startDamage] call GSC_UsedVehicle)) || (!alive _vehicle)};
		if (alive _vehicle) then
		{
			_rTime = (time + _timeOut);
			waitUntil {(time > _rTime) || ((count crew _vehicle) > 0) || (!alive _vehicle)};
			if ((alive _vehicle) && (time > _rTime) && ((count crew _vehicle) < 1)) then
			{
				_vehicle setVariable ["RESPAWN_VEHICLE_NOW", true];
				_wait = 0;
			};
		}
		else
		{
			_wait = 0;
			if (!isNull _vehicle) then
			{
				_rTime = (time + _rsTime);
				waitUntil {(time > _rTime) || (isNull _vehicle)};
				if (!isNull _vehicle) then
				{
					_vehicle setVariable ["RESPAWN_VEHICLE_NOW", true];
				};
			};
		};
	};
};

_resC = [_vehicle, _marker, _rsType, _resB] spawn
{
	private "_vehicle";
	private "_marker";
	private "_rsType";
	private "_SR";
	_vehicle = _this select 0;
	_marker = _this select 1;
	_rsType = _this select 2;
	_respawnSR = _this select 3;
	
	waitUntil {(!isNil {_vehicle getVariable "RESPAWN_VEHICLE_NOW"}) || (isNull _vehicle)};
	terminate _respawnSR;
	_null = [_vehicle, _marker, _rsType] spawn PKS_ServerBS_RespawnObject;
};

_vehicle setVariable ["OPFL_VEHICLE_SR", [_resC, _resB]];
