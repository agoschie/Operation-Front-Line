private "_kitName";
private "_display";
private "_listBox";
private "_UID";
_display = uiNamespace getVariable "PKS_GUI_DISPLAY";
_listBox = _display displayCtrl 1006;
_kitName = _listBox lbData (lbCurSel _listBox);

_UID = getPlayerUID player;

if (PLAYER_KIT == _kitName) exitWith {hint "ALREADY HAVE THIS KIT!";};
if ((PKS_KIT_TABLE getVariable _kitName) < 1) exitWith {hint "OUT OF KIT!";};
[[PCS_UNIQUE, _kitName], "PKS_SetKitMsg", PCS_S_SERVER, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
