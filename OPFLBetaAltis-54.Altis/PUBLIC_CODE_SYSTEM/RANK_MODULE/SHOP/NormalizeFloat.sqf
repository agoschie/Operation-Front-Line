private "_value";
private "_a";
_value = _this select 0;
//_a = 0;
if (finite _value) then
{
	//_a = value;
	_value = _value / 0.001;
	_value = floor _value;
	_value = _value * 0.001;
}
else
{
	_value = 0;
};
_value;