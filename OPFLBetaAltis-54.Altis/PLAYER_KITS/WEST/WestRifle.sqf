_kitTag = "Rifleman";
_kitName = "WestRifle";
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
	["arifle_MX_F", "30Rnd_65x39_caseless_mag_Tracer", 8],
	["arifle_TRG21_F", "30Rnd_556x45_Stanag_Tracer_Green", 8],
	["arifle_Mk20_F", "30Rnd_556x45_Stanag_Tracer_Green", 8]
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

_description = "Standard MX and grenades.";
_return = [_kitTag, _magazines, _weapons, _buildings, _special, _limit, _kitName, _description, _altPrimary, _altScope];
_return;