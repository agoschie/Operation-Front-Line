private "_delay";
private "_enemyBP";
private "_myBP";
private "_initialTime";
_delay = 15;
switch (playerSide) do
{
	case west:
	{
		_enemyBP = "BATTLE_POSITION_EAST";
		_myBP = "BATTLE_POSITION_WEST";
	};
	case east:
	{
		_enemyBP = "BATTLE_POSITION_WEST";
		_myBP = "BATTLE_POSITION_EAST";
	};
};
while {true} do
{
	waitUntil {((alive player) && (([player, (getMarkerPos _enemyBP)] call GSC_2dDistance) < ((getMarkerSize _enemyBP) select 0))) || (!([player, "BATTLE_FIELD_AREA"] call MSO_fnc_inArea) && ([player] call GSC_IsCarrier) && (([player, (getMarkerPos _myBP)] call GSC_2dDistance) > ((getMarkerSize _myBP) select 0)))};
	_initialTime = diag_tickTime;
	OPFL_SCREEN_HINT_TEXT = "YOU HAVE 15 SECONDS TO: Leave the enemy base or return to the battle area with the flag!";
	waitUntil {	(!alive player) || 
			((([player, (getMarkerPos _enemyBP)] call GSC_2dDistance) >= ((getMarkerSize _enemyBP) select 0)) && !(!([player, "BATTLE_FIELD_AREA"] call MSO_fnc_inArea) && ([player] call GSC_IsCarrier) && (([player, (getMarkerPos _myBP)] call GSC_2dDistance) > ((getMarkerSize _myBP) select 0)))) || 
			(diag_tickTime >= (_initialTime + _delay))
	};
	if (diag_tickTime >= (_initialTime + _delay)) then
	{
		player setDamage 1;
	};
	OPFL_SCREEN_HINT_TEXT = "";
};
	