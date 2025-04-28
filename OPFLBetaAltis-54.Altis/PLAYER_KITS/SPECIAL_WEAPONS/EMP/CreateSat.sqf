private "_name";
private "_dir";
private "_id";
private "_side";
private "_sat";

_name = _this select 0;
_dir = [] + (_this select 1);
_side = _this select 2;
_id = _this select 3;

_sat = "Logic" createVehicleLocal [0,0,0];

_sat setVariable ["SAT_NAME", _name];
_sat setVariable ["SAT_DIR", _dir];
_sat setVariable ["SAT_SIDE", _side];
_sat setVariable ["SAT_ID", _id];

_sat setVariable ["SAT_CONNECTED", false];
_sat setVariable ["SAT_CONNECTED_UID", ""];
_sat setVariable ["SAT_OFFSET", 0];
_sat setVariable ["SAT_TARGET_POS", []];
_sat setVariable ["SAT_FIRED", false];

missionNamespace setVariable [format["EMP_%1_REF", _id], _sat];