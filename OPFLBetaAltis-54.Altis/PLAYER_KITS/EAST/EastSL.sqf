_kitTag = "Squad leader";
_kitName = "EastSL";
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
];

_special = [
];

_altPrimary = [
	["arifle_Katiba_F", "30Rnd_65x39_caseless_green_mag_Tracer", 8],
	["arifle_AK12_F", "30Rnd_762x39_Mag_Green_F", 8],
	["arifle_AKS_F", "30Rnd_545x39_Mag_Green_F", 8]
];

_altScope = [
	"",
	"optic_Aco",
	"optic_Holosight",
	"optic_Arco",
	"optic_Hamr",
	"optic_MRCO",
	"optic_SOS",
	"optic_DMS",
	"optic_AMS",
	"optic_KHS_blk",
	"optic_NVS"
];

_description = "The best kit to assist\nin leading; this kit allows\nyou to build things and\nsee all player markers.";
_return = [_kitTag, _magazines, _weapons, _buildings, _special, _limit, _kitName, _description, _altPrimary, _altScope];
_return;