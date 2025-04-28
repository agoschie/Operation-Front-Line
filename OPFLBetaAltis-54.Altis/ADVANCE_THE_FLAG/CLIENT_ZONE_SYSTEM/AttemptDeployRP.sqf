if (isNil "OPFL_FLAG_ZONE_LIST") exitWith {};
if (alive player && OPFL_RP_READY && ((OPFL_LAST_RP_TIME + 1) <= diag_tickTime)) then
{
	OPFL_LAST_RP_TIME = diag_tickTime;
	
	private ["_flagObject", "_enemyBase", "_baseColor", "_sizePercent", "_flagPos", "_isDest", "_enemyBaseSize"];
	
	{
		if ((_x getVariable "FLAG_ZONE_SIDE") == playerSide) then
		{
			_flagObject = _x;
		};
	} foreach OPFL_FLAG_ZONE_LIST;
	
	_flagPos = (_flagObject getVariable "FLAG_ZONE_STATE") select 2;
	_sizePercent = (_flagObject getVariable "FLAG_ZONE_STATE") select 1;
	_isDest = (_flagObject getVariable "FLAG_ZONE_STATE") select 3;
	if (_isDest) then
	{
		_redRad = OPFL_DESTROYED_RADIUS;
	}
	else
	{
		_redRad = OPFL_REDEPLOY_RADIUS;
	};
	
	if ((_flagObject getVariable "FLAG_ZONE_SIDE") == west) then
	{

		_enemyBase = "BATTLE_POSITION_EAST";
		_baseColor = "ColorRed";
	};
	
	if ((_flagObject getVariable "FLAG_ZONE_SIDE") == east) then
	{
		_enemyBase = "BATTLE_POSITION_WEST";
		_baseColor = "ColorBlue";
	};

	_enemyBaseSize = (getMarkerSize _enemyBase) select 0;

	if (!(_flagObject getVariable "FLAG_ZONE_READY")) exitWith 
	{
		hint format ["PLEASE WAIT %1 SECONDS BEFORE REDEPLOYING!", OPFL_DEPLOY_READY_TIME - (OPFL_ADVANCE_TIMERS select (playerSide == east))];
	};
	
	if (OPFL_PINNED_ZONES && (_sizePercent < 1)) exitWith
	{
		hint format ["THE FLAG IS PINNED AT %1 PERCENT!", (_sizePercent * 100)];
	};

	if (!([getPosASL player, "BATTLE_FIELD_AREA"] call MSO_fnc_inArea)) exitWith {hint "CAN NOT DEPLOY OUT OF BATTLE AREA!";};
	if (([getPosASL player, _flagPos] call GSC_2dDistance) > _redRad) exitWith {hint "MUST DEPLOY IN YELLOW CIRCLE!";};
	if ([getPosASL player, (_flagObject getVariable "FLAG_ZONE_SIDE")] call GSC_OverEZW) exitWith {hint "CAN NOT DEPLOY PAST ENEMY LINE!";};
	if ((([getPosASL player, (getMarkerPos _enemyBase)] call GSC_2dDistance) <= (OPFL_ZONE_RADIUS + _enemyBaseSize)) && !OPFL_ROUND_MODE) exitWith {hint "CANT DEPLOY IN ENEMIES BASE PROTECTOR CIRCLE";};
	if (surfaceIsWater (getPosASL player)) exitWith {hint "CAN NOT DEPLOY IN WATER";};
	
	[[player, getPosATL player, _flagPos], "OPFL_DeployRP", PCS_S_SERVER, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
};