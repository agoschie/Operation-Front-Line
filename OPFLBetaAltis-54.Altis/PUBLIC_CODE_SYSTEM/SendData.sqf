private "_type";
private "_data";
private "_atomic";
private "_pipe";
private "_tmpID";
private "_machine";

_data = + (_this select 0);
_type = _this select 1;
_atomic = _this select 2;
_pipe = "";
_tmpID = 0;
_machine = _data select 2;

/*
if (isServer || (_type == "ALL") || (_type == "SERVER")) then
{
	_data set [2, -1];
	_data = _data - [-1];
};
*/
if ((_type == "ALL") || (_type == "SERVER")) then
{
	_data set [2, -1];
	_data = _data - [-1];
};

if (3 < count _this) then
{
	_pipe = _this select 3;
	missionNamespace setVariable [_pipe, _data];
}
else
{
	if (_atomic) then
	{
		PCS_PUBLIC_EX_ATOMIC = _data;
		_pipe = "PCS_PUBLIC_EX_ATOMIC";
	}
	else
	{
		PCS_PUBLIC_EX = _data;
		_pipe = "PCS_PUBLIC_EX";
	};
};


if (_type == "SERVER") exitWith
{
	if (!isServer) then
	{
		publicVariableServer _pipe;
		missionNamespace setVariable [_pipe, nil];
	};
};

if (_type == "ALL") exitWith
{
	publicVariable _pipe;
	missionNamespace setVariable [_pipe, nil];
};
	
//default client types

if (!isServer) then
{
		publicVariableServer _pipe;
		missionNamespace setVariable [_pipe, nil];
}
else
{
	//all clients
	if (_type == "CLIENT") exitWith
	{
		(missionNamespace getVariable _pipe) deleteAt 2;
		publicVariable _pipe;
		missionNamespace setVariable [_pipe, nil];
	};
	
	//specific clients
	_tmpID = [_machine] call PCS_TempID;
	if (_tmpID > 0) then
	{
		//(missionNamespace getVariable _pipe) set [2, -1];
		//missionNamespace setVariable [_pipe, (missionNamespace getVariable _pipe) - [-1]];
		if (_type != "OBJECT_LOCAL") then {(missionNamespace getVariable _pipe) deleteAt 2;};
		_tmpID publicVariableClient _pipe;
		missionNamespace setVariable [_pipe, nil];
		diag_log format ["SEND SUCCESS: %1", _tmpID];
	};
};
