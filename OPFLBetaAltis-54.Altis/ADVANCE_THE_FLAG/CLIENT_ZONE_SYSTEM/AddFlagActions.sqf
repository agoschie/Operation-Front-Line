private "_person";
private "_actions";
private "_index";

_person = _this select 0;
_actions = [];
_index = 0;

if ((count OPFL_PLAYER_PACKED_ZONE) > 0) then
{
	{
		(OPFL_PLAYER_PACKED_ZONE select 0) removeAction _x;
	} foreach (OPFL_PLAYER_PACKED_ZONE select 1);
};

OPFL_PLAYER_PACKED_ZONE = [_person];

{
if (playerSide == (_x getVariable "FLAG_ZONE_SIDE")) then
{
	//deploy
	_index = _person addAction [format ["DEPLOY %1", (_x getVariable "FLAG_ZONE_NAME")], 
				OPFL_Client_DeployZone, 
				[_x], 
				10, 
				true, 
				true, 
				"", 
				format ["(player == vehicle player) && _target == ((OPFL_FLAG_ZONE_LIST select %1) getVariable 'FLAG_ZONE_CARRIER_UNIT')", _forEachIndex]];
	_actions set [(count _actions), _index];
	
	if (!OPFL_MICRO_MODE) then
	{
		//redeploy
		_index = _person addAction [format ["Redeploy %1", (_x getVariable "FLAG_ZONE_NAME")], 
				OPFL_Client_ReDeployZone, 
				[_x], 
				10, 
				true, 
				false, 
				"", 
				format ["(player == vehicle player) && (((getPosASL _target) distance (((OPFL_FLAG_ZONE_LIST select %1) getVariable 'FLAG_ZONE_STATE') select 2)) <= 11) && ((OPFL_FLAG_ZONE_LIST select %1) getVariable 'FLAG_ZONE_PLANTED')", _forEachIndex]];
		_actions set [(count _actions), _index];
	}
	else
	{
		//undeploy
		_index = _person addAction [format ["Undeploy %1", (_x getVariable "FLAG_ZONE_NAME")], 
				OPFL_Client_PickUpZone, 
				[_x], 
				10, 
				true, 
				false, 
				"", 
				format ["(player == vehicle player) && (((getPosASL _target) distance (((OPFL_FLAG_ZONE_LIST select %1) getVariable 'FLAG_ZONE_STATE') select 2)) <= 11) && ((OPFL_FLAG_ZONE_LIST select %1) getVariable 'FLAG_ZONE_PLANTED')", _forEachIndex]];
		_actions set [(count _actions), _index];
	};
};
} foreach OPFL_FLAG_ZONE_LIST;

OPFL_PLAYER_PACKED_ZONE set [1, _actions];