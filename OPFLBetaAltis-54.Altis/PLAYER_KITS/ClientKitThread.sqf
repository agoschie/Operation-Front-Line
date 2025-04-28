private "_handle";
_handle = addMissionEventHandler ["EachFrame", 
{
	private ["_wait", "_FILL_KIT", "_CHANGE_WEAPONS", "_MAIN_MENU", "_BUILD_LIST", "_SELECT_BUILD", "_BUILD", "_CANCEL"];

	_wait = 1;

	//kit states
	_FILL_KIT = 1;
	_CHANGE_WEAPONS = 2;

	//menu states
	_MAIN_MENU = 1;
	_BUILD_LIST = 2;
	_SELECT_BUILD = 3;
	_BUILD = 4;
	_CANCEL = 5;


	while {(count PKS_CLIENT_KIT_QUEUE) > 0} do
	{
		call PKS_ClientKitQueue;
	};
	while {(count PKS_BUILDING_MENU_QUEUE) > 0} do
	{
		call PKS_ClientBS_MenuQueue;
	};
	call PKS_RejectWeapon;
	
}];

//((count PKS_CLIENT_KIT_QUEUE) > 0) || ((count PKS_BUILDING_MENU_QUEUE) > 0)}