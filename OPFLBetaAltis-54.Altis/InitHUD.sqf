disableSerialization;
HUD_DISPLAY_FUNCTIONS_LIST = [];
HUD_STATIC_FUNCTIONS_LIST = [];
//sleep 0.035;

//waitUntil
//{
//	cutRsc ["hud","PLAIN"];
//	//_UI_HUD = uiNamespace getVariable "hud";
//	false
//};


HUD_MAIN_LAYER = ("HUD_MAIN_HUD" call BIS_fnc_rscLayer);
HUD_MAIN_LAYER cutRsc ["hud", "PLAIN"];

["HUD_DRAW_EH", "onEachFrame", {
	call OPFL_Client_ProcessHUDFunctions
}] call BIS_fnc_addStackedEventHandler;
/**
uiNamespace setVariable ["HUD_DRAW_EH", addMissionEventHandler ["Draw3D", {
	if (player == player) then
	{
		HUD_MAIN_LAYER cutRsc ["hud","PLAIN"];
	}
	else
	{
		removeMissionEventHandler ["Draw3D", (uiNamespace getVariable "HUD_DRAW_EH")];
	};
}]];
**/
//[[], {cutRsc ["hud", "PLAIN"];}] call PCS_AddPerFrameEvent;