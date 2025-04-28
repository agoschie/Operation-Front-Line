private "_side";
private "_flagObject";
private "_fbp";
_side = _this select 0;
_flagObject = _this select 1;
switch (_side) do
{
	case west:
	{
		[(getPos OPFL_WEST_FOB), _flagObject, OPFL_FOB_RADIUS] call GSC_RandPosAroundObject;
		//_fbp = getPosATL OPFL_WEST_FALL_BACK_OBJ;
		//if (([_side, _fbp] call GSC_ValidFBP)) then
		//{
			//[_fbp, _flagObject, OPFL_FOB_RADIUS] call GSC_RandPosAroundObject;
		//}
		//else
		//{
		//	[(getPos OPFL_WEST_FOB), _flagObject, OPFL_FOB_RADIUS] call GSC_RandPosAroundObject;
		//};
	};
			
	case east:
	{
		[(getPos OPFL_EAST_FOB), _flagObject, OPFL_FOB_RADIUS] call GSC_RandPosAroundObject;
		//_fbp = getPosATL OPFL_EAST_FALL_BACK_OBJ;
		//if (([_side, _fbp] call GSC_ValidFBP)) then
		//{
		//	[_fbp, _flagObject, OPFL_FOB_RADIUS] call GSC_RandPosAroundObject;
		//}
		//else
		//{
		//	[(getPos OPFL_EAST_FOB), _flagObject, OPFL_FOB_RADIUS] call GSC_RandPosAroundObject;
		//};
	};
};

_flagObject setVariable ["FLAG_ZONE_ACTIVATED", false];