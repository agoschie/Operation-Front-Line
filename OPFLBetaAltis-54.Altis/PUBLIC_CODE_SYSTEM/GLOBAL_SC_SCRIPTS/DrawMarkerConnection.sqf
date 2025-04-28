private "_marker";
private "_westBPPos";
private "_eastBPPos";
private "_xDis";
private "_yDis";
private "_dir";
private "_axisPosX";
private "_axisPosY";
private "_fatness";
private "_color";
private "_mName";

_westBPPos = _this select 0;
_eastBPPos = _this select 1;
_fatness = _this select 2;
_color = _this select 3;
_mName = _this select 4;
_xDis = (_westBPPos select 0) - (_eastBPPos select 0);
_yDis = (_westBPPos select 1) - (_eastBPPos select 1);
if (_yDis == 0) then
{
	_dir = 90;
}
else
{
	_dir = atan(_xDis / _yDis);
};
_axisPosX = (_westBPPos select 0) - (_xDis / 2);
_axisPosY = (_westBPPos select 1) - (_yDis / 2);


_marker = createMarkerLocal [_mName, [_axisPosX, _axisPosY]];
_marker setMarkerDirLocal _dir;
_marker setMarkerShapeLocal "RECTANGLE";
_marker setMarkerColorLocal _color;
_marker setMarkerSizeLocal [_fatness,(([_westBPPos, _eastBPPos] call GSC_2dDistance) / 2)];