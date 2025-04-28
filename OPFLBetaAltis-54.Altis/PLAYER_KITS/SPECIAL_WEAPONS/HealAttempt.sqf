private "_friendUnit";
private "_person";
_friendUnit = cursorTarget;
_person = _this select 0;
if (!((!isNull _friendUnit) && (_friendUnit isKindOf "Man") && (playerSide == ([_friendUnit] call GSC_Side)) && ((_person distance _friendUnit) < 3) && ((damage _friendUnit) > 0))) exitWith {};

if (!PKS_PLAYER_IS_BUSY && isNil {_person getVariable "PKS_HEAL_ACTIVITY_IN_PROGRESS"}) then
{
	_person setVariable ["PKS_HEAL_ACTIVITY_IN_PROGRESS", true];
	PKS_PLAYER_IS_BUSY = true;
	//[_person, _friendUnit] spawn (_this select 1);
	[_person, _friendUnit] spawn PKS_HealMode;	
};