private "_vehicle";
private "_startPos";
private "_startDamage";
private "_usedDistance";
private "_return";
		
_vehicle = _this select 0;
_startPos = _this select 1;
_startDamage = _this select 2;
_usedDistance = 5;
_return = false;

if (((_startPos distance _vehicle) > _usedDistance) || ((damage _vehicle) > _startDamage)) then
{
	_return = true;
};

_return;