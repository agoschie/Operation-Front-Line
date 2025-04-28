[[],
{
	private ["_carrier", "_carrierState", "_rpChange", "_timerA", "_timerB", "_flagTimeLine"];

	_carrier = objNull;
	_carrierState = [];
	_rpChange = false;

	//hintSilent format ["FRAME RATE: %1", ([_initFrame, diag_tickTime] call GSC_FrameRate)];
	//_initFrame = diag_tickTime;
	
	//track rallypoints
	{
		private ["_person", "_unlock"];
		_person = _x select 0;
		_unlock = false;
		
		if (!isNull _person) then
		{
			if (alive _person) then
			{
				if (!isNil {_person getVariable "OPFL_RP_POS"}) then
				{
					if ((_person distance (_person getVariable "OPFL_RP_POS")) > OPFL_RP_DISTANCE) then
					{
						[_person] call OPFL_Server_DisableRP;
						[_person, "OPFL_DeleteRP", PCS_S_CLIENT, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
					};
				};
				
				if (isNil {_person getVariable "OPFL_RP_POS"}) then
				{
					if (((_person getVariable "OPFL_RP_TIME") + OPFL_RP_READY_TIME) < diag_tickTime) then
					{				
						_unlock = true;
					};
				};
			}
			else
			{
				if (!isNil {_person getVariable "OPFL_RP_POS"}) then
				{
					[_person] call OPFL_Server_DisableRP;
				};
				_unlock = true;
			};
		}
		else
		{
			_unlock = true;
		};
		
		//unlock the player, delete RP
		if (_unlock) then
		{
			if (!isNull _person) then
			{
				_person setVariable ["OPFL_RP_TIME", nil];
			};
			["", "OPFL_UnlockRP", _x select 1, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
			OPFL_RP_LIST set [_forEachIndex, -1];
			_rpChange = true;
		};
		
	} foreach OPFL_RP_LIST;
	
	//if this array is big, every frame could be become taxing
	if (_rpChange) then
	{
		OPFL_RP_LIST = OPFL_RP_LIST - [-1];
	};
	
	while {(count OPFL_FLAG_ZONE_QUEUE) > 0} do
	{
		[] call OPFL_Server_FlagZoneQueue;
	};
	_flagTimeLine = diag_tickTime;
	{
		if (_x getVariable "FLAG_ZONE_PLANTED") then
		{
			if ((_x getVariable "FLAG_ZONE_ACTIVATED") && ([_x, OPFL_SCT] call OPFL_Server_NeedScan)) then
			{
				[_x, OPFL_SCT] call OPFL_Server_ScanFlagZone;
				[_x] call OPFL_Server_UpdateVisualState;
			};
		
			if (!(_x getVariable "FLAG_ZONE_READY")) then
			{
				if ((_flagTimeLine >= ((_x getVariable "FLAG_ZONE_TOD") + OPFL_DEPLOY_READY_TIME)) && PCS_RNK_ON) then
				{
					_x setVariable ["FLAG_ZONE_READY", true, true];
					OPFL_CLOCK_START = true;
				};
			};
		}
		else
		{
			_carrier = _x getVariable "FLAG_ZONE_CARRIER_UNIT";
			_carrierState = [!isNull _carrier, getPosASL _carrier];
			
			if (_carrierState select 0) then
			{
				_x setVariable ["FLAG_ZONE_CARRIER_POS", _carrierState select 1];
			};
			
			if (!alive _carrier) then
			{
				[_x, _carrier, (_x getVariable "FLAG_ZONE_CARRIER_POS"), false, true] call OPFL_Server_DeployFlagZone;
			};
		};
	} foreach OPFL_FLAG_ZONE_LIST;
	
	_timerA = [0, OPFL_DEPLOY_READY_TIME min (floor (_flagTimeLine - (OPFL_WEST_FLAG getVariable "FLAG_ZONE_TOD")))] select PCS_RNK_ON;
	_timerB = [0, OPFL_DEPLOY_READY_TIME min (floor (_flagTimeLine - (OPFL_EAST_FLAG getVariable "FLAG_ZONE_TOD")))] select PCS_RNK_ON;
	if ((_timerA != (OPFL_ADVANCE_TIMERS select 0)) || (_timerB != (OPFL_ADVANCE_TIMERS select 1))) then
	{
		OPFL_ADVANCE_TIMERS set [0, _timerA];
		OPFL_ADVANCE_TIMERS set [1, _timerB];
		publicVariable "OPFL_ADVANCE_TIMERS";
		if (!isDedicated) then
		{
			private ["_exit"];
			_exit = false;
			if (_timerA == OPFL_DEPLOY_READY_TIME) then
			{
				if (!OPFL_WB) then
				{
					playSound "VoteRP";
					OPFL_WB = true;
					_exit = true;
				};
			}
			else
			{
				OPFL_WB = false;
			};
			if (_timerB == OPFL_DEPLOY_READY_TIME) then
			{
				if (!OPFL_EB) then
				{
					if (!_exit) then
					{
						playSound "VoteRP";
					};
					OPFL_EB = true;
				};
			}
			else
			{
				OPFL_EB = false;
			};
		};
	};
	//false
}] call PCS_AddPerFrameEvent;