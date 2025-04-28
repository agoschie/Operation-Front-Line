private ["_id", "_text", "_return"];
_id = 23518;


_text = [OPFL_DEPLOY_READY_TIME - (OPFL_ADVANCE_TIMERS select 1)] call GSC_FormatTime;

if ((OPFL_DEPLOY_READY_TIME - (OPFL_ADVANCE_TIMERS select 1)) < 1) then
{
	(_UI_HUD displayCtrl _id) ctrlSetTextColor [0,1,0,1];
}
else
{
	(_UI_HUD displayCtrl _id) ctrlSetTextColor [1,0.5,0.5,1];
};
		 
_return = [_id, _text];
_return;