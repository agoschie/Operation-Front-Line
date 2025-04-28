private ["_weapon", "_cfg", "_return"];

_weapon = _this;
_return = [];
_cfg = configFile >> "CfgWeapons";

if (isClass (_cfg >> _weapon)) then
{
	_cfg = configFile >> "CfgWeapons" >> _weapon;

	if (isClass (_cfg >> "LinkedItems")) then
	{
		_cfg = _cfg >> "LinkedItems";
		if (0 < count _cfg) then
		{
			for "_i" from 0 to ((count _cfg) - 1) do
			{
				if (isClass (_cfg select _i)) then
				{
					_return pushBack getText ((_cfg select _i) >> "item");
				};
			};
		};
	};
};
_return;