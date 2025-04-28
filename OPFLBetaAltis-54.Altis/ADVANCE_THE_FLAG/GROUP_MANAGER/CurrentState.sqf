#define NULL_STATE		0
#define DEAD_STATE		1
#define WOUNDED_STATE	2
#define SPAWN_STATE		3
#define PARA_STATE		4
#define	LOW_STATE		5
#define HAPPY_STATE		6

private ["_unit", "_dmg"];
_unit = _this;

if (isNull _unit) exitWith
{
	_unit = NULL_STATE;
	_unit;
};

if (!alive _unit) exitWith
{
	_unit = DEAD_STATE;
	_unit;
};

_dmg = _unit call GSC_GetDamage;
if ((_dmg select 0) >= 0.1) exitWith
{
	_unit = WOUNDED_STATE;
	_unit;
};

if ([_unit] call GSC_InSafeZone) exitWith
{
	_unit = SPAWN_STATE;
	_unit;
};

if ((_unit != vehicle _unit) && (!isNull vehicle _unit)) exitWith
{
	_unit = typeOf vehicle _unit;
	_unit;
};

if ("para_pilot" == animationState _unit) exitWith
{
	_unit = animationState _unit;
	_unit;
};

if (!someAmmo _unit) exitWith
{
	_unit = LOW_STATE;
	_unit;
};

_unit = HAPPY_STATE;
_unit;
