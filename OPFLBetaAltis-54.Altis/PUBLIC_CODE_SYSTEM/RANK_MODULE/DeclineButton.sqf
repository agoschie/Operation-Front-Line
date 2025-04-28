if (!isNil "PCS_UNIQUE") then
{
	[PCS_UNIQUE, "PCS_RNK_Decline", PCS_S_SERVER, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
	closeDialog 0;
};