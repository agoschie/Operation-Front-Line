private "_flagObject";
private "_side";
private "_zone";

_flagObject = _this select 0;
_zone = (_flagObject getVariable "FLAG_ZONE_NAME");
_side = (_flagObject getVariable "FLAG_ZONE_SIDE");
//_null = [_flagObject] execVM "ADVANCE_THE_FLAG\CLIENT_ZONE_SYSTEM\MP_MARKER_EH.sqf";
_null = [_flagObject] spawn OPFL_Client_FlagMarkerEH;
_null = [_flagObject] spawn OPFL_Client_FlagBeeping;

waitUntil {!isNil "OPFL_CLOCK_START"};
//if (playerSide == _side) then
//{
//	if (OPFL_MICRO_MODE) then
//	{
//		_action = _flagObject addAction [format ["Undeploy %1", _zone], "ADVANCE_THE_FLAG\CLIENT_ZONE_SYSTEM\PickUpZone.sqf", [_flagObject]];
//	}
//	else
//	{
//		_action = _flagObject addAction [format ["Redeploy %1", _zone], "ADVANCE_THE_FLAG\CLIENT_ZONE_SYSTEM\ReDeployZone.sqf", [_flagObject]];
//	};
//};