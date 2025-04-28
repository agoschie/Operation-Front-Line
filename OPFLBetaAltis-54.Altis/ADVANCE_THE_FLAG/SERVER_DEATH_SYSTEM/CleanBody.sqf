private "_body";
_body = _this select 0;

sleep OPFL_BODY_CLEANUP_TIME;
waitUntil {!isNil "OPFL_FLAG_ZONE_QUEUE"};
OPFL_FLAG_ZONE_QUEUE set [(count OPFL_FLAG_ZONE_QUEUE), [[_body], 4]];
