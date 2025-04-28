private "_position";
private "_center";
private "_side";
private "_rotateDir";
private "_yPos";
private "_ryPos";
private "_erYPos";
private "_wrYPos";
private "_return";
_position = _this select 0;
_side = _this select 1;
_rotateDir = markerDir "BP_AXIS_CONNECTOR";
_center = getMarkerPos "BP_AXIS_CONNECTOR";
_return = false;

if ("OBJECT" == typeName _position) then
{
	_position = getPosASL _position;
};

_rotatedPositions = call GSC_RotateField;
_yPos = (([_center,_position,_rotateDir] call MSO_fnc_vectRotate2D) select 1);
_erYPos = ((_rotatedPositions select 1) select 1);
_wrYPos = ((_rotatedPositions select 0) select 1);

if (_side == west) then
{
	if (_erYPos > _wrYPos) then
	{
		if (_yPos > _erYPos) then
		{
			_return = true;
		};
	}
	else
	{
		if (_yPos < _erYPos) then
		{
			_return = true;
		};
	};
};
if (_side == east) then
{
	if (_erYPos > _wrYPos) then
	{
		if (_yPos < _wrYPos) then
		{
			_return = true;
		};
	}
	else
	{
		if (_yPos > _wrYPos) then
		{
			_return = true;
		};
	};
};
if (_return) exitWith {_return;};

{
	if ((_side != (_x getVariable "FLAG_ZONE_SIDE")) && (_x getVariable "FLAG_ZONE_PLANTED")) then
	{
		//"BATTLE_POSITION_EAST" setMarkerPosLocal _erPosition;
		//"BATTLE_POSITION_WEST" setMarkerPosLocal _wrPosition;
		_ryPos = (([_center,(getPosASL _x),_rotateDir] call MSO_fnc_vectRotate2D) select 1);
	
		
		if (_side == west) then
		{
			if (_erYPos > _wrYPos) then
			{
				if (_yPos > _ryPos) then
				{
					_return = true;
				};
			}
			else
			{
				if (_yPos < _ryPos) then
				{
					_return = true;
				};
			};
		};
		if (_side == east) then
		{
			if (_erYPos > _wrYPos) then
			{
				if (_yPos < _ryPos) then
				{
					_return = true;
				};
			}
			else
			{
				if (_yPos > _ryPos) then
				{
					_return = true;
				};
			};
		};
	};
	if (_return) exitWith {};
} foreach OPFL_FLAG_ZONE_LIST;

_return;