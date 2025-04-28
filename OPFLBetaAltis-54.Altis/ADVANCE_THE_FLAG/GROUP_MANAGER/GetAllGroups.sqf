if ("STRING" == typeName _this) then
{
	if (!isServer) exitWith {};
	private ["_id", "_send", "_group"];

	_id = _this;
	_send = [];

	if (([_id] call PCS_TempID) < 1) exitWith {};
	if (0 < count OPFL_ACTIVE_GROUPS) exitWith {};
	
	_null = 
	{
		_group = _x select 0;
		if (!isNull _group) then
		{
			_send pushBack (netId _group);
			_send pushBack (((_group getVariable "OPFL_GROUP") select 0) call PCS_GetName);
		};
		false
	} count OPFL_ACTIVE_GROUPS;

	[_send, "OPFL_GetAllGroups", _id, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
}
else
{
	if (isDedicated) exitWith {};
	private ["_group", "_i", "_end"];
	_i = 0;
	_end = count _this;
	while {_i < _end} do
	{
		
		_group = groupFromNetId (_this select _i);
		_i = _i + 1;
		if (!isNull _group) then
		{
			_group setVariable ["OPFL_IS_OPEN_GROUP", true];
			_group setVariable ["OPFL_GROUP_ID", _this select _i];
		};
		_i = _i + 1;
	};
	
};