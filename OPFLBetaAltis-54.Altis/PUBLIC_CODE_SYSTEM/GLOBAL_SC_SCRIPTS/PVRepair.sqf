private "_unit";
_unit = _this select 0;
if (alive _unit) then
{
if((damage _unit) > 0.4) then 
{
	
	_unit setDamage 0.4;
}
else
{
	if ([_unit] call GSC_IsDisabled) then
	{
		_unit setDamage (damage _unit);
		player sideChat format ["%1 damage", (damage _unit)];
	};
};
};