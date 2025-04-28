if ([player] call GSC_InSafeZone) exitWith {player sideChat "*** CAN NOT BUILD IN SAFE ZONE ***";};
if ((count PKS_BUILD_ARGUMENTS) < 1) then
{
	PKS_BUILDING_MENU_QUEUE set [(count PKS_BUILDING_MENU_QUEUE), ["", 4, ((_this select 3) select 0)]];
};