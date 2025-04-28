private "_uid";
_uid = _this select 0;

if ("STRING" != typeName _uid) exitWith
{
	diag_log "RemovePendingClient: arg 1 needs to be string";
};
PCS_PENDING_CLIENTS = PCS_PENDING_CLIENTS - [_uid];