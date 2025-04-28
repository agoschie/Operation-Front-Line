if ((VRS_LAST_TIME_CHECK + 1) <= diag_ticktime) then
{
	private "_dead";
	private "_i";
	_i = 0;
	{
		_dead = false;
		if((((_x getVariable "VRS_INIT_POS") distance getPosATL _x) > 10) || ((_x getVariable "VRS_INIT_DMG") < damage _x)) then
		{
			if (((({alive _x} count crew _x) < 1)) && ((_x nearEntities ["Man", (_x getVariable "VRS_NEAR_DIST")]) isEqualTo [])) then
			{

				if ((!alive _x) || ([_x] call GSC_IsDisabled)) then
				{
					if ((_x getVariable "VRS_RS_COUNT") > 0) then
					{
						_x setVariable ["VRS_RS_COUNT", (_x getVariable "VRS_RS_COUNT") - 1];
					}
					else
					{
						_dead = true;
					};
				};
				if((_x getVariable "VRS_AB_COUNT") > 0) then
				{
					_x setVariable ["VRS_AB_COUNT", (_x getVariable "VRS_AB_COUNT") - 1];
				}
				else
				{
					_dead = true;
				};

			}
			else
			{
				_x setVariable ["VRS_AB_COUNT", (_x getVariable "VRS_AB_TIME")];
				_x setVariable ["VRS_RS_COUNT", (_x getVariable "VRS_RS_TIME")];
			};
		};
		if (_dead) then
		{
			[_x, _i] call VRS_RespawnVehicle;
		};
		_i = _i + 1;
	} foreach VRS_VEHICLE_LIST;
	VRS_LAST_TIME_CHECK = diag_ticktime;
};


if ((VRS_PENDING_CLIENTS > 0) || (VRS_BLCK_CURRENT_INDEX > 0)) then
{
	if ((VRS_LAST_TIME + VRS_BLCK_DELAY) <= diag_ticktime) then
	{

		private "_arg";
		private "_i";
		_i = 0;
		
		if (VRS_BLCK_CURRENT_INDEX < 1) then
		{
			VRS_ADDR = [PCS_S_ALL, VRS_LAST_CLIENT] select (VRS_PENDING_CLIENTS == 1);
			if (VRS_PENDING_CLIENTS == 1) then
			{
				VRS_ADDR = VRS_LAST_CLIENT;
				VRS_BLCK_DELAY = 0.02;
			}
			else
			{
				VRS_ADDR = PCS_S_ALL;
				VRS_BLCK_DELAY = 0.25;
			};
			_arg = [0, VRS_VEHICLE_COUNT];
			VRS_PENDING_CLIENTS = 0;
		}
		else
		{
			_arg = [VRS_BLCK_CURRENT_INDEX];
		};

		
		while {((VRS_BLCK_CURRENT_INDEX + _i) < VRS_VEHICLE_COUNT) && (_i < VRS_BLCK_SIZE)} do
		{
		 	_arg set [count _arg, (VRS_VEHICLE_LIST select (VRS_BLCK_CURRENT_INDEX + _i))];
			_i = _i + 1;
		};
		VRS_BLCK_CURRENT_INDEX = VRS_BLCK_CURRENT_INDEX + _i;
		[_arg, "VR_AddVBlck", VRS_ADDR, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;

		if (VRS_BLCK_CURRENT_INDEX >= VRS_VEHICLE_COUNT) then
		{
				VRS_BLCK_CURRENT_INDEX = 0;
		};
		VRS_LAST_TIME = diag_ticktime;
	
	};
};