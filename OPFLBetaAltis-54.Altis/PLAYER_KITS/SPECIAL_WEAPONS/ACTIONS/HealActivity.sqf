_healAttempt = {
private "_friendUnit";
private "_person";
_friendUnit = cursorTarget;
_person = _this select 0;
if (!((!isNull _friendUnit) && (_friendUnit isKindOf "Man") && (playerSide == ([_friendUnit] call GSC_Side)) && ((_person distance _friendUnit) < 3) && ((damage _friendUnit) > 0))) exitWith {};

if (isNil {_person getVariable "PKS_HEAL_ACTIVITY_IN_PROGRESS"}) then
{
	_person setVariable ["PKS_HEAL_ACTIVITY_IN_PROGRESS", true];
	//[_person, _friendUnit] spawn (_this select 1);
	[_person, _friendUnit] spawn PKS_HealMode;	
};
};

_healMode = {

private "_friendUnit";
private "_i";
private "_fail";
private "_person";
private "_friendUID";
_person = _this select 0;
_friendUnit = _this select 1;
_i = 0;
_fail = false;

_person playMove "ainvpknlmstpslaywrfldnon_medic";
_person sideChat "HEALING FRIEND...";

while {_i < 7} do
{
	sleep 1;
	if ((!alive _friendUnit) || (!alive _person) || ((_friendUnit distance player) >= 3)) exitWith {_fail = true; player sideChat "HEAL FAILED!";};
	_i = _i + 1;
};

if (!_fail) then
{
	if (local _friendUnit) then
	{
		_friendUID = getPlayerUID player;
	}
	else
	{
		_friendUID = getPlayerUID _friendUnit;
	};
	[_friendUnit, "PKS_HealMsg", _friendUnit, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic; 
	player sideChat "FINISHED HEALING...";
};

_person setVariable ["PKS_HEAL_ACTIVITY_IN_PROGRESS", nil];
};
[[(_this select 0)], "PKS_HealAttempt"] call PCS_SpawnAtomic;