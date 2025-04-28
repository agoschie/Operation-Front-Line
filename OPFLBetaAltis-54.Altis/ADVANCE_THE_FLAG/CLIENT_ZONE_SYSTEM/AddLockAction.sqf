OPFL_LOCK_ACTION = [
	player addAction ["<img image='a3\modules_f\data\iconLock_ca.paa'/> <t color='#FFFF00'> Lock Vehicle</t>", 
				{[PCS_SHOP_VEHICLE, "PCS_SHOP_LockVehicle", PCS_SHOP_VEHICLE, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;}, 
				[], 
				-1, 
				false, 
				true, 
				"", 
				"((locked PCS_SHOP_VEHICLE) == 0) && (((getCursorObjectParams select 0) == PCS_SHOP_VEHICLE) || (PCS_SHOP_VEHICLE == vehicle player))"],
	
	player
];