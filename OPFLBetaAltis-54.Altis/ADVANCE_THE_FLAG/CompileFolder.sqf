private "_systemName";
private "_folderName";
private "_folderScripts";
private "_code";

_systemName = _this select 0;
_folderName = _this select 1;
_folderScripts = call compile preProcessFile format ["%1\ScriptList.sqf", _folderName];			

{
	//_code = (compile preProcessFile format["%1\%2.sqf", _folderName, _x]);
	//_code call compile format ["%1_%2 = _this;", _systemName, _x];
	missionNamespace setVariable [format ["%1_%2", _systemName, _x], (compileFinal preProcessFile format["%1\%2.sqf", _folderName, _x])];
} foreach _folderScripts;
