if((rating player) < 0) then 
{
	if(player == leader player) then 
	{
		player setUnitRank 'SERGEANT';
	} 
	else 
	{
		player setUnitRank 'PRIVATE';
	};
};