diag_log "BEGINNING";
private ["_mrk", "_surrogate", "_i"];
_surrogate = format ["BATTLE_POSITION_WEST_%1", paramsArray select 6];
_mrk = createMarkerLocal ["BATTLE_POSITION_WEST", getMarkerPos _surrogate];
_mrk setMarkerShapeLocal "ELLIPSE";
_mrk setMarkerBrushLocal "BDiagonal";
_mrk setMarkerColorLocal "ColorBlue";
_mrk setMarkerAlphaLocal 1;
_mrk setMarkerSizeLocal (getMarkerSize _surrogate);

_surrogate = format ["BATTLE_POSITION_EAST_%1", paramsArray select 6];
_mrk = createMarkerLocal ["BATTLE_POSITION_EAST", getMarkerPos _surrogate];
_mrk setMarkerShapeLocal "ELLIPSE";
_mrk setMarkerBrushLocal "BDiagonal";
_mrk setMarkerColorLocal "ColorRed";
_mrk setMarkerAlphaLocal 1;
_mrk setMarkerSizeLocal (getMarkerSize _surrogate);
diag_log "CLIENT BLOCK DONE";
if (!isServer) exitWith {};
diag_Log "SERVER BEGINNING";
_i = 1;

while {(_i < 5)} do
{
	diag_log "DELETING";
	if (_i != (paramsArray select 6)) then
	{
		//(format ["BATTLE_POSITION_WEST_%1", _i]) setMarkerSizeLocal [0,0];
		//(format ["BATTLE_POSITION_EAST_%1", _i]) setMarkerSizeLocal [0,0];
		GSC_SPAWN_PROTECTED_AREAS = GSC_SPAWN_PROTECTED_AREAS - [format ["BATTLE_POSITION_WEST_%1", _i]];
		GSC_SPAWN_PROTECTED_AREAS = GSC_SPAWN_PROTECTED_AREAS - [format ["BATTLE_POSITION_EAST_%1", _i]];
		deleteMarker (format ["BATTLE_POSITION_WEST_%1", _i]);
		deleteMarker (format ["BATTLE_POSITION_EAST_%1", _i]);
	};
	_i = _i + 1;
};

diag_log "SERVER BLOCK DONE";