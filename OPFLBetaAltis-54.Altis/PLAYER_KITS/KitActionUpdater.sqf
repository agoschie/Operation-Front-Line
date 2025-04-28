private "_code";
_code = _this select 0;

if (isServer) then
{
	if (!isNil {PKS_KIT_TABLE getVariable (_code select 6)}) exitWith {"DUPLICATE KIT NAME EXISTS!" createVehicleLocal [0,0,0];};
	PKS_KIT_TABLE setVariable [(_code select 6), (_code select 5), true];
};

if (isDedicated) exitWith {};
if (true) exitWith {};
_this spawn 
{
	private "_code";
	private "_crate";
	private "_listRank";
	private "_wait";
	private "_id";

	_code = _this select 0;
	_crate = _this select 1;
	_listRank = _this select 2;
	_wait = 1;
	_id = "none";

	waitUntil {!isNil {PKS_KIT_TABLE getVariable (_code select 6)}};

	while {_wait == 1} do
	{
		_lastVal = PKS_KIT_TABLE getVariable (_code select 6);
		if((typeName _id) != "STRING") then
		{
			_crate removeAction _id;
		};
		_id = _crate addAction [format ["%1 %2/%3", (_code select 0), _lastVal, (_code select 5)], PKS_SelectKit, (_code select 6), _listRank];
		waitUntil {_lastVal != (PKS_KIT_TABLE getVariable (_code select 6))};
	};
};