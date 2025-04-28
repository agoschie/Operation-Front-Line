if (!isServer) exitWith {diag_log "ERROR (TempID): Can not use this function on non-server machine";};
private "_voidPtr";
private "_type";
private "_return";
_voidPtr = _this select 0;
_type = typeName _voidPtr;
_return = _voidPtr;

call
{
	if (_type == "OBJECT") exitWith
	{
		_return = 0;
		if (!isNull _voidPtr) then
		{
			_return = owner _voidPtr;
		};
	};

	if (_type == "STRING") exitWith
	{
		_return = 0;
		if (!isNil {_voidPtr call PCS_IDToTemp}) then
		{
			_return = _voidPtr call PCS_IDToTemp;
		};
	};
	
	//default number
	
};

_return;