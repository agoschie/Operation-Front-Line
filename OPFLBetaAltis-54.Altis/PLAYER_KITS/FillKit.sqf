private ["_player", "_magazines", "_weapons", "_buildings", 
"_special", "_kitName", "_primaryWeaponData", "_primaryWeaponScope", "_muzzles", "_script"];

_player = _this select 0;

PKS_REFILL_PLAYER = _player;
if ((count _this) > 1) then
{
	//unload
	if (!isNil "PLAYER_KIT") then
	{
		for "_i" from 0 to (-1 + count ((PLAYER_KIT call PKS_GetKitData) select 4)) do
		{
			[false, _player, PLAYER_KIT] call (((PLAYER_KIT call PKS_GetKitData) select 4) select _i);
		};
	};
	
	PLAYER_KIT = _this select 1;
	
	//load
	for "_i" from 0 to (-1 + count ((PLAYER_KIT call PKS_GetKitData) select 4)) do
	{
		[true, _player, PLAYER_KIT] call (((PLAYER_KIT call PKS_GetKitData) select 4) select _i);
	};
};

_kitStuff = PLAYER_KIT call PKS_GetKitData;
_magazines = _kitStuff select 1;
_weapons = _kitStuff select 2;
_special = _kitStuff select 4;
_kitName = _kitStuff select 6;
_primaryWeaponData = (_kitStuff select 7) select ((PLAYER_KIT call PKS_GetKitIndices) select 0);
_primaryWeaponScope = (_kitStuff select 8) select ((PLAYER_KIT call PKS_GetKitIndices) select 1);

removeAllWeapons _player;
removeAllItems _player;
removeAllItemsWithMagazines _player;
removeAllAssignedItems _player;
removeBackpack _player;

//add essentials
{
	player linkItem _x;
} foreach PKS_ESSENTIALS;

//add primary weapon and magazines, then select it
_player addMagazines [_primaryWeaponData select 1, 1];
_player addWeapon (_primaryWeaponData select 0);
if (1 < count getArray(configFile >> "CfgWeapons" >> (_primaryWeaponData select 0) >> "muzzles")) then
{
	_player selectWeapon ((getArray(configFile >> "cfgWeapons" >> (_primaryWeaponData select 0) >> "muzzles")) select 0);
}
else
{
	_player selectWeapon (_primaryWeaponData select 0);
};
_player addPrimaryWeaponItem _primaryWeaponScope;



{
	private "_case";
	_case = toUpper (_x select 1);
	switch (_case) do
	{
		//backpack
		case "B":
		{
			_player addBackpack (_x select 0);
		};
		
		//weapon
		case "W":
		{
			_player addWeapon (_x select 0);
		};
		
		//item
		case "I":
		{
			_player addItem (_x select 0);
			_player assignItem (_x select 0);
		};
		
		//weapon attachments
		case "P":
		{
			_player addPrimaryWeaponItem (_x select 0);
		};
		
		case "S":
		{
			_player addSecondaryWeaponItem (_x select 0);
		};
		
		case "H":
		{
			_player addHandgunItem (_x select 0);
		};
		
		//error
		default
		{
			diag_log format ["PLAYER KIT SYSTEM: Error, invalid identifier for kit weapon, %1", _kitName];
		};
	};
} foreach ((PLAYER_KIT call PKS_GetKitData) select 2);

if ((_primaryWeaponData select 2) > 1) then
{
	_player addMagazines [_primaryWeaponData select 1, (_primaryWeaponData select 2) - 1];
};

{
	_player addMagazines _x;
} foreach _magazines;


//refresh buildings action menu
[_player, _kitName, _kitStuff select 3] call PKS_ClientBS_BuildingActionMenu;


["PLAYER_KIT_REFILL"] call GSC_PlaySound;

PKS_NEED_REFILL = false;