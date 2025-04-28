(uiNamespace getVariable "PCS_RNK_GUI_DISPLAY") displayRemoveEventHandler ["KeyDown", uiNamespace getVariable "PCS_RNK_NOESC"];
removeMissionEventHandler ["EachFrame", (uiNamespace getVariable "PCS_RNK_GUI_THREAD")];
uiNamespace setVariable ["PCS_RNK_GUI_DISPLAY", nil];
uiNamespace setVariable ["PCS_RNK_NOESC", nil];
uiNamespace setVariable ["PCS_RNK_GUI_LDTIME", nil];
uiNamespace setVariable ["PCS_RNK_GUI_THREAD", nil];