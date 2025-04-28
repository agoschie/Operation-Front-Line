_kitTag = "Engineer";
_kitName = "EastEngineer";
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
["HMG 3 minutes", "O_HMG_01_high_F"],
["GMG 4 minutes", "O_GMG_01_high_F"],
["HMG Lowered 3 minutes", "O_HMG_01_F"],
["GMG Lowered 4 minutes", "O_GMG_01_F"],
["Mortar 5 minutes", "O_Mortar_01_F"],
["AA 5 minutes", "O_static_AA_F"],
["AT 5 minutes", "O_static_AT_F"]
];

_special = [
PKS_RepairAbility
];

_altPrimary = [
	["arifle_Katiba_F", "30Rnd_65x39_caseless_green_mag_Tracer", 8],
	["arifle_AK12_F", "30Rnd_762x39_Mag_Green_F", 8]
];

_altScope = [
	"",
	"optic_Aco",
	"optic_Holosight",
	"optic_Arco",
	"optic_Hamr",
	"optic_MRCO"
];

_description = "The engineer kit; this kit\nhas the ability to build things\nas well as repair.";
_return = [_kitTag, _magazines, _weapons, _buildings, _special, _limit, _kitName, _description, _altPrimary, _altScope];
_return;