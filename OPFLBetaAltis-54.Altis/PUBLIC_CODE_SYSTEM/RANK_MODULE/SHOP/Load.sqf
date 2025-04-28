((_this select 0) displayCtrl 1006) ctrlEnable false;
uiNamespace setVariable ["PCS_SHOP_GUI_DISPLAY", _this select 0];
uiNamespace setVariable ["PCS_SHOP_GUI_MODEL", (_this select 0) displayCtrl 1006];
_rotator = [0] call PCS_SHOP_CreateRotator;
[360, 0, _rotator, 90] call PCS_SHOP_SetRotator;
uiNamespace setVariable ["PCS_SHOP_GUI_ROTATOR", _rotator];
uiNamespace setVariable ["PCS_SHOP_SC", ["W", "E"] select (playerSide == east)];

{
	uiNamespace setVariable [format ["PCS_SHOP_%1", _x select 0], _x select 2];
} foreach (uiNamespace getVariable format["PCS_SHOP_VEHICLES_LIST_%1", uiNamespace getVariable "PCS_SHOP_SC"]);

/*
{
	_var = format ["PCS_SHOP_%1", _x select 0];
	uiNamespace setVariable [_var, (uiNamespace getVariable format["PCS_SHOP_VEHICLES_LIST_%1", _side]) apply {[-1, _x select 0] ((_x select 2) == _forEachIndex)}];
	uiNamespace setVariable [_var, (uiNamespace getVariable _var) - [-1]];
} foreach (uiNamespace getVariable "PCS_SHOP_CATEGORY_LIST");
*/

1 call PCS_SHOP_View;

uiNamespace setVariable ["PCS_SHOP_GUI_THREAD", addMissionEventHandler ["Draw3D", {

	
	private ["_obj", "_rotator", "_dir", "_tempA", "_tempB"];
	_obj = uiNamespace getVariable "PCS_SHOP_GUI_MODEL";
	_rotator = uiNamespace getVariable "PCS_SHOP_GUI_ROTATOR";
	
	//**************************************************************
	
	_dir = [_rotator] call PCS_SHOP_ProcessRotator;
	
	_obj ctrlSetModelDirAndUp [[cos _dir, sin _dir, 0], [0,0,1]];

	if (_dir == 360) then
	{
		[360, 0, _rotator, 90] call PCS_SHOP_SetRotator;
	};
	
	//*************************************************************
	
	//_temp = vehicles apply {[-1, typeOf _x] select ((uiNamespace getVariable "PCS_SHOP_SC") == (_x getVariable ["PCS_SHOP_SIDE", ""]))}
	{
		((uiNamespace getVariable "PCS_SHOP_GUI_DISPLAY") displayCtrl (_x select 2)) ctrlSetText format ["%1 / %2", 0, _x select 1];
		((uiNamespace getVariable "PCS_SHOP_GUI_DISPLAY") displayCtrl (_x select 2)) ctrlSetTextColor [0,1,0,1];
	} foreach (uiNamespace getVariable "PCS_SHOP_CATEGORY_LIST");
	{
		_tempA = ((uiNamespace getVariable "PCS_SHOP_CATEGORY_LIST") select (uiNamespace getVariable format ["PCS_SHOP_%1", _x]));
		_tempB = (ctrlText ((uiNamespace getVariable "PCS_SHOP_GUI_DISPLAY") displayCtrl (_tempA select 2))) splitString "/ ";
		((uiNamespace getVariable "PCS_SHOP_GUI_DISPLAY") displayCtrl (_tempA select 2)) ctrlSetText format ["%1 / %2", (parseNumber (_tempB select 0)) + 1, _tempB select 1];
		((uiNamespace getVariable "PCS_SHOP_GUI_DISPLAY") displayCtrl (_tempA select 2)) ctrlSetTextColor ([[1, 0, 0, 1], [0, 1, 0, 1]] select (((parseNumber (_tempB select 0)) + 1) < (parseNumber (_tempB select 1))));
	} foreach ((vehicles apply {[-1, typeOf _x] select ((uiNamespace getVariable "PCS_SHOP_SC") == (_x getVariable ["PCS_SHOP_SIDE", ""]))}) - [-1]);

	//*************************************************************
	
	_tempA = (ctrlText ((uiNamespace getVariable "PCS_SHOP_GUI_DISPLAY") displayCtrl ((uiNamespace getVariable "PCS_SHOP_CATEGORY_LIST") select (uiNamespace getVariable format ["PCS_SHOP_%1", uiNamespace getVariable "PCS_SHOP_MODEL_CLASS"]) select 2))) splitString "/ ";

	if ((parseNumber (_tempA select 0)) < (parseNumber (_tempA select 1))) then
	{
		((uiNamespace getVariable "PCS_SHOP_GUI_DISPLAY") displayCtrl 1214) ctrlEnable true;
	}
	else
	{
		((uiNamespace getVariable "PCS_SHOP_GUI_DISPLAY") displayCtrl 1214) ctrlEnable false;
	};
	
	//*************************************************************
}]];