private "_wait";
private "_i";
private "_handle";
private "_person";

_wait = 1;
waitUntil {!isNil "PKS_BUILD_ARGUMENTS"};
while {_wait == 1} do
{
	waitUntil {(count PKS_BUILD_ARGUMENTS) > 0};
	_person = player;
	_arguments = PKS_BUILD_ARGUMENTS;
	_dirPlayer = getDir _person;
	_positionPlayer = [getPosASL _person, ((PKS_BUILDING_TYPES getVariable _arguments) select 1) select 3, _dirPlayer] call GSC_PolarVector;
	_positionPlayer = ASLToATL _positionPlayer;
	_positionPlayer set [2, [0, 0 max (_positionPlayer select 2)] select (((getPosATL _person) select 2) > 0.01)];
	_dirPlayer = _dirPlayer + (((PKS_BUILDING_TYPES getVariable PKS_BUILD_VISUALIZER) select 1) select 2);
	_bTime = ((PKS_BUILDING_TYPES getVariable _arguments) select 1) select 1;
	_maxDistance = ((((PKS_BUILDING_TYPES getVariable _arguments) select 1) select 3) + 1 + ceil(((sizeOf _arguments) / 2)));
	
	_i = 0;
	_handle = _person call PKS_BuildingAnimation;
	while {(_i < _bTime) && (alive _person) && !(_handle call PKS_AnimationInterrupt)} do
	{
		PKS_BUILD_HUD_TEXT = format ["%1 / %2 (DISTANCE: %3 / %4)", _i, _bTime, _positionPlayer vectorDistance (getPosATLVisual player), _maxDistance];
		PKS_PROGRESS_BAR = _i / _bTime;
		sleep 1;
		_i = _i + 1;
	};
	
	_handle call PKS_CancelAnimation;
	
	if(_i == _bTime) then
	{
		_null = [[_arguments, _positionPlayer, _dirPlayer], "PKS_ServerBS_BuildObjectMsg", PCS_S_SERVER] spawn PCS_MPCodeBroadcast; 
	};
	
	PKS_BUILD_HUD_TEXT = "";
	PKS_PROGRESS_BAR = 0;
	PKS_BUILD_ARGUMENTS = [];
	PKS_PLAYER_IS_BUSY = false;
};