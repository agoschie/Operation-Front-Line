//"PCS_PUBLIC_EX_ATOMIC" addPublicVariableEventHandler
(format ["PCS_KB_%1", _this]) addPublicVariableEventHandler
{
	private "_publicName";
	private "_publicValue";
	private "_scriptArguments";
	private "_scriptEx";
	private "_machineType";
	private "_compiledLine";
	private "_machine";
	
	_publicName = _this select 0;
	_publicValue = _this select 1;
	_scriptArguments = _publicValue select 0;
	_scriptEx = _publicValue select 1;
	if (2 < count _publicValue) then
	{
		_machine = _publicValue select 2;
	};
	
	
	if (!isNil "_machine") exitWith
	{
		private ["_me", "_type"];
		_me = false;
		_type = "TEMPORARY_ID";
		
		if (!isDedicated) then
		{
			if ("SCALAR" == typeName _machine) then
			{
				if (_machine == owner player) then
				{
					_me = true;
				};
			};
			if ("OBJECT" == typeName _machine) then
			{
				if (local _machine) then
				{
					_me = true;
				};
				_type = "OBJECT_LOCAL";
			};
			if ("STRING" == typeName _machine) then
			{
				if (_machine == PCS_UNIQUE) then
				{
					_me = true;
				};
			};
			if ("ARRAY" == typeName _machine) then
			{
				_me = true;
				_type = "CLIENT";
			};
			
			if (_me) then
			{
				if (_type == "CLIENT") then
				{
					[[_publicValue, _type, true], "PCS_SendData"] call PCS_CallFnc;
				};
				_null = [_scriptArguments, _scriptEx] call PCS_CallFnc;
			}
			else
			{
				//diag_log "MPCodeEH_Atomic: Unsupported address";
				[[_publicValue, _type, true], "PCS_SendData"] call PCS_CallFnc;
			};
		}
		else
		{
			if ("OBJECT" == typeName _machine) then
			{
				if (local _machine) then
				{
					_me = true;
				};
				_type = "OBJECT_LOCAL";
			};
			if ("ARRAY" == typeName _machine) then
			{
				_type = "CLIENT";
			};
			
			if (_me) then
			{
				_null = [_scriptArguments, _scriptEx] call PCS_CallFnc;
			}
			else
			{
				//diag_log "MPCodeEH_Atomic: Unsupported address";
				[[_publicValue, _type, true], "PCS_SendData"] call PCS_CallFnc;
			};
		};
		missionNamespace setVariable [_publicName, nil];
	};
	diag_log "EH FIRED!";
	_null = [_scriptArguments, _scriptEx] call PCS_CallFnc;
	missionNamespace setVariable [_publicName, nil];
};

PCS_PEHA_READY = true;
diag_log "EH ADDED!";