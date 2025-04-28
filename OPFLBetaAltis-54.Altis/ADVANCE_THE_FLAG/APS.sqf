_this allowDamage false;
_this enableSimulation false;
_this spawn
{
		private ["_obj", "_menu"];
		_obj = _this;
	if (!isNil "RTMS_INITIALIZED") then
	{
		_menu = call OPFL_ParachuteSpawn_Object;
		_menu set [0, _obj];
		_menu = _menu call RTMS_CreateMenuObject;
		[_menu, true] call RTMS_SendRequest;
	};

	_menu = _obj addAction [
							"<img image='a3\ui_f\data\Map\VehicleIcons\pictureParachute_ca.paa'/> <t color='#FF0000'> PARACHUTE TO LOCATION</t>",
							{[[], "OPFL_ParachuteSpawn"] call PCS_SpawnAtomic;},
							[],
							6,
							true,
							true,
							"",
							"(player == vehicle player)",
							4,
							false
						];
};