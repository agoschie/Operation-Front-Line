private "_executeState";

_executeState = EMP_SERVER_EMP_QUEUE select 0;
switch (_executeState select 1) do
{
	case _CONNECT:
	{
		(_executeState select 0) call EMP_ConnectSat;
	};
	
	case _DISCONNECT:
	{
		(_executeState select 0) call EMP_DisconnectSat;
	};

	case _SET_TARGET:
	{
		(_executeState select 0) call EMP_SetTarget;
	};

	case _SET_OFFSET:
	{
		(_executeState select 0) call EMP_SetOffset;
	};

	case _REFRESH_SAT_LIST:
	{
		(_executeState select 0) call EMP_RefreshSatList;
	};

	case _FIRE:
	{
		(_executeState select 0) call EMP_FireSat;
	};
	
	default
	{
		player sideChat "EMP: INVALID STATE CHANGE!";
	};
};
EMP_SERVER_EMP_QUEUE set [0, -1];
EMP_SERVER_EMP_QUEUE = EMP_SERVER_EMP_QUEUE - [-1];