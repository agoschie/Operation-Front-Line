private "_friendUnit";
private "_i";
private "_fail";
private "_person";
private "_friendUID";
private "_handle";
_person = _this select 0;
_friendUnit = _this select 1;
_i = 0;
_fail = false;

//_person playMove "ainvpknlmstpslaywrfldnon_medic";
_handle = _person call PKS_MedicAnimation;
_person sideChat "HEALING FRIEND...";
PKS_PROGRESS_BAR = 0.001;
_i = diag_tickTime;
//while {_i < 6} do
//{
	//sleep 1;
	waitUntil 
	{
		if ((!alive _friendUnit) || (!alive _person) || ((_friendUnit distance player) >= 3)) exitWith {_fail = true; player sideChat "HEAL FAILED!";}; 
		PKS_PROGRESS_BAR = (diag_tickTime - _i) / 6; 
		(diag_tickTime > (_i + 6))
	};
	//_i = _i + 1;
	//PKS_PROGRESS_BAR = _i / 6;
//};
PKS_PROGRESS_BAR = 0;
_handle call PKS_CancelAnimation;

if (!_fail) then
{
	if (local _friendUnit) then
	{
		_friendUID = getPlayerUID player;
	}
	else
	{
		_friendUID = getPlayerUID _friendUnit;
	};
	[_friendUnit, "PKS_HealMsg", _friendUnit, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic; 
	player sideChat "FINISHED HEALING...";
};

_person setVariable ["PKS_HEAL_ACTIVITY_IN_PROGRESS", nil];
PKS_PLAYER_IS_BUSY = false;