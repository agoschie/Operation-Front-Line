if (PCS_RNK_RUNNING) then
{
	private ["_record", "_temp", "_handle", "_i"];
	_record = format ["%1", _this select 0];
	_handle = _record call PCS_RNK_GetHandle;
	
	PCS_RNK_WEST_RECORDS = PCS_RNK_WEST_RECORDS - [_record];
	PCS_RNK_EAST_RECORDS = PCS_RNK_EAST_RECORDS - [_record];
	PCS_RNK_ACTIVE_RECORDS = PCS_RNK_ACTIVE_RECORDS - [_record];
	
	_i = PCS_RNK_PENDING_RECORDS find [_this select 0, _this select 1, _handle];
	if (_i > -1) then
	{
		PCS_RNK_PENDING_RECORDS deleteAt _i;
	}
	else //else his record is already activated
	{
		//greater than zero signifies he was participating in the match
		/*
		if (((PCS_RNK_RECORDS getVariable _record) select 2) > 0) then
		{
			//YOU SIR HAVE BEEN PUNISHED FOR ABANDONING THE MATCH!!!
			_record = _record call PCS_RNK_GetRecord;	
			_record set [8,(_record select 8) + 1];	
			_record deleteRange [9, 6];
			_record append (["opfl", "GMTime", ""] call PCS_CallExtension);
			_record = format ["%1", _this select 0];
		};
		*/
		
		_null = ["opfl", "PublishAccount", [(_record call PCS_RNK_GetHandle) select 0, _record call PCS_RNK_GetRecord]] call PCS_CallExtension;
		if (!isNil {PCS_RNK_RECORDS getVariable format ["%1_LPI", _record]}) then
		{
			PCS_RNK_PUBLISH deleteAt (PCS_RNK_RECORDS getVariable format ["%1_LPI", _record]);
			PCS_RNK_RECORDS setVariable [format ["%1_LPI", _record], nil];
		};
	};

	PCS_RNK_RECORDS setVariable [format["%1_AGREED", _record], nil];
	PCS_RNK_RECORDS setVariable [format["%1_SIDE", _record], nil];
	PCS_RNK_RECORDS setVariable [_record, (PCS_RNK_RECORDS getVariable _record) select 2];
	_null = ["opfl", "Commit", [(_handle + [((PCS_RNK_RECORDS getVariable _record) > 0) && PCS_RNK_ON])]] call PCS_CallExtension; //close the record, and free up connection
};