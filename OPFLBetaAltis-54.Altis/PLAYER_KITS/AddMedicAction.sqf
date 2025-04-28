if (isNil "PKS_MEDIC_HANDLE") exitWith {};
private "_person";
private "_action";
_person = _this select 0;
	
if (!isNil "PKS_MEDIC_ACTION") then
{
	(PKS_MEDIC_ACTION select 0) removeAction (PKS_MEDIC_ACTION select 1);
};
_action = _person addAction [ "Heal Friend",
					PKS_HealActivity, 
					[], 
					100, 
					false, 
					true, 
					"", 
					"!PCS_IN_VEHICLE && (!isNull cursorTarget) && (alive cursorTarget) && (cursorTarget isKindOf 'Man') && (playerSide == ([cursorTarget] call GSC_Side)) && ((_target distance cursorTarget) < 3) && ((damage cursorTarget) > 0)"];

PKS_MEDIC_ACTION = [_person, _action];