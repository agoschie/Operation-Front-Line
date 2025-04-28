private ["_key", "_outputSize"];
_outputSize = _this select 1;
_key = (_this select 0) select [0, _outputSize];
{
	_key set [_forEachIndex mod _outputSize, (((_key select (_forEachIndex mod _outputSize)) || _x) && !((_key select (_forEachIndex mod _outputSize)) && _x))];
} foreach ((_this select 0) - _key);

_key;