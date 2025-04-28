private "_display";
private "_listBox";
private "_i";
private "_index";
private "_handle";
private "_currentData";
if (!isNil {uiNamespace getVariable "PKS_GUI_DISPLAY"}) exitWith {};
if (1 > count PKS_AVAILABLE_KITS) exitWith {closeDialog 0};
if (isNil "PKS_INITIALIZED") exitWith {closeDialog 0};
_display = _this select 0;
_listBox = _display displayCtrl 1006;
_i = 0;
_index = 0;
uiNamespace setVariable ["PKS_GUI_DISPLAY", _display];
uiNamespace setVariable ["PKS_GUI_PRIMARY", PKS_PRIMARY_INDEX];
uiNamespace setVariable ["PKS_GUI_SCOPE", PKS_SCOPE_INDEX];

{
	_currentData = _x call PKS_GetKitData;
	_index = _listBox lbAdd (_currentData select 0);
	_listBox lbSetData [_index, _x];
	
	if ((PKS_KIT_TABLE getVariable _x) > 0) then
	{
		_listBox lbSetColor [_index, [0,0.8,0,1]];
	}
	else
	{
		_listBox lbSetColor [_index, [0.8,0,0,1]];
	};
} foreach PKS_AVAILABLE_KITS;

_listBox lbSetCurSel 0;

[player] call PKS_ThreadGUI;
call PKS_UpdateWeaponPictures;