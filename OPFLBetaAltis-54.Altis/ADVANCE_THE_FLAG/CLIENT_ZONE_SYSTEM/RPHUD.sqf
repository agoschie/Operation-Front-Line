private ["_idList", "_textList", "_return"];
_idList = 23508;
		  
_textList = "a3\ui_f\data\Map\Markers\Military\flag_CA.paa";

if 	(
	(([(OPFL_F_FLAG getVariable "FLAG_ZONE_STATE") select 2, getPosASL player] call GSC_2dDistance) <= 
	([OPFL_REDEPLOY_RADIUS, OPFL_DESTROYED_RADIUS] select ((OPFL_F_FLAG getVariable "FLAG_ZONE_STATE") select 3)))
	) then
{
	(_UI_HUD displayCtrl _idList) ctrlSetTextColor [1,1,0,1];
}
else
{
	(_UI_HUD displayCtrl _idList) ctrlSetTextColor [0.4,0.4,0.4,0.9];
};
		 
_return = [_idList, _textList];
_return;