private "_flagObject";
private "_overLine";
private "_positionPlayer";
private "_originalPos";
private "_dirPlayer";
private "_ticketGainScript";
private "_zoneScript";
private "_sizePercent";
private "_ID";
private "_soundPath";
private "_redRad";

_person = _this select 0;
_positionPlayer = _this select 1;
_originalPos = _this select 2;

if (isNull _person) exitWith {};
if ((!alive _person) || ("" == getPlayerUID _person)) exitWith {};

_ID = (getPlayerUID _person) call PCS_UIDToID;
if (_ID == "") exitWith {};

{
	if ((_x getVariable "FLAG_ZONE_SIDE") == [_person] call GSC_Side) then
	{
		_flagObject = _x;
	};
} foreach OPFL_FLAG_ZONE_LIST;

if (isNil "_flagObject") exitWith {};

_redRad = [OPFL_REDEPLOY_RADIUS, OPFL_DESTROYED_RADIUS] select (_flagObject getVariable "FLAG_ZONE_DESTROYED");

_sizePercent = (_flagObject getVariable "FLAG_ZONE_STATE") select 1;

_overLine = false;

_overLine = (([_positionPlayer, (_flagObject getVariable "FLAG_ZONE_SIDE")] call GSC_OverEZW) || (!([_positionPlayer, "BATTLE_FIELD_AREA"] call MSO_fnc_inArea)) || (([_positionPlayer, _flagObject] call GSC_2dDistance) > _redRad));

if (!(_flagObject getVariable "FLAG_ZONE_PLANTED") || (!isNil {_person getVariable "OPFL_RP_TIME"}) || _overLine || !([_originalPos, (getPosASL _flagObject)] call GSC_EqualPosArrays) || !(_flagObject getVariable "FLAG_ZONE_READY") || (OPFL_PINNED_ZONES && (_sizePercent < 1))) exitWith {};

_person setVariable ["OPFL_RP_POS", _positionPlayer];
_person setVariable ["OPFL_RP_FLAG_POS", _originalPos];
_person setVariable ["OPFL_RP_SIDE", [_person] call GSC_Side];
_person setVariable ["OPFL_RP_ID", _ID];
_person setVariable ["OPFL_RP_TIME", diag_tickTime];
_person setVariable ["OPFL_RP_VOTE", 0];
_person setVariable ["OPFL_RP_VOTE_LIST", []];

["", "OPFL_LockRP", _ID, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;

//_soundPath = format ["%1ADVANCE_THE_FLAG\SOUNDS\dpl%2.wss", PCS_M_ROOT, floor random 3];
//playSound3D [_soundPath, _person, false, _positionPlayer, 10, 1, 200];

OPFL_RP_LIST set [count OPFL_RP_LIST, [_person, _ID , [_person] call GSC_Side]];

[[_person, _positionPlayer], "OPFL_CreateRP", PCS_S_CLIENT, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;