waitUntil {PKS_SYNCHRONIZED};
if (!isDedicated) then
{
	PKS_BUILD_ROOF_FINDER = "Logic" createVehicleLocal [0,0,0];
	PKS_CLIENT_KIT_QUEUE = [];
	PKS_BUILDING_MENU_QUEUE = [];
	PKS_BUILD_ARGUMENTS = [];
	PKS_BUILD_HUD_TEXT = "";
	
	HUD_DISPLAY_FUNCTIONS_LIST set [(count HUD_DISPLAY_FUNCTIONS_LIST), [[], PKS_ClientBS_BuildHUD]];
	_null = [] spawn PKS_ClientBS_BuildTimeClock;
	_null = [] spawn PKS_ClientBS_BuildVisualizer;
	_null = [] spawn PKS_ClientBS_ClientBuildThread;
};