/**
private ["_minDistance",
		"_return",
		"_count",
		"_configF",
		"_currentConfig",
		"_configs",
		"_lastTime"

];

_return = RTMS_CACHE_DISTANCE;
_configF = (configFile >> "CfgVehicles");
//_count = count _configF;
_currentConfig = "";
_configs = [];
_lastTime = diag_tickTime;
//_configF = "((sizeOf configName _x) > RTMS_CACHE_DISTANCE)" configClasses _configF;

//_configF = "(configName _x) isKindOf 'Man'" configClasses _configF;

{
	_configs append (format["(configName _x) isKindOf '%1'", _x] configClasses _configF);
} foreach RTMS_CLASS_NAMES;

_configs = _configs arrayIntersect _configs;

{
	if ("SCALAR" == typeName (_x getVariable "CLASS_DISTANCE")) then
	{
		_minDistance = ((_x getVariable "CLASS_DISTANCE") + 10) min 100;
		_return = [_return, _minDistance] select (_minDistance > _return);
	};
} foreach RTMS_CLASS_LIST;
		
if (false) exitWith {_return};

{
	_currentConfig = configName _x;
	
	if (_return < ((sizeOf _currentConfig) + 10)) then
	{
		_return = ((sizeOf _currentConfig) + 10) min 100;
	};
} foreach _configs;

diag_log format ["RTMS MAX CACHE SIZE: %1", _return];

_return;
**/
private "_OOC";
_OOC = _this;
if ((({(_OOC isKindOf _x) && (_OOC != _x)} count RTMS_CLASS_NAMES) < 1) && (RTMS_CACHE_DISTANCE < 100)) then
{
	private ["_oocSize", "_configs", "_configF", "_currentConfig"];
	_oocSize = 0;
	//_configs = [];
	//_configF = (configFile >> "CfgVehicles");
	//_configs append (format["(configName _x) isKindOf '%1'", _OOC] configClasses _configF);
	//_configs append (("(configName _x) isKindOf " + _OOC) configClasses _configF);
	//diag_log format ["SEARCHING: %1", count _configs];
	{
		if ((configName _x) isKindOf _OOC) then
		{
			if (isNumber (_x >> "mapSize")) then
			{
				_oocSize = 10 + getNumber (_x >> "mapSize");
			};
							
			if (RTMS_CACHE_DISTANCE < _oocSize) then
			{
				RTMS_CACHE_DISTANCE = _oocSize min 100;
			};
			RTMS_CONFIGS set [_forEachIndex, -1];
		};
		if (_oocSize == 100) exitWith {};
	} foreach RTMS_CONFIGS;
	RTMS_CONFIGS = RTMS_CONFIGS - [-1];
};
