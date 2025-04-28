if (([_this select 0] call PCS_TempID) > 0) then 
{
	PKS_SERVER_KIT_QUEUE set [(count PKS_SERVER_KIT_QUEUE), [[_this select 0, _this select 1, (_this select 0) call PCS_IDToUID], 1]]; 
};