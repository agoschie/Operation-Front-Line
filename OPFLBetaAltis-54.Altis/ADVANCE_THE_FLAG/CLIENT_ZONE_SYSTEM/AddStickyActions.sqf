if (isNil "OPFL_GROUP_MANAGER_ACTION") then
{
	call OPFL_AddGroupAction;
	call OPFL_Client_AddRPAction;
	call OPFL_Client_AddLockAction;
	call OPFL_Client_AddUnlockAction;
	call OPFL_Client_AddKickPlayersAction;
	call OPFL_Client_AddFlipAction;
	call OPFL_Client_AddAirDeploymentAction;
};