private "_position";
private "_fbpObject";

if (!isNil "PKS_DEPLOY_FBP_IN_PROGRESS") exitWith {};
PKS_DEPLOY_FBP_IN_PROGRESS = true;

_fbpObject = _this select 3;

_position = getPosASL player;
_position set [2, 0];
_position = [_position, 10, (getDir player)] call GSC_PolarVector;
_null = [[_fbpObject, _position], "_null = _this spawn ServerFBPSystem_DeployFBP;", PCS_S_SERVER] spawn PCS_MPCodeBroadcast;

PKS_DEPLOY_FBP_IN_PROGRESS = nil;