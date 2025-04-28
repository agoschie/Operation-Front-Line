private "_swName";
private "_deployAction";
private "_kitName";
private "_fbpObject";
private "_fbpString";
_swName = "DeployFBPAbility";
_deployAction = "none";
_attachedBody = "none";
_fbpObject = objNull;
_fbpString = "none";
_kitName = _this select 0;

switch (playerSide) do
{
	case west:
	{
		_fbpObject = PKS_WEST_FALL_BACK_OBJ;
		_fbpString = "PKS_WEST_FALL_BACK_OBJ";
	};
	
	case east:
	{
		_fbpObject = PKS_EAST_FALL_BACK_OBJ;
		_fbpString = "PKS_EAST_FALL_BACK_OBJ";
	};
};

while {_kitName == PLAYER_KIT} do
{
	waitUntil {(alive player) || (_kitName != PLAYER_KIT)};
	if (_kitName == PLAYER_KIT) then
	{
		_attachedBody = player;
		_deployAction = _attachedBody addAction ["DEPLOY FALLBACK POSITION", PKS_DeployFBPActivity, _fbpObject, -100, false, true, "", format ["%1 getVariable 'PKS_FBP_DEPLOY_READY'", _fbpString]];
	};
	waitUntil {(!alive player) || (_kitName != PLAYER_KIT)};
	if ("STRING" != (typeName _deployAction)) then
	{
		_attachedBody removeAction _deployAction;
		_deployAction = "none";
	};
};
