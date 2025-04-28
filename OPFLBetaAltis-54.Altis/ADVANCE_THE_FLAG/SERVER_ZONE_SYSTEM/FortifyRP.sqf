private "_flagObject";
private "_flagObjectE";
private "_overLine";
private "_positionPlayer";
private "_originalPos";
private "_dirPlayer";
private "_ticketGainScript";
private "_zoneScript";
private "_sizePercent";
private "_ID";
private "_unitID";
private "_votes";

_person = _this select 0;
_unitID = _this select 1;
_positionPlayer = _this select 2;
//_positionPlayer = _this select 1;
//_originalPos = _this select 2;

if (isNull _person) exitWith {};
if ((!alive _person) || ("" == (_unitID call PCS_IDToUID))) exitWith {};
if (isNil {_person getVariable "OPFL_RP_POS"}) exitWith {};

_ID = _person getVariable "OPFL_RP_ID";
//_unitID = (getPlayerUID _unit) call PCS_UIDToID;

if ((_unitID in (_person getVariable "OPFL_RP_VOTE_LIST")) || (_unitID == _ID)) exitWith {};

{
	if ((_x getVariable "FLAG_ZONE_SIDE") == (_person getVariable "OPFL_RP_SIDE")) then
	{
		_flagObject = _x;
	}
	else
	{
		_flagObjectE = _x;
	};
} foreach OPFL_FLAG_ZONE_LIST;

_sizePercent = (_flagObject getVariable "FLAG_ZONE_STATE") select 1;
if ((OPFL_PINNED_ZONES && (_sizePercent < 1)) && !(_positionPlayer isEqualTo (_person getVariable "OPFL_RP_POS"))) exitWith {};

//_overLine = false;

//_overLine = (([_positionPlayer, (_flagObject getVariable "FLAG_ZONE_SIDE")] call GSC_OverEZW) || (!([_positionPlayer, "BATTLE_FIELD_AREA"] call MSO_fnc_inArea)) || (([_positionPlayer, _flagObject] call GSC_2dDistance) > OPFL_REDEPLOY_RADIUS));

//if (!(_flagObject getVariable "FLAG_ZONE_PLANTED") || (!isNil {_person getVariable "OPFL_RP_POS"}) || _overLine || !([_originalPos, (getPosASL _flagObject)] call GSC_EqualPosArrays) || !(_flagObject getVariable "FLAG_ZONE_READY") || (OPFL_PINNED_ZONES && (_sizePercent < 1))) exitWith {};

_votes = 1 + (_person getVariable "OPFL_RP_VOTE");
_person setVariable ["OPFL_RP_VOTE", _votes];
//[_person, "OPFL_LockVoteRP", _unitID, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;

if (_votes == OPFL_RP_VOTES_REQ) then
{
	//[_person, "OPFL_DeleteRP", PCS_S_CLIENT, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
	[_flagObject, _person getVariable "OPFL_RP_FLAG_POS", _person getVariable "OPFL_RP_POS", [], true] call OPFL_Server_ReDeployFlagZone;
	
	//this code updates all the rally points in response to deploying the flag
	//friendly gets deleted and enemy gets checked for validity (if not valid its gets deleted too)
	{
		if (!isNil {(_x select 0) getVariable "OPFL_RP_POS"}) then
		{
			private "_person";
			_person = _x select 0;
			if ((_flagObject getVariable "FLAG_ZONE_SIDE") == (_x select 2)) then
			{
			
				[_person, "OPFL_DeleteRP", PCS_S_CLIENT, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
			
				//delete RP, but leave deploy time for locking/unlocking ability
				[_person] call OPFL_Server_DisableRP;
			
				if (((_person getVariable "OPFL_RP_TIME") + OPFL_RP_READY_TIME) < diag_tickTime) then
				{
					["", "OPFL_UnlockRP", _x select 1, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
					_person setVariable ["OPFL_RP_TIME", nil];
					OPFL_RP_LIST set [_forEachIndex, -1];
				};
			}
			else
			{
				_overLine = false;
				_positionPlayer = _person getVariable "OPFL_RP_POS";

				_overLine = (([_positionPlayer, (_flagObjectE getVariable "FLAG_ZONE_SIDE")] call GSC_OverEZW) || (!([_positionPlayer, "BATTLE_FIELD_AREA"] call MSO_fnc_inArea)) || (([_positionPlayer, _flagObjectE] call GSC_2dDistance) > OPFL_REDEPLOY_RADIUS));

				if (!(_flagObjectE getVariable "FLAG_ZONE_PLANTED") || _overLine || !(_flagObjectE getVariable "FLAG_ZONE_READY")) then
				{
					[_person, "OPFL_DeleteRP", PCS_S_CLIENT, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
			
					//delete RP, but leave deploy time for locking/unlocking ability
					[_person] call OPFL_Server_DisableRP;
			
					if (((_person getVariable "OPFL_RP_TIME") + OPFL_RP_READY_TIME) < diag_tickTime) then
					{
						["", "OPFL_UnlockRP", _x select 1, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
						_person setVariable ["OPFL_RP_TIME", nil];
						OPFL_RP_LIST set [_forEachIndex, -1];
					};
				};
			};
		};
	} foreach OPFL_RP_LIST;
	
	OPFL_RP_LIST = OPFL_RP_LIST - [-1];
	
}
else
{
	[[_person, _votes], "OPFL_UpdateRP", PCS_S_CLIENT, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
};