if ("ARRAY" == typeName _this) then
{
	private ["_player", "_group", "_grpList", "_id", "_kicked"];
	_player = _this select 0;
	_id = _this select 1;

	if (isNull _player || isNull _id) exitWith {};
	if (!alive _id) exitWith {};
	_kicked = _id;
	_id = (getPlayerUID _id) call PCS_UIDToID;
	if ((!alive _player) || (_id == "") || (((getPlayerUID _player) call PCS_UIDToID) == "")) exitWith {};
	
	_group = group _player;
	if (isNil {_group getVariable "OPFL_GROUP"}) exitWith {};
	_grpList = _group getVariable "OPFL_GROUP";
	if (2 > count _grpList) exitWith {};
	if (_id == ((getPlayerUID _player) call PCS_UIDToID)) exitWith {};
	
	if ((_id in _grpList) && (((getPlayerUID _player) call PCS_UIDToID) == (_grpList select 0))) then
	{
		if (_id == ((getPlayerUID _player) call PCS_UIDToID)) then
		{
			if (!(_group call OPFL_PromoteLeader)) then
			{
				OPFL_ACTIVE_GROUPS = OPFL_ACTIVE_GROUPS - [_group];
				[_player] join grpNull;
				diag_log format ["%1", _group];
				deleteGroup _group;
			}
			else
			{
				[_player] join grpNull;
			};
		}
		else
		{
			[_kicked] join grpNull;
			_grpList = _grpList - [_id];
			_group setVariable ["OPFL_GROUP", _grpList];
		};
		["", "OPFL_MakeLeader", _id, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
	};
}
else
{
	if (diag_tickTime > (uiNamespace getVariable "OPFL_GUI_KICKG_TIME")) then
	{
		uiNamespace setVariable ["OPFL_GUI_JOING_TIME", diag_tickTime + 0.25];
		private ["_group", "_id", "_myGroupLB", "_display"];
		_display = uiNamespace getVariable "OPFL_GUI_DISPLAY";
		_myGroupLB = _display displayCtrl 1007;
		_group = group player;
		_kicked = objectFromNetId (_myGroupLB lbData (lbCurSel _myGroupLB));
		
		if (isNull _kicked) exitWith {};
		_id = getPlayerUID _kicked;
		
		if (player == _kicked) exitWith {hint "WAT DA FCK M8";};
		if (!OPFL_IS_LEADER || !alive player || ("" == _id) || (2 > count units _group)) exitWith {hint "NOT YOUR GROUP";}; //lets not waste net usage
		if (!alive _kicked) exitWith {hint "PLEASE WAIT UNTIL PLAYER RESPAWNS";};
		
		[[player, _kicked] , "OPFL_KickPlayer", PCS_S_SERVER, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
	};
};