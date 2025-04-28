if (isNil "_this") exitWith {diag_log "CallFnc: No args";};
if ("SCALAR" == typeName (_this select 1)) exitWith
{
	(_this select 0) call (missionNamespace getVariable ((uiNamespace getVariable "PCS_FNC_TABLE") getVariable [format ["PCS_FNC%1_KSTIRH", (_this select 1)], "PCS_BadFnc"]));
	diag_log format ["FIRED AS NUMBER: %1", _this select 1];
};

if ("STRING" == typeName (_this select 1)) exitWith
{
	private "_id";
	_id = (uiNamespace getVariable "PCS_FNC_TABLE") getVariable (_this select 1);
	(_this select 0) call (missionNamespace getVariable ((uiNamespace getVariable "PCS_FNC_TABLE") getVariable [format ["PCS_FNC%1_KSTIRH", _id], "PCS_BadFnc"]));
	diag_log format ["FIRED AS STRING: %1", _this select 1];
};

diag_log "CallFnc: Invalid function arg type";