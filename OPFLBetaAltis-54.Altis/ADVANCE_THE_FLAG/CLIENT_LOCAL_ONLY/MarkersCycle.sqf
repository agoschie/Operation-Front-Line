while {true} do
{
	call OPFL_Client_GroupPositionMarkers;
	call OPFL_Client_PositionMarker;
	if (OPFL_ALL_SIDE_MARKERS_ENABLED) then
	{
		call OPFL_Client_AllPositionMarkers;
	};
	sleep 0.25;
};