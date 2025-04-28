private "_posA";
private "_posB";
private "_bTrue";
private "_bFalse";
_posA = _this select 0;
_posB = _this select 1;
_bTrue = true;
_bFalse = false;

if (!(((typeName _posA) == "ARRAY") && ((typeName _posB) == "ARRAY"))) exitWith {_bFalse;};

if (isNil {_posA select 0}) exitWith {_bFalse;};
if (isNil {_posA select 1}) exitWith {_bFalse;};
if (isNil {_posA select 2}) then {_posA set [2, 0];};

if (isNil {_posB select 0}) exitWith {_bFalse;};
if (isNil {_posB select 1}) exitWith {_bFalse;};
if (isNil {_posB select 2}) then {_posA set [2, 0];};

if (((_posA select 0) == (_posB select 0)) && ((_posA select 1) == (_posB select 1)) && ((_posA select 2) == (_posB select 2))) exitWith {_bTrue;};
_bFalse;