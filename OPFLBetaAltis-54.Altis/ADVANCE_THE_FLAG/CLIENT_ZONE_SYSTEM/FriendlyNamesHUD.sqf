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

_id = 23506;
			
_color = [0.55,1,0.55,1];
_screenPos = [0,0];
_text = "";
	
if ((!isNull _unit) && (alive _unit) && ((player distance _unit) < _friendlyDistance) && (playerSide == ([_unit] call GSC_Side)) && (_unit isKindOf "Man")) then
{
	if (OPFL_LAST_TARGET != _unit) then
	{
		if (!isNil {OPFL_LAST_TARGET getVariable "OPFL_IS_GREEN"}) then
		{
			OPFL_FRIEND_BALL hideObject true;
			OPFL_LAST_TARGET setVariable ["OPFL_IS_GREEN", nil];
		};
	};
	
	//_screenPos = worldToScreen (_unit modelToWorld [0,0,1.8288]);
	_visPos = ASLToATL (visiblePositionASL _unit);
	_vecUp = vectorUp _unit;
	//HUD_ATL_FINDER_LOGIC setPosATL [(_visPos select 0), (_visPos select 1), 5000];
	//_height = 5000 - ((getPos HUD_ATL_FINDER_LOGIC) select 2);
	//_visPos set [2, (_visPos select 2) + _height];
	_visPos = [(1.92 * (_vecUp select 0)) + (_visPos select 0), (1.92 * (_vecUp select 1)) + (_visPos select 1), (1.92 * (_vecUp select 2)) + (_visPos select 2)];
	_screenPos = worldToScreen _visPos;
	if ((count _screenPos) < 2) then
	{
		_screenPos = [0,0];
	};
	_text = _unit call GSC_Name;
	if (_text == "Error: No unit") then
	{
		_text = "";
		if (!isNil {_unit getVariable "OPFL_IS_GREEN"}) then
		{
			OPFL_FRIEND_BALL hideObject true;
			_unit setVariable ["OPFL_IS_GREEN", nil];
		};
	}
	else
	{
		if (isNil {_unit getVariable "OPFL_IS_GREEN"}) then
		{
			_unit setVariable ["OPFL_IS_GREEN", true];
			OPFL_FRIEND_BALL setPosATL ASLToATL AGLToASL (_unit modelToWorldVisual (_unit selectionPosition "spine"));
			OPFL_FRIEND_BALL hideObject false;
		}
		else
		{
			OPFL_FRIEND_BALL setPosATL ASLToATL AGLToASL (_unit modelToWorldVisual (_unit selectionPosition "spine"));
		};
	};
	OPFL_LAST_TARGET = _unit;
}
else
{
	if (!isNull OPFL_LAST_TARGET) then
	{
		if (!isNil {OPFL_LAST_TARGET getVariable "OPFL_IS_GREEN"}) then
		{
			OPFL_FRIEND_BALL hideObject true;
			OPFL_LAST_TARGET setVariable ["OPFL_IS_GREEN", nil];
		};
	};
};
		 
_return = [_id, _screenPos, _color, _text];
_return;
	