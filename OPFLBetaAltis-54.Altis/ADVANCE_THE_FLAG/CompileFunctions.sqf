private "_scripts";
private "_CompileFolder";

_scripts = 
[
["OPFL", "ADVANCE_THE_FLAG"],
["OPFL_Client", "ADVANCE_THE_FLAG\CLIENT_LOCAL_ONLY"],
["OPFL_Server", "ADVANCE_THE_FLAG\SERVER_DEATH_SYSTEM"],
["OPFL_Server", "ADVANCE_THE_FLAG\SERVER_ZONE_SYSTEM"],
["OPFL_Client", "ADVANCE_THE_FLAG\CLIENT_ZONE_SYSTEM"],
["OPFL_Client", "ADVANCE_THE_FLAG\CLIENT_ZONE_SYSTEM\FLAG_ZONE_STATES"],
["OPFL", "ADVANCE_THE_FLAG\GROUP_MANAGER"]
];
_CompileFolder = compile PreProcessFile "ADVANCE_THE_FLAG\CompileFolder.sqf";
{
	_null = _x call _CompileFolder;
} foreach _scripts;

OPFL_ALL_SCRIPTS_COMPILED = true;