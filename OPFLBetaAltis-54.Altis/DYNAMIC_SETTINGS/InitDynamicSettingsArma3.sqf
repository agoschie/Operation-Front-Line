//Author: Goschie
//Version: Beta v0.9.2

DYNAMIC_SETTINGS_ROOT_FOLDER = "";

//compile module
["Final"] call compile preProcessFile format ["%1DYNAMIC_SETTINGS\CompileFunctions.sqf", DYNAMIC_SETTINGS_ROOT_FOLDER];
//set the list
call DynamicSettings_DynamicSettingsList;

//initial global values
{
	private "_variableName";
	private "_initValue";
	_variableName = _x select 0;
	if ("ARRAY" == typeName ((_x select 4) select ((_x select 2) - 1))) then
	{
		_initValue = + (_x select 4) select ((_x select 2) - 1);
	}
	else
	{
		_initValue = (_x select 4) select ((_x select 2) - 1);
	};

	missionNamespace setVariable [_variableName, _initValue];
} foreach DYNAMIC_SETTINGS_LIST;


//add settings menu action to new player and delete old action (stores action for next respawn and only happens when settings were initially added)
_null = [] spawn {
waitUntil {player == player};
player addEventHandler ["Respawn", {
	if (!isNil "DYNAMIC_SETTINGS_ACTION") then
	{
		(DYNAMIC_SETTINGS_ACTION select 1) removeAction (DYNAMIC_SETTINGS_ACTION select 0);
		call DynamicSettings_AddSettingsActions;
	};
}];
//add settings menu action to current player and store
call DynamicSettings_AddSettingsActions;
};

DYNAMIC_SETTINGS_INITIALIZED = true;