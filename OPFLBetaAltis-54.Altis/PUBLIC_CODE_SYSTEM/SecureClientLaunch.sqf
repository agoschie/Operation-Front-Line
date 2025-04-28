private ["_key"];
_key = (8 + floor random 9) call GSC_CreateRandomKey;
_key = _key call GSC_MapKeyToVarName;



(format ["PCS_RK_%1", _key]) addPublicVariableEventHandler
{
	
	if ((_this select 1) call PCS_HardKeyCompileList) then
	{
		with missionNamespace do
		{
			((_this select 1) select 0) call PCS_MPCodeEH;
			((_this select 1) select 1) call PCS_MPCodeEH_Atomic;
			[
			[[], OPFL_InitOPFL, true],
			[[], PKS_InitPlayerKits, false],
			[[], compile preProcessFile "DYNAMIC_SETTINGS\InitDynamicSettingsArma3.sqf", false]
			] call PCS_SafeSpawn;
		};
	}
	else
	{
		//some how instigate a crash
	};
	missionNamespace setVariable [_this select 0, [((8 + floor random 9) call GSC_CreateRandomKey) call GSC_MapKeyToVarName, ((8 + floor random 9) call GSC_CreateRandomKey) call GSC_MapKeyToVarName]];
};

waitUntil {!isNil "PCS_SERVER_INITIALIZED"};
waitUntil {!isNil "PCS_TEMPORARY_ID_ESTABLISHED"};
PCS_UNIQUE = PCS_TEMPORARY_ID_ESTABLISHED select 1;

missionNamespace setVariable ["PCS_KREH_INPUT", [_key, PCS_UNIQUE]];
publicVariableServer "PCS_KREH_INPUT";