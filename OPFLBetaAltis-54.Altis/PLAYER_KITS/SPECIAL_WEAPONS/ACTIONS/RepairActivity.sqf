_repairAttempt = {
private "_friendUnit";
private "_person";
_friendUnit = cursorTarget;
_person = _this select 0;
if (!(((!isNull _friendUnit) && (alive _friendUnit)) && ((_friendUnit isKindOf "LandVehicle") || (_friendUnit isKindOf "Air") || (_friendUnit isKindOf "Ship")) && ((_person distance _friendUnit) < (sizeOf (typeOf _friendUnit))) && (((damage _friendUnit) > 0.4) || ([_friendUnit] call GSC_IsDisabled)))) exitWith {};

if (isNil {_person getVariable "PKS_REPAIR_ACTIVITY_IN_PROGRESS"}) then
{
	_person setVariable ["PKS_REPAIR_ACTIVITY_IN_PROGRESS", true];
	_null = [_person, _friendUnit] spawn PKS_RepairMode;
};
};

_repairMode = {

private "_friendUnit";
private "_person";
private "_i";
private "_fail";
_person = _this select 0;
_friendUnit = _this select 1;
_i = 0;
_fail = false;

_person playMove "ainvpknlmstpslaywrfldnon_medic";
_person sideChat "REPAIRING VEHICLE...";

while {_i < 29} do
{
	sleep 1;
	if ((!alive _friendUnit) || (!alive _person) || ((_friendUnit distance _person) >= (sizeOf (typeOf _friendUnit)))) exitWith {_fail = true; player sideChat "REPAIR FAILED!";};
	_i = _i + 1;
	if (_i == 7) then
	{
		_person playMove "ainvpknlmstpslaywrfldnon_medic";
	};
	if (_i == 15) then
	{
		_person playMove "ainvpknlmstpslaywrfldnon_medic";
	};
	if (_i == 22) then
	{
		_person playMove "ainvpknlmstpslaywrfldnon_medic";
	};
};

if (!_fail) then
{
	[[_friendUnit], "PKS_RepairMsg", PCS_S_SERVER, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic; 
	player sideChat "FINISHED REPAIRING...";
};

_person setVariable ["PKS_REPAIR_ACTIVITY_IN_PROGRESS", nil];
};

[[(_this select 0)], "PKS_RepairAttempt"] call PCS_SpawnAtomic;