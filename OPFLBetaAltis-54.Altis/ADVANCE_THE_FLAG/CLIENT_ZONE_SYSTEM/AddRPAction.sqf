OPFL_RP_ACTION = [
	player addAction ["<img image='a3\ui_f\data\IGUI\Cfg\simpleTasks\types\interact_ca.paa'/> <t color='#FFFF00'> DEPLOY RP</t>", 
				{[[], "OPFL_Client_AttemptDeployRP"] call PCS_SpawnAtomic;}, 
				[], 
				100, 
				false, 
				true, 
				"", 
				"!PCS_IN_VEHICLE"],
	
	player
];