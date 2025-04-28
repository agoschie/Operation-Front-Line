if (isNil "OPFL_LOCAL_RP_LIST") exitWith {};
private "_person";
_person = _this;

{
	if (!isNull (_x select 0)) then
	{
		if ((_x select 0) == _person) then
		{
			deleteVehicle (_x select 4);
			deleteMarkerLocal (_x select 6);
			OPFL_LOCAL_RP_LIST set [_forEachIndex, -1];
		};
	}
	else
	{
		deleteVehicle (_x select 4);
		deleteMarkerLocal (_x select 6);
		OPFL_LOCAL_RP_LIST set [_forEachIndex, -1];
	};
} foreach OPFL_LOCAL_RP_LIST;

OPFL_LOCAL_RP_LIST = OPFL_LOCAL_RP_LIST - [-1];