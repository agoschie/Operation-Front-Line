private "_pPos";
private "_weapon";
private "_return";

if (isNil "PKS_REFILL_PLAYER") exitWith {};
if (!alive PKS_REFILL_PLAYER) exitWith {};

_pPos = getPosASL PKS_REFILL_PLAYER;


if (!PKS_NEED_REFILL && ((0 < ({if (([_pPos, getMarkerPos _x] call GSC_2dDistance) < ((getMarkerSize _x) select 0)) exitWith {1}; false} count PKS_REJECT_AREAS)))) then
{
	private ["_potential", "_current"];
	_potential = [];
	_potential append PKS_ESSENTIALS;
	_current =  
			(weapons PKS_REFILL_PLAYER) + 
			(magazines PKS_REFILL_PLAYER) + 
			(assignedItems PKS_REFILL_PLAYER) + 
			(items PKS_REFILL_PLAYER);
			//(primaryWeaponItems PKS_REFILL_PLAYER) + 
			//(secondaryWeaponItems PKS_REFILL_PLAYER) +
			//(handgunItems PKS_REFILL_PLAYER);
	{
		_current append (PKS_REFILL_PLAYER weaponAccessories _x)
	} foreach (weapons PKS_REFILL_PLAYER);
	
	//never mind how this looks weird as shit, experimental hacker protection
	(PLAYER_KIT call PKS_GetKitData) call
	{
		{
			_potential pushBackUnique (_x select 0);
		} foreach (_this select 1); //mags
		
		{
			_potential pushBackUnique (_x select 0);
			_potential append ((_x select 0) call PKS_GetPossibleLinkedItems);
		} foreach (_this select 2); //weapons

		_potential append ((_this select 7) select ((PLAYER_KIT call PKS_GetKitIndices) select 0)); //primary weapon
		_potential call BIS_fnc_arrayPop;
		_potential append ((((_this select 7) select ((PLAYER_KIT call PKS_GetKitIndices) select 0)) select 0) call PKS_GetPossibleLinkedItems); //attachments
		_potential pushBackUnique ((_this select 8) select ((PLAYER_KIT call PKS_GetKitIndices) select 1)); //scope
		
	};
	_potential pushBackUnique "";
	_current = _current - _potential;
	
	if (0 < count _current) then
	{
		{
			player sideChat "ARMORY KITS: You are not authorized to use that item at base!";
			diag_log format ["UNAURTHORIZED: %1", _x];
			removeAllItems PKS_REFILL_PLAYER;
			removeAllItemsWithMagazines PKS_REFILL_PLAYER;
			removeAllAssignedItems PKS_REFILL_PLAYER;
			removeAllWeapons PKS_REFILL_PLAYER;
			removeBackpack PKS_REFILL_PLAYER;
		} foreach _current;
	};
		
};