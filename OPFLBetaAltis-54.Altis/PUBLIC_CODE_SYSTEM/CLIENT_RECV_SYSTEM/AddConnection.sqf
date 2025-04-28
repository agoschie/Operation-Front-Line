private "_UID";
private "_owner";
_UID = _this select 0;
_owner = _this select 3;

{
	PCS_CLIENT_IDS set [_forEachIndex, [1, _x + 1] select ((_x + 1) < 256)];
	
	if ((PCS_CLIENT_IDS select _forEachIndex) > 1) exitWith {};
	
	if (_forEachIndex == PCS_CLIENT_IDS_INDEX) exitWith
	{
		PCS_CLIENT_IDS pushBack [1]; 
		PCS_CLIENT_IDS_INDEX = PCS_CLIENT_IDS_INDEX + 1;
	};
} foreach PCS_CLIENT_IDS;

//incase he was kicked early last time and failed to trigger disconnect
//should also be benign due to the inability to successfully launch safe spawn, if you get kicked early without assigned player
//PCS_UID_CONNECTIONS_LIST = PCS_UID_CONNECTIONS_LIST - [_UID];
//PCS_PENDING_CLIENTS = PCS_PENDING_CLIENTS - [_UID];
//PCS_UID_CONNECTIONS_LIST set [(count PCS_UID_CONNECTIONS_LIST), format ["%1", _UID]];

PCS_UID_CONNECTIONS_LIST pushBackUnique _UID;

(uiNamespace getVariable "PCS_FNC_TABLE") setVariable [format ["PCS_%1_CLIENT", _UID], _owner];
(uiNamespace getVariable "PCS_FNC_TABLE") setVariable [format ["PCS_%1_ID", _owner], toString PCS_CLIENT_IDS];
(uiNamespace getVariable "PCS_FNC_TABLE") setVariable [format ["PCS_%1_UID", toString PCS_CLIENT_IDS], _UID];
(uiNamespace getVariable "PCS_FNC_TABLE") setVariable [format ["PCS_%1_NAME", toString PCS_CLIENT_IDS], (_this select 1)];


[_UID, "INITIAL"] call PCS_LogConnection;

_null = _this spawn {sleep 5; player sideChat format ["%1, RAN THE CONNECTED SCRIPT, %2", (count PCS_UID_CONNECTIONS_LIST), (_this select 0)];};