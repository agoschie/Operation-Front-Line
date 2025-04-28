_null = ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["Draw", 
" 
 {
	(_this select 0) drawIcon [ 
	getText (configFile >> 'CfgMarkers' >> 'mil_arrow2' >> 'icon'), 
	[[0,0,1,1], [0, 1, 0,1]] select (player == _x), 
	visiblePosition _x, 
	10, 
	10, 
	getDirVisual _x, 
	_x call GSC_Name, 
	1, 
	0.02, 
	'TahomaB', 
	'right' 
	];
  } foreach ((allUnits apply {[-1, _x] select (([_x] call GSC_Side) == ([player] call GSC_Side))}) - [-1]);
"];

/**
private "_marker";
private "_wait";
waitUntil {alive player};



_wait = 1;
while {_wait == 1} do
{
	if (alive player) then
	{
		_marker = createMarkerLocal [format["P%1UNIT_POSITION_MARKER", "PLAYER"], getPosASL player];
		_marker setMarkerSizeLocal [0.5, 0.5];
		_marker setMarkerShapeLocal "ICON";
		_marker setMarkerColorLocal "ColorGreen";
		_marker setMarkerTypeLocal "mil_arrow2";
		_marker setMarkerDirLocal (getDir (vehicle player));
		if ((leader player) == player) then
		{
			_marker setMarkerTextLocal format ["%1(LEADER)", (player call GSC_Name)];
		}
		else
		{
			_marker setMarkerTextLocal (player call GSC_Name);
		};
		sleep 0.2;
		deleteMarkerLocal _marker;
	}
	else
	{
		waitUntil {alive player};
	};
};
**/