private "_magazines";
private "_weapons";
private "_kitName";
private "_kitTag";
private "_return";
private "_limit";
private "_buildings";
private "_special";
private "_description";
_kitTag = "Rifleman";
_kitName = "EastRifle";
_limit = 10;

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
	"optic_NVS"
];

_description = "A standard katiba and grenades.";
_return = [_kitTag, _magazines, _weapons, _buildings, _special, _limit, _kitName, _description, _altPrimary, _altScope];
_return;