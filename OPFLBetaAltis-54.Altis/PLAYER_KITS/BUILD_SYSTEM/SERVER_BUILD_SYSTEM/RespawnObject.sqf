(_this select 0) setVariable ["VEHICLE_IS_RESPAWNING", true];
private "_vehicle";
private "_marker";
private "_rsType";
_vehicle = _this select 0;
_marker = _this select 1;
_rsType = _this select 2;
		
if (!isNull _vehicle) then
{
	_init = _vehicle getVariable "PKS_UNIT_INIT";
	_type = typeOf _vehicle;
	deleteVehicle _vehicle;
	_objData = [_type, (getMarkerPos _marker), (markerDir _marker), _init];
	if (_rsType == "AT_POS") then
	{
		_null = [_objData] spawn PKS_ServerBS_BuildObject;
	};
	if (_rsType == "AROUND") then
	{
		_null = [_objData, true] spawn PKS_ServerBS_BuildObject;
	};
};