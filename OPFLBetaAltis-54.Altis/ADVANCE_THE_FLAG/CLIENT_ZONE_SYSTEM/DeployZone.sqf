if (!isNil "OPFL_PLAYER_DEPLOY_LOCK") exitWith {};
OPFL_PLAYER_DEPLOY_LOCK = true;

_arguments = _this select 3;
_person = _this select 0;
_flagObject = _arguments select 0;
_bpDistance = OPFL_ZONE_RADIUS + ((getMarkerSize "BATTLE_POSITION_WEST") select 0);
_side = _flagObject getVariable "FLAG_ZONE_SIDE";

_position = [_person, 1, (getDir _person)] call GSC_PolarVector;
if (!([_position, "BATTLE_FIELD_AREA"] call MSO_fnc_inArea)) exitWith {OPFL_PLAYER_DEPLOY_LOCK = nil; hint "CAN NOT DEPLOY OUT OF BATTLE AREA!";};
if ([_position, (_flagObject getVariable "FLAG_ZONE_SIDE")] call GSC_OverEZW) exitWith {OPFL_PLAYER_DEPLOY_LOCK = nil; hint "CAN NOT DEPLOY PAST ENEMY LINE!";};
if ((([_position, getMarkerPos "BATTLE_POSITION_EAST"] call GSC_2dDistance) <= _bpDistance) && (_side == west) && !OPFL_ROUND_MODE) exitWith {OPFL_PLAYER_DEPLOY_LOCK = nil; hint "FLAG ZONE AREA TOO CLOSE TO ENEMY BASE!";};
if ((([_position, getMarkerPos "BATTLE_POSITION_WEST"] call GSC_2dDistance) <= _bpDistance) && (_side == east) && !OPFL_ROUND_MODE) exitWith {OPFL_PLAYER_DEPLOY_LOCK = nil; hint "FLAG ZONE AREA TOO CLOSE TO ENEMY BASE!";};

_null = [[_flagObject, _person, _position, true], "OPFL_Server_DeployMsg", PCS_S_SERVER] spawn PCS_MPCodeBroadcast;

sleep 3;
OPFL_PLAYER_DEPLOY_LOCK = nil;