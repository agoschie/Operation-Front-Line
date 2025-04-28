private "_action";
private "_player";
private "_kitName";
private "_buildings";
_player = _this select 0;
_kitName = _this select 1;
_buildings = _this select 2;
call PKS_ClientBS_ClearBuildingActions;
BUILDING_ACTIONS_PLAYER = _player;
BUILDING_ACTIONS_KIT = _kitName;

if ((count _buildings) > 0) then
{
	_action =  BUILDING_ACTIONS_PLAYER addAction ["BUILDING LIST", "PLAYER_KITS\BUILD_SYSTEM\CLIENT_BUILD_SYSTEM\BuildingList.sqf", [_kitName], -10, false, false, "", "!PCS_IN_VEHICLE && BUILDING_ACTION_STATE == 1"];
	BUILDING_ACTIONS_LIST = BUILDING_ACTIONS_LIST + [_action];
	
	private "_i";
	_i = 0;
	
	{
		_action = BUILDING_ACTIONS_PLAYER addAction [(_x select 0), "PLAYER_KITS\BUILD_SYSTEM\CLIENT_BUILD_SYSTEM\BuildSelectedObject.sqf", [(_x select 1), _kitName], ((-10) - _i), false, false, "", "!PCS_IN_VEHICLE && BUILDING_ACTION_STATE == 2"];
		BUILDING_ACTIONS_LIST = BUILDING_ACTIONS_LIST + [_action];
		_i = _i + 1;
	} foreach _buildings;
	
	_action = BUILDING_ACTIONS_PLAYER addAction ["Build", "PLAYER_KITS\BUILD_SYSTEM\CLIENT_BUILD_SYSTEM\ObjBuild.sqf", [_kitName], (-11 - _i), false, false, "", "!PCS_IN_VEHICLE && BUILDING_ACTION_STATE == 3"];
	BUILDING_ACTIONS_LIST = BUILDING_ACTIONS_LIST + [_action];

	_action = BUILDING_ACTIONS_PLAYER addAction ["Cancel", "PLAYER_KITS\BUILD_SYSTEM\CLIENT_BUILD_SYSTEM\ObjCancel.sqf", [_kitName], (-12 - _i), false, false, "", "!PCS_IN_VEHICLE && BUILDING_ACTION_STATE > 1"];
	BUILDING_ACTIONS_LIST = BUILDING_ACTIONS_LIST + [_action];
};