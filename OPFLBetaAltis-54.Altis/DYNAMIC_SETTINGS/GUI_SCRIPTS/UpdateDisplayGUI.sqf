private "_display";
private "_listBox";
private "_description";
private "_descriptionText";
private "_type";
private "_typeText";
private "_settingValueIndex";
private "_settingRef";
private "_settingValueName";

_display = uiNamespace getVariable "DYNAMIC_SETTINGS_GUI_DISPLAY";
_listBox = _display displayCtrl 1012;
_description =_display displayCtrl 1014;
_type = _display displayCtrl 1013;
_settingValueName = _display displayCtrl 1011;

_settingRef = DYNAMIC_SETTINGS_LIST select (lbCurSel _listBox);
_typeText = _settingRef select 1;
_descriptionText = _settingRef select 5;
_settingValueIndex = ((_settingRef select 2) - 1) + (_listBox lbValue (lbCurSel _listBox));

_type ctrlSetText _typeText;
_description ctrlSetText _descriptionText;
_settingValueName ctrlSetText format ["%1", (_settingRef select 3) select _settingValueIndex];