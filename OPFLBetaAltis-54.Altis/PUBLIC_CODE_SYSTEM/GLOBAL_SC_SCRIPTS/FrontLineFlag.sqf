private "_center";
private "_side";
private "_rotateDir";
private "_yPos";
private "_lastYPos";
private "_erYPos";
private "_wrYPos";
private "_return";
_side = _this select 0;
_rotateDir = markerDir "BP_AXIS_CONNECTOR";
_center = getMarkerPos "BP_AXIS_CONNECTOR";
_return = objNull;

_rotatedPositions = call GSC_RotateField;
_erYPos = ((_rotatedPositions select 1) select 1);
_wrYPos = ((_rotatedPositions select 0) select 1);


{
	if ((_side == (_x getVariable "FLAG_ZONE_SIDE")) && (_x getVariable "FLAG_ZONE_PLANTED")) then
	{
		_yPos = (([_center, (getPosASL _x),_rotateDir] call MSO_fnc_vectRotate2D) select 1);
		if (isNil "_lastYPos") exitWith
		{
			_lastYPos = _yPos;
			_return = _x;
		};
		
	
		
		if (_side == west) then
		{
			if (_erYPos > _wrYPos) then
			{
				if (_yPos > _lastYPos) then
				{
					_lastYPos = _yPos;
					_return = _x;
				};
			}
			else
			{
				if (_yPos < _lastYPos) then
				{
					_lastYPos = _yPos;
					_return = _x;
				};
			};
		};
		if (_side == east) then
		{
			if (_erYPos > _wrYPos) then
			{
				if (_yPos < _lastYPos) then
				{
					_lastYPos = _yPos;
					_return = _x;
				};
			}
			else
			{
				if (_yPos > _lastYPos) then
				{
					_lastYPos = _yPos;
					_return = _x;
				};
			};
		};
	};
} foreach OPFL_FLAG_ZONE_LIST;

_return;