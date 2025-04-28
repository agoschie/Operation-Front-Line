private ["_display", "_indices", "_pictureBoxA", "_pictureBoxB", "_primDescrip", "_scopeDescrip"];
_display = uiNamespace getVariable "PKS_GUI_DISPLAY";
_pictureBoxA = (_display displayCtrl 1023);
_pictureBoxB = (_display displayCtrl 1027);
_primDescrip = (_display displayCtrl 1022);
_scopeDescrip = (_display displayCtrl 1031);

_indices = [] + (PLAYER_KIT call PKS_GetKitIndices);
_pictureBoxA ctrlSetText getText ( configFile >> "CfgWeapons" >> (((PLAYER_KIT call PKS_GetKitData) select 7) select (_indices select 0) select 0) >> "picture" );
_primDescrip ctrlSetText getText ( configFile >> "CfgWeapons" >> (((PLAYER_KIT call PKS_GetKitData) select 7) select (_indices select 0) select 0) >> "displayName" );
private ["_scopeClass"];
_scopeClass = (((PLAYER_KIT call PKS_GetKitData) select 8) select (_indices select 1));
if (_scopeClass == "") then
{
	_pictureBoxB ctrlSetText "";
	_scopeDescrip ctrlSetText "Iron Sights? You crazy...";
}
else
{
	_pictureBoxB ctrlSetText getText ( configFile >> "CfgWeapons" >> _scopeClass >> "picture" );
	_scopeDescrip ctrlSetText getText ( configFile >> "CfgWeapons" >> _scopeClass >> "displayName" );
};

[(_indices select 0), (_indices select 2), _display, 1018] call PKS_UpdateButtonIndices;
[(_indices select 1), (_indices select 3), _display, 1020] call PKS_UpdateButtonIndices;