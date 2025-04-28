private "_flagObject";
private "_side";
private "_wait";
private "_BP";
private "_initTime";
private "_aIntersect";
waitUntil {!OPFL_ROUND_MODE};
_flagObject = _this select 0;
_side = _flagObject getVariable "FLAG_ZONE_SIDE";
if (_side == west) then
{
	_BP = "BATTLE_POSITION_EAST";
};
if (_side == east) then
{
	_BP = "BATTLE_POSITION_WEST";
};
_wait = 1;
while {_wait == 1} do
{
	_aIntersect = [_flagObject] call GSC_AxisIntersectPoint;
	_distanceFromBP = ([_aIntersect, getMarkerPos _BP] call GSC_2dDistance);
	if (_distanceFromBP < OPFL_OPFL_TICKET_SPEED_LIMIT) then
	{
		_distanceFromBP = OPFL_OPFL_TICKET_SPEED_LIMIT;
	};
	_flagTicketSpeed = (_distanceFromBP / OPFL_TICKET_SPEED);
	if (!([_flagObject] call OPFL_Server_InHotZone)) then
	{
		_initTime = diag_ticktime;
		waitUntil {diag_ticktime >= (_initTime + _flagTicketSpeed)};
		//sleep _flagTicketSpeed
	}
	else
	{
		_initTime = diag_ticktime;
		waitUntil {diag_ticktime >= (_initTime + (_flagTicketSpeed / 1.25))};
		//sleep (_flagTicketSpeed / 1.25)
	};
	
	OPFL_TICKET_QUEUE set [(count OPFL_TICKET_QUEUE), [_side, true]];
};