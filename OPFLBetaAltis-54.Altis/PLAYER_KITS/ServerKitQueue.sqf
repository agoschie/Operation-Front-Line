private "_executeState";

_executeState = PKS_SERVER_KIT_QUEUE select 0;
switch (_executeState select 1) do
{
	case _SET_KIT:
	{
		(_executeState select 0) call PKS_SetKit;
	};
	
	case _DISCONNECT_KIT:
	{
		(_executeState select 0) call PKS_DisconnectKit;
		diag_log "DISCONNECT KIT ATtempT!";
	};
	
	default
	{
		diag_log "INVALID STATE CHANGE!";
	};
};
PKS_SERVER_KIT_QUEUE set [0, -1];
PKS_SERVER_KIT_QUEUE = PKS_SERVER_KIT_QUEUE - [-1];