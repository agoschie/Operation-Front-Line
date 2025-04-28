private "_marker";
private "_westBPPos";
private "_eastBPPos";
private "_xDis";
private "_yDis";
private "_dir";
private "_axisPosX";
private "_axisPosY";
private "_enemyBaseSize";
private "_enemyBaseBorder";
private "_enemyBase";
private "_baseColor";


_marker = createMarkerLocal ["BP_TAG_WEST", (getMarkerPos "BATTLE_POSITION_WEST")];
_marker setMarkerDirLocal 0;
_marker setMarkerShapeLocal "ICON";
_marker setMarkerTypeLocal "hd_flag";
_marker setMarkerColorLocal "ColorBlue";
_marker setMarkerSizeLocal [0,0];
_marker setMarkerTextLocal "West Base";

_marker = createMarkerLocal ["BP_TAG_EAST", (getMarkerPos "BATTLE_POSITION_EAST")];
_marker setMarkerDirLocal 0;
_marker setMarkerShapeLocal "ICON";
_marker setMarkerTypeLocal "hd_flag";
_marker setMarkerColorLocal "ColorRed";
_marker setMarkerSizeLocal [0,0];
_marker setMarkerTextLocal "East Base";

if (playerSide == west) then
{

	_enemyBase = "BATTLE_POSITION_EAST";
	_baseColor = "ColorRed";
};
if (playerSide == east) then
{
	_enemyBase = "BATTLE_POSITION_WEST";
	_baseColor = "ColorBlue";
};

_enemyBaseSize = (getMarkerSize _enemyBase) select 0;

if (OPFL_ROUND_MODE) then
{
	_marker = createMarkerLocal ["BP_END_ZONE_WEST", (getMarkerPos "BATTLE_POSITION_WEST")];
	_marker setMarkerDirLocal 0;
	_marker setMarkerShapeLocal "ELLIPSE";
	_marker setMarkerBrushLocal "Border";
	_marker setMarkerColorLocal "ColorBlue";
	_marker setMarkerSizeLocal [(2 * OPFL_ZONE_RADIUS) + ((getMarkerSize "BATTLE_POSITION_WEST") select 0), (2 * OPFL_ZONE_RADIUS) + ((getMarkerSize "BATTLE_POSITION_WEST") select 1)];

	_marker = createMarkerLocal ["BP_END_ZONE_EAST", (getMarkerPos "BATTLE_POSITION_EAST")];
	_marker setMarkerDirLocal 0;
	_marker setMarkerShapeLocal "ELLIPSE";
	_marker setMarkerBrushLocal "Border";
	_marker setMarkerColorLocal "ColorRed";
	_marker setMarkerSizeLocal [(2 * OPFL_ZONE_RADIUS) + ((getMarkerSize "BATTLE_POSITION_EAST") select 0), (2 * OPFL_ZONE_RADIUS) + ((getMarkerSize "BATTLE_POSITION_EAST") select 1)];
}
else
{
	_enemyBaseBorder = createMarkerLocal ["OPFL_ENEMY_BASE_MARKER", (getMarkerPos _enemyBase)];
	_enemyBaseBorder setMarkerShapeLocal "ELLIPSE";
	_enemyBaseBorder setMarkerBrushLocal "Border";
	_enemyBaseBorder setMarkerColorLocal _baseColor;
	_enemyBaseBorder setMarkerSizeLocal [(OPFL_ZONE_RADIUS + _enemyBaseSize), (OPFL_ZONE_RADIUS + _enemyBaseSize)];
};

[getMarkerPos "BP_TAG_EAST", 
 getMarkerPos "BP_TAG_WEST", 
 0, 
 "ColorBlack",
 "BP_AXIS_CONNECTOR"] call GSC_DrawMarkerConnection;
 
OPFL_DESTROYED_RADIUS = (markerSize "BP_AXIS_CONNECTOR") select 1;
 
_marker = createMarkerLocal ["BATTLE_FIELD_AREA", (getMarkerPos "BP_AXIS_CONNECTOR")];
_marker setMarkerDirLocal (markerDir "BP_AXIS_CONNECTOR");
_marker setMarkerShapeLocal OPFL_BATTLE_FIELD_SHAPE;
_marker setMarkerBrushLocal "BORDER";
_marker setMarkerColorLocal "ColorGreen";
_marker setMarkerSizeLocal [(OPFL_BATTLE_FIELD_WIDTH_RATIO * ((markerSize "BP_AXIS_CONNECTOR") select 1)), ((markerSize "BP_AXIS_CONNECTOR") select 1)];
 
 _marker = createMarkerLocal ["BP_BOUND_WEST", (getMarkerPos "BATTLE_POSITION_WEST")];
 _marker setMarkerDirLocal (markerDir "BP_AXIS_CONNECTOR");
 _marker setMarkerShapeLocal "RECTANGLE";
 _marker setMarkerColorLocal "ColorBlue";
 _marker setMarkerSizeLocal [0,0];
 
 _marker = createMarkerLocal ["BP_BOUND_EAST", (getMarkerPos "BATTLE_POSITION_EAST")];
 _marker setMarkerDirLocal (markerDir "BP_AXIS_CONNECTOR");
 _marker setMarkerShapeLocal "RECTANGLE";
 _marker setMarkerColorLocal "ColorRed";
 _marker setMarkerSizeLocal [0,0];
