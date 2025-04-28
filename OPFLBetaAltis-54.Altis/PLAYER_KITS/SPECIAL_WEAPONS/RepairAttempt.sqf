private "_friendUnit";
private "_person";
_friendUnit = cursorTarget;
_person = _this select 0;
if (!(((!isNull _friendUnit) && (alive _friendUnit)) && ((_friendUnit isKindOf "LandVehicle") || (_friendUnit isKindOf "Air") || (_friendUnit isKindOf "Ship")) && ((_person distance _friendUnit) < (sizeOf (typeOf _friendUnit))) && (((damage _friendUnit) > 0.4) || ([_friendUnit] call GSC_IsDisabled)))) exitWith {};

if (!PKS_PLAYER_IS_BUSY && isNil {_person getVariable "PKS_REPAIR_ACTIVITY_IN_PROGRESS"}) then
{
	_person setVariable ["PKS_REPAIR_ACTIVITY_IN_PROGRESS", true];
	PKS_PLAYER_IS_BUSY = true;
	_null = [_person, _friendUnit] spawn PKS_RepairMode;
};