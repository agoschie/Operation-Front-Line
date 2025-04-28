//PARAMETERS********************

EMP_ARC_TIME = 600; //seconds, 180 divided by EMP arc time gives rotation rate
EMP_TIME_SPACING = 600; //seconds;
EMP_TIME_WINDOW_ANGLE = 15; //degrees off center of 90 degrees, so if 15, would be 75 to 105 degrees
EMP_SAT_NAME_WEST = "NATO";
EMP_SAT_NAME_EAST = "CSAT";
EMP_SAT_ORBIT_DIR = [1,0,0]; //coming from (in this case coming from east horizon)
EMP_SAT_GROUP_SIZE = 1; //how many satellites are grouped together at once

//***********************PARAMETERS

//server/client variables
EMP_AVAILABLE_SAT_LIST = []; //available to connect to (will be same integers for both sides)

if(isServer) then
{
	EMP_SERVER_EMP_QUEUE = [];
	EMP_SAT_GROUPS = [];
	EMP_GROUP_COUNT = 0;

	[] call EMP_CreateSatGroup;
	_null = [] spawn EMP_ServerEMPThread;

};

if(!isDedicated) then
{
};






EMP_INIT_RAN = true;