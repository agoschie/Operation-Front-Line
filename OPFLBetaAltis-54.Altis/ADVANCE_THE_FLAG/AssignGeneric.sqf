private ["_obj", "_locNum"];
_obj = _this select 0;
_locNum = _this select 1;
if (isServer) then 
{
	if (_locNum == paramsArray select 6) then
	{
		_obj enableSimulationGlobal false; 
		_obj allowDamage false;
	}
	else
	{
		_obj spawn 
		{
			sleep (5 / (1 + (random 100))); 
			deleteVehicle _this;
		};
	};
};