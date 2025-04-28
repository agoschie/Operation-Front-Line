private "_flagObject";
private "_destroyingSide";
private "_side";
private "_name";
private "_deployed";
private "_captureLevel";
private "_supportLevel";
private "_isValidFBP";
private "_ticketGainScript";
private "_zoneScript";
_flagObject = _this select 0;
_destroyingSide = _this select 1;

_side = _flagObject getVariable "FLAG_ZONE_SIDE";
_name = _flagObject getVariable "FLAG_ZONE_NAME";
_deployed = _flagObject getVariable "FLAG_ZONE_PLANTED";
_captureLevel = _flagObject getVariable "FLAG_ZONE_CAPTURED";
_supportLevel = _flagObject getVariable "FLAG_ZONE_SUPPORT";

if ((_captureLevel > 0) && (_supportLevel > 0)) exitWith {};
{
	terminate _x;
} foreach (_flagObject getVariable "FLAG_ZONE_SCRIPTS");
_flagObject setVariable ["FLAG_ZONE_SCRIPTS", []];

_flagObject setVariable ["FLAG_ZONE_READY", false, true];
_flagObject setVariable ["FLAG_ZONE_DESTROYED", true];
_flagObject setVariable ["FLAG_ZONE_CAPTURED", OPFL_ZONE_CAPTURE_TIME];
_flagObject setVariable ["FLAG_ZONE_SUPPORT", OPFL_ZONE_DEATH_TIME];
_flagObject setVariable ["FLAG_ZONE_LAST_SCAN", nil];
_flagObject setVariable ["FLAG_ZONE_TOD", diag_tickTime];

[_side, _flagObject] call OPFL_Server_DestroyRepos;
switch (_side) do
{
	case west:
	{
		OPFL_EAST_FLAG setVariable ["FLAG_ZONE_TOD", diag_tickTime - OPFL_DEPLOY_READY_TIME];
		if (_side == _destroyingSide) then
		{
			UNIVERSAL_MESSAGE = format ["%1 EXPIRED DUE TO LACK OF SUPPORT", _name];
			publicVariable "UNIVERSAL_MESSAGE";
			//_flagObject setVariable ["FLAG_ZONE_STATE", [2, 1, [(getPos _flagObject), (getPos _flagObject), (OPFL_ZONE_RADIUS + (random FLAG_RANDOM_MARKER_DISTANCE))] call GSC_RandPosAroundObject], true];
		}
		else
		{
			UNIVERSAL_MESSAGE = format ["EAST DESTROYED %1", _name];
			publicVariable "UNIVERSAL_MESSAGE";
			//_flagObject setVariable ["FLAG_ZONE_STATE", [2, 1, [(getPos _flagObject), (getPos _flagObject), (OPFL_ZONE_RADIUS + (random FLAG_RANDOM_MARKER_DISTANCE))] call GSC_RandPosAroundObject], true];
		};
	};
	
	case east:
	{
		OPFL_WEST_FLAG setVariable ["FLAG_ZONE_TOD", diag_tickTime - OPFL_DEPLOY_READY_TIME];
		if (_side == _destroyingSide) then
		{
			UNIVERSAL_MESSAGE = format ["%1 EXPIRED DUE TO LACK OF SUPPORT", _name];
			publicVariable "UNIVERSAL_MESSAGE";
			//_flagObject setVariable ["FLAG_ZONE_STATE", [2, 1, [(getPos _flagObject), (getPos _flagObject), (OPFL_ZONE_RADIUS + (random FLAG_RANDOM_MARKER_DISTANCE))] call GSC_RandPosAroundObject], true];
		}
		else
		{
			UNIVERSAL_MESSAGE = format ["WEST DESTROYED %1", _name];
			publicVariable "UNIVERSAL_MESSAGE";
			//_flagObject setVariable ["FLAG_ZONE_STATE", [2, 1, [(getPos _flagObject), (getPos _flagObject), (OPFL_ZONE_RADIUS + (random FLAG_RANDOM_MARKER_DISTANCE))] call GSC_RandPosAroundObject], true];
		};
	};
};

[_flagObject] call OPFL_Server_UpdateVisualState;

//this code updates all the rally points in response to deploying the flag
//friendly gets deleted
{
	if (!isNil {(_x select 0) getVariable "OPFL_RP_POS"}) then
	{
		private "_person";
		_person = _x select 0;
		if ((_flagObject getVariable "FLAG_ZONE_SIDE") == (_x select 2)) then
		{
			
			[_person, "OPFL_DeleteRP", PCS_S_CLIENT, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
		
			//delete RP, but leave deploy time for locking/unlocking ability
			[_person] call OPFL_Server_DisableRP;
			
			if (((_person getVariable "OPFL_RP_TIME") + OPFL_RP_READY_TIME) < diag_tickTime) then
			{
				["", "OPFL_UnlockRP", _x select 1, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
				_person setVariable ["OPFL_RP_TIME", nil];
				OPFL_RP_LIST set [_forEachIndex, -1];
			};
		};
	};
} foreach OPFL_RP_LIST;
	
OPFL_RP_LIST = OPFL_RP_LIST - [-1];

//_ticketGainScript = [_flagObject] spawn OPFL_Server_TicketGain;
//_zoneScript = [_flagObject] spawn OPFL_Server_ActivateFlagZone;

//_flagObject setVariable ["FLAG_ZONE_SCRIPTS", [_ticketGainScript]];
//_flagObject setVariable ["FLAG_ZONE_SCRIPTS", []];