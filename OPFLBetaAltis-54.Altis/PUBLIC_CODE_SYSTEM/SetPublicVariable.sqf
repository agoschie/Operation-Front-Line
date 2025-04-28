private "_value";
private "_name";
private "_object";

_object = _this select 0;
_name = _this select 1;
_value = _this select 2;

_object setVariable [_name, _value, true];

[[_object, _name], {
	private "_object";
	private "_name";
	private "_objList";
	_object = _this select 0;
	_name = _this select 1;
	
	if (isNil {PCS_PV_TABLE getVariable _name}) then
	{
		PCS_PV_TABLE setVariable [_name, [_object]];
		PCS_PV_LIST set [(count PCS_PV_LIST), _name];
	}
	else
	{
		_objList = PCS_PV_TABLE getVariable _name;
		if (!(_object in _objList)) then
		{
			_objList set [(count _objList), _object];
		};
	};
}] call PCS_SpawnAtomic;

