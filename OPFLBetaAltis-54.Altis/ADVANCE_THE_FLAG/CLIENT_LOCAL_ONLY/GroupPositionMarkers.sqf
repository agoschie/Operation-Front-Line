private "_markerList";
private "_marker";
private "_wait";
private "_groupUnits";

_markerList = ['none'];
_marker = "none";
_wait = 1;
while {_wait == 1} do
{
	_markerList = [];
	_index = 0;
	_groupUnits = units (group player);
	{
		if ((player != _x) && (alive _x)) then
		{
			_marker = createMarkerLocal [format["P%1UNIT_POSITION_MARKER", _index], getPosASL _x];
			_marker setMarkerShapeLocal "ICON";
			_marker setMarkerTypeLocal "hd_arrow";
			_marker setMarkerColorLocal "ColorGreen";
			_marker setMarkerSizeLocal [0.3, 0.3];
			_marker setMarkerAlphaLocal 0.5;
			_marker setMarkerDirLocal (getDir (vehicle _x));
			if ((leader _x) == _x) then
			{
				_marker setMarkerTextLocal format ["%1(LEADER)", (_x call GSC_Name)];
			}
			else
			{
				_marker setMarkerTextLocal "";
			};
			_markerList = _markerList + [_marker];
			_index = _index + 1;
		};
	} foreach _groupUnits;
	sleep 1;
	{
		deleteMarkerLocal _x;
	} foreach _markerList;
};