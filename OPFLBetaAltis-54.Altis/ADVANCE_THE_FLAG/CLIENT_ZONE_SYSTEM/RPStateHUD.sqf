private ["_idList", "_textList", "_return"];
_idList = 23510;

if (OPFL_RP_READY) then
{
	_textList = "RP READY";
	OPFL_RP_ANIM = 0;
}
else
{
	if (OPFL_RP_ANIM == 0) then
	{		  
		_textList = "CHARGING";
		OPFL_RP_ANIM = diag_tickTime + 2;
	}
	else
	{
		if (diag_tickTime > OPFL_RP_ANIM) then
		{
			OPFL_RP_ANIM = 0;
			_textList = "CHARGING";
		}
		else
		{
			if (diag_tickTime > (OPFL_RP_ANIM - 0.5)) then
			{
				_textList = "CHARGING...";
			}
			else
			{
				if (diag_tickTime > (OPFL_RP_ANIM - 1)) then
				{
					_textList = "CHARGING..";
				}
				else
				{
					if (diag_tickTime > (OPFL_RP_ANIM - 3/2)) then
					{
						_textList = "CHARGING.";
					}
					else
					{
						_textList = "CHARGING";
					};
				};
			};
		};
	};
};

if 	(
	(([(OPFL_F_FLAG getVariable "FLAG_ZONE_STATE") select 2, getPosASL player] call GSC_2dDistance) <= 
	([OPFL_REDEPLOY_RADIUS, OPFL_DESTROYED_RADIUS] select ((OPFL_F_FLAG getVariable "FLAG_ZONE_STATE") select 3)))
	) then
{
	(_UI_HUD displayCtrl _idList) ctrlSetTextColor [1,1,0,1];
}
else
{
	(_UI_HUD displayCtrl _idList) ctrlSetTextColor [0.5,0.5,0.5,0.9];
};
		 
_return = [_idList, _textList];
_return;