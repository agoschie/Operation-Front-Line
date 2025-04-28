private "_magazines";
private "_weapons";
private "_kitName";
private "_kitTag";
private "_return";
private "_limit";
private "_buildings";
private "_special";
private "_description";
_kitTag = "Engineer";
_kitName = "WestEngineer";
_limit = 3;

_magazines = [
	["HandGrenade", 3],
	["SmokeShell", 1]
];
_weapons = [
	["Binocular", "W"],
	["NVGoggles", "W"]
];

_buildings = [
["Spike 30 seconds", "Land_CzechHedgehog_01_F"],
["Sandbag Fence 30 seconds", "Land_BagFence_Long_F"],
["HMG 3 minutes", "B_HMG_01_high_F"],
["GMG 4 minutes", "B_GMG_01_high_F"],
["HMG Lowered 3 minutes", "B_HMG_01_F"],
["GMG Lowered 4 minutes", "B_GMG_01_F"],
["Mortar 5 minutes", "B_Mortar_01_F"],
["AA 5 minutes", "B_static_AA_F"],
["AT 5 minutes", "B_static_AT_F"]
];

_special = [
	PKS_RepairAbility
];

_altPrimary = [
	["arifle_MX_F", "30Rnd_65x39_caseless_mag_Tracer", 8],
	["arifle_TRG21_F", "30Rnd_556x45_Stanag_Tracer_Green", 8]
];

_altScope = [
	"",
	"optic_Aco",
	"optic_Holosight",
	"optic_Arco",
	"optic_Hamr",
	"optic_MRCO"
];

_description = "This is an Engineer kit.\nThe primary weapon is a MX.\nThe kit also has the ability to BUILD and REPAIR.";
_return = [_kitTag, _magazines, _weapons, _buildings, _special, _limit, _kitName, _description, _altPrimary, _altScope];
_return;