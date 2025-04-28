private "_player";
private "_squad";
_player = _this select 0;
_squad = "NONE";

{
	_soldierindex = 1;
	while {_soldierindex <= 9} do
	{
		if (format["%1", _player] == format["%1_%2", _x, _soldierindex]) then
		{
			_squad = _x;
		};
		_soldierindex = _soldierindex + 1;
	};
} foreach OPFL_SQUAD_LIST;

_squad;
