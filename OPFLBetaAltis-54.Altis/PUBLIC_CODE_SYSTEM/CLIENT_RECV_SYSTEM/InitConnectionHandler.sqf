if(!isServer) exitWith {};
PCS_UID_CONNECTIONS_LIST = [];
PCS_UID_FAILED_LIST = [];
PCS_UID_INITIAL_LIST = [];
PCS_ON_DISCONNECTED_FNC_LIST = [PCS_RemoveConnection, PCS_RemovePendingClient]; //compile "_null = format['%1 has DISCONNECTED to the session', (_this select 0)] createVehicleLocal [0,0,0];"];
PCS_ON_CONNECTED_FNC_LIST = [PCS_AddConnection, PCS_AddPendingClient]; //compile "_null = format['%1 has connected to the session', (_this select 0)] createVehicleLocal [0,0,0];"];

//onPlayerConnected "[_uid, _name, _id] call PCS_OnConnected";
//onPlayerDisconnected "[_uid, _name, _id] call PCS_OnDisconnected";

["PCS_ConnectionHandler", "onPlayerConnected", {[_uid, _name, _id, _owner] call PCS_OnConnected; diag_log format ["PLAYER CONNECTED: %1, %2", _name, _uid];}] call BIS_fnc_addStackedEventhandler;
["PCS_DisconnectionHandler", "onPlayerDisconnected", {[_uid, _name, _id, _owner] call PCS_OnDisconnected;diag_log format ["PLAYER DISCONNECTED: %1, %2, %3, %4", _name, _uid, _owner, owner TEST_OWNED_OBJECT];}] call BIS_fnc_addStackedEventHandler;