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
	if (_side == playerSide) then 
	{
		if (isNil {uiNamespace getVariable "OPFL_SPAWN_ICONS"}) then 
		{
			uiNamespace setVariable ["OPFL_SPAWN_ICONS", []];
		}; 
		(uiNamespace getVariable "OPFL_SPAWN_ICONS")  pushBackUnique "OPFL_REARM"; 
		uiNamespace setVariable  ["OPFL_REARM", ["Rearm", _obj modelToWorld [0,0,1]]];
	}; 
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