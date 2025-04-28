private "_value";
private "_nearZero";
_value = _this select 0;
_nearZero = 0.0001;
if ((abs _value) < _nearZero) then
{
	_value = 0;
};
_value;