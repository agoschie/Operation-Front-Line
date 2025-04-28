_wait = 1;
while {_wait == 1} do
{
	waitUntil {sideEnemy == side player};
	_rank = "PRIVATE";
	if ((leader player) == player) then
	{
		_rank = "SERGEANT";
	};
	player setUnitRank _rank;
};
//_null = [[player, _rank], "OPFL_Client_SetRankMsg", PCS_S_ALL] spawn PCS_MPCodeBroadcast;