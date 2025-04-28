private ["_magazines", "_weapons", "_kitName", "_kitTag", "_return", "_limit", "_buildings", "_special", "_description", "_altPrimary", "_altScope"];
_kitTag = "Default";
_kitName = "WestDefaultKit";
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
	["arifle_MX_F", "30Rnd_65x39_caseless_mag_Tracer", 8]
];

_altScope = [
	""
];

_description = "This is a west default kit.";

_return = [_kitTag, _magazines, _weapons, _buildings, _special, _limit, _kitName, _description, _altPrimary, _altScope];
_return;