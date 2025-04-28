OPFL_MAX_GROUP_SIZE = 9;
if ((!isNull cursorTarget) && (alive cursorTarget) && (playerSide == ([cursorTarget] call GSC_Side)) && ((leader cursorTarget) == cursorTarget) && ((player distance cursorTarget) < 3) && ((count units cursorTarget) < OPFL_MAX_GROUP_SIZE)) then
{
	_groupLeader = cursorTarget;
	
	[player] join _groupLeader;
};