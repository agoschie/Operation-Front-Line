private "_folderScriptsWest";
private "_folderScriptsEast";
private "_rank";
private "_code";
private "_kitName";
waitUntil {(!isNil "PKS_WEST_KIT_CRATE") && (!isNil "PKS_EAST_KIT_CRATE")};
_folderScriptsWest = call compile preProcessFile "PLAYER_KITS\WEST\ScriptList.sqf";
_folderScriptsEast = call compile preProcessFile "PLAYER_KITS\EAST\ScriptList.sqf";	
if(!isDedicated) then
{
	_null = PKS_WEST_KIT_CRATE addAction ["<img image='a3\ui_f\data\gui\cfg\Hints\rifle_ca.paa'/> <t color='#00ff00'> WEAPON KITS</t>", "PLAYER_KITS\GUI_SCRIPTS\ActivateArmoryGUI.sqf", [], 1000, true, true, "", "(!PCS_IN_VEHICLE)"];
	_null = PKS_EAST_KIT_CRATE addAction ["<img image='a3\ui_f\data\gui\cfg\Hints\rifle_ca.paa'/> <t color='#00ff00'> WEAPON KITS</t>", "PLAYER_KITS\GUI_SCRIPTS\ActivateArmoryGUI.sqf", [], 1000, true, true, "", "(!PCS_IN_VEHICLE)"];
	if (!isNil "RTMS_INITIALIZED") then
	{
	private ["_menu"];
	_menu = call PKS_Armory_Object;
	_menu set [0, PKS_WEST_KIT_CRATE];
	_menu = _menu call RTMS_CreateMenuObject;
	[_menu, true] call RTMS_SendRequest;
	_menu = call PKS_Armory_Object;
	_menu set [0, PKS_EAST_KIT_CRATE];
	_menu = _menu call RTMS_CreateMenuObject;
	[_menu, true] call RTMS_SendRequest;
	};
};
_rank = 0;
{
	_code = call compile preProcessFile format["%1\%2.sqf", "PLAYER_KITS\WEST", _x];
	_kitName = _code select 6;
	
	if ((_kitName != "WestDefaultKit") && (_kitName != "EastDefaultKit")) then
	{
		_null = [_code, PKS_WEST_KIT_CRATE, _rank] call PKS_KitActionUpdater;
		_rank = _rank + 1;
	};
} foreach _folderScriptsWest;
_rank = 0;
{
	_code = call compile preProcessFile format["%1\%2.sqf", "PLAYER_KITS\EAST", _x];
	_kitName = _code select 6;
	
	if ((_kitName != "WestDefaultKit") && (_kitName != "EastDefaultKit")) then
	{
		_null = [_code, PKS_EAST_KIT_CRATE, _rank] call PKS_KitActionUpdater;
		_rank = _rank + 1;
	};
} foreach _folderScriptsEast;

