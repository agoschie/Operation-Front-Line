private ["_obj", "_locNum", "_side"];
_obj = _this select 0;
_locNum = _this select 1;
_side = _this select 2;
if (_locNum == paramsArray select 6) then
{
	if (isServer) then 
	{
		_obj enableSimulationGlobal false; 
		_obj allowDamage false;
	};
	OPFL_EAST_BUNKER = _obj;
}
else
{
	if (isServer) then
	{
		_obj spawn 
		{
			sleep (5 / (1 + (random 100))); 
			deleteVehicle _this;
		};
	};
};