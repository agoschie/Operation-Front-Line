private "_kitName";
private "_crate";
private "_UID";

_kitName = _this select 3;
_crate = _this select 0;
_UID = getPlayerUID player;

if (PLAYER_KIT == _kitName) exitWith {hint "ALREADY HAVE THIS KIT!";};
if ((PKS_KIT_TABLE getVariable _kitName) < 1) exitWith {hint "OUT OF KIT!";};
		

if (_crate == PKS_WEST_KIT_CRATE) then
{
	if (playerSide == west) then
	{
		[[PCS_UNIQUE, _kitName], "PKS_SetKitMsg", PCS_S_SERVER, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
	}
	else
	{
		hint "THESE ARE NOT YOUR WEAPONS!";
	};
};
if (_crate == PKS_EAST_KIT_CRATE) then
{
	if (playerSide == east) then
	{
		[[PCS_UNIQUE, _kitName], "PKS_SetKitMsg", PCS_S_SERVER, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
	}
	else
	{
		hint "THESE ARE NOT YOUR WEAPONS!";
	};
};