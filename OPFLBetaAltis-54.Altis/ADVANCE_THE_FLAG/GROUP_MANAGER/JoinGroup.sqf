if (1 < count _this) then
{
	private ["_player", "_group", "_myGroup", "_id", "_oldGroup"];
	_player = _this select 0;
	_group = _this select 1;
	_oldGroup = group player;
	
	if (isNull _player) exitWith {}; //invalid state
	
	_id = (getPlayerUID _player) call PCS_UIDToID;
	if (("" == _id) || (isNull _group) || !alive _player) exitWith {}; //invalid state
	if (isNil {_group getVariable "OPFL_OPEN_GROUP"}) exitWith {}; //invalid state
	if (isNil {_oldGroup getVariable "OPFL_GROUP"}) then
	{
		[_player] join _group;
		(_group getVariable "OPFL_GROUP") pushBack _id;
		["", "OPFL_NotLeader", _id, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
	}
	else
	{
		if (_oldGroup != _group) then
		{
			private ["_grpList"];
			_grpList = _oldGroup getVariable "OPFL_GROUP";
			
			//if leader, promote new leader or close group, else, just remove
			if (_id == (_grpList select 0)) then
			{
				if (!(_oldGroup call OPFL_PromoteLeader)) then
				{
					OPFL_ACTIVE_GROUPS = OPFL_ACTIVE_GROUPS - [_group];
					[_player] join _group;
					diag_log format ["%1", _oldGroup];
					deleteGroup _oldGroup;
				}
				else
				{
					[_player] join _group;
				};
			}
			else
			{
				_grpList = _grpList - [_id];
				_oldGroup setVariable ["OPFL_GROUP", _grpList];
				[_player] join _group;
			};
		
			(_group getVariable "OPFL_GROUP") pushBack _id;
			["", "OPFL_NotLeader", _id, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
		};
	};
}
else
{
	if (diag_tickTime > (uiNamespace getVariable "OPFL_GUI_JOING_TIME")) then
	{
		uiNamespace setVariable ["OPFL_GUI_JOING_TIME", diag_tickTime + 1];
		private ["_group", "_id", "_allGroupLB", "_display"];
		_display = uiNamespace getVariable "OPFL_GUI_DISPLAY";
		_allGroupLB = _display displayCtrl 1006;
		if (0 > lbCurSel _allGroupLB) exitWith {};
		_group = groupFromNetId (_allGroupLB lbData (lbCurSel _allGroupLB));
		
		if (!alive player) exitWith {};
		if (isNull _group) exitWith {};
		if (isNil {_group getVariable "OPFL_IS_OPEN_GROUP"}) exitWith {};
		if (_group == group player) exitWith {};
		
		[[player, _group], "OPFL_JoinGroup", PCS_S_SERVER, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
		player say "VoteRP";
	};
};

