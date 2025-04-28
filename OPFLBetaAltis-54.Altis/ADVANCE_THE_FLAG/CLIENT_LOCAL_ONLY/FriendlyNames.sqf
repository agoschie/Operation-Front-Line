if (OPFL_ACE_ENABLED) exitWith {};
private "_wait";
_wait = 1;
_currentName = "none";
_friendlyDistance = 500;

while {_wait == 1} do
{
	sleep 0.1;
	if ((!isNull cursorTarget) && (alive cursorTarget) && ((player distance cursorTarget) < _friendlyDistance) && (playerSide == ([cursorTarget] call GSC_Side))) then
	{
		if (_currentName != (cursorTarget call GSC_Name)) then
		{
			_currentName = (cursorTarget call GSC_Name);
			((_this select 0) displayCtrl 3) ctrlSetText _currentName;
		};
	}
	else
	{
		if (_currentName != "none") then
		{
			_currentName = "none";
			((_this select 0) displayCtrl 3) ctrlSetText "";
		};
	};
};