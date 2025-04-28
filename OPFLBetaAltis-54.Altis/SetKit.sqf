waitUntil { !(isNull player) };
if (player == (_this select 0)) then
{
	PLAYER_KIT = compile loadFile format["PLAYER_KITS\%1",(_this select 1)];
};