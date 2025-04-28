private "_person";
private "_side";
private "_oldBody";
private "_UID";
private "_wait";

_person = _this select 0;
_side = _this select 1;
_UID = _this select 2;
_oldBody = "none";
_wait = 1;	

while {_wait == 1} do
{
	waitUntil {_UID != getPlayerUID _person};
	"player respawn" createVehicleLocal [0,0,0];
	_oldBody = _person;
	_wait = 0;
	{
		if ((getPlayerUID _x) == _UID) then 
		{
			_person = _x; 
			_wait = 1;
		};
	} foreach playableUnits;
	if (_wait == 1) then
	{
		if (!isNil "OPFL_ALL_FLAGS_CREATED" && !OPFL_ROUND_MODE) then
		{
			"ticket loss from respawn" createVehicleLocal [0,0,0];
			OPFL_TICKET_QUEUE set [(count OPFL_TICKET_QUEUE), [_side, false]];
		};
		_null = [_oldBody] spawn OPFL_Server_CleanBody;
	};
};

_null = [_oldBody] spawn OPFL_Server_CleanBody;