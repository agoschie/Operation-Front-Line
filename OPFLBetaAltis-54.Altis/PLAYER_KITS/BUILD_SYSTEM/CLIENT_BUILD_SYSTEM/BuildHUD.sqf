private ["_idList", "_textList", "_return"];
_idList = 23505;
		  
_textList = PKS_BUILD_HUD_TEXT;
if (PKS_PROGRESS_BAR > 0) then
{
	(_UI_HUD displayCtrl _idList) progressSetPosition PKS_PROGRESS_BAR;
	(_UI_HUD displayCtrl _idList) ctrlSetPosition [(safeZoneX + (safeZoneW / 3)), (safeZoneY + (safeZoneH / 3))];
	(_UI_HUD displayCtrl _idList) ctrlCommit 0;
	PKS_PROGRESS_BAR_RESET = false;
}
else
{
	if (!PKS_PROGRESS_BAR_RESET) then
	{
		(_UI_HUD displayCtrl _idList) ctrlSetPosition [safeZoneX - 100, safeZoneY - 100];
		(_UI_HUD displayCtrl _idList) ctrlCommit 0;
		PKS_PROGRESS_BAR_RESET = true;
	};
};
		 
_return = [_idList, _textList];
_return;