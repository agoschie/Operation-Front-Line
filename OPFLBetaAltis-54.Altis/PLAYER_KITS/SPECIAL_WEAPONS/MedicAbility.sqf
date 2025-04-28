private ["_loading", "_body", "_kitName", "_handle"];
_loading = _this select 0;
_body = _this select 1;
_kitName = _this select 2;

if (_loading) then
{
	if (!isNil "PKS_MEDIC_ACTION" || !isNil "PKS_MEDIC_HANDLE") exitWith {diag_log format ["PLAYER KIT SYSTEM: Error, possible duplicate special ability, %1", _kitName];}; //already enabled
	
	PKS_MEDIC_HANDLE = player addEventHandler ["Respawn", {
		[_this select 0] call PKS_AddMedicAction;
	}];
	
	[player] call PKS_AddMedicAction;
}
else
{
	if (!isNil "PKS_MEDIC_ACTION" && !isNil "PKS_MEDIC_HANDLE") then
	{
		(PKS_MEDIC_ACTION select 0) removeAction (PKS_MEDIC_ACTION select 1);
		player removeEventHandler ["Respawn", PKS_MEDIC_HANDLE];
		PKS_MEDIC_ACTION = nil;
		PKS_MEDIC_HANDLE = nil;
	}
	else
	{
		diag_log format ["PLAYER KIT SYSTEM: Error, possible duplicate special ability, %1", _kitName];
	};
};