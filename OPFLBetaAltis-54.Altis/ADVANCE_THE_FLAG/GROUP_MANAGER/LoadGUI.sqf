private "_display";
private "_i";
private "_index";
private "_handle";
private "_currentData";
_display = _this select 0;

_i = 0;
_index = 0;
if (isNil "OPFL_FLAG_ZONE_LIST") exitWith {};
if (isNil "OPFL_IS_LEADER") then
{
	OPFL_IS_LEADER = true;
	[PCS_UNIQUE, "OPFL_GetAllGroups", PCS_S_SERVER, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
};

uiNamespace setVariable ["OPFL_GUI_DISPLAY", _display];
uiNamespace setVariable ["OPFL_GUI_JOING_TIME", diag_tickTime];
uiNamespace setVariable ["OPFL_GUI_OPENG_TIME", diag_tickTime];
uiNamespace setVariable ["OPFL_GUI_CLOSENG_TIME", diag_tickTime];
uiNamespace setVariable ["OPFL_GUI_KICKG_TIME", diag_tickTime];
uiNamespace setVariable ["OPFL_GUI_BOX_SELECTED", [controlNull, -1]];

((uiNamespace getVariable "OPFL_GUI_DISPLAY") displayCtrl 1003) ctrlEnable false;
((uiNamespace getVariable "OPFL_GUI_DISPLAY") displayCtrl 1010) ctrlEnable false;

//_listBox lbSetCurSel 0;
[player] call OPFL_ThreadGUI;