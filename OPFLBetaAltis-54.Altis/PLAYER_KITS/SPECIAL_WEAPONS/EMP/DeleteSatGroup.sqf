private "_index";

_index = _this select 0;

{
	[_x] call EMP_DeleteSat;
} foreach (EMP_SAT_GROUP select _index);

EMP_SAT_GROUP set [_index, -1];
EMP_SAT_GROUP = EMP_SAT_GROUP - [-1];
EMP_GROUP_COUNT = EMP_GROUP_COUNT - 1;