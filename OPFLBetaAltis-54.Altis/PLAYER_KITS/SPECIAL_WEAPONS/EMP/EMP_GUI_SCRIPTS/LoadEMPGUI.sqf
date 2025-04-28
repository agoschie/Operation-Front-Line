private "_display";
private "_listBox";
private "_satID";
private "_handle";
private "_index";

_display = _this select 0;
_listBox = _display displayCtrl 1006;
_satID = getPlayerUID player;
uiNamespace setVariable ["EMP_GUI_DISPLAY", _display];

if (isNil "EMP_INIT_RAN") then
{
	EMP_INIT_RAN = true;
	missionNamepsace setVariable ["EMP_AVAILABLE_SAT_LIST", [1]];
	missionNamepsace setVariable ["EMP_ARC_TIME", 600]; //seconds, 180 divided by EMP arc time gives rotation rate
	missionNamepsace setVariable ["EMP_TIME_SPACING", 600]; //seconds;
	missionNamepsace setVariable ["EMP_TIME_WINDOW_ANGLE", 15]; //degrees off center of 90 degrees, so if 15, would be 75 to 105 degrees
	missionNamepsace setVariable ["EMP_SAT_SIDE_NAME", format ["%1", playerSide]];
	
};

{
	_index = _listBox lbAdd "BLABLA";
	_listBox lbSetData [_index, "BLABLABLA"];
} foreach [1,2];
_listBox lbSetCurSel 0;

_handle = [] spawn EMP_EMPThreadGUI;
uiNamespace setVariable ["EMP_GUI_THREAD", _handle];
