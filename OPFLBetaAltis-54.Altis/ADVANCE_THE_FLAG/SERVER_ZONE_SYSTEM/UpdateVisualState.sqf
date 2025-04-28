private "_flagObject";
private "_captureTime";
private "_supportTime";
private "_state";
private "_percent";
private ["_visualState", "_newVisualState"];
_flagObject = _this select 0;
_captureTime = _flagObject getVariable "FLAG_ZONE_CAPTURED";
_supportTime = _flagObject getvariable "FLAG_ZONE_SUPPORT";
if (_flagObject getVariable "FLAG_ZONE_PLANTED") then
{
	_state = 2;
}
else
{
	_state = 1;
};
if ((_supportTime < _captureTime) && (_supportTime < OPFL_ZONE_DEATH_WARNING_TIME)) then
{
	_percent = _supportTime / OPFL_ZONE_DEATH_TIME;
}
else
{
	_percent = _captureTime / OPFL_ZONE_CAPTURE_TIME;
};

_newVisualState = [_state, _percent, getPosASL _flagObject, _flagObject getVariable "FLAG_ZONE_DESTROYED"];

if (!isNil {_flagObject getVariable "FLAG_ZONE_STATE"}) then
{
	_visualState = _flagObject getVariable "FLAG_ZONE_STATE";
	//if (!(((_visualState select 0) == _state) && ((_visualState select 1) == _percent) && ([(getPosASL _flagObject),(_visualState select 2)] call GSC_EqualPosArrays))) then
	//{
	//	_flagObject setVariable ["FLAG_ZONE_STATE", _newVisualState, true];
	//};
	if (!(_visualState isEqualTo _newVisualState)) then
	{
		_flagObject setVariable ["FLAG_ZONE_STATE", _newVisualState, true];
	};
}
else
{
	_flagObject setVariable ["FLAG_ZONE_STATE", _newVisualState, true];
};