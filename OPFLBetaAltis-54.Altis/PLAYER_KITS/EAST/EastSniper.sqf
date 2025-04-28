private "_magazines";
private "_weapons";
private "_kitName";
private "_kitTag";
private "_return";
private "_limit";
private "_buildings";
private "_special";
private "_description";
_kitTag = "Sniper";
_kitName = "EastSniper";
_limit = 1;

_magazines = [
	["5Rnd_127x108_APDS_Mag", 1],
	["30Rnd_9x21_Mag", 3],
    ["HandGrenade", 3],
	["SmokeShell", 1]
];
_weapons = [
	["B_TacticalPack_ocamo", "B"],
	["Binocular", "W"],
	["NVGoggles", "W"],
	["hgun_Rook40_snds_F", "W"],
	["bipod_01_F_blk", "P"]
];

_buildings = [

];

_special = [
];

_altPrimary = [
	["srifle_GM6_F", "5Rnd_127x108_Mag", 7]
];

_altScope = [
	"",
	"optic_LRPS"
	
];

_description = "The most annoying kit in the game.\nA standard GM6 Lynx sniper rifle.";
_return = [_kitTag, _magazines, _weapons, _buildings, _special, _limit, _kitName, _description, _altPrimary, _altScope];
_return;