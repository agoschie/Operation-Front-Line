private "_kitName";
if (isNil "PKS_CLIENT_KIT_QUEUE") exitWith {};
_kitName = _this select 0;
if (_kitName == "DEFAULT") then
{
	if (playerSide == west) then
	{
		_kitName = "WestDefaultKit";
	};
	if (playerSide == east) then
	{
		_kitName = "EastDefaultKit";
	};
};
PKS_CLIENT_KIT_QUEUE set [(count PKS_CLIENT_KIT_QUEUE), [[player, _kitName], 1]];