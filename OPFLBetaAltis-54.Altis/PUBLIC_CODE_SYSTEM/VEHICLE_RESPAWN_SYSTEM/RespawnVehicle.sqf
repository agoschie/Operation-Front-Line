private "_vehicle";
private "_newVehicle";
private "_index";
private "_type";
	
_vehicle = _this select 0;
_index = _this select 1;
_type = typeOf _vehicle;

_newVehicle = _type createVehicle (_vehicle getVariable "VRS_INIT_POS");
_newVehicle setPosATL (_vehicle getVariable "VRS_INIT_POS");
_newVehicle setDir (_vehicle getVariable "VRS_INIT_DIR");
_newVehicle setVariable ["VRS_INIT_POS", (_vehicle getVariable "VRS_INIT_POS")];
_newVehicle setVariable ["VRS_INIT_DIR", (_vehicle getVariable "VRS_INIT_DIR")];
_newVehicle setVariable ["VRS_AB_TIME", (_vehicle getVariable "VRS_AB_TIME")];
_newVehicle setVariable ["VRS_RS_TIME", (_vehicle getVariable "VRS_RS_TIME")];
_newVehicle setVariable ["VRS_AB_COUNT", (_vehicle getVariable "VRS_AB_TIME")];
_newVehicle setVariable ["VRS_RS_COUNT", (_vehicle getVariable "VRS_RS_TIME")];
_newVehicle setVariable ["VRS_NEAR_DIST", (_vehicle getVariable "VRS_NEAR_DIST")];
_newVehicle setVariable ["VRS_INIT_DMG", damage _newVehicle];
_newVehicle call (VRS_INIT_LIST select _index);
deleteVehicle _vehicle;
VRS_VEHICLE_LIST set [_index, _newVehicle];
[[_index, _newVehicle], "VR_UpdIndex", PCS_S_ALL, "PIPE_KEY_A"] call PCS_MPCodeBroadcast;