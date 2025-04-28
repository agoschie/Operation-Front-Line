player sideChat "VR SYSTEM: Please wait for all respawnable vehicles to finish initializing! This may take a while depending on how many are being used....";
waitUntil {!isNil "VRS_VEHICLE_COUNT"};
if (VRS_VEHICLE_COUNT > 1) then
{
	waitUntil {VRS_VEHICLE_COUNT == count VRS_VEHICLE_LIST};
};