/*************
[] call bis_fnc_hints;
_wait = 1;
while {_wait == 1} do
{
	waitUntil{UNIVERSAL_MESSAGE != "none"};
	[UNIVERSAL_MESSAGE] spawn 
	{
		private "_message";
		_message = _this select 0;
		[] call BIS_AdvHints_setDefaults;
		BIS_AdvHints_THeader = "PCS Announcements";
		BIS_AdvHints_TInfo = "";
		BIS_AdvHints_TImp = _message;
		BIS_AdvHints_TAction = "";
		BIS_AdvHints_TBinds = "";
		BIS_AdvHints_Text = call BIS_AdvHints_formatText;
		BIS_AdvHints_Duration = 10;
		BIS_AdvHints_HideCode = "hintSilent '';";
		call BIS_AdvHints_showHint;
	};
	UNIVERSAL_MESSAGE = "none";
};
****************/

["UniversalMsgLoop", "onEachFrame",
{	
	if (UNIVERSAL_MESSAGE != "none") then
	{
		hint format ["ATTENTION:\n%1", UNIVERSAL_MESSAGE];
		player sideChat format ["ATTENTION: %1", UNIVERSAL_MESSAGE];
	};
	
	UNIVERSAL_MESSAGE = "none";
}] call BIS_fnc_addStackedEventHandler;
