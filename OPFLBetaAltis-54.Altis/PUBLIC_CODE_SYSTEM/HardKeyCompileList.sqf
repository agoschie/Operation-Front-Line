diag_log "EXECUTE HARD COMPILE";
private ["_paths", "_names", "_return", "_keyA", "_keyB"];
_return = true;
_keyA = format ["PCS_KA_%1", _this select 0];
_keyB = format ["PCS_KB_%1", _this select 1];

_paths = [
	"ADVANCE_THE_FLAG\CLIENT_ZONE_SYSTEM\AddUnlockAction.sqf",
	"ADVANCE_THE_FLAG\CLIENT_ZONE_SYSTEM\AttemptDeployRP.sqf", 
	"ADVANCE_THE_FLAG\CLIENT_ZONE_SYSTEM\AttemptVote.sqf", 
	"ADVANCE_THE_FLAG\CLIENT_ZONE_SYSTEM\DeployZone.sqf", 
	"ADVANCE_THE_FLAG\CLIENT_ZONE_SYSTEM\PickUpZone.sqf", 
	"ADVANCE_THE_FLAG\CLIENT_ZONE_SYSTEM\ReDeployZone.sqf", 
	"ADVANCE_THE_FLAG\CLIENT_ZONE_SYSTEM\RedeployMode.sqf", 
	"ADVANCE_THE_FLAG\CLIENT_ZONE_SYSTEM\UndeployMode.sqf", 
	"ADVANCE_THE_FLAG\GROUP_MANAGER\CloseGroup.sqf", 
	"ADVANCE_THE_FLAG\GROUP_MANAGER\GetAllGroups.sqf", 
	"ADVANCE_THE_FLAG\GROUP_MANAGER\GroupDisconnect.sqf", 
	"ADVANCE_THE_FLAG\GROUP_MANAGER\JoinGroup.sqf", 
	"ADVANCE_THE_FLAG\GROUP_MANAGER\KickPlayer.sqf", 
	"ADVANCE_THE_FLAG\GROUP_MANAGER\LeaveGroup.sqf", 
	"ADVANCE_THE_FLAG\GROUP_MANAGER\LoadGUI.sqf", 
	"ADVANCE_THE_FLAG\GROUP_MANAGER\OpenGroup.sqf", 
	"ADVANCE_THE_FLAG\GROUP_MANAGER\PromoteLeader.sqf", 
	"ADVANCE_THE_FLAG\InitOPFL.sqf", 
	"ADVANCE_THE_FLAG\SERVER_ZONE_SYSTEM\DeployRP.sqf", 
	"ADVANCE_THE_FLAG\SERVER_ZONE_SYSTEM\DestroyFlagZone.sqf", 
	"ADVANCE_THE_FLAG\SERVER_ZONE_SYSTEM\FlagZoneThread.sqf", 
	"ADVANCE_THE_FLAG\SERVER_ZONE_SYSTEM\FortifyRP.sqf", 
	"ADVANCE_THE_FLAG\SERVER_ZONE_SYSTEM\RequestAllRP.sqf", 
	"ADVANCE_THE_FLAG\SERVER_ZONE_SYSTEM\TicketClockThread.sqf", 
	"ADVANCE_THE_FLAG\SERVER_ZONE_SYSTEM\UnDeployFlagZone.sqf",
	"PLAYER_KITS\BUILD_SYSTEM\CLIENT_BUILD_SYSTEM\BuildTimeClock.sqf", 
	"PLAYER_KITS\DisconnectKit.sqf", 
	"PLAYER_KITS\GUI_SCRIPTS\SelectKitGUI.sqf", 
	"PLAYER_KITS\InitPlayerKits.sqf", 
	"PLAYER_KITS\SPECIAL_WEAPONS\ACTIONS\DeployFBPActivity.sqf", 
	"PLAYER_KITS\SPECIAL_WEAPONS\ACTIONS\HealActivity.sqf", 
	"PLAYER_KITS\SPECIAL_WEAPONS\ACTIONS\RepairActivity.sqf", 
	"PLAYER_KITS\SPECIAL_WEAPONS\HealMode.sqf", 
	"PLAYER_KITS\SPECIAL_WEAPONS\RepairMode.sqf", 
	"PLAYER_KITS\SelectKit.sqf", 
	"PLAYER_KITS\SetKit.sqf",  
	"PUBLIC_CODE_SYSTEM\CLIENT_RECV_SYSTEM\BroadcastWeather.sqf", 
	"PUBLIC_CODE_SYSTEM\RANK_MODULE\AgreedButton.sqf", 
	"PUBLIC_CODE_SYSTEM\RANK_MODULE\DeclineButton.sqf", 
	"PUBLIC_CODE_SYSTEM\RANK_MODULE\LoadGUI.sqf", 
	"PUBLIC_CODE_SYSTEM\RANK_MODULE\SHOP\LockVehicle.sqf", 
	"PUBLIC_CODE_SYSTEM\RANK_MODULE\SHOP\UnlockVehicle.sqf", 
	"PUBLIC_CODE_SYSTEM\SafeSpawn.sqf", 
	"PUBLIC_CODE_SYSTEM\VEHICLE_RESPAWN_SYSTEM\MainThread.sqf", 
	"PUBLIC_CODE_SYSTEM\VEHICLE_RESPAWN_SYSTEM\RespawnVehicle.sqf", 
	"ADVANCE_THE_FLAG\CLIENT_LOCAL_ONLY\TeamKillingEH.sqf", 
	"ADVANCE_THE_FLAG\CLIENT_ZONE_SYSTEM\AddLockAction.sqf"
];

_names = [
	"OPFL_Client_AddUnlockAction",
	"OPFL_Client_AttemptDeployRP",
	"OPFL_Client_AttemptVote",
	"OPFL_Client_DeployZone",
	"OPFL_Client_PickUpZone",
	"OPFL_Client_ReDeployZone",
	"OPFL_Client_RedeployMode",
	"OPFL_Client_UndeployMode",
	"OPFL_CloseGroup",
	"OPFL_GetAllGroups",
	"OPFL_GroupDisconnect",
	"OPFL_JoinGroup",
	"OPFL_KickPlayer",
	"OPFL_LeaveGroup",
	"OPFL_LoadGUI",
	"OPFL_OpenGroup",
	"OPFL_PromoteLeader",
	"OPFL_InitOPFL",
	"OPFL_Server_DeployRP",
	"OPFL_Server_DestroyFlagZone",
	"OPFL_Server_FlagZoneThread",
	"OPFL_Server_FortifyRP",
	"OPFL_Server_RequestAllRP",
	"OPFL_Server_TicketClockThread",
	"OPFL_Server_UnDeployFlagZone",
	"PKS_ClientBS_BuildTimeClock",
	"PKS_DisconnectKit",
	"PKS_SelectKitGUI",
	"PKS_InitPlayerKits",
	"PKS_DeployFBPActivity",
	"PKS_HealActivity",
	"PKS_RepairActivity",
	"PKS_HealMode",
	"PKS_RepairMode",
	"PKS_SelectKit",
	"PKS_SetKit",
	"PCS_BroadcastWeather",
	"PCS_RNK_AgreedButton",
	"PCS_RNK_DeclineButton",
	"PCS_RNK_LoadGUI",
	"PCS_SHOP_LockVehicle",
	"PCS_SHOP_UnlockVehicle",
	"PCS_SafeSpawn",
	"VRS_MainThread",
	"VRS_RespawnVehicle",
	"OPFL_Client_TeamKillingEH",
	"OPFL_Client_AddLockAction"
];

diag_log "LISTS BUILT";
with missionNamespace do
{
	diag_log "LOOPING";
	{

		if (!isNil _x) exitWith {_return = false; diag_log format ["EMERGENCY EXIT: %1", _x];};
		missionNamespace setVariable [_x, (compileFinal 								(
																[
																	"PIPE_KEY_B",
																	_keyB,
																	(["PIPE_KEY_A", _keyA, preProcessFile (_paths select _forEachIndex)] call GSC_FindReplaceString)
																] 
																call GSC_FindReplaceString
																)
																)];
	} foreach _names;
	diag_log "FINISHED LOOPING";
};
_return;