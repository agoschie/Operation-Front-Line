private ["_index", "_endIndex", "_display", "_control"];
_index = _this select 0;
_endIndex = _this select 1;
_display = _this select 2;
_control = _this select 3;

if (_index < 1) then
{
	(_display displayCtrl _control) ctrlEnable false;
}
else
{
	(_display displayCtrl _control) ctrlEnable true;
};
if (_index < _endIndex) then
{
	(_display displayCtrl (_control + 1)) ctrlEnable true;
}
else
{
	(_display displayCtrl (_control + 1)) ctrlEnable false;
};