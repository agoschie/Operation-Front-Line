if ("OBJECT" == typeName _this) then
{
	private ["_player", "_group", "_myGroup", "_id"];
	_player = _this;

	if (isNull _player) exitWith {};
	
	_id = (getPlayerUID _player) call PCS_UIDToID;
	if ((!alive _player) || (_id == "")) exitWith {};
	
	_group = group _player;
	if (isNil {_group getVariable "OPFL_OPEN_GROUP"}) exitWith {};
	if (isNil {_group getVariable "OPFL_GROUP"}) exitWith {};
	
	if (_id == ((_group getVariable "OPFL_GROUP") select 0)) then
	{
		_group setVariable ["OPFL_OPEN_GROUP", nil];
		[_group, "OPFL_SetCloseGroup", PCS_S_CLIENT, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
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
		_group = group player;
		
		if (!OPFL_IS_LEADER || (player != leader player) || !alive player || isNil {_group getVariable "OPFL_IS_OPEN_GROUP"}) exitWith {};
		
		[player, "OPFL_CloseGroup", PCS_S_SERVER, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
	};
};