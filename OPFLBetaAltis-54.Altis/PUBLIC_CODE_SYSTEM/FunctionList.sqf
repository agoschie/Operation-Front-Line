//too small to make files for
OPFL_Client_ScreenHintRefresh = compileFinal "if (OPFL_SCREEN_HINT_TEXT == _this) then { OPFL_SCREEN_HINT_TEXT = '';};";
OPFL_Client_AddFlagActionsPlayer = compileFinal "[player] call OPFL_Client_AddFlagActions;";
OPFL_RPReadyFalse = compileFinal "OPFL_RP_READY = false";
OPFL_RPReadyTrue = compileFinal "OPFL_RP_READY = true; playSound 'RPReady';";
OPFL_VoteLockTrue = compileFinal "_this setVariable ['OPFL_VOTE_LOCK', true];";
OPFL_IsLeaderTrue = compileFinal "OPFL_IS_LEADER = true;";
OPFL_IsLeaderFalse = compileFinal "OPFL_IS_LEADER = false;";
OPFL_SetOpenGroup = compileFinal "if (!isNull _this) then {_this setVariable ['OPFL_IS_OPEN_GROUP', true];};";
OPFL_SetCloseGroup = compileFinal "if (!isNull _this) then {_this setVariable ['OPFL_IS_OPEN_GROUP', nil];};";
OPFL_SetGroupID = compileFinal "if (!isNull (_this select 0)) then {(_this select 0) setVariable ['OPFL_GROUP_ID', _this select 1];};";
PKS_AddMedicActionPlayer = compileFinal "[player] call PKS_AddMedicAction;";
PKS_AddRepairActionPlayer = compileFinal "[player] call PKS_AddRepairAction;";
PKS_ServerBS_BuildObjectMsg = compileFinal "_null = [_this] spawn PKS_ServerBS_BuildObject;";
PCS_InitSyncMsg = compileFinal "_this call PCS_ConnectUID;";
PKS_FillKitMsg = compileFinal "_this call PKS_RequestFillKit;";
PKS_SetKitMsg = compileFinal "_this call PKS_RequestSetKit;";
PKS_HealMsg = compileFinal "if(alive _this) then {_this setDamage 0;};";
PKS_RepairMsg = compileFinal "_this call GSC_PVRepair;";
OPFL_Server_DeployMsg = compileFinal "_null = _this spawn OPFL_Server_DeployFlagZone;";
OPFL_Server_UndeployMsg = compileFinal "OPFL_FLAG_ZONE_QUEUE set [(count OPFL_FLAG_ZONE_QUEUE), [_this, 2]];";
OPFL_Server_RedeployMsg = compileFinal "OPFL_FLAG_ZONE_QUEUE set [(count OPFL_FLAG_ZONE_QUEUE), [_this, 5]];";
OPFL_Server_End1Msg = compileFinal "endMission 'END1';";
OPFL_Server_End2Msg = compileFinal "endMission 'END2';";
OPFL_Server_End3Msg = compileFinal "endMission 'END3';";
OPFL_Server_FlagPckMsg = compileFinal "hint format ['FLAG %1 PACKED', (_this select 0)];";
OPFL_DeployRP = compileFinal "OPFL_FLAG_ZONE_QUEUE set [(count OPFL_FLAG_ZONE_QUEUE), [_this, 6]];";
OPFL_FortifyRP = compileFinal "OPFL_FLAG_ZONE_QUEUE set [(count OPFL_FLAG_ZONE_QUEUE), [_this, 8]];";
OPFL_RequestAllRP = compileFinal "OPFL_FLAG_ZONE_QUEUE set [(count OPFL_FLAG_ZONE_QUEUE), [_this, 7]];";



private ["_key"];
_key = 32 call GSC_CreateRandomKey;
//[_key, 8] call GSC_CompressKey;
_key = _key call GSC_MapKeyToVarName;
missionNamespace setVariable ["PCS_CallFnc", compileFinal (["KSTIRH", _key, preProcessFile "PUBLIC_CODE_SYSTEM\CallFnc.sqf"] call GSC_FindReplaceString)];
{
	//_x call PCS_AddFnc;
	if (("STRING" == typeName (_x select 0)) && ("STRING" == typeName (_x select 1))) then
	{
		(uiNamespace getVariable "PCS_FNC_TABLE") setVariable [format ["PCS_FNC%1_%2", PCS_NEXT_FNC_ID, _key], (_x select 1)];
		(uiNamespace getVariable "PCS_FNC_TABLE") setVariable [(_x select 0), PCS_NEXT_FNC_ID];
		PCS_NEXT_FNC_ID = PCS_NEXT_FNC_ID + 1;
	};
} foreach [
["PCS_TestFunctionB", "PCS_TestFunctionA"],

["OPFL_Client_ScreenHintRefresh", "OPFL_Client_ScreenHintRefresh"],

["OPFL_Client_AddFlagActionsPlayer", "OPFL_Client_AddFlagActionsPlayer"],
["OPFL_Client_AddStickyActions", "OPFL_Client_AddStickyActions"],
["OPFL_Client_UndeployAttempt", "OPFL_Client_UndeployAttempt"],
["OPFL_Client_RedeployAttempt", "OPFL_Client_RedeployAttempt"],
["OPFL_Client_AttemptDeployRP", "OPFL_Client_AttemptDeployRP"],
["OPFL_Client_AttemptVote", "OPFL_Client_AttemptVote"],
["OPFL_ParachuteSpawn", "OPFL_Client_ParachuteSpawn"],
["OPFL_SynchAllRP", "OPFL_Client_SynchAllRP"],
["OPFL_CreateRP", "OPFL_Client_CreateRP"],
["OPFL_DeleteRP", "OPFL_Client_DeleteRP"],
["OPFL_LockRP", "OPFL_RPReadyFalse"],
["OPFL_UnlockRP", "OPFL_RPReadyTrue"],
["OPFL_LockVoteRP", "OPFL_VoteLockTrue"],
["OPFL_MakeLeader", "OPFL_IsLeaderTrue"],
["OPFL_NotLeader", "OPFL_IsLeaderFalse"],
["OPFL_SetOpenGroup", "OPFL_SetOpenGroup"],
["OPFL_SetCloseGroup", "OPFL_SetCloseGroup"],
["OPFL_OpenGroup", "OPFL_OpenGroup"],
["OPFL_CloseGroup", "OPFL_CloseGroup"],
["OPFL_JoinGroup", "OPFL_JoinGroup"],
["OPFL_LeaveGroup", "OPFL_LeaveGroup"],
["OPFL_KickPlayer", "OPFL_KickPlayer"],
["OPFL_GetAllGroups", "OPFL_GetAllGroups"],
["OPFL_SetGroupID", "OPFL_SetGroupID"],

["PKS_HealAttempt", "PKS_HealAttempt"],
["PKS_RepairAttempt", "PKS_RepairAttempt"],
["PKS_AddMedicActionPlayer", "PKS_AddMedicActionPlayer"],
["PKS_AddRepairActionPlayer", "PKS_AddRepairActionPlayer"],

["PCS_CheckConnection", "PCS_CheckConnection"],
["PCS_OnConnected", "PCS_OnConnected"],

["PCS_RNK_Agree", "PCS_RNK_Agree"],
["PCS_RNK_Decline", "PCS_RNK_Decline"],

["PKS_ServerBS_BuildObjectMsg", "PKS_ServerBS_BuildObjectMsg"],
//["OPFL_Client_SetRankMsg", compileFinal "(_this select 0) setUnitRank (_this select 1);"],
["OPFL_Client_RestoreRank", "OPFL_Client_RestoreRank"],
//["PCS_UIDSynchedMsg", compileFinal "PCS_UID_SYNCHRONIZED = true; _null = _this spawn PCS_SyncWeather;"],
//["PCS_DuplicateMsg", compileFinal "while {true} do {hintSilent 'IT APPEARS A DUPLICATE UID EXISTS!!! THIS IS A STRANGE PROBLEM...'; sleep 1;};"],
["PCS_InitSyncMsg", "PCS_InitSyncMsg"],
//["OPFL_Server_InitTicketMsg", compileFinal "_null = _this execVM 'InitDeathTicket.sqf';"],
["PKS_FillKitMsg", "PKS_FillKitMsg"],
["PKS_SetKitMsg", "PKS_SetKitMsg"],
["PKS_HealMsg", "PKS_HealMsg"],
["PKS_RepairMsg", "PKS_RepairMsg"],

["OPFL_Server_DeployMsg", "OPFL_Server_DeployMsg"],
["OPFL_Server_UndeployMsg", "OPFL_Server_UndeployMsg"],
["OPFL_Server_RedeployMsg", "OPFL_Server_RedeployMsg"],
["OPFL_Server_End1Msg", "OPFL_Server_End1Msg"],
["OPFL_Server_End2Msg", "OPFL_Server_End2Msg"],
["OPFL_Server_End3Msg", "OPFL_Server_End3Msg"],
["OPFL_Server_FlagPckMsg", "OPFL_Server_FlagPckMsg"],
["OPFL_DeployRP", "OPFL_DeployRP"],
["OPFL_FortifyRP", "OPFL_FortifyRP"],
["OPFL_RequestAllRP", "OPFL_RequestAllRP"],

["VR_UpdIndex", "VRS_UpdIndex"],
["VR_AddVBlck", "VRS_AddVBlck"],

["PCS_SHOP_LockVehicle", "PCS_SHOP_LockVehicle"],
["PCS_SHOP_UnlockVehicle", "PCS_SHOP_UnlockVehicle"],

["PCS_SendData", "PCS_SendData"]




]; //add functions here to make them accessible to the Public Code System ^ ["any_function_name", function]

//they should be pre-compiled using compileFinal in arma3 to secure them