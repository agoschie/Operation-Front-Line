private "_flagPos";
private "_flagState";
private "_flagObject";
private "_flagName";
private "_flagSide";
private "_flagColor";
private "_sizePercent";
private "_zoneMarker";
private "_borderMarker";
private "_lineMarker";
private "_tagMarker";
private "_visualState";
private "_lastFlagState";
private "_lastFlagPos";
private "_lastSizePercent";
private "_isEnemy";
private "_virtualFlag";
private "_isDest";
_flagObject = _this select 0;
_visualState = _flagObject getVariable "FLAG_ZONE_STATE";
_flagState = _visualState select 0;
_sizePercent = _visualState select 1;
_flagPos = _visualState select 2;
_isDest = _visualState select 3;
_flagName = _flagObject getVariable "FLAG_ZONE_NAME";
_flagSide = _flagObject getVariable "FLAG_ZONE_SIDE";
_virtualFlag = _flagObject getVariable "FLAG_ZONE_VIRTUAL";

switch (_flagSide) do
{
	case west:
	{
		_flagColor = "ColorBlue";
	};
	
	case east:
	{
		_flagColor = "ColorRed";
	};
};

_isEnemy = OPFL_HIDDEN_ZONES && (playerSide != _flagSide);

if (_flagState == 2) then
{
	if (_isEnemy) then
	{
		[_flagPos, _sizePercent, _flagName, _flagColor, _flagObject] call OPFL_Client_CreateFlagMarkersEnemy;
	}
	else
	{
		[_flagPos, _sizePercent, _flagName, _flagColor, _flagObject] call OPFL_Client_CreateFlagMarkers;
	};
	
	if (playerSide == _flagSide) then
	{
		if (_isDest) then
		{
			"OPFL_RP_BORDER_MARKER" setMarkerSizeLocal [OPFL_DESTROYED_RADIUS, OPFL_DESTROYED_RADIUS];
		}
		else
		{
			"OPFL_RP_BORDER_MARKER" setMarkerSizeLocal [OPFL_REDEPLOY_RADIUS, OPFL_REDEPLOY_RADIUS];
		};
	};
	_virtualFlag setPosASL _flagPos;
	//_virtualFlag setVariable ["OPFL_VF_POS", _flagPos];
	_lastFlagPos = _flagPos;
	_lastSizePercent = _sizePercent;
}
else
{
	_virtualFlag hideObject true;
};
_lastFlagState = _flagState;
while {true} do
{
	//ignore the boolean algebra here, its for non-equal visual state
	waitUntil 
	{
		_visualState = _flagObject getVariable "FLAG_ZONE_STATE"; 
		(_flagState != (_visualState select 0))  || (_sizePercent != (_visualState select 1)) || !([(_visualState select 2), _flagPos] call GSC_EqualPosArrays) || !(_isDest isEqualTo (_visualState select 3))
	};
	_visualState = _flagObject getVariable "FLAG_ZONE_STATE";
	_flagState = _visualState select 0;
	_sizePercent = _visualState select 1;
	_flagPos = _visualState select 2;
	_isDest = _visualState select 3;
	
	if ((_flagState == 1) && (_lastFlagState == 2)) then
	{
		[_flagObject] call OPFL_Client_DeleteFlagMarkers;
		_virtualFlag hideObject true;
	};
	if ((_flagState == 2) && (_lastFlagState == 1)) then
	{
		if (_isEnemy) then
		{
			[_flagPos, _sizePercent, _flagName, _flagColor, _flagObject] call OPFL_Client_CreateFlagMarkersEnemy;
		}
		else
		{
			[_flagPos, _sizePercent, _flagName, _flagColor, _flagObject] call OPFL_Client_CreateFlagMarkers;
		};
		
		if (playerSide == _flagSide) then
		{
			player say "FMove";
		}
		else
		{
			player say "EMove";
		};
		_virtualFlag hideObject false;
		_virtualFlag setPosASL _flagPos;
		_lastFlagPos = _flagPos;
		_lastSizePercent = _sizePercent;
	};
	if ((_flagState == 2) && (_lastFlagState == 2)) then
	{
		if (!([_lastFlagPos, _flagPos] call GSC_EqualPosArrays)) then
		{
			[_flagObject, _flagPos] call OPFL_Client_UpdateFlagMarkerPos;
			_virtualFlag setPosASL _flagPos;
			_lastFlagPos = _flagPos;
			if (playerSide == _flagSide) then
			{
				player say "FMove";
			}
			else
			{
				player say "EMove";
			};
		};
		if (_lastSizePercent != _sizePercent) then
		{
			if (_isEnemy) then
			{
				[_flagObject, _sizePercent] call OPFL_Client_UpdateFlagMarkerSizeEnemy;
			}
			else
			{
				[_flagObject, _sizePercent] call OPFL_Client_UpdateFlagMarkerSize;
			};
			_lastSizePercent = _sizePercent;
		};
	};
	
	if ((_flagState == 2) && (playerSide == _flagSide)) then
	{
		if (_isDest) then
		{
			"OPFL_RP_BORDER_MARKER" setMarkerSizeLocal [OPFL_DESTROYED_RADIUS, OPFL_DESTROYED_RADIUS];
		}
		else
		{
			"OPFL_RP_BORDER_MARKER" setmarkerSizeLocal [OPFL_REDEPLOY_RADIUS, OPFL_REDEPLOY_RADIUS];
		};
	};
	_lastFlagState = _flagState;
};



