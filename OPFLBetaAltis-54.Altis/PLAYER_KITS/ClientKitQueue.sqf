private "_executeState";

_executeState = PKS_CLIENT_KIT_QUEUE select 0;
switch (_executeState select 1) do
{
	case _FILL_KIT:
	{
		(_executeState select 0) call PKS_FillKit;
	};
	
	case _CHANGE_WEAPONS:
	{
		(_executeState select 0) call PKS_ChangeWeapons;
	};
	
	default
	{
		player sideChat "INVALID STATE CHANGE!";
	};
};
PKS_CLIENT_KIT_QUEUE set [0, -1];
PKS_CLIENT_KIT_QUEUE = PKS_CLIENT_KIT_QUEUE - [-1];