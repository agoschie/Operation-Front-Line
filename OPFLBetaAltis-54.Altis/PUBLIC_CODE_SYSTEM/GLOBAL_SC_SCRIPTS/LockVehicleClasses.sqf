private "_vehicleClasses";

_vehicleClasses = _this select 0;

{
	if ((typeOf _x) in _vehicleClasses) then 
	{	 
		_x lock true;
	};
} foreach vehicles;