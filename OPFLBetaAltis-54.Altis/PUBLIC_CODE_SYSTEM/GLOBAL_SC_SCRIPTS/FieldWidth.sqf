private "_dFromCenter";
private "_radialWidth";
private "_height";
private "_width";

_dFromCenter = _this select 0;
_radialWidth = 0;
_height = (getMarkerSize "BATTLE_FIELD_AREA") select 1;
_width = (getMarkerSize "BATTLE_FIELD_AREA") select 0;
if (OPFL_BATTLE_FIELD_SHAPE == "ELLIPSE") then
{
	_radialWidth = (_width * _width) * (1 - ((_dFromCenter * _dFromCenter) / (_height * _height)));
	if (_radialWidth > 0) then
	{
		_radialWidth = sqrt(_radialWidth);
	}
	else
	{
		_radialWidth = 0;
	};
}
else
{
	if (_dFromCenter < _height) then
	{
		_radialWidth = _width;
	}
	else
	{
		_radialWidth = 0;
	};
};

_radialWidth;