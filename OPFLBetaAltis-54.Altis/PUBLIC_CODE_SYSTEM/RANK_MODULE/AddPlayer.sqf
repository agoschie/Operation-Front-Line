if (PCS_RNK_RUNNING) then
{
	private ["_uid", "_name", "_record", "_handle"];
	_uid = _this select 0;
	_name = _this select 1;
	_record = format ["%1", _uid];

	PCS_RNK_LAST_TRD = PCS_RNK_LAST_TRD + 2;
	diag_log "PCS RANK: Making connection";
	_handle = ["opfl", "Connect", [format ["%1", PCS_RNK_LAST_TRD], format ["%1", PCS_RNK_LAST_TRD - 1], _record, (PCS_RNK_RECORDS getVariable [_record, -1]) > 0]] call PCS_CallExtension;
	diag_log "PCS RANK: Connection finished";
	[_record, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false, _handle] call PCS_RNK_CreateRecord; //create a non-activated record, where we still are waiting on database
	diag_log "PCS RANK: Record default created";
	//PCS_RNK_RECORDS setVariable [format ["%1_AGREED", _record], true];
	PCS_RNK_PENDING_RECORDS pushBack [_uid, _name, _handle];
	diag_log "PCS RANK: Pending...";
};