private "_position";
private "_center";
private "_side";
private "_rotateDir";
private "_yPos";
private "_ryPos";
private "_erYPos";
private "_wrYPos";
private "_return";
_side = _this select 0;
_position = "none";
if ((count _this) > 1) then
{
	_position = _this select 1;
};
_rotateDir = markerDir "BP_AXIS_CONNECTOR";
_center = getMarkerPos "BP_AXIS_CONNECTOR";
_return = false;

_yLinePos = 0;
_yFBP = 0;

_rotatedPositions = call GSC_RotateField;
_erYPos = ((_rotatedPositions select 1) select 1);
_wrYPos = ((_rotatedPositions select 0) select 1);

switch (_side) do
{
	case west:
	{
		if ((typeName _position) == "STRING") then
		{
			_position = getPosASL OPFL_WEST_FALL_BACK_OBJ;
		};
		_yLinePos = (([_center,OPFL_WEST_FALL_BACK_LINE,_rotateDir] call MSO_fnc_vectRotate2D) select 1);
		_yFBP = (([_center,_position,_rotateDir] call MSO_fnc_vectRotate2D) select 1);
		if (_erYPos > _wrYPos) then
		{
			if (_yLinePos > _yFBP) then
			{
				_return = true;
			};
		}
		else
		{
			if (_yLinePos < _yFBP) then
			{
				_return = true;
			};
		};
		if (([_position, "BATTLE_FIELD_AREA"] call MSO_fnc_inArea) && _return) then
		{
			_return = true;
		}
		else
		{
			_return = false;
		};
	};
	
	case east:
	{
		if ((typeName _position) == "STRING") then
		{
			_position = getPosASL OPFL_EAST_FALL_BACK_OBJ;
		};
		_yLinePos = (([_center,OPFL_EAST_FALL_BACK_LINE,_rotateDir] call MSO_fnc_vectRotate2D) select 1);
		_yFBP = (([_center,_position,_rotateDir] call MSO_fnc_vectRotate2D) select 1);
		if (_erYPos > _wrYPos) then
		{
			if (_yLinePos < _yFBP) then
			{
				_return = true;
			};
		}
		else
		{
			if (_yLinePos > _yFBP) then
			{
				_return = true;
			};
		};
		if (([_position, "BATTLE_FIELD_AREA"] call MSO_fnc_inArea) && _return) then
		{
			_return = true;
		}
		else
		{
			_return = false;
		};
	};
};

_return;