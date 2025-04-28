_kitTag = "Grenadier";
_kitName = "WestGrenadier";
_limit = 3;


_magazines = [
	["3Rnd_HE_Grenade_shell", 4],
	["3Rnd_Smoke_Grenade_shell", 2]
];
_weapons = [
	["B_TacticalPack_rgr", "B"],
	["Binocular", "W"],
	["NVGoggles", "W"]
];

_buildings = [

];

_special = [
];

_altPrimary = [
	["arifle_MX_GL_F", "30Rnd_65x39_caseless_mag_Tracer", 8]
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

_description = "An MX and optics equipped with a grenade launcher.";
_return = [_kitTag, _magazines, _weapons, _buildings, _special, _limit, _kitName, _description, _altPrimary, _altScope];
_return;