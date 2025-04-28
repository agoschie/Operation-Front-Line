private "_display";
private "_listBox";
private "_saveButton";
private "_index";

_display = _this select 0;
_listBox = _display displayCtrl 1012;
_saveButton = _display displayCtrl 1007;
uiNamespace setVariable ["DYNAMIC_SETTINGS_GUI_DISPLAY", _display];

if (isNil "DYNAMIC_SETTINGS_LIST") exitWith {};
if (isNil "DYNAMIC_SETTINGS_INITIALIZED") exitWith {};

{
	_index = _listBox lbAdd format ["<> %1", (_x select 1)];
	_listBox lbSetValue [_index, 0];
} foreach DYNAMIC_SETTINGS_LIST;

_listBox lbSetCurSel 1;
ctrlSetFocus _listBox;
_saveButton ctrlEnable false;

call DynamicSettings_UpdateDisplayGUI;