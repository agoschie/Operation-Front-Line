private "_i";

OPFL_HOT_ZONES = [];

_i = 1;
while {(getMarkerColor (format ["HOT_ZONE_%1", _i])) == "ColorYellow"} do
{
	OPFL_HOT_ZONES = OPFL_HOT_ZONES + [(format ["HOT_ZONE_%1", _i])];
	_i = _i + 1;
};