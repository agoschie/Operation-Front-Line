private "_scriptArguments";
private "_scriptEx";
private "_machine";
private "_machineType";
private "_compiledLine";
private "_packet";
_scriptArguments = _this select 0;
_scriptEx = _this select 1;
_machine = _this select 2;
_machineType = typeName _machine;
_scriptEx = (uiNamespace getVariable "PCS_FNC_TABLE") getVariable _scriptEx;
_packet = [_scriptArguments, _scriptEx, _machine];

if ("OBJECT" == _machineType) exitWith
{
	if (local _machine) then
	{
		_null = [_scriptArguments, _scriptEx] spawn PCS_CallFnc;
	}
	else
	{
		[[_packet, "OBJECT_LOCAL", false, _this select 3], "PCS_SendData"] call PCS_SpawnAtomic;
	};
};

if ("SCALAR" == _machineType) then
{
	private "_me";
	_me = false;
	if (!isDedicated && isServer) then
	{
		if (_machine == owner player) then
		{
			_null = [_scriptArguments, _scriptEx] spawn PCS_CallFnc;
			_me = true;
		};
	};
	if (!_me) then
	{
		[[_packet, "TEMPORARY_ID", false, _this select 3], "PCS_SendData"] call PCS_SpawnAtomic;
	};
};
if ("ARRAY" == _machineType) then
{
	_machine = _machine select 0;
	
	if (_machine == "SERVER") exitWith
	{
		if (isServer) then
		{
			_null = [_scriptArguments, _scriptEx] spawn PCS_CallFnc;
		}
		else
		{
			[[_packet, "SERVER", false, _this select 3], "PCS_SendData"] call PCS_SpawnAtomic;
		};
	};

	if (!isDedicated && (_machine == "CLIENT")) exitWith
	{
		[[_packet, "CLIENT", false, _this select 3], "PCS_SendData"] call PCS_SpawnAtomic;
		if (isServer) then
		{
			_null = [_scriptArguments, _scriptEx] spawn PCS_CallFnc;
		};
	};
	
	if (isDedicated && (_machine == "CLIENT")) exitWith
	{
		[[_packet, "CLIENT", false, _this select 3], "PCS_SendData"] call PCS_SpawnAtomic;
	};

	if (_machine == "ALL") exitWith
	{
		[[_packet, "ALL", false, _this select 3], "PCS_SendData"] call PCS_SpawnAtomic;
		_null = [_scriptArguments, _scriptEx] spawn PCS_CallFnc;
	};
}
else
{

	//default UID

	if (_machine == PCS_UNIQUE) then
	{
		_null = [_scriptArguments, _scriptEx] spawn PCS_CallFnc;
	}
	else
	{
		[[_packet, "UID", false, _this select 3], "PCS_SendData"] call PCS_SpawnAtomic;
	};
};
