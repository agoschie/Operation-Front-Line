private [
	"_return"
];
if ("string" == typeName (_this select 1)) then
{
	_return = [0.5 * vectorMagnitude (((boundingBoxReal (_this select 0)) select 1) vectorDiff ((boundingBoxReal (_this select 0)) select 0)), 10000] select ((_this select 0) == RTMS_PERSONAL_MENU);
}
else
{
	_return = _this select 1;
};

_return;