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
	
	if (west == _side) then
	{
		OPFL_WEST_SHOP = _obj;
	};
	
	if (east == _side) then
	{
		OPFL_EAST_SHOP = _obj;
	};
	
	if (_side == playerSide) then 
	{
		_action = _obj addAction ["<img image='a3\ui_f\data\Map\VehicleIcons\iconTank_ca.paa'/> <t color='#FFFF00'> Buy Vehicle</t>", 
		 {createDialog "ShopDialog";},  
		 [],  
		 100,  
		 false,  
		 true,  
		 "",  
		 "(player == vehicle player)"];
		if (isNil {uiNamespace getVariable "OPFL_SPAWN_ICONS"}) then 
		{
			uiNamespace setVariable ["OPFL_SPAWN_ICONS", []];
		};
		(uiNamespace getVariable "OPFL_SPAWN_ICONS")  pushBackUnique "OPFL_LAPTOP"; 
		uiNamespace setVariable  ["OPFL_LAPTOP", ["Buy Vehicles", _obj modelToWorld [0,0,1]]];
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