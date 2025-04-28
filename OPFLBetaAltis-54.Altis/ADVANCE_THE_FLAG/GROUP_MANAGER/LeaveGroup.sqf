if ("OBJECT" == typeName _this) then
{
	private ["_player", "_group", "_grpList", "_id"];
	_player = _this;

	if (isNull _player) exitWith {};
	_id = (getPlayerUID _player) call PCS_UIDToID;
	if ((!alive _player) || (_id == "")) exitWith {};
	
	_group = group _player;
	if (isNil {_group getVariable "OPFL_GROUP"}) exitWith {};
	_grpList = _group getVariable "OPFL_GROUP";
	
	//only if in group and not empty
	if ((_id in _grpList) && (1 < count _grpList)) then
	{
		if (_id == (_grpList select 0)) then
		{
			_group call OPFL_PromoteLeader;
		}
		else
		{
			_grpList = _grpList - [_id];
			_group setVariable ["OPFL_GROUP", _grpList];
		};
		[_player] join grpNull;
		["", "OPFL_MakeLeader", _id, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
	};
}
else
{
	if (diag_tickTime > (uiNamespace getVariable "OPFL_GUI_JOING_TIME")) then
	{
		uiNamespace setVariable ["OPFL_GUI_JOING_TIME", diag_tickTime + 1];
		private ["_group", "_id"];
		_group = group player;
		
		if (OPFL_IS_LEADER && (2 > count units _group)) exitWith {hint "YOUR GROUP IS EMPTY";}; //lets not waste net usage
		if (!alive player) exitWith {hint "PLEASE WAIT UNTIL ALIVE";};
		
		[player , "OPFL_LeaveGroup", PCS_S_SERVER, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
	};
};