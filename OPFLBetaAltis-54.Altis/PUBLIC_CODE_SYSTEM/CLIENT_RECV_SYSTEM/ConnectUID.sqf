//this script is just what you want to trigger on the first "hello server"

private "_uid";
private "_wait";
private "_uidCount";
private "_uidConnected";
private "_timeStamp";
_uid = _this;
_uidCount = 0;

diag_log "SERVER RECEIVED";

VRS_PENDING_CLIENTS = VRS_PENDING_CLIENTS + 1;
VRS_LAST_CLIENT = _uid;