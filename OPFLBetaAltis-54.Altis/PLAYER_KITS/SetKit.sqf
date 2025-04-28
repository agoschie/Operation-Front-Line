private "_ID";
private "_kitName";
private "_table";
private "_UID";

_ID = _this select 0;
_kitName = _this select 1;
_UID = _this select 2;
_table = PKS_KIT_TABLE;

if ((_table getVariable format ["P%1KIT", _UID]) == _kitName) exitWith {};

if ((_table getVariable _kitName) > 0) then
{
	_table setVariable [_kitName, ((_table getVariable _kitName) - 1), true];
	[_table, _UID] call PKS_DropKit;
	_table setVariable [format ["P%1KIT", _UID], _kitName];
	
	[[_kitName], "PKS_FillKitMsg", _ID, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
};