_undeployAttempt = {
private "_flagObject";
private "_flagPos";		
_flagObject = _this select 0;
_flagPos = (_flagObject getVariable "FLAG_ZONE_STATE") select 2;

if (!(_flagObject getVariable "FLAG_ZONE_READY")) exitWith 
{
	hint format ["PLEASE WAIT %1 SECONDS BEFORE UNDEPLOYING!", OPFL_DEPLOY_READY_TIME];
};
if (((getPosASL player) distance _flagPos) > 11) exitWith {};

if (isNil "OPFL_UNDEPLOY_LOCK") then
{
	OPFL_UNDEPLOY_LOCK = true;
	//_null = [(_this select 0), _flagPos] spawn (_this select 1);
	_null = [(_this select 0), _flagPos] spawn OPFL_Client_UndeployMode;
};
};



_undeployMode = {
private "_flagObject";
private "_flagPos";
private "_zone";
_flagObject = _this select 0;
_flagPos = _this select 1;
_zone = (_flagObject getVariable "FLAG_ZONE_NAME");

if (!([player] call GSC_IsCarrier)) then
{
	if ((_flagObject getVariable "FLAG_ZONE_PLANTED")) then
	{
		player playMove "ainvpknlmstpslaywrfldnon_medic";
		player sideChat "PICKING UP FLAG...";
		_endTime = (diag_tickTime + 10);
		waitUntil {(diag_tickTime > _endTime) || (!alive player) || (!(_flagObject getVariable "FLAG_ZONE_PLANTED")) || !([_flagPos, ((_flagObject getVariable "FLAG_ZONE_STATE") select 2)] call GSC_EqualPosArrays) || !(_flagObject getVariable "FLAG_ZONE_READY")};
		if (diag_tickTime > _endTime) then
		{
			[[_flagObject, player, _flagPos, true], "OPFL_Server_UndeployMsg", PCS_S_SERVER, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
		};
	}
	else
	{
		hint format["%1 IS ALREADY UNDEPLOYED!", _zone];
	};
}
else
{
	hint "ALREADY CARRYING ZONE";
};
OPFL_UNDEPLOY_LOCK = nil;
};

[[((_this select 3) select 0)], "OPFL_Client_UndeployAttempt"] call PCS_SpawnAtomic;