if (!isNull _this) then
{
	if (alive _this) then
	{
		if (local _this) exitWith
		{
			_this lock 2;
		};
		[_this, "PCS_SHOP_LockVehicle", _this, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
	};
};
