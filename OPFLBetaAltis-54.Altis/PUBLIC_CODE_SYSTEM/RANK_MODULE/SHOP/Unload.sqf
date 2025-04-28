removeMissionEventHandler ["Draw3D", uiNamespace getVariable "PCS_SHOP_GUI_THREAD"];
deleteVehicle (uiNamespace getVariable "PCS_SHOP_GUI_ROTATOR");
uiNamespace setVariable ["PCS_SHOP_GUI_DISPLAY", nil];
uiNamespace setVariable ["PCS_SHOP_GUI_MODEL", nil];
uiNamespace setVariable ["PCS_SHOP_MODEL_CLASS", nil];
uiNamespace setVariable ["PCS_SHOP_GUI_ROTATOR", nil];
uiNamespace setVariable ["PCS_SHOP_GUI_THREAD", nil];
/*
{
	uiNamespace setVariable [format ["PCS_SHOP_%1", _x select 0], nil];
} foreach (uiNamespace getVariable "PCS_SHOP_CATEGORY_LIST");
*/

{
	uiNamespace setVariable [format ["PCS_SHOP_%1", _x select 0], nil];
} foreach (uiNamespace getVariable format["PCS_SHOP_VEHICLES_LIST_%1", uiNamespace getVariable "PCS_SHOP_SC"]);
uiNamespace setVariable ["PCS_SHOP_SC", nil];