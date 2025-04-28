if (isNil "OPFL_LOCAL_RP_LIST") exitWith {};
private ["_person", "_vote"];
_person = _this select 0;

if (isNull _person) exitWith {};

_vote = _this select 1;

{
	if ((_x select 0) == _person) exitWith
	{
		_x set [1, _vote];
	};
} foreach OPFL_LOCAL_RP_LIST;