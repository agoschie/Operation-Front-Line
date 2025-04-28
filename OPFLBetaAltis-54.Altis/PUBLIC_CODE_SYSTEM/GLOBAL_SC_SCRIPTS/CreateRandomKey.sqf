private ["_key"];
_key = [];
for "_i" from 1 to _this do
{
	_key pushBack (floor random 256);
};
_key;