private "_uid";
_uid = _this select 0;

PKS_SERVER_KIT_QUEUE set [(count PKS_SERVER_KIT_QUEUE), [[PKS_KIT_TABLE, format['%1', _uid]], 2]];