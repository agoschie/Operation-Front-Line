if (!isNil "OPFL_LOCAL_RP_LIST") exitWith {};

OPFL_LOCAL_RP_LIST = [];

if (_this != "") then
{
	private ["_blck", "_data", "_blckCount", "_size"];
	_blck = [];
	_blckCount = 0;
	_data = _this splitString "|";
	
	//convert data string back to array, store in OPFL_LOCAL_RP_LIST
	_size =
	{
		if (_blckCount == 0) then
		{
			_blck pushBack (objectFromNetId _x);
			_blckCount = _blckCount + 1;
		}
		else
		{
			if (_blckCount == 1) then
			{
				_blck pushBack (parseNumber _x);
				_blck PushBack [];
				_blckCount = _blckCount + 1;
			}
			else
			{
				(_blck select 2) pushBack (parseNumber _x);
				if (_blckCount < 4) then
				{
					_blckCount = _blckCount + 1;
				}
				else
				{
					OPFL_LOCAL_RP_LIST pushBack _blck;
					_blck = [];
					_blckCount = 0;
				};
			};
		};
		false
	} count _data;
	
	//if invalid synch data, leave empty
	//else, add side of rp to each block in rp list
	if ((_size % 4) != 0) then
	{
		OPFL_LOCAL_RP_LIST = [];
		diag_log "OPFL: Failed to synch data, invalid string";
	}
	else
	{
		private ["_rank", "_flag", "_menu"];
		{
			if (!isNull (_x select 0)) then
			{
				if (alive (_x select 0)) then
				{
					if ((_x select 0) != player) then
					{
						_x pushBack ([_x select 0] call GSC_Side);
					}
					else
					{
						_x pushBack playerSide;
					};
					_flag = "FlagSmall_F" createVehicleLocal (_x select 2);
					_flag setPosATL (_x select 2);
					_flag allowDamage false;
					_flag enableSimulation false;
					player disableCollisionWith _flag;
					_x pushBack _flag;
					_x pushBack ((_x select 0) call GSC_Name);
					
					if ((_x select 0) != player) then
					{
						_flag addAction ["<img image='a3\ui_f\data\IGUI\Cfg\simpleTasks\types\interact_ca.paa'/> <t color='#FFFF00'> VOTE RP</t>", 
						{[_this, "OPFL_Client_AttemptVote"] call PCS_SpawnAtomic;}, 
						[], 
						101, 
						true, 
						true, 
						"", 
						"(player == vehicle player) && (_target getVariable 'RP_CAN_VOTE')"]
					};
					
					//_menu = (call OPFL_RP_Object) call RTMS_CreateMenuObject;
					//[_menu, true] call RTMS_SendRequest;
					
					_flag setVariable ["RP_PLAYER", _x select 0];
					_flag setVariable ["RP_POS", _x select 2];
					_flag setVariable ["RP_CAN_VOTE", true];
					_flag setVariable ["RP_TIME", diag_tickTime];
					
					_flag = createMarkerLocal [format ["OPFL_RP_MARKER_%1", _x select 5], _x select 2];
					_flag setMarkerShapeLocal "ICON";
					_flag setMarkerTypeLocal "mil_flag";
					//_flag setMarkerTextLocal format ["RP: %1", _x select 5];
					_flag setMarkerTextLocal "";
					_flag setMarkerDirLocal 0;
					_flag setMarkerSizeLocal [0.004 / (ctrlMapScale ((findDisplay 12) displayCtrl 51)), 0.004 / (ctrlMapScale ((findDisplay 12) displayCtrl 51))];
					_flag setMarkerColorLocal "ColorYellow";
					
					_x pushBack _flag;
				};
			};
		} foreach OPFL_LOCAL_RP_LIST;
	};
};

//rp main thread
OPFL_LAST_MAP_ZOOM = 0;
[[],
{
	private ["_remove", "_dist", "_scale"];
	_remove = false;
	_dist = 0;
	if (visibleMap) then
	{
		_size = 0.004 / (ctrlMapScale ((findDisplay 12) displayCtrl 51));
		if (OPFL_LAST_MAP_ZOOM != _size) then
		{
			OPFL_LAST_MAP_ZOOM = _size;
			_null = 
			{
				(_x select 6) setMarkerSizeLocal [_size, _size];
			false
			} count OPFL_LOCAL_RP_LIST;
		};
	};
	
	{
		
		if (!isNull (_x select 0)) then
		{
			if (alive (_x select 0)) then
			{
				_dist = player distance (_x select 4);
				if ((playerSide == (_x select 3)) && (_dist < viewDistance)) then
				{
					if ( (_dist < 200) || ((_x select 1) > 0) ) then
					{
						drawIcon3D 
						[
							"",
							[1,1,1,1],
							ASLToAGL (ATLToASL (_x select 2)),
							0,
							0,
							0,
							format ["%1 : %2/%3", (_x select 5), (_x select 1), OPFL_RP_VOTES_REQ],
							0,
							0.03 * (0.25 + (0.75/(1 + (_dist / 250)))),
							"PuristaMedium",
							"",
							false
						];
					}
					else
					{
						//if (([_x select 4, "VIEW", player] checkVisibility [eyePos player, getPosASL (_x select 4)]) > 0) then
						if (!(terrainIntersectASL [eyePos player, getPosASL (_x select 4)])) then
						{
							drawIcon3D 
							[
								"",
								[1,1,1,1],
								ASLToAGL (ATLToASL (_x select 2)),
								0,
								0,
								0,
								format ["%1 : %2/%3", (_x select 5), (_x select 1), OPFL_RP_VOTES_REQ],
								0,
								0.03 * (0.25 + (0.75/(1 + (_dist / 250)))),
								"PuristaMedium",
								"",
								false
							];
						};
					};
				};
			}
			else
			{
				deleteVehicle (_x select 4);
				deleteMarkerLocal (_x select 6);
				OPFL_LOCAL_RP_LIST set [_forEachIndex, -1];
				_remove = true;
			};
		}
		else
		{
			deleteVehicle (_x select 4);
			deleteMarkerLocal (_x select 6);
			OPFL_LOCAL_RP_LIST set [_forEachIndex, -1];
			_remove = true;
		};
	} foreach OPFL_LOCAL_RP_LIST;
	
	if (_remove) then
	{
		OPFL_LOCAL_RP_LIST = OPFL_LOCAL_RP_LIST - [-1];
	};



}] call PCS_AddPerFrameEvent;