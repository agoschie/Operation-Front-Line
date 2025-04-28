/***************************************************************************
init.sqf
22 JUL 2019
By Goschie
****************************************************************************/

HUD_fnc_updateMiniMap = {
	_map = _this select 0;
	_map ctrlMapAnimAdd [0, 0.05, player];
	ctrlMapAnimCommit _map;
};

/***************************************************************************
Settings
****************************************************************************/
// Disable saving
enableSaving [false, false];

// Disables sentances for orders
enableSentences false;

// Allow attack commands to be given
player enableAttack false;

// Have to test this
// finishMissionInit true;
/***************************************************************************
End
****************************************************************************/

//call compile preProcessFile "ROTATION_MENU_SYSTEM\InitRotationMenuSystem.sqf";

//call your scripts from SafeSpawn, the Public code systems safe initializer
if (isServer) then
{
	[
		[[], OPFL_InitOPFL, true],
		[[], PKS_InitPlayerKits, false],
		[[], compile preProcessFile "DYNAMIC_SETTINGS\InitDynamicSettingsArma3.sqf", false]
	] call PCS_SafeSpawn;
}
else
{
	call PCS_SecureClientLaunch;
};
