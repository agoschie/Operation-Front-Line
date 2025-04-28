private "_flagObject";
private "_carrier";
private "_lastFlagPos";
private "_isCarrier";
private "_isQueue";
private "_ticketLossScript";
private "_plantOnDeathScript";
private "_sizePercent";

_flagObject = _this select 0;
_carrier = _this select 1;
_lastFlagPos = _this select 2;
_sizePercent = (_flagObject getVariable "FLAG_ZONE_STATE") select 1;

_isQueue = false;
if ((count _this) > 3) then
{
	_isQueue = _this select 3;
};
if (!_isQueue) exitWith
{
	OPFL_FLAG_ZONE_QUEUE set [(count OPFL_FLAG_ZONE_QUEUE), [[_flagObject, _carrier, _lastFlagPos, true], 2]];
};

_isCarrier = [_carrier] call GSC_IsCarrier;

if ((!(_flagObject getVariable "FLAG_ZONE_PLANTED")) || (!alive _carrier) || (!([_lastFlagPos, (getPosASL _flagObject)] call GSC_EqualPosArrays)) || _isCarrier || !(_flagObject getVariable "FLAG_ZONE_READY") || (OPFL_PINNED_ZONES && (_sizePercent < 1))) exitWith {};
_flagObject setVariable ["FLAG_ZONE_PLANTED", false, true];
_flagObject setVariable ["FLAG_ZONE_CARRIER_UNIT", _carrier, true];
_flagObject setVariable ["FLAG_ZONE_CARRIER_POS", _lastFlagPos];
_flagObject setVariable ["FLAG_ZONE_ACTIVATED", false];
_flagObject setVariable ["FLAG_ZONE_LAST_SCAN", nil];
_carrier setVariable ["OPFL_DELETE_LOCK", true];

{
	terminate _x;
} foreach (_flagObject getVariable "FLAG_ZONE_SCRIPTS");
_flagObject setVariable ["FLAG_ZONE_SCRIPTS", []];

//_ticketLossScript = [_flagObject] spawn OPFL_Server_TicketLoss;
//_flagObject setVariable ["FLAG_ZONE_SCRIPTS", [_ticketLossScript]];

[_flagObject] call OPFL_Server_UpdateVisualState;
if (local _carrier) then
{
	//hint format ["FLAG %1 PACKED", (_flagObject getVariable "FLAG_ZONE_NAME")];
}
else
{
	[[(_flagObject getVariable "FLAG_ZONE_NAME")], "OPFL_Server_FlagPckMsg", (getPlayerUID _carrier) call PCS_UIDToID, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
};
//_null = [[_flagObject, _carrier], "_null = _this spawn OPFL_Client_DeployAction;", (getPlayerUID _carrier)] spawn PCS_MPCodeBroadcast;