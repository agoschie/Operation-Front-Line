waitUntil {(!isNil "OPFL_FLAG_ZONE_LIST") && (!isNil "OPFL_ALL_FLAGS_CREATED")};

_null = player addEventHandler ["Respawn", {
	[_this select 0] call OPFL_Client_AddFlagActions;
}];
waitUntil
{
	[player] call OPFL_Client_AddFlagActions;
	true;
};