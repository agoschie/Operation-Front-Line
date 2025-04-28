private "_initTime";
private "_endTime";
private "_return";

_return = 0;
if (2 > count _this) exitWith {diag_log "GSC_FrameRate: Not enough arguments";};

_initTime = _this select 0;
_endTime = _this select 1;

_return = 1 / (_endTime - _initTime);

_return;