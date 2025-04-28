private ["_loading", "_body", "_kitName", "_handle"];
_loading = _this select 0;
_body = _this select 1;
_kitName = _this select 2;

if (_loading) then
{
	if (!isNil "PKS_REPAIR_ACTION" || !isNil "PKS_REPAIR_HANDLE") exitWith {diag_log format ["PLAYER KIT SYSTEM: Error, possible duplicate special ability, %1", _kitName];}; //already enabled
	
	PKS_REPAIR_HANDLE = player addEventHandler ["Respawn", {
	[_this select 0] call PKS_AddRepairAction;
	}];
	
	[player] call PKS_AddRepairAction;
}
else
{
	if (!isNil "PKS_REPAIR_ACTION" && !isNil "PKS_REPAIR_HANDLE") then
	{
		(PKS_REPAIR_ACTION select 0) removeAction (PKS_REPAIR_ACTION select 1);
		player removeEventHandler ["Respawn", PKS_REPAIR_HANDLE];
		PKS_REPAIR_ACTION = nil;
		PKS_REPAIR_HANDLE = nil;
	}
	else
	{
		diag_log format ["PLAYER KIT SYSTEM: Error, possible duplicate special ability, %1", _kitName];
	};
};