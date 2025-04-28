private ["_uid", "_name", "_person", "_record"];
_uid = _this select 0;
_name = _this select 1;
_person = _this select 2;
_record = format ["%1", _uid];
(_record call PCS_RNK_GetRecord) set [6, ((_record call PCS_RNK_GetRecord) select 6) + 1];
(_record call PCS_RNK_GetRecord) set [7, ((_record call PCS_RNK_GetRecord) select 7) + ([PCS_RNK_WFP_DT_MULTIPLIER, 1] select PCS_RNK_ON)];
PCS_RNK_RECORDS setVariable [format ["%1_LPI", _record], PCS_RNK_PUBLISH pushBackUnique [_record, _uid call PCS_UIDToID]];