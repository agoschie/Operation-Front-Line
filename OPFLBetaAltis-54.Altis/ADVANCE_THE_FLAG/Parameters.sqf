OPFL_SQUAD_LIST = ["ALPHA", "BRAVO", "CHARLIE", "DELTA", "ECHO", "FOXTROT", "GOLF", "HOTEL", "INDIA", "JULIET", "KILO", "LIMA"];
OPFL_PLAYER_CAPACITY = 54; //must match your maximum playable east+west sided men
OPFL_MAX_FLAG_ZONES = 1; //if the maximum player capacity is reached, you will get the maximum amount of flag zones you indicated per side, steadily increasing towards maximum as the player count rises. (assume even players on both sides)
OPFL_MICRO_MODE = true;
OPFL_GAME_TIME = 3600;//3600 //10800
OPFL_DEPLOY_READY_TIME = 120; //how long  you must wait before you can move the flag again in both micro OPFL and regular OPFL
OPFL_ZONE_RADIUS = 10;
OPFL_REDEPLOY_RADIUS = 100;
OPFL_STARTING_TICKETS = 100;
OPFL_TICKET_SPEED = 100; //ONE second for every OPFL_TICKET_SPEED meters from battle position (DISTANCE meters / OPFL_TICKET_SPEED meters = seconds)
OPFL_OPFL_TICKET_SPEED_LIMIT = 100; //by default it should match OPFL_TICKET_SPEED to equal one ticket per second.
OPFL_ZONE_CAPTURE_TIME = 60;
OPFL_ZONE_DEATH_TIME = 300; //300
OPFL_ZONE_DEATH_WARNING_TIME = 60;
OPFL_ZONE_REV_TIME = 300;
OPFL_FOB_RADIUS = 2;
OPFL_BODY_CLEANUP_TIME = 30; //30
OPFL_BATTLE_FIELD_SHAPE = "RECTANGLE";
OPFL_BATTLE_FIELD_WIDTH_RATIO = 0.5;
OPFL_ACE_ENABLED = false;
OPFL_CARRIER_RSPN_ENABLED = false;
OPFL_VIRTUAL_FLAGS = true;
OPFL_RP_READY_TIME = 30; //seconds
OPFL_RP_DISTANCE = 15; //meters
OPFL_RP_VOTES_REQ = 1;
OPFL_PARACHUTE_DISTANCE = 500;
OPFL_ATTACK_TIMER = 60;

//performance
OPFL_SCT = 0.5; //cycle of scans in seconds

/***************************************************************************
End
****************************************************************************/



/***************************************************************************
Parameter Overrides (setting to false does not override)
****************************************************************************/

OPFL_ROUND_MODE = false;
OPFL_HIDDEN_ZONES = false;
OPFL_PINNED_ZONES = false;
OPFL_CARRIER_VLOCK = false;

/***************************************************************************
End
****************************************************************************/



/***************************************************************************
Parameter array conditions
****************************************************************************/
if (OPFL_ROUND_MODE || (paramsarray select 2) == 1) then
{
	OPFL_ROUND_MODE = true;
}
else
{
	OPFL_ROUND_MODE = false;
};

if (OPFL_HIDDEN_ZONES || (paramsarray select 3) == 1) then
{
	OPFL_HIDDEN_ZONES = true;
}
else
{
	OPFL_HIDDEN_ZONES = false;
};

if (OPFL_PINNED_ZONES || (paramsarray select 4) == 1) then
{
	OPFL_PINNED_ZONES = true;
}
else
{
	OPFL_PINNED_ZONES = false;
};

if (OPFL_CARRIER_VLOCK || (paramsarray select 5) == 1) then
{
	OPFL_CARRIER_VLOCK = true;
}
else
{
	OPFL_CARRIER_VLOCK = false;
};

diag_log format ["BATTLE FIELD LOCATION: %1", paramsarray select 6];

/***************************************************************************
End
****************************************************************************/