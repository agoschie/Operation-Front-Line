private "_i";
private "_satW";
private "_satE";
private "_satGroup";
_satGroup = [];
_i = 1;

//merge all available satellites into one list, use server to translate based on client side
while {_i <= EMP_SAT_GROUP_SIZE} do
{
	_satW = [format ["%1%2S", EMP_SAT_NAME_WEST, _i, west], EMP_SAT_ORBIT_DIR, west, _i] call EMP_CreateSat; //create sat stores game logic, which is also referenced by global variable based on name
	_satE = [format ["%1%2S", EMP_SAT_NAME_EAST, (_i+1), east], EMP_SAT_ORBIT_DIR, east, _i] call EMP_CreateSat;
	
	_satGroup = _satGroup + [_satW, _satE]; //all evens are West (starting zero) 
	_i = _i + 2;
};
_satGroup set [_i, diag_tickTime]; //set spawn time
EMP_SAT_GROUPS set [count EMP_SAT_GROUPS, _satGroup];
EMP_GROUP_COUNT = EMP_GROUP_COUNT + 1;