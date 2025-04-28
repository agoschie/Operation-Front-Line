private "_flagObject";
private "_sizePercent";
private "_flagPos";		
_flagObject = _this select 0;
_flagPos = (_flagObject getVariable "FLAG_ZONE_STATE") select 2;
_sizePercent = (_flagObject getVariable "FLAG_ZONE_STATE") select 1;

if (!(_flagObject getVariable "FLAG_ZONE_READY")) exitWith 
{
	hint format ["PLEASE WAIT %1 SECONDS BEFORE REDEPLOYING!", OPFL_DEPLOY_READY_TIME];
};

if (OPFL_PINNED_ZONES && (_sizePercent < 1)) exitWith
{
	hint format ["THE FLAG IS PINNED AT %1 PERCENT!", (_sizePercent * 100)];
};

if (((getPosASL player) distance _flagPos) > 11) exitWith {};

if (isNil "OPFL_REDEPLOY_LOCK") then
{
	OPFL_REDEPLOY_LOCK = true;
	//_null = [(_this select 0), _flagPos] spawn (_this select 1);
	_null = [(_this select 0), _flagPos] spawn OPFL_Client_RedeployMode;
};