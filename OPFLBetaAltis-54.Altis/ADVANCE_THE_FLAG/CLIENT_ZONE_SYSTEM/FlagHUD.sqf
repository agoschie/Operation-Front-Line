private "_y";
private "_id";
private "_screenPos";
private "_color";
private "_text";
private "_return";

private "_flag";
private "_carrier";
private "_percent";
private "_state";
private "_visualState";
private "_visPos";
private "_vecUp";

//if (isNil "HUD_ATL_FINDER_LOGIC") then
//{
//	HUD_ATL_FINDER_LOGIC = "Logic" createVehicleLocal [0,0,0]; //no need to recreate every frame, and polling is single threaded
//};

_flag = _this select 0;
_id = _this select 1;
_carrier = _flag getVariable "FLAG_ZONE_CARRIER_UNIT";
_visualState = _flag getVariable "FLAG_ZONE_STATE";
_virtualFlag = _flag getVariable "FLAG_ZONE_VIRTUAL";
_state = _visualState select 0;
_percent = _visualState select 1;
_text = format ["FLAG %1 %2%3", (_flag getVariable "FLAG_ZONE_NAME"), ceil (_percent * 100), "%"];

if (_state == 2) then
{
	if (_percent < 1) then
	{
		_color = [1,0,0,1];
		if (isNil "OPFL_ATTACK") then
		{
			OPFL_ATTACK = diag_tickTime;
			playSound "UnderAttack";
		};
	}
	else
	{
		_color = [0.8,0.8,0.8,0.5];
		if (!isNil "OPFL_ATTACK") then
		{
			if (diag_tickTime > (OPFL_ATTACK + OPFL_ATTACK_TIMER)) then
			{
				OPFL_ATTACK = nil;
			};
		};
	};
}
else
{
	_color = [0,0,1,1];
};

if (isNull _carrier) then
{
	_screenPos = worldToScreen (_virtualFlag modelToWorld [0,0,2]);
}
else
{
	//_screenPos = worldToScreen ((vehicle _carrier) modelToWorld [0,0,2]);
	//_visPos = ASLToATL (visiblePositionASL (vehicle _carrier));
	_visPos = (vehicle _carrier) modelToWorldVisual [0,0,0];
	_vecUp = vectorUp (vehicle _carrier);
	//HUD_ATL_FINDER_LOGIC setPosATL [(_visPos select 0), (_visPos select 1), 5000];
	//_height = 5000 - ((getPos HUD_ATL_FINDER_LOGIC) select 2);
	//_visPos set [2, (_visPos select 2) + _height];
	_screenPos = worldToScreen [(2 * (_vecUp select 0)) + (_visPos select 0), (2 * (_vecUp select 1)) + (_visPos select 1), (2 * (_vecUp select 2)) + (_visPos select 2)];
};
if ((count _screenPos) < 2) then
{
	_screenPos = [0,0];
	_text = "";
};
		 
_return = [_id, _screenPos, _color, _text];
_return;