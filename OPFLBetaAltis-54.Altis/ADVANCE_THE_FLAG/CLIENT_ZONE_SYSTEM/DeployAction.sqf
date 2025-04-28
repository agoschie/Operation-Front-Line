private "_flagObject";
private "_person";
private "_zone";
_flagObject = _this select 0;
_person = _this select 1;
_zone = (_flagObject getVariable "FLAG_ZONE_NAME");

_index = _person addAction [format ["DEPLOY %1", _zone], OPFL_Client_DeployZone, [_flagObject], 10, false, true, "", "alive _target "];
OPFL_PLAYER_PACKED_ZONE = [_person, _index, _zone];
hint format ["%1 PACKED", _zone];