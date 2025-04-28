private "_wait";
private "_SET_KIT";
private "_DISCONNECT_KIT";

_wait = 1;

//states
_SET_KIT = 1;
_DISCONNECT_KIT = 2;

waitUntil
{
	if ((count PKS_SERVER_KIT_QUEUE) > 0) then
	{	
		call PKS_ServerKitQueue;
	};
	false
};
