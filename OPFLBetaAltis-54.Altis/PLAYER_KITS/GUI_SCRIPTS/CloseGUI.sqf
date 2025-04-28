removeMissionEventHandler ["EachFrame", (uiNamespace getVariable "PKS_GUI_THREAD")];
uiNamespace setVariable ["PKS_GUI_DISPLAY", nil];
uiNamespace setVariable ["PKS_GUI_THREAD", nil];
uiNamespace setVariable ["PKS_GUI_THREAD_ARG", nil];
uiNamespace setVariable ["PKS_GUI_THREAD_LF", nil];

if (PKS_NEED_REFILL && alive player) then
{
	[player] call PKS_FillKit;
};

PKS_NEED_REFILL = false;