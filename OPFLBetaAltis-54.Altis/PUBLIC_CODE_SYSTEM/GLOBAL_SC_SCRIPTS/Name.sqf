private "_return";
_return = "";
if (!isNull _this) then
{
	if (alive _this) then
	{
		_return = name _this;
	}
	else
	{
		if (!isNil {_this getVariable "OPFL_UNIT_NAME"}) then
		{
			_return = _this getVariable "OPFL_UNIT_NAME";
		};
	};
};
_return;