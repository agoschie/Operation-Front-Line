private "_uid";

_uid = _this select 0;

PCS_PENDING_CLIENTS set [(count PCS_PENDING_CLIENTS), _uid];