private ["_person", "_pos"];
if (isNil "PLAYER_KIT") exitWith {};

_person = _this select 0;
_pos = (_this select 1);
_pos set [2, 150];

if (_person == player) then
{
	removeBackpack _person;
	_person addBackpack "B_Parachute";
	_person setPosATL _pos;
	_person action ["OpenParachute", _person];
	PKS_CLIENT_KIT_QUEUE set [(count PKS_CLIENT_KIT_QUEUE), [[_person], 1]];
	player say "VoteRP";
};
