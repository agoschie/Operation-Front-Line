private ["_side", "_size", "_class", "_temp", "_name", "_type", "_cost", "_stockTime", "_description"];
_side = uiNamespace getVariable "PCS_SHOP_SC";
_class = (((uiNamespace getVariable format["PCS_SHOP_VEHICLES_LIST_%1", _side]) select (_this - 1)) select 0);
_size = (((uiNamespace getVariable format["PCS_SHOP_VEHICLES_LIST_%1", _side]) select (_this - 1)) select 1);
_name = ((uiNamespace getVariable "PCS_SHOP_GUI_DISPLAY") displayCtrl 1200);
_type = ((uiNamespace getVariable "PCS_SHOP_GUI_DISPLAY") displayCtrl 1210);
_cost = ((uiNamespace getVariable "PCS_SHOP_GUI_DISPLAY") displayCtrl 1211);
_stockTime = ((uiNamespace getVariable "PCS_SHOP_GUI_DISPLAY") displayCtrl 1212);
_description = ((uiNamespace getVariable "PCS_SHOP_GUI_DISPLAY") displayCtrl 1213);

uiNamespace setVariable ["PCS_SHOP_MODEL_CLASS", _class];
uiNamespace setVariable ["PCS_SHOP_MODEL_NUM", _this - 1];

(uiNamespace getVariable 'PCS_SHOP_GUI_MODEL') ctrlSetModel (getText (configfile >> 'CfgVehicles' >> _class >> 'model'));
(uiNamespace getVariable 'PCS_SHOP_GUI_MODEL') ctrlSetModelScale _size;

_temp = (ctrlText ((uiNamespace getVariable "PCS_SHOP_GUI_DISPLAY") displayCtrl ((uiNamespace getVariable "PCS_SHOP_CATEGORY_LIST") select (uiNamespace getVariable format ["PCS_SHOP_%1", _class]) select 2))) splitString "/ ";

if ((parseNumber (_temp select 0)) < (parseNumber (_temp select 1))) then
{
	((uiNamespace getVariable "PCS_SHOP_GUI_DISPLAY") displayCtrl 1214) ctrlEnable true;
}
else
{
	((uiNamespace getVariable "PCS_SHOP_GUI_DISPLAY") displayCtrl 1214) ctrlEnable false;
};
_temp = ((uiNamespace getVariable format["PCS_SHOP_VEHICLES_LIST_%1", _side]) select (_this - 1));
_name ctrlSetText (_temp select 6);
_type ctrlSetText format ["TYPE: %1", _temp select 3];
_cost ctrlSetText format ["COST: %1 DTags", _temp select 4];
_stockTime ctrlSetText format ["STOCK TIME: %1", [_temp select 5] call GSC_FormatTime];
_description ctrlSetText format ["DESCRIPTION: %1", _temp select 7];