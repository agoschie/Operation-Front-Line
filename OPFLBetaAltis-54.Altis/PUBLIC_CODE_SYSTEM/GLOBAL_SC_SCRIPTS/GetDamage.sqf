private "_return";
_return = [1, 1];
if (!isNull _this) then
{
	if (alive _this) then
	{
		private "_count";
		_return set [0, 0];
		_count =
		{
			_return set [0, (_return select 0) + _x]; true
		} count ((getAllHitPointsDamage _this) select 2);
		if (_count > 0) then {_return = [(_return select 0) / _count, 1 / _count];};
	};
};

_return;