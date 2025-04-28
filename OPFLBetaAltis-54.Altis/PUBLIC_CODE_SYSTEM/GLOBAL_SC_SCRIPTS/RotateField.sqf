private "_return";
private "_rotateDir";
private "_erPosition";
private "_wrPosition";
private "_center";
_rotateDir = markerDir "BP_AXIS_CONNECTOR";
_center = getMarkerPos "BP_AXIS_CONNECTOR";
_erPosition = [];
_wrPosition = [];
_return = [];

_erPosition = [_center, OPFL_BPE_POS, _rotateDir] call MSO_fnc_vectRotate2D;
_wrPosition = [_center, OPFL_BPW_POS, _rotateDir] call MSO_fnc_vectRotate2D;

_return = [_wrPosition, _erPosition];

_return;