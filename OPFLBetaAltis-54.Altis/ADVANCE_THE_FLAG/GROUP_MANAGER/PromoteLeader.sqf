private ["_myGroup", "_grpList", "_return"];
_myGroup = _this;
_return = true;
_grpList = _myGroup getVariable "OPFL_GROUP";

_grpList deleteAt 0;
					
if (1 > count _grpList) then
{
		_myGroup setVariable ["OPFL_OPEN_GROUP", nil];
		_myGroup setVariable ["OPFL_GROUP", nil];
		_return = false;
}
else
{
	[[_myGroup, (_grpList select 0) call PCS_GetName], "OPFL_SetGroupID", PCS_S_CLIENT, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
	["", "OPFL_MakeLeader", _grpList select 0, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
};

_return;