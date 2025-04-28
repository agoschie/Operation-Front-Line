private "_magazines";
private "_weapons";
private "_kitName";
private "_kitTag";
private "_return";
private "_limit";
private "_buildings";
private "_special";
private "_description";
_kitTag = "Marksman";
_kitName = "EastMarks";
_limit = 2;

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
	["srifle_DMR_01_F", "10Rnd_762x54_Mag", 8],
	["srifle_DMR_02_F", "10Rnd_338_Mag", 8],
	["srifle_DMR_05_blk_F", "10Rnd_127x54_Mag", 8]
];

_altScope = [
	"",
	"optic_SOS",
	"optic_DMS",
	"optic_AMS",
	"optic_KHS_blk",
	"optic_NVS"
	
];

_description = "A DMR with a DMS scope.";
_return = [_kitTag, _magazines, _weapons, _buildings, _special, _limit, _kitName, _description, _altPrimary, _altScope];
_return;