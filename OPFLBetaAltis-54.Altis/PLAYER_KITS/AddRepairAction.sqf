if (isNil "PKS_REPAIR_HANDLE") exitWith {};
private "_person";
private "_action";
_person = _this select 0;
	
if (!isNil "PKS_REPAIR_ACTION") then
{
	(PKS_REPAIR_ACTION select 0) removeAction (PKS_REPAIR_ACTION select 1);
};

_action = _person addAction [ "Repair Vehicle",
					PKS_RepairActivity, 
					[], 
					100, 
					false, 
					true, 
					"", 
					"!PCS_IN_VEHICLE && (((!isNull cursorTarget) && (alive cursorTarget) && isNil {cursorTarget getVariable 'PKS_NO_REPAIR'}) && ((cursorTarget isKindOf 'LandVehicle') || (cursorTarget isKindOf 'Air') || (cursorTarget isKindOf 'Ship')) && ((_target distance cursorTarget) < (sizeOf (typeOf cursorTarget))) && (((damage cursorTarget) > 0.4) || ([cursorTarget] call GSC_IsDisabled)))"];

PKS_REPAIR_ACTION = [_person, _action];