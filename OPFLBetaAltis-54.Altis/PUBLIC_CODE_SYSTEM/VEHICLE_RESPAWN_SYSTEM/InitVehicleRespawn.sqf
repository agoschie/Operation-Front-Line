if (isServer) then
{
	VRS_PENDING_CLIENTS = 0;
	VRS_LAST_CLIENT = "";
	VRS_ADDR = "";
	VRS_VEHICLE_RESPAWN_QUEUE = [];
	VRS_BLCK_CURRENT_INDEX = 0;
	VRS_BLCK_SIZE = 5;
	VRS_BLCK_DELAY = 0.25;
	VRS_LAST_TIME = 0; //for sending vehicle list blocks to clients
	VRS_LAST_TIME_CHECK = 0; //for checking vehicle states

	if (isNil "VRS_VEHICLE_LIST") then
	{
		VRS_VEHICLE_COUNT = 0;
		publicVariable "VR_VEHICLE_COUNT";
	}
	else
	{
		VRS_VEHICLE_COUNT = count VRS_VEHICLE_LIST;
		[[], VRS_MainThread] call PCS_AddPerFrameEvent;
	};
};

VRS_INITIALIZED = true;