private "_initialTime";
publicVariable "UNITIME";
waitUntil {OPFL_CLOCK_START};
_initialTime = diag_tickTime;

if (PCS_RNK_ON) then
{
	if (!OPFL_ROUND_MODE) then
	{
		waitUntil
		{
			if ((floor (diag_tickTime - _initialTime)) != UNITIME) then
			{
				UNITIME = floor (diag_tickTime - _initialTime);
				publicVariable "UNITIME";
			};
			if ((count OPFL_TICKET_QUEUE) > 0) then
			{
				call OPFL_Server_TicketQueue;
			};
			(((diag_tickTime - _initialTime) >= OPFL_GAME_TIME))
		};
		// || (OPFL_AMERICAN_TICKETS >= OPFL_TICKET_VICTORY) || (OPFL_RUSSIAN_TICKETS >= OPFL_TICKET_VICTORY)
		sleep 1;

		if (OPFL_AMERICAN_TICKETS > OPFL_RUSSIAN_TICKETS) then
		{
			UNIVERSAL_MESSAGE = format ["END OF MISSION!  BLUFOR: %1,  OPFOR: %2", OPFL_AMERICAN_TICKETS, OPFL_RUSSIAN_TICKETS];
			publicVariable "UNIVERSAL_MESSAGE";
			[west] call PCS_RNK_EndGame;
			sleep 7;
			[[], "OPFL_Server_End1Msg", PCS_S_ALL, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
		};

		if (OPFL_RUSSIAN_TICKETS > OPFL_AMERICAN_TICKETS) then
		{
			UNIVERSAL_MESSAGE = format ["END OF MISSION!  BLUFOR: %1,  OPFOR: %2", OPFL_AMERICAN_TICKETS, OPFL_RUSSIAN_TICKETS];
			publicVariable "UNIVERSAL_MESSAGE";
			[east] call PCS_RNK_EndGame;
			sleep 7;
			[[], "OPFL_Server_End2Msg", PCS_S_ALL, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
		};

		if (OPFL_RUSSIAN_TICKETS == OPFL_AMERICAN_TICKETS) then
		{
			UNIVERSAL_MESSAGE = format ["END OF MISSION!  BLUFOR: %1,  OPFOR: %2", OPFL_AMERICAN_TICKETS, OPFL_RUSSIAN_TICKETS];
			publicVariable "UNIVERSAL_MESSAGE";
			[independent] call PCS_RNK_EndGame;
			sleep 7;
			[[], "OPFL_Server_End3Msg", PCS_S_ALL, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
		}; 
	}
	else
	{
		waitUntil {!isNil "OPFL_ROUND_WIN"};
		if (OPFL_ROUND_WIN == west) then
		{
			UNIVERSAL_MESSAGE = format ["END OF MISSION!<br></br><br></br>BLUFOR: %1<br></br>OPFOR: %2", 1, 0];
			publicVariable "UNIVERSAL_MESSAGE";
			sleep 7;
			[[], "OPFL_Server_End1Msg", PCS_S_ALL, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
		};

		if (OPFL_ROUND_WIN == east) then
		{
			UNIVERSAL_MESSAGE = format ["END OF MISSION!<br></br><br></br>BLUFOR: %1<br></br>OPFOR: %2", 0, 1];
			publicVariable "UNIVERSAL_MESSAGE";
			sleep 7;
			[[], "OPFL_Server_End2Msg", PCS_S_ALL, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
		};
	};
}
else
{
	waitUntil
	{
		if ((floor (diag_tickTime - _initialTime)) != UNITIME) then
		{
			UNITIME = floor (diag_tickTime - _initialTime);
			publicVariable "UNITIME";
		};
		if ((count OPFL_TICKET_QUEUE) > 0) then
		{
			call OPFL_Server_TicketQueue;
		};
		((((diag_tickTime - _initialTime) >= OPFL_GAME_TIME)) || (((playersNumber west) min (playersNumber east)) >= PCS_RNK_PLAYER_THRESHOLD))
	};
	sleep 1;
	UNIVERSAL_MESSAGE = format ["END OF MISSION!  BLUFOR: %1,  OPFOR: %2", OPFL_AMERICAN_TICKETS, OPFL_RUSSIAN_TICKETS];
	publicVariable "UNIVERSAL_MESSAGE";
	[independent] call PCS_RNK_EndGame;
	sleep 7;
	[[], "OPFL_Server_End3Msg", PCS_S_ALL, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
};

// Write stats to everones rpt
//_null = [[], "_null = [] execVM 'SPY\SPY_rptStats\SPY_rptStats.sqf';", PCS_S_ALL] spawn PCS_MPCodeBroadcast;