private ["_key", "_charlist"];
_key = [];
_charlist = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
{
	_key pushBack (_charlist select (_x mod 36));
} forEach (_this);

_key = _key joinString "";
_key;
