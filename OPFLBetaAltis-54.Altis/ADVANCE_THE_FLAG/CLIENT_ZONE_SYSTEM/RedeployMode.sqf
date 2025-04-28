private "_markerName";
private "_flagObject";
private "_flagPos";
private "_enemyBase";
private "_baseColor";
private "_enemyBaseBorder";
private "_enemyBaseSize";
private "_wait";		
_flagObject = _this select 0;
_flagPos = _this select 1;
_wait = 1;

OPFL_SCREEN_HINT_TEXT = "             ***REDPLOY MODE*** Click in yellow circle on map to redeploy the flag!";

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
_markerName = createMarkerLocal ["OPFL_REDPLOY_BORDER_MARKER", _flagPos];
_markerName setMarkerShapeLocal "ELLIPSE";
_markerName setMarkerBrushLocal "Border";
_markerName setMarkerColorLocal "ColorYellow";
_markerName setMarkerSizeLocal [OPFL_REDEPLOY_RADIUS, OPFL_REDEPLOY_RADIUS];

if (!OPFL_ROUND_MODE) then
{
	_enemyBaseBorder = createMarkerLocal ["OPFL_ENEMY_BASE_MARKER", (getMarkerPos _enemyBase)];
	_enemyBaseBorder setMarkerShapeLocal "ELLIPSE";
	_enemyBaseBorder setMarkerBrushLocal "Border";
	_enemyBaseBorder setMarkerColorLocal _baseColor;
	_enemyBaseBorder setMarkerSizeLocal [(OPFL_ZONE_RADIUS + _enemyBaseSize), (OPFL_ZONE_RADIUS + _enemyBaseSize)];
};

OPFL_CLICK_POSITION = [1,1,1];

["RedeployMode", "onMapSingleClick", {
	if (0 == count OPFL_CLICK_POSITION) then
	{
		player sideChat "CLICK CLICK";
		OPFL_CLICK_POSITION = _pos;
	};
true;}] call BIS_fnc_addStackedEventHandler;

while {_wait == 1} do
{
	OPFL_CLICK_POSITION = [];

	//onMapSingleClick "OPFL_CLICK_POSITION = _pos; onMapSingleClick ''; true;"
	

	waitUntil {((count OPFL_CLICK_POSITION) > 0) || !([_flagPos, ((_flagObject getVariable "FLAG_ZONE_STATE") select 2)] call GSC_EqualPosArrays) || !(alive player) || ((_flagPos distance (getPosASL player)) > 11) || !(_flagObject getVariable "FLAG_ZONE_READY")};
	if ((count OPFL_CLICK_POSITION) > 0) then
	{
		//client checks for validity then broadcast (remember, lag can cause false success, so server uses finite state machine style checking as well)
		if (((([OPFL_CLICK_POSITION] call GSC_HighestSurface) select 2) > 1) || (surfaceIsWater OPFL_CLICK_POSITION)) exitWith {hint "SOMETHING IS IN THE WAY!";};
		if ([OPFL_CLICK_POSITION] call GSC_ToSteep) exitWith {hint "SURFACE IS TOO STEEP!";};
		if (([OPFL_CLICK_POSITION, _flagPos] call GSC_2dDistance) > OPFL_REDEPLOY_RADIUS) exitWith {hint "MUST DEPLOY IN YELLOW CIRCLE!";};
		if ((([OPFL_CLICK_POSITION, (getMarkerPos _enemyBase)] call GSC_2dDistance) <= (OPFL_ZONE_RADIUS + _enemyBaseSize)) && !OPFL_ROUND_MODE) exitWith {hint "CANT DEPLOY IN ENEMIES BASE PROTECTOR CIRCLE";};
		if (!([OPFL_CLICK_POSITION, "BATTLE_FIELD_AREA"] call MSO_fnc_inArea)) exitWith {hint "CAN NOT DEPLOY OUT OF BATTLE AREA!";};
		if ([OPFL_CLICK_POSITION, (_flagObject getVariable "FLAG_ZONE_SIDE")] call GSC_OverEZW) exitWith {hint "CAN NOT DEPLOY PAST ENEMY LINE!";};
		OPFL_CLICK_POSITION set [2, 0];
		[[_flagObject, _flagPos, OPFL_CLICK_POSITION, (getPosASL player), true], "OPFL_Server_RedeployMsg", PCS_S_SERVER, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
		_wait = 0;
		deleteMarkerLocal _markerName;
		deleteMarkerLocal _enemyBaseBorder;
	}
	else
	{
		_wait = 0;
		deleteMarkerLocal _markerName;
		deleteMarkerLocal _enemyBaseBorder;
	};
};
["RedeployMode", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
OPFL_SCREEN_HINT_TEXT = "";
OPFL_REDEPLOY_LOCK = nil;