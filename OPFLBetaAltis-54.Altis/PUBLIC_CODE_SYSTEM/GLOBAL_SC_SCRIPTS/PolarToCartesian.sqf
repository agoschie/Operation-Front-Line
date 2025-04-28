private "_magnitude";
private "_angA";
private "_angB";
private "_basisX";
private "_basisY";
private "_basisZ";

_basisX = [1,0,0];
_basisY = [0,1,0];
_basisZ = [0,0,1];

//angles are standard and non-inverted (need to convert arma's angles)
_magnitude = _this select 0;
_angA = _this select 1;
_angB = _this select 2;


//allows basis vectors to be whatever you like, but usually should be orthogonal, and of magnitude unit length (could be stretched).
if (!isNil {_this select 3}) then
{
	_basisX = _this select 3;
};
if (!isNil {_this select 4}) then
{
	_basisY = _this select 4;
};
if (!isNil {_this select 5}) then
{
	_basisZ = _this select 5;
};

_return = [
	(_magnitude * sin(_angB) * (_basisZ select 0)) + (_magnitude * cos(_angB) * cos(_angA) * (_basisX select 0)) + (_magnitude * cos(_angB) * sin(_angA) * (_basisY select 0)), 
	(_magnitude * sin(_angB) * (_basisZ select 1)) + (_magnitude * cos(_angB) * cos(_angA) * (_basisX select 1)) + (_magnitude * cos(_angB) * sin(_angA) * (_basisY select 1)), 
	(_magnitude * sin(_angB) * (_basisZ select 2)) + (_magnitude * cos(_angB) * cos(_angA) * (_basisX select 2)) + (_magnitude * cos(_angB) * sin(_angA) * (_basisY select 2))
];

_return;