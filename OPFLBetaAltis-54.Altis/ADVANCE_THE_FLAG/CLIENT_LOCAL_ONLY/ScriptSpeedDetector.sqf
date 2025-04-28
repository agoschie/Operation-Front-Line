if (false) exitWith {};
private "_wait";
_wait = 1;

while {_wait == 1} do
{
	sleep 1;
	_beginTime = diag_frameno;
	[[1,2,3], {_pos = getPos player; player sideChat "BOOP"; SPEED_EX_DONE = true;}] call PCS_SpawnAtomic;
	waitUntil {!isNil "SPEED_EX_DONE"};
	_endTime = diag_frameno;
	player globalChat format ["statement speed: %1 frames, at %2 fps, or %3 seconds", (_endTime - _beginTime), diag_fps, (_endTime - _beginTime) / diag_fps];
};