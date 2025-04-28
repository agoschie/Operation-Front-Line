private "_basePosition";
private "_objectUnit";
private "_radius";
private "_randDeg";

_basePosition = _this select 0;
_objectUnit = _this select 1;
_radius = _this select 2;

_randDeg = random 359;

_basePosition set [0, (_basePosition select 0) + (_radius * sin (_randDeg))];
_basePosition set [1, (_basePosition select 1) + (_radius * cos (_randDeg))];

if ((typeName _objectUnit) == "STRING") then
{
	_objectUnit setMarkerPosLocal _basePosition;
};
if ((typeName _objectUnit) == "OBJECT") then
{
	_objectUnit setPos _basePosition;
};
if ((typeName _objectUnit) == "ARRAY") then
{
	_objectUnit = _basePosition;
	_objectUnit;
};