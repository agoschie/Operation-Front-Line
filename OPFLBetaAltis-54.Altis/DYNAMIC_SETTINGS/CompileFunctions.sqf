private "_scripts";
private "_CompileFolder";
private "_compileType";
_compileType = "";
if (0 < count _this) then
{
	_compileType = _this select 0;
};

_scripts = 
[
["DynamicSettings", "DYNAMIC_SETTINGS"],
["DynamicSettings", "DYNAMIC_SETTINGS\GUI_SCRIPTS"]
];
_CompileFolder = compile PreProcessFile format ["%1DYNAMIC_SETTINGS\CompileFolder%2.sqf", DYNAMIC_SETTINGS_ROOT_FOLDER, _compileType];
{
	_null = _x call _CompileFolder;
} foreach _scripts;

DYNAMIC_SETTINGS_ALL_SCRIPTS_COMPILED = true;