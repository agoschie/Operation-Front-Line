private "_magazines";
private "_weapons";
private "_kitName";
private "_kitTag";
private "_return";
private "_limit";
private "_buildings";
private "_special";
private "_description";
_kitTag = "Grenadier";
_kitName = "EastGrenadier";
_limit = 3;

_magazines = [
	["1Rnd_HE_Grenade_shell", 12],
	["1Rnd_Smoke_Grenade_shell", 6]
	
];
_weapons = [
	["B_TacticalPack_ocamo", "B"],
	["Binocular", "W"],
	["NVGoggles", "W"]
];

_buildings = [

];

_special = [
];

_altPrimary = [
	["arifle_Katiba_GL_F", "30Rnd_65x39_caseless_green_mag_Tracer", 8]
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

_description = "A Katiba with a grenade launcher.";

_return = [_kitTag, _magazines, _weapons, _buildings, _special, _limit, _kitName, _description, _altPrimary, _altScope];
_return;