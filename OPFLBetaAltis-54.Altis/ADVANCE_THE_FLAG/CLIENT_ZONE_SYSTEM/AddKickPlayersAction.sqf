OPFL_KICKPLAYERS_ACTION = [
	player addAction ["<img image='a3\ui_f\data\IGUI\Cfg\Actions\eject_ca.paa'/> <t color='#FFFF00'> Kick Out Players</t>", 
				{[player, PCS_SHOP_VEHICLE] call PCS_SHOP_KickOutPlayers}, 
				[], 
				-1, 
				false, 
				true, 
				"", 
				"(((getCursorObjectParams select 0) == PCS_SHOP_VEHICLE) || (PCS_SHOP_VEHICLE == vehicle player))"], // && (0 < count ((crew PCS_SHOP_VEHICLE) - (units player)))"],
	
	player
];