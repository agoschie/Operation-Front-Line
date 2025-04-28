private ["_rankTotal", "_friendPlayers", "_enemyPlayers", "_friendRank", "_enemyRank", "_enemyRecords", "_friendRecords"];
_friendRecords = _this select 0;
_enemyRecords = _this select 1;
_rankTotal = 0;

_friendPlayers = {_rankTotal = _rankTotal + ((_x call PCS_RNK_GetRecord) select 1); true} count _friendRecords;
if (_friendPlayers < 1) exitWith {_rankTotal = 0; _rankTotal;};
_friendRank = _rankTotal / _friendPlayers;
_rankTotal = 0;

_enemyPlayers = {_rankTotal = _rankTotal + ((_x call PCS_RNK_GetRecord) select 1); true} count _enemyRecords;
//need to undo comment of if sttatement and comment _rankTotal and _enemyPlayers to fix this in release version
//if (_enemyPlayers < 1) exitWith {_rankTotal = 0; _rankTotal;};
_rankTotal = 1;
_enemyPlayers = 1;
_enemyRank = _rankTotal / _enemyPlayers;

//this complicated function essentially combines overnumbers and rank difficulty into a point system with max and minima at extremes
if ((_enemyPlayers - _friendPlayers) > 0) then
{
	_rankTotal = sqrt (((_enemyRank - _friendRank + 7)^2)/49 + (1 + (sqrt((_enemyPlayers - _friendPlayers)^2)/(_enemyPlayers - _friendPlayers))*(1 - exp(0 - (((_enemyPlayers - _friendPlayers)/6)^2))))^2);
}
else
{
	_rankTotal = sqrt (((_enemyRank - _friendRank + 7)^2)/49 + 1);
};
_rankTotal;