private "_executeState";

_executeState = PKS_BUILDING_MENU_QUEUE select 0;
if (BUILDING_ACTIONS_KIT == (_executeState select 2)) then
{
	switch (_executeState select 1) do
	{
		case _MAIN_MENU:
		{
			if (BUILDING_ACTION_STATE != _MAIN_MENU) then
			{
				BUILDING_ACTION_STATE = 1;
			};
		};
	
		case _BUILD_LIST:
		{
			if (BUILDING_ACTION_STATE == _MAIN_MENU) then
			{
				BUILDING_ACTION_STATE = _BUILD_LIST;
			};
		};
	
		case _SELECT_BUILD:
		{
			if (BUILDING_ACTION_STATE == _BUILD_LIST) then
			{
				PKS_BUILD_VISUALIZER = (_executeState select 0);
				BUILDING_ACTION_STATE = _SELECT_BUILD;
			};
		};
	
		case _BUILD:
		{
			if (!PKS_PLAYER_IS_BUSY && (BUILDING_ACTION_STATE == _SELECT_BUILD)) then
			{
				PKS_PLAYER_IS_BUSY = true;
				if ((count PKS_BUILD_ARGUMENTS) < 1) then
				{
					PKS_BUILD_ARGUMENTS = PKS_BUILD_VISUALIZER;
				};
			};
		};
	
		case _CANCEL:
		{
			switch (BUILDING_ACTION_STATE) do
			{
				case _SELECT_BUILD:
				{
					PKS_BUILD_VISUALIZER = [];
					BUILDING_ACTION_STATE = _BUILD_LIST;
				};
			
				case _BUILD_LIST:
				{
					BUILDING_ACTION_STATE = _MAIN_MENU;
				};
			};
		};
	
		default
		{
			player sideChat "INVALID STATE CHANGE!";
		};
	};
};
PKS_BUILDING_MENU_QUEUE set [0, -1];
PKS_BUILDING_MENU_QUEUE = PKS_BUILDING_MENU_QUEUE - [-1];