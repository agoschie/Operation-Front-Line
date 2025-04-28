private "_friendUnit";
private "_person";
private "_i";
private "_fail";
private "_handle";
_person = _this select 0;
_friendUnit = _this select 1;
_i = 0;
_fail = false;

//_person playMove "ainvpknlmstpslaywrfldnon_medic";
_handle = _person call PKS_BuildingAnimation; 
_person sideChat "REPAIRING VEHICLE...";
PKS_PROGRESS_BAR = 0.001;
_i = diag_tickTime;
//while {_i < 30} do
//{
	//sleep 1;
	waitUntil
	{
		if ((_handle call PKS_AnimationInterrupt) || (!alive _friendUnit) || (!alive _person) || ((_friendUnit distance _person) >= (sizeOf (typeOf _friendUnit)))) exitWith {_fail = true; player sideChat "REPAIR FAILED!";};
		PKS_PROGRESS_BAR = (diag_tickTime - _i) / 30;
		((diag_tickTime > (_i + 30)) || _fail)
	};
	//_i = _i + 1;
	//PKS_PROGRESS_BAR = _i / 30;
//};
PKS_PROGRESS_BAR = 0;
_handle call PKS_CancelAnimation;

if (!_fail) then
{
	[[_friendUnit], "PKS_RepairMsg", PCS_S_SERVER, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic; 
	player sideChat "FINISHED REPAIRING...";
};

_person setVariable ["PKS_REPAIR_ACTIVITY_IN_PROGRESS", nil];
PKS_PLAYER_IS_BUSY = false;