private "_executeState";
private "_DEPLOY";
private "_UNDEPLOY";
private "_DESTROY";
private "_DEL_BODY";
private "_RE_DEPLOY";
private "_DEPLOY_RP";
private "_REMOVE_RP";
private "_FORTIFY_RP";


//states
_DEPLOY = 1;
_UNDEPLOY = 2;
_DESTROY = 3;
_DEL_BODY = 4;
_RE_DEPLOY = 5;
_DEPLOY_RP = 6;
_REQUEST_RP = 7;
_FORTIFY_RP = 8;

_executeState = OPFL_FLAG_ZONE_QUEUE select 0;
switch (_executeState select 1) do
{
	case _DEPLOY:
	{
		(_executeState select 0) call OPFL_Server_DeployFlagZone;
		//[] call OPFL_Server_UpdateFBL;
	};
	
	case _UNDEPLOY:
	{
		(_executeState select 0) call OPFL_Server_UnDeployFlagZone;
		//[] call OPFL_Server_UpdateFBL;
	};
	
	case _DESTROY:
	{
		(_executeState select 0) call OPFL_Server_DestroyFlagZone;
		//[] call OPFL_Server_UpdateFBL;
	};
	
	case _DEL_BODY:
	{
		(_executeState select 0) call OPFL_Server_SafelyDeleteBody;
		//player sideChat "DELETE BODY ATtempT!";
	};
	
	case _RE_DEPLOY:
	{
		(_executeState select 0) call OPFL_Server_ReDeployFlagZone;
		//[] call OPFL_Server_UpdateFBL;
		//[[1], {player sideChat format ["I AM NUMBER %1", (_this select 0)];}] call PCS_ExecAtomic;
		//player sideChat "I AM NUMBER 2";
	};
	
	case _DEPLOY_RP:
	{
		(_executeState select 0) call OPFL_Server_DeployRP;
	};
	
	case _REQUEST_RP:
	{
		(_executeState select 0) call OPFL_Server_RequestAllRP;
	};
	
	case _FORTIFY_RP:
	{
		(_executeState select 0) call OPFL_Server_FortifyRP;
	};
	
	default
	{
		player sideChat "INVALID STATE CHANGE!";
	};
};
OPFL_FLAG_ZONE_QUEUE set [0, -1];
OPFL_FLAG_ZONE_QUEUE = OPFL_FLAG_ZONE_QUEUE - [-1];

	