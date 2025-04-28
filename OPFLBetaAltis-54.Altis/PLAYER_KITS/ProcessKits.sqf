private "_folderScriptsWest";
private "_folderScriptsEast";
private "_rank";
private "_code";
private "_kitName";
_folderScriptsWest = call compile preProcessFile "PLAYER_KITS\WEST\ScriptList.sqf";
_folderScriptsEast = call compile preProcessFile "PLAYER_KITS\EAST\ScriptList.sqf";					
_rank = 0;
{
	try
	{
		private ["_magazines", "_weapons", "_kitName", "_kitTag", "_return", "_limit", "_buildings", "_special", "_description", "_altPrimary", "_altScope"];
		_code = call compile preProcessFile format["%1\%2.sqf", "PLAYER_KITS\WEST", _x];
	}
	catch
	{
		//diag_log format ["PLAYER KIT SYSTEM: Error, your kits are broken!\n|ERROR BEGIN|%1\n|ERROR END|", _exception];
	};
	_kitName = _code select 6;
	PKS_KIT_TABLE setVariable [format["KIT_STUFF_%1_DESCRIPTION", _kitName], (_code select 7)];
	//_code set [7, nil];
	//_code deleteAt 7;
	PKS_KIT_TABLE setVariable [format["KIT_STUFF_%1", _kitName], compileFinal preProcessFile format["%1\%2.sqf", "PLAYER_KITS\WEST", _x]]; //compilefinal for hacker protect
	PKS_KIT_TABLE setVariable [format["KIT_INDEX_%1", _kitName], [0,0, -1 + count (_code select 8), -1 + count (_code select 9)]];
	if ((playerSide != east) && (_kitName != "WestDefaultKit") && (_kitName != "EastDefaultKit")) then
	{
		PKS_AVAILABLE_KITS set [(count PKS_AVAILABLE_KITS), _kitName];
	};
} foreach _folderScriptsWest;
_rank = 0;
{
	try
	{
		private ["_magazines", "_weapons", "_kitName", "_kitTag", "_return", "_limit", "_buildings", "_special", "_description", "_altPrimary", "_altScope"];
		_code = call compile preProcessFile format["%1\%2.sqf", "PLAYER_KITS\EAST", _x];
	}
	catch
	{
		//diag_log format ["PLAYER KIT SYSTEM: Error, your kits are broken!\n|ERROR BEGIN|%1\n|ERROR END|", _exception];
	};
	_kitName = _code select 6;
	PKS_KIT_TABLE setVariable [format["KIT_STUFF_%1_DESCRIPTION", _kitName], (_code select 7)];
	//_code set [7, nil];
	//_code deleteAt 7;
	PKS_KIT_TABLE setVariable [format["KIT_STUFF_%1", _kitName], compileFinal preProcessFile format["%1\%2.sqf", "PLAYER_KITS\EAST", _x]]; //compilefinal for hacker protect
	PKS_KIT_TABLE setVariable [format["KIT_INDEX_%1", _kitName], [0,0, -1 + count (_code select 8), -1 + count (_code select 9)]];
	if ((playerSide != west) && (_kitName != "WestDefaultKit") && (_kitName != "EastDefaultKit")) then
	{
		PKS_AVAILABLE_KITS set [(count PKS_AVAILABLE_KITS), _kitName];
	};
} foreach _folderScriptsEast;