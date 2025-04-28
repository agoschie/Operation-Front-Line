private "_kitName";
private "_side";
private "_comDelay";

_kitName = _this select 0;
_comDelay = 5;

_side = playerSide;

while {_kitName == PLAYER_KIT} do
{
	if (_kitName != PLAYER_KIT) exitWith {};
	_markerList = [];
	_index = 0;
	{
		waitUntil {true};
		if ((player != _x) && ((group player) != (group _x)) && (_side == ([_x] call GSC_Side)) && (alive _x)) then
		{
			_marker = createMarkerLocal [format["COMMUNICATOR%1UNIT_POSITION_MARKER", _index], getPosASL _x];
			_marker setMarkerShapeLocal "ICON";
			_marker setMarkerTypeLocal "hd_arrow";
			_marker setMarkerColorLocal "ColorBlue";
			_marker setMarkerSizeLocal [0.3, 0.3];
			_marker setMarkerAlphaLocal [0.5, 0.5];
			_marker setMarkerDirLocal (getDir (vehicle _x));
			_marker setMarkerTextLocal "";
	
			_markerList = _markerList + [_marker];
			_index = _index + 1;
		};
		if (_kitName != PLAYER_KIT) exitWith {};
	} foreach AllUnits;
	
	if (_kitName == PLAYER_KIT) then
	{
		_delay = (diag_tickTime + _comDelay);
		waitUntil {(diag_tickTime > _delay) || (_kitName != PLAYER_KIT)};
	};
	
	{
		deleteMarkerLocal _x;
	} foreach _markerList;
};