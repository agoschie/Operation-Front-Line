private "_flagObject";
private "_side";
private "_wait";
waitUntil {!OPFL_ROUND_MODE};
_flagObject = _this select 0;
_side = _flagObject getVariable "FLAG_ZONE_SIDE";
_wait = 1;
while {_wait == 1} do
{
	sleep (OPFL_TICKET_SPEED * 2);
	OPFL_TICKET_QUEUE set [(count OPFL_TICKET_QUEUE), [_side, false]];
};
