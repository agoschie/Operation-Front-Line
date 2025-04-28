OPFL_AIR_DEPLOYMENT_ACTION = [
	player addAction ["<img image='a3\ui_f\data\IGUI\Cfg\Actions\eject_ca.paa'/> <t color='#FFFF00'> LAUNCH AIR DEPLOYMENT</t>", 
				{
					if (PCS_LAST_AIR_DEPLOYMENT != PCS_SHOP_VEHICLE) then
					{
						PCS_LAST_AIR_DEPLOYMENT = PCS_SHOP_VEHICLE;
						player moveInDriver PCS_SHOP_VEHICLE; 
						PCS_SHOP_VEHICLE setPosATL [(getPosATL PCS_SHOP_VEHICLE) select 0, (getPosATL PCS_SHOP_VEHICLE) select 1, 1000]; 
						PCS_SHOP_VEHICLE engineOn true; 
						PCS_SHOP_VEHICLE setAirplaneThrottle 10;
					};
				}, 
				[], 
				-1, 
				false, 
				true, 
				"", 
				"(PCS_SHOP_VEHICLE isKindOf 'Plane') && (((getCursorObjectParams select 0) == PCS_SHOP_VEHICLE) || (PCS_SHOP_VEHICLE == vehicle player)) && (local PCS_SHOP_VEHICLE)"],
	
	player
];