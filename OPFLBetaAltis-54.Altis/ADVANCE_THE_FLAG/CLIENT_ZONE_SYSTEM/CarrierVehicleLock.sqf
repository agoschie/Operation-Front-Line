//private "_inVeh";

if (PCS_IN_VEHICLE) then
{
	if ([player] call GSC_IsCarrier) then
	{
		//player leaveVehicle vehicle player;
		moveOut player;
		//if (isNil "_inVeh") then
		//{
		//	_inVeh = vehicle player;
		//	doGetOut player;
		//		
		//};
		//if (_inVeh != vehicle player) then
		//{
		//	_inVeh = nil;
		//};
	};
};