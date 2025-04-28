ctrlSetFocus ((_this select 0) displayCtrl 1013);
uiNamespace setVariable ["PCS_RNK_NOESC", (_this select 0) displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"]];
uiNamespace setVariable ["PCS_RNK_GUI_DISPLAY", _this select 0];
uiNamespace setVariable ["PCS_RNK_GUI_LDTIME", diag_tickTime];
_null = [] spawn {playMusic "IntroMusic";};

uiNamespace setVariable ["PCS_RNK_GUI_THREAD", addMissionEventHandler ["EachFrame", 
{
	if ((diag_tickTime - (uiNamespace getVariable "PCS_RNK_GUI_LDTIME")) < PCS_RNK_RULES_TIMEOUT) then
	{
		((uiNamespace getVariable "PCS_RNK_GUI_DISPLAY") displayCtrl 1005) ctrlSetText ([floor (PCS_RNK_RULES_TIMEOUT - (diag_tickTime - (uiNamespace getVariable "PCS_RNK_GUI_LDTIME")))] call GSC_FormatTime);
	}
	else
	{
		if (!isNil "PCS_UNIQUE") then
		{
			[PCS_UNIQUE, "PCS_RNK_Decline", PCS_S_SERVER, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
			closeDialog 0;
		};
	};
}]];