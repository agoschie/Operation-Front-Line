private "_y";
private "_id";
private "_screenPos";
private "_color";
private "_text";
private "_return";

private "_unit";
private "_friendlyDistance";
private "_vecUp";
private "_visPos";
private "_height";

//if (isNil "HUD_ATL_FINDER_LOGIC") then
//{
//	HUD_ATL_FINDER_LOGIC = "Logic" createVehicleLocal [0,0,0]; //no need to recreate every frame, and polling is single threaded
//};

_unit = cursorTarget;
_friendlyDistance = 500;

_y = 0.03;

_id = 23521;
			
_color = [212/255,175/255,55/255,1];
_screenPos = [0,0];
_text = "";
	
if ((!isNull _unit) && (alive _unit) && ((player distance _unit) < _friendlyDistance) && (playerSide == ([_unit] call GSC_Side)) && (_unit isKindOf "Man")) then
{
	//_screenPos = worldToScreen (_unit modelToWorld [0,0,1.8288]);
	_visPos = ASLToATL (visiblePositionASL _unit);
	_vecUp = vectorUp _unit;
	//HUD_ATL_FINDER_LOGIC setPosATL [(_visPos select 0), (_visPos select 1), 5000];
	//_height = 5000 - ((getPos HUD_ATL_FINDER_LOGIC) select 2);
	//_visPos set [2, (_visPos select 2) + _height];
	_screenPos = worldToScreen [(1.94 * (_vecUp select 0)) + (_visPos select 0), (1.94 * (_vecUp select 1)) + (_visPos select 1), (1.94 * (_vecUp select 2)) + (_visPos select 2)];
	if ((count _screenPos) < 2) then
	{
		_screenPos = [0,0];
	}
	else
	{
		_screenPos set [0, (_screenPos select 0) - (safeZoneW*(1.5/100))];
	};
	//_text = _unit call OPFL_GetRankImage;
	_text = getText (configfile >> "CfgRanks" >> (_unit getVariable ["OPFL_PLAYER_RANK", "0"]) >> "texture");
	if ((name player) == "Error: No unit") then
	{
		_text = "";
	};
};
		 
_return = [_id, _screenPos, _color, _text];
_return;
	