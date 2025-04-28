OPFL_UNLOCK_ACTION = [
	player addAction ["<img image='a3\modules_f\data\iconUnlock_ca.paa'/> <t color='#FFFF00'> Unlock Vehicle</t>", 
				{[PCS_SHOP_VEHICLE, "PCS_SHOP_UnlockVehicle", PCS_SHOP_VEHICLE, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;}, 
				[], 
				1000, 
				true, 
				true, 
				"", 
				"((locked PCS_SHOP_VEHICLE) == 2) && (((getCursorObjectParams select 0) == PCS_SHOP_VEHICLE) || (PCS_SHOP_VEHICLE == vehicle player))"],
	
	player
];