OPFL_KICKPLAYERS_ACTION = [
	player addAction ["<img image='a3\ui_f\data\IGUI\Cfg\Actions\eject_ca.paa'/> <t color='#FFFF00'> Kick Out Players</t>", 
				{PCS_SHOP_VEHICLE setVectorUp surfaceNormal getPosASL PCS_SHOP_VEHICLE;}, 
				[], 
				-1, 
				false, 
				true, 
				"", 
				"((getCursorObjectParams select 0) == PCS_SHOP_VEHICLE) && (((surfaceNormal getPosASL PCS_SHOP_VEHICLE) vectorCos (vectorUp _this)) < 0.1)"],
	
	player
];