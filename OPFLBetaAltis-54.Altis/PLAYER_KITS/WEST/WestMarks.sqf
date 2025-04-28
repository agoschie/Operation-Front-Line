_kitTag = "Marksman";
_kitName = "WestMarks";
_limit = 3;

_magazines = [
	["HandGrenade", 3],
	["SmokeShell", 1]
];
_weapons = [
	["Binocular", "W"],
	["NVGoggles", "W"],
	["bipod_01_F_blk", "P"]
];

_buildings = [

];

_special = [
];

_altPrimary = [
	["srifle_DMR_03_F", "20Rnd_762x51_Mag", 8],
	["srifle_EBR_F", "20Rnd_762x51_Mag", 8],
	["srifle_DMR_06_olive_F", "20Rnd_762x51_Mag", 8]
];

_altScope = [
	"",
	"optic_SOS",
	"optic_DMS",
	"optic_AMS",
	"optic_KHS_blk",
	"optic_NVS"
	
];

_description = "An EBR with a scope and\nbasic riflemen necessities.";
_return = [_kitTag, _magazines, _weapons, _buildings, _special, _limit, _kitName, _description, _altPrimary, _altScope];
_return;