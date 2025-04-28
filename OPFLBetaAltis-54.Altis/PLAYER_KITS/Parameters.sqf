PKS_ACE_ENABLED = false;
PKS_REJECT_AREAS = ["BATTLE_POSITION_EAST", "BATTLE_POSITION_WEST"]; //must be circles
PKS_REJECT_MSG = "ARMORY: What are you doing soldier? You are not authorized to use this weapon at base!";


//building types
PKS_BUILDING_TYPES = createLocation ["Name", [0,0,0], 0, 0];
{
	PKS_BUILDING_TYPES setVariable [(_x select 1) select 0, _x];
	if (!isDedicated) then
	{
		(_x select (_x pushBack (((_x select 1) select 0) createVehicleLocal [0,0,0]))) hideObject true;
		(_x select 2) allowDamage false;
		(_x select 2) lock true;
		(_x select 2) enableWeaponDisassembly false;
		(_x select 2) setVariable ["PKS_NO_REPAIR", true];
		(_x select 2) enableSimulation false;
	};
	
} foreach [
	["Spike 30 seconds", ["Land_CzechHedgehog_01_F", 30, 0, 2, ""]],
	["Sandbag Fence 30 seconds", ["Land_BagFence_Long_F", 30, 0, 1.5, ""]],
	["HMG 3 minutes", ["B_HMG_01_high_F", 180, 0, 1.5, ""]],
	["GMG 4 minutes", ["B_GMG_01_high_F", 240, 0, 1.5, ""]],
	["HMG Lowered 3 minutes", ["B_HMG_01_F", 180, 0, 1.5, ""]],
	["GMG Lowered 4 minutes", ["B_GMG_01_F", 240, 0, 1.5, ""]],
	["Mortar 5 minutes", ["B_Mortar_01_F", 300, 0, 1.5, ""]],
	["AA 5 minutes", ["B_static_AA_F", 300, 0, 1.5, ""]],
	["AT 5 minutes", ["B_static_AT_F", 300, 0, 1.5, ""]],
	
	["HMG 3 minutes", ["O_HMG_01_high_F", 180, 0, 1.5, ""]],
	["GMG 4 minutes", ["O_GMG_01_high_F", 240, 0, 1.5, ""]],
	["HMG Lowered 3 minutes", ["O_HMG_01_F", 180, 0, 1.5, ""]],
	["GMG Lowered 4 minutes", ["O_GMG_01_F", 240, 0, 1.5, ""]],
	["Mortar 5 minutes", ["O_Mortar_01_F", 300, 0, 1.5, ""]],
	["AA 5 minutes", ["O_static_AA_F", 300, 0, 1.5, ""]],
	["AT 5 minutes", ["O_static_AT_F", 300, 0, 1.5, ""]]
];
