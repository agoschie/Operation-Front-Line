_kitTag = "Heavy AT";
_kitName = "EastMAT";
_limit = 3;

_magazines = [
	["Titan_AT", 1]
];
_weapons = [
	["B_FieldPack_ocamo", "B"],
	["Binocular", "W"],
	["NVGoggles", "W"],
	["launch_O_Titan_short_F", "W"]
];

_buildings = [

];

_special = [
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

_description = "A Katiba and a Titan; this\1 Titan round.";
_return = [_kitTag, _magazines, _weapons, _buildings, _special, _limit, _kitName, _description, _altPrimary, _altScope];
_return;