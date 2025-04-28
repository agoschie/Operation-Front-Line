if (isServer) then
{
	if (PCS_RNK_RUNNING && !isNull (_this select 1)) then
	{
		if (([_this select 1] call GSC_Side) != ([_this select 0] call GSC_Side)) then
		{
			if (((getPlayerUID (_this select 1)) call PCS_UIDToID) != "") then
			{
				[getPlayerUID (_this select 1), ((getPlayerUID (_this select 1)) call PCS_UIDToID) call PCS_GetName, (_this select 1)] call PCS_RNK_UpdatePlayerKills;
			}
			else
			{
				if ((((_this select 1) getVariable ["OPFL_UNIT_UID", ""]) call PCS_UIDToID) != "") then
				{
					[(_this select 1) getVariable "OPFL_UNIT_UID", (((_this select 1) getVariable "OPFL_UNIT_UID") call PCS_UIDToID) call PCS_GetName, (_this select 1)] call PCS_RNK_UpdatePlayerKills;
				};
			};
		};
		
		if (((getPlayerUID (_this select 1)) call PCS_UIDToID) != "") then
		{
			[getPlayerUID (_this select 1), ((getPlayerUID (_this select 1)) call PCS_UIDToID) call PCS_GetName, (_this select 1)] call PCS_RNK_UpdatePlayerKills;
		};
	};
};

if (!isDedicated) then
{
	//attach name to dead body
	(_this select 0) setVariable ["OPFL_UNIT_NAME", _this select ((count _this) - 1)];
	
	//play sound and indicate for the person who got the kill
	if (!isNull (_this select 1)) then
	{
		if (((_this select 1) == player) || (((_this select 1) getVariable ["OPFL_UNIT_UID", ""]) == getPlayerUID player)) then
		{
			if (([_this select 1] call GSC_Side) != ([_this select 0] call GSC_Side)) then
			{
				//play sound
				//playSound "GotKill";
			};
		};
	};
};
(_this select 0) setVariable ["OPFL_UNIT_UID", getPlayerUID (_this select 0)];