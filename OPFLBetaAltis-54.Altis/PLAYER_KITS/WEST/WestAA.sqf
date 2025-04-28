_kitTag = "Anti Air";
_kitName = "WestAA";
_limit = 2;

_magazines = [
	["Titan_AA", 1]
];
_weapons = [
	["B_TacticalPack_rgr", "B"],
	["Binocular", "W"],
	["NVGoggles", "W"],
	["launch_B_Titan_F", "W"]
];

_buildings = [

];

_special = [
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


_description = "This is an American Anti-Aircraft kit.\nThe primary is a MX and the secondary is a Titan AA";

_return = [_kitTag, _magazines, _weapons, _buildings, _special, _limit, _kitName, _description, _altPrimary, _altScope];
_return;