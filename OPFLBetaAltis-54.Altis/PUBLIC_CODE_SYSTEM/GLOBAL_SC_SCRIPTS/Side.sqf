#define NO_SIDE -1
#define EAST 0			// (Russian)
#define WEST 1			// (NATO)
#define RESISTANCE 2	// Guerilla 
#define CIVILIAN 3
#define NEUTRAL 4
#define ENEMY 5
#define FRIENDLY 6
#define LOGIC 7

private ["_obj", "_side"];
_obj = param [0, objNull, [objNull], 1];
_side = side _obj;

_obj = switch (getNumber (configFile >> "CfgVehicles" >> typeOf _obj >> "side")) do
{
	case EAST: {east};
	case WEST: {west};
	case RESISTANCE: {independent};
	case CIVILIAN: {civilian};
	case NEUTRAL: {neutral};
	case ENEMY: {sideEnemy};
	case FRIENDLY: {sideFriendly};
	case LOGIC: {sideLogic};
	default {diag_log "GSC Side: No side known for object..."; sideUnknown};
};

//check if team killer
_side = _obj;

_side;