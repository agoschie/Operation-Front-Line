private "_flagObject";
private "_side";
private "_position";
if (!OPFL_ROUND_MODE || !isNil "OPFL_ROUND_WIN") exitWith {};
_flagObject = _this select 0;
_side = _flagObject getVariable "FLAG_ZONE_SIDE";
_position = getPosASL _flagObject;

if (_side == west) then
{
	if ([_position, "BP_END_ZONE_EAST"] call MSO_fnc_inArea) then
	{
		OPFL_ROUND_WIN = west;
	};
}
else
{
	if ([_position, "BP_END_ZONE_WEST"] call MSO_fnc_inArea) then
	{
		OPFL_ROUND_WIN = east;
	};
};