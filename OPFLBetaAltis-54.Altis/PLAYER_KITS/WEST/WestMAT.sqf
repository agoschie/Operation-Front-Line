private "_magazines";
private "_weapons";
private "_kitName";
private "_kitTag";
private "_return";
private "_limit";
private "_buildings";
private "_special";
private "_description";
_kitTag = "Medium AT";
_kitName = "WestMAT";
_limit = 3;

_magazines = [
	["NLAW_F", 2]
];
_weapons = [
	["B_TacticalPack_rgr", "B"],
	["Binocular", "W"],
	["NVGoggles", "W"],
	["launch_NLAW_F", "W"]
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

_description = "An MX and PCML rocket launcher.\n";
_return = [_kitTag, _magazines, _weapons, _buildings, _special, _limit, _kitName, _description, _altPrimary, _altScope];
_return;