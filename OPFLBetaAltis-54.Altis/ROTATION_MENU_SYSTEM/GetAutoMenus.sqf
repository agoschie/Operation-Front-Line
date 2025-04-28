	private [
	"_class", 
	"_object", 
	"_temp", 
	"_superClasses", 
	"_index", 
	"_gunner", 
	"_driver", 
	"_commander", 
	"_pilot", 
	"_copilot", 
	"_sideGunner", 
	"_passenger", 
	"_backseat", 
	"_found",
	"_frontNumb",
	"_tranportNumb",
	"_gunnerIndex",
	"_distance",
	"_size",
	"_textSize",
	"_color",
	"_font",
	"_condition",
	"_conditionNS",
	"_iconPath",
	"_sideCondition",
	"_cargoCondition",
	"_turrets",
	"_manTurrets",
	"_turretFunc"
	
	];
	_object = _this select 0;
	_object = [_object, RTMS_PERSONAL_SOURCE] select (_object == RTMS_PERSONAL_MENU);
	_color = _this select 1;
	_size = _this select 2;
	_textSize = _this select 3;
	_font = _this select 4;
	_distance = [_this select 5, 100] select (RTMS_PERSONAL_MENU == (_this select 0));
	_iconPath = _this select 7;
	_conditionNS = _this select 8;
	_class = typeOf _object;
	_return = [];
	_temp = [];
	_found = false;
	_frontNumb = getArray (configFile >> "CfgVehicles" >> _class >> "cargoIsCoDriver[]");
	_transportNumb = getNumber (configFile >> "CfgVehicles" >> _class >> "transportSoldier");
	_gunnerIndex = 1;
	_turrets = allTurrets _object;
	_manTurrets = (allTurrets [_object, true]) - _turrets;
	if (_frontNumb isEqualTo []) then
	{
		_frontNumb = 1;
	}
	else
	{
		_frontNumb = {_x} count _frontNumb;
	};
	
	_driver = ["Driver", _color, _size, _textSize, _font, RTMS_GetInDriver, [], _distance, [["Driver"], RTMS_condition], _iconPath, _conditionNS];
	_gunner = ["Gunner", _color, _size, _textSize, _font, RTMS_GetInGunner, [], _distance, [["Gunner"], RTMS_condition], _iconPath, _conditionNS];
	_commander = ["Commander", _color, _size, _textSize, _font, RTMS_GetInCommander, [], _distance, [["Commander"], RTMS_condition], _iconPath, _conditionNS];
	_passenger = ["Passenger", _color, _size, _textSize, _font, RTMS_GetInPassenger, [], _distance, [[_transportNumb], RTMS_cargoCondition], _iconPath, _conditionNS];
	_backseat = ["Back seat", _color, _size, _textSize, _font, RTMS_GetInBackseat, [], _distance, [[_transportNumb], RTMS_cargoCondition], _iconPath, _conditionNS];
	_sideGunner = ["Side Gunner", _color, _size, _textSize, _font, {}, [], _distance, [], _iconPath, _conditionNS];
	
	_turretFunc =
	{
		if (player == vehicle player) then
		{
			player action ["getInTurret", (_this select 0), (_this select 1)];
		}
		else
		{
			//player setPosASL [0,0,1000];
			//player moveInTurret [_this select 0, (_this select 1)];
			if (RTMS_SEAT_DELAY > (diag_tickTime - RTMS_SEAT_TIME)) exitWith {};
			RTMS_SEAT_TIME = diag_tickTime;
			player action ["CancelAction", player];
			player action ["moveToTurret", (_this select 0), (_this select 1)];
		};
	};
	
	if (_class isKindOf "Car") then
	{
		if ("" != getText(configFile >> "CfgVehicles" >> _class >> "driverAction")) then
		{
			_temp append _driver;
			_temp append [[_object, "DRIVER"] call RTMS_GetVehiclePos];
			_return append [_temp];
			_temp = [];
		};
		
		_null = 
		{
			if ((_x isEqualTo [0]) && !((_object magazinesTurret _x) isEqualTo [])) then
			{
				_temp append _gunner;
				//_temp append [[_object, [0]] call RTMS_GetVehiclePos];
				//_return append [_temp];
				//_temp = [];
			}
			else
			{
				if (_x isEqualTo [0,0]) then
				{
					_temp append _commander;
					//_return append [_temp];
					//_temp = [];
				}
				else
				{
					if ((_object magazinesTurret _x) isEqualTo []) then
					{
						_temp append _sideGunner;
						_temp set [0, "Co-Driver"];
						_temp set [5, _turretFunc];
						_temp set [6, [_x]];
						_temp set [8, [(_temp select 6), RTMS_sideCondition]];
						//_return append [_temp];
						//_temp = [];
					}
					else
					{
						_temp append _sideGunner;
						_temp set [0, format ["%1 %2", (_temp select 0), _gunnerIndex]];
						_temp set [5, _turretFunc];
						_temp set [6, [_x]];
						_temp set [8, [(_temp select 6), RTMS_sideCondition]];
						//_return append [_temp];
						//_temp = [];
						_gunnerIndex = _gunnerIndex + 1;
					};
				};
			};
			_temp append [[_object, _x] call RTMS_GetVehiclePos];
			_return append [_temp];
			_temp = [];
		false
		} count _turrets;
		
		if (_transportNumb > _frontNumb) then
		{
			_temp append _backseat;
			_return append [_temp];
			_temp = [];
		};
		if (!_found && (_transportNumb > 0)) then
		{
			_temp append _passenger;
			_return append [_temp];
			_temp = [];
			_found = true;
		};
	};
	
	if (_class isKindOf "Tank") then
	{
		if ("" != getText(configFile >> "CfgVehicles" >> _class >> "driverAction")) then
		{
			_temp append _driver;
			_temp append [[_object, "DRIVER"] call RTMS_GetVehiclePos];
			_return append [_temp];
			_temp = [];
		};
		
		_null = 
		{
			if ((_x isEqualTo [0]) && !((_object magazinesTurret _x) isEqualTo [])) then
			{
				_temp append _gunner;
				//_return append [_temp];
				//_temp = [];
			}
			else
			{
				if (_x isEqualTo [0,0]) then
				{
					_temp append _commander;
					//_return append [_temp];
					//_temp = [];
				}
				else
				{
					if ((_object magazinesTurret _x) isEqualTo []) then
					{
						_temp append _sideGunner;
						
						_temp set [0, "Co-Driver"];
						_temp set [5, _turretFunc];
						_temp set [6, [_x]];
						_temp set [8, [(_temp select 6), RTMS_sideCondition]];
						//_return append [_temp];
						//_temp = [];
					}
					else
					{
						_temp append _sideGunner;
						_temp set [0, format ["%1 %2", (_temp select 0), _gunnerIndex]];
						_temp set [5, _turretFunc];
						_temp set [6, [_x]];
						_temp set [8, [(_temp select 6), RTMS_sideCondition]];
						//_return append [_temp];
						//_temp = [];
						_gunnerIndex = _gunnerIndex + 1;
					};
				};
			};
			_temp append [[_object, _x] call RTMS_GetVehiclePos];
			_return append [_temp];
			_temp = [];
		false
		} count _turrets;
		
		if (_transportNumb > _frontNumb) then
		{
			_temp append _backseat;
			_return append [_temp];
			_temp = [];
		};
		if (!_found && (_transportNumb > 0)) then
		{
			_temp append _passenger;
			_return append [_temp];
			_temp = [];
			_found = true;
		};
	};
	
	if (_class isKindOf "Air") then
	{
		if ("" != getText(configFile >> "CfgVehicles" >> _class >> "driverAction")) then
		{
			_temp append _driver;
			_temp set [0, "Pilot"];
			_temp append [[_object, "DRIVER"] call RTMS_GetVehiclePos];
			_return append [_temp];
			_temp = [];
		};
		
		_null = 
		{
			if ((_x isEqualTo [0]) && !((_object magazinesTurret _x) isEqualTo [])) then
			{
				_temp append _gunner;
				//_return append [_temp];
				//_temp = [];
			}
			else
			{
				if (_x isEqualTo [0,0]) then
				{
					_temp append _commander;
					//_return append [_temp];
					//_temp = [];
				}
				else
				{
					if ((_object magazinesTurret _x) isEqualTo []) then
					{
						_temp append _sideGunner;
						_temp set [0, "Co-Pilot"];
						_temp set [5, _turretFunc];
						_temp set [6, [_x]];
						_temp set [8, [(_temp select 6), RTMS_sideCondition]];
						//_return append [_temp];
						//_temp = [];
					}
					else
					{
						_temp append _sideGunner;
						if (_gunnerIndex == 1) then
						{
							_temp set [0, "Left Door Gunner"];
						}
						else
						{
							if (_gunnerIndex == 2) then
							{
								_temp set [0, "Right Door Gunner"];
							}
							else
							{
								_temp set [0, format ["%1 %2", (_temp select 0), _gunnerIndex]];
							};
						};
						_temp set [5, _turretFunc];
						_temp set [6, [_x]];
						_temp set [8, [(_temp select 6), RTMS_sideCondition]];
						//_return append [_temp];
						//_temp = [];
						_gunnerIndex = _gunnerIndex + 1;
					};
				};
			};
			_temp append [[_object, _x] call RTMS_GetVehiclePos];
			_return append [_temp];
			_temp = [];
		false
		} count _turrets;
		
		if (!_found && (_transportNumb > 0)) then
		{
			_temp append _passenger;
			_return append [_temp];
			_temp = [];
			_found = true;
		};
	};
	
	if (_class isKindOf "StaticWeapon") then
	{
		
		_null = 
		{
			if ((_x isEqualTo [0]) && !((_object magazinesTurret _x) isEqualTo [])) then
			{
				_temp append _gunner;
				//_return append [_temp];
				//_temp = [];
			}
			else
			{
				if (_x isEqualTo [0,0]) then
				{
					_temp append _commander;
					//_return append [_temp];
					//_temp = [];
				}
				else
				{
					if ((_object magazinesTurret _x) isEqualTo []) then
					{
						_temp append _sideGunner;
						_temp set [0, "Spotter"];
						_temp set [5, _turretFunc];
						_temp set [6, [_x]];
						_temp set [8, [(_temp select 6), RTMS_sideCondition]];
						//_return append [_temp];
						//_temp = [];
					}
					else
					{
						_temp append _sideGunner;
						_temp set [0, format ["%1 %2", (_temp select 0), _gunnerIndex]];
						_temp set [5, _turretFunc];
						_temp set [6, [_x]];
						_temp set [8, [(_temp select 6), RTMS_sideCondition]];
						//_return append [_temp];
						//_temp = [];
						_gunnerIndex = _gunnerIndex + 1;
					};
				};
			};
			_temp append [[_object, _x] call RTMS_GetVehiclePos];
			_return append [_temp];
			_temp = [];
		false
		} count _turrets;
		
		if (_transportNumb > _frontNumb) then
		{
			_temp append _backseat;
			_return append [_temp];
			_temp = [];
		};
		if (!_found && (_transportNumb > 0)) then
		{
			_temp append _passenger;
			_return append [_temp];
			_temp = [];
			_found = true;
		};
	};
	
	if (_return isEqualTo []) then
	{
		if ("" != getText(configFile >> "CfgVehicles" >> _class >> "driverAction")) then
		{
			_temp append _driver;
			_temp append [[_object, "DRIVER"] call RTMS_GetVehiclePos];
			_return append [_temp];
			_temp = [];
		};
		
		_null = 
		{
			if ((_x isEqualTo [0]) && !((_object magazinesTurret _x) isEqualTo [])) then
			{
				_temp append _gunner;
				//_return append [_temp];
				//_temp = [];
			}
			else
			{
				if (_x isEqualTo [0,0]) then
				{
					_temp append _commander;
					//_return append [_temp];
					//_temp = [];
				}
				else
				{
					if ((_object magazinesTurret _x) isEqualTo []) then
					{
						_temp append _sideGunner;
						_temp set [0, "Co-Driver"];
						_temp set [5, _turretFunc];
						_temp set [6, [_x]];
						_temp set [8, [(_temp select 6), RTMS_sideCondition]];
						//_return append [_temp];
						//_temp = [];
					}
					else
					{
						_temp append _sideGunner;
						_temp set [0, format ["%1 %2", (_temp select 0), _gunnerIndex]];
						_temp set [5, _turretFunc];
						_temp set [6, [_x]];
						_temp set [8, [(_temp select 6), RTMS_sideCondition]];
						//_return append [_temp];
						//_temp = [];
						_gunnerIndex = _gunnerIndex + 1;
					};
				};
			};
			_temp append [[_object, _x] call RTMS_GetVehiclePos];
			_return append [_temp];
			_temp = [];
		false
		} count _turrets;
		
		if (_transportNumb > _frontNumb) then
		{
			_temp append _backseat;
			_return append [_temp];
			_temp = [];
		};
		if (!_found && (_transportNumb > 0)) then
		{
			_temp append _passenger;
			_return append [_temp];
			_temp = [];
			_found = true;
		};
	};
	
	if (0 < count _manTurrets) then
	{
		_temp append _sideGunner;
		_temp set [0, "Defending Passenger"];
		_temp set [5, RTMS_GetInDefendingPassenger];
		_temp set [6, [_manTurrets]];
		_temp set [8, [_temp select 6, RTMS_manTurretCondition]];
		_temp append [[_object, _manTurrets] call RTMS_GetVehiclePos];
		_return append [_temp];
		_temp = [];
	};
	_return = [["Vehicle Positions", RTMS_DEFAULT_SUB_COLOR, RTMS_DEFAULT_SUB_SIZE, RTMS_DEFAULT_SUB_TEXT_SIZE, "PuristaMedium", RTMS_PushSubMenu, [_return], _distance, [], "A3\ui_f\data\IGUI\Cfg\Cursors\getin_ca.paa", _conditionNS]];
	_return;
	