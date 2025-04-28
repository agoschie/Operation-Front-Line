private ["_id", "_name", "_grpList"];

_id = (_this select 0) call PCS_UIDToID;
_name = _this select 1;

{
	if (!isNull _x) then
	{
		_grpList = _x getVariable "OPFL_GROUP";
		if (_id in _grpList) then
		{
			if (_id == (_grpList select 0)) then
			{
				if (!(_x call OPFL_PromoteLeader)) then
				{
					OPFL_ACTIVE_GROUPS set [_forEachIndex, -1];
					[_x, "OPFL_SetCloseGroup", PCS_S_CLIENT, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
				};
			}
			else
			{
				_grpList = _grpList - [_id];
				_x setVariable ["OPFL_GROUP", _grpList];
			};
		};
	};
} foreach OPFL_ACTIVE_GROUPS;

OPFL_ACTIVE_GROUPS = OPFL_ACTIVE_GROUPS - [-1];