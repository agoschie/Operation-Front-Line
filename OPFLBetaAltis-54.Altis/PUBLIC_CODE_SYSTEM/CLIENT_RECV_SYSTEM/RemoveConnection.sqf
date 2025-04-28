private ["_UID", "_owner", "_ID"];
_UID = _this select 0;
_owner = _UID call PCS_UIDToTemp;
_ID = _owner call PCS_TempToID;

[_UID, "FAILED"] call PCS_LogConnection;
PCS_UID_CONNECTIONS_LIST = PCS_UID_CONNECTIONS_LIST - [format ["%1", _UID]];

(uiNamespace getVariable "PCS_FNC_TABLE") setVariable [format ["PCS_%1_CLIENT", _UID], nil];
(uiNamespace getVariable "PCS_FNC_TABLE") setVariable [format ["PCS_%1_ID", _owner], nil];
(uiNamespace getVariable "PCS_FNC_TABLE") setVariable [format ["PCS_%1_UID", _ID], nil];
(uiNamespace getVariable "PCS_FNC_TABLE") setVariable [format ["PCS_%1_NAME", _ID], nil];