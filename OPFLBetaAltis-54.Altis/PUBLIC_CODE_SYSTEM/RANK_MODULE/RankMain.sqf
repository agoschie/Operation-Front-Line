/*
	0 UIDName,
	1 Rank,
	2 Level,
	3 Matches,
	4 Wins,
	5 Losses,
	6 Kills,
	7 Chickens
	8 Left
	9 Year
	10 Month
	11 Day
	12 Hour
	13 Minute
	14 Second
*/

diag_log "RNK MAIN: got indices";

private ["_mainEH"];
PCS_RNK_RECORDS = createLocation ["Name", [0,0,0], 0, 0];
PCS_RNK_SHOP_DATA = createLocation ["Name", [0,0,0], 0, 0];
PCS_RNK_PENDING_RECORDS = [];
PCS_RNK_ACTIVE_RECORDS = [];
PCS_RNK_WEST_RECORDS = [];
PCS_RNK_EAST_RECORDS = [];
PCS_RNK_PUBLISH = [];
PCS_RNK_LAST_TRD = 0;
PCS_RNK_RUNNING = true;
PCS_RNK_T1 = diag_tickTime + 1;
PCS_RNK_T2 = diag_tickTime + 1.5;
PCS_RNK_REAL_GL = 0;
PCS_RNK_BAN_HOURS = 24;
PCS_RNK_DITCH_LIMIT = 5;
PCS_RNK_PIPE = ["", -1];
diag_log "RNK MAIN: declared vars";

{
	PCS_RNK_SHOP_DATA setVariable [format ["SHOP_%1_W", _forEachIndex], 0];
	PCS_RNK_SHOP_DATA setVariable [format ["SHOP_%1_E", _forEachIndex], 0];
} foreach (uiNamespace getVariable "PCS_SHOP_CATEGORY_LIST");

"PCS_RNK_PIPE" addPublicVariableEventHandler
{
	_var = _this select 1;
	_id = _var select 0;
	_index = _var select 1;
	_side = ['W', 'E'] select ((PCS_RNK_RECORDS getVariable format ["%1_SIDE", _id call PCS_IDToUID]) == east);
	_record = format ["%1", _id call PCS_IDToUID];
	
	if ((_id call PCS_IDToUID) != "") then
	{
		diag_log "1";
		if ((isNull (PCS_RNK_SHOP_DATA getVariable [format ["SHOP_E%1_%2", _id call PCS_IDToUID, _side], objNull])) && ((PCS_RNK_SHOP_DATA getVariable format ["SHOP_%1_%2", ((uiNamespace getVariable format["PCS_SHOP_VEHICLES_LIST_%1", _side]) select _index) select 2, _side]) < (((uiNamespace getVariable "PCS_SHOP_CATEGORY_LIST") select (((uiNamespace getVariable format["PCS_SHOP_VEHICLES_LIST_%1", _side]) select _index) select 2)) select 1))) then
		{
			diag_log "2";
			if (((_record call PCS_RNK_GetRecord) select 7) >= (((uiNamespace getVariable format["PCS_SHOP_VEHICLES_LIST_%1", _side]) select _index) select 4)) then
			{
				diag_log "3";
				(_record call PCS_RNK_GetRecord) set [7, ((_record call PCS_RNK_GetRecord) select 7) - (((uiNamespace getVariable format["PCS_SHOP_VEHICLES_LIST_%1", _side]) select _index) select 4)];
				PCS_RNK_SHOP_DATA setVariable [format ["SHOP_%1_%2", ((uiNamespace getVariable format["PCS_SHOP_VEHICLES_LIST_%1", _side]) select _index) select 2, _side], (PCS_RNK_SHOP_DATA getVariable format ["SHOP_%1_%2", ((uiNamespace getVariable format["PCS_SHOP_VEHICLES_LIST_%1", _side]) select _index) select 2, _side]) + 1];
				PCS_RNK_RECORDS setVariable [format ["%1_LPI", _record], PCS_RNK_PUBLISH pushBackUnique [_record, _id]];
				PCS_SHOP_VEHICLE = [_side, _index, _id call PCS_IDToUID] call PCS_SHOP_CreateVehicle;
				PCS_RNK_SHOP_DATA setVariable [format ["SHOP_E%1_%2", _id call PCS_IDToUID, _side], PCS_SHOP_VEHICLE];
				PCS_RNK_STATS = (_record call PCS_RNK_GetRecord) select 7;
				//(_id call PCS_IDToTemp) publicVariableClient "PCS_RNK_STATS";
				(_id call PCS_IDToTemp) publicVariableClient "PCS_SHOP_VEHICLE";
				diag_log "4";
			};
		};
	};
};

//removes from player list, leaves publish events alone, and sets the active record to disconnected
//we leave it alone incase he rejoins the same active mission (like switching sides)
PCS_ON_DISCONNECTED_FNC_LIST set [(count PCS_ON_DISCONNECTED_FNC_LIST), PCS_RNK_RemovePlayer];
diag_log "RNK MAIN: set disconnect EH";
//add player to list, make new record or reuse old active record, make new account if it doesn't exist in database
PCS_ON_CONNECTED_FNC_LIST set [(count PCS_ON_CONNECTED_FNC_LIST), PCS_RNK_AddPlayer];
diag_log "RNK MAIN: set connect EH";
PCS_RNK_RUN_THREAD =
{
	private ["_mainEH"];
	
	PCS_RNK_MAIN_EH = addMissionEventHandler ["EachFrame", {
		private ["_cock", "_record", "_side"];
		_record = "";
		//if (PCS_RNK_RUNNING) then
		//{
			//this can be made more efficient in due time
			{
				_record = format ["%1", _x select 0];
				if (!isNil {PCS_RNK_RECORDS getVariable format ["%1_SIDE", _record]} && !isNil {PCS_RNK_RECORDS getVariable format ["%1_AGREED", _record]}) then
				{
					diag_log "RNK MAIN: waiting for record...";
					_cock = ["opfl", "GetOutput", [(_x select 2) select 1]] call PCS_CallExtension; //request the record, but no guarantee its ready
					if ("STRING" != typeName _cock) then
					{
						private ["_temp", "_banned"];
						_side = ['W', 'E'] select ((PCS_RNK_RECORDS getVariable format ["%1_SIDE", _record]) == east);
						diag_log "RNK MAIN: got something";
						PCS_RNK_PENDING_RECORDS set [_forEachIndex, -1];
						
						if (!isNil "PCS_RNK_STATS") then
						{
							_temp = PCS_RNK_STATS;
						};
						_banned = _cock deleteAt ((count _cock) - 1);
						PCS_RNK_STATS = _cock select [0, 9];
		
						_cock pushBack true;
						_cock pushBack (_x select 2);
						_cock call PCS_RNK_CreateRecord; //merge and activate record
						
						//greater than zero signifies he was participating in the match
						if (((PCS_RNK_RECORDS getVariable _record) select 2) > 0) then
						{
						
							//YOU SIR HAVE BEEN UNPUNISHED FOR REJOINING THE MATCH!!!
							/*
							_record = _record call PCS_RNK_GetRecord;
							
							_record set [8, [0, (_record select 8) - 1] select ((_record select 8) > 0)];
							PCS_RNK_STATS set [8, _record select 8];
					
							_record = format ["%1", _x select 0];
							_null = ["opfl", "PublishAccount", [(_record call PCS_RNK_GetHandle) select 0, _record call PCS_RNK_GetRecord]] call PCS_CallExtension;
							*/
							
							//***
							//this block puts client into game play state
							if (((_x select 0) call PCS_UIDToID) != "") then
							{
								if (!isNull (PCS_RNK_SHOP_DATA getVariable [format ["SHOP_E%1_%2", _x select 0, _side], objNull])) then
								{
									PCS_SHOP_VEHICLE = PCS_RNK_SHOP_DATA getVariable [format ["SHOP_E%1_%2", _x select 0, _side], objNull];
									((_x select 0) call PCS_UIDToTemp) publicVariableClient "PCS_SHOP_VEHICLE";
								};
								
								diag_log "RNK MAIN: sending record...";
								((_x select 0) call PCS_UIDToTemp) publicVariableClient "PCS_RNK_STATS"; //give him his well deserved statistics
							};
							if (!isNil "_temp") then
							{
								PCS_RNK_STATS = _temp; //incase server is also client
							};
							
							if ((PCS_RNK_RECORDS getVariable format ["%1_SIDE", _record]) == west) then
							{
								PCS_RNK_WEST_RECORDS pushBackUnique _record;
							}
							else
							{
								PCS_RNK_EAST_RECORDS pushBackUnique _record;
							};
							//***
						}
						else
						{
							//if ((((_cock select 8) % PCS_RNK_DITCH_LIMIT) == 0) && ((_cock select 8) > 0)) then
							//{
								if (_banned < 1) then
								{
									//***
									//this block puts client into game play state
									if (((_x select 0) call PCS_UIDToID) != "") then
									{
										if (!isNull (PCS_RNK_SHOP_DATA getVariable [format ["SHOP_E%1_%2", _x select 0, _side], objNull])) then
										{
											PCS_SHOP_VEHICLE = PCS_RNK_SHOP_DATA getVariable [format ["SHOP_E%1_%2", _x select 0, _side], objNull];
											((_x select 0) call PCS_UIDToTemp) publicVariableClient "PCS_SHOP_VEHICLE";
										};
										
										diag_log "RNK MAIN: sending record...";
										((_x select 0) call PCS_UIDToTemp) publicVariableClient "PCS_RNK_STATS"; //give him his well deserved statistics
									};
									if (!isNil "_temp") then
									{
										PCS_RNK_STATS = _temp; //incase server is also client
									};
								
									if ((PCS_RNK_RECORDS getVariable format ["%1_SIDE", _record]) == west) then
									{
										PCS_RNK_WEST_RECORDS pushBackUnique _record;
									}
									else
									{
										PCS_RNK_EAST_RECORDS pushBackUnique _record;
									};
									//***
								}
								else
								{
									if (((_x select 0) call PCS_UIDToID) != "") then
									{
										diag_log "KICKED PLAYER";
										"1234" serverCommand format ["#exec kick '%1'", _x select 0];
									};
								};
							//}
							//else
							//{
								/*
								//this block puts client into game play state
								if (((_x select 0) call PCS_UIDToID) != "") then
								{
									if (!isNull (PCS_RNK_SHOP_DATA getVariable [format ["SHOP_E%1_%2", _x select 0, _side], objNull])) then
									{
										PCS_SHOP_VEHICLE = PCS_RNK_SHOP_DATA getVariable [format ["SHOP_E%1_%2", _x select 0, _side], objNull];
										((_x select 0) call PCS_UIDToTemp) publicVariableClient "PCS_SHOP_VEHICLE";
									};
									
									diag_log "RNK MAIN: sending record...";
									((_x select 0) call PCS_UIDToTemp) publicVariableClient "PCS_RNK_STATS"; //give him his well deserved statistics
								};
								if (!isNil "_temp") then
								{
									PCS_RNK_STATS = _temp; //incase server is also client
								};
								
								if ((PCS_RNK_RECORDS getVariable format ["%1_SIDE", _record]) == west) then
								{
									PCS_RNK_WEST_RECORDS pushBackUnique _record;
								}
								else
								{
									PCS_RNK_EAST_RECORDS pushBackUnique _record;
								};
								*/
							//};
						};
						
						diag_log "RNK MAIN: record created";
					};
				};
			} foreach PCS_RNK_PENDING_RECORDS;
			PCS_RNK_PENDING_RECORDS = PCS_RNK_PENDING_RECORDS - [-1];
			
			
			//accumulate rank once a second and check for dead DB connections
			if (diag_tickTime >= PCS_RNK_T1) then
			{
				PCS_RNK_T1 = diag_tickTime + 1;
				
				//kick all clients with dead DB connections
				{
					if (((_x select 2) call PCS_UIDToID) != "") then
					{
						diag_log "KICKED PLAYER";
						"1234" serverCommand format ["#exec kick '%1'", _x select 2];
					};
				} foreach (["opfl", "GetState", ""] call PCS_CallExtension);
				
				if (!isNil "OPFL_CLOCK_START") then
				{
					if (OPFL_CLOCK_START && PCS_RNK_ON) then
					{
						PCS_RNK_REAL_GL = PCS_RNK_REAL_GL + 1;
						
						private ["_accum", "_rec"];
						_accum = [PCS_RNK_WEST_RECORDS, PCS_RNK_EAST_RECORDS] call PCS_RNK_PointAccumulator;
						_null = 
						{
							_rec = PCS_RNK_RECORDS getVariable _x;
							_rec set [2, (_rec select 2) + _accum];
						false
						} count PCS_RNK_WEST_RECORDS;
						
						_accum = [PCS_RNK_EAST_RECORDS, PCS_RNK_WEST_RECORDS] call PCS_RNK_PointAccumulator;
						_null = 
						{
							_rec = PCS_RNK_RECORDS getVariable _x;
							_rec set [2, (_rec select 2) + _accum];
						false
						} count PCS_RNK_EAST_RECORDS;
						
					};
				};
			};
			
			//publish once a second
			if ((diag_tickTime + 0.5) >= PCS_RNK_T2) then
			{
				PCS_RNK_T2 = diag_tickTime + 1.5;
				private ["_records"];
				_records = [];
				if (0 < ({
					_null = ["opfl", "PublishAccount", [((_x select 0) call PCS_RNK_GetHandle) select 0, (_x select 0) call PCS_RNK_GetRecord]] call PCS_CallExtension;
					PCS_RNK_RECORDS setVariable [format ["%1_LPI", _x select 0], nil];
					PCS_RNK_STATS = ((_x select 0) call PCS_RNK_GetRecord) select 7;
					((_x select 1) call PCS_IDToTemp) publicVariableClient "PCS_RNK_STATS";
					true
				} count PCS_RNK_PUBLISH)) then
				{
					PCS_RNK_PUBLISH resize 0;
				};
			};
		//};
	}];
};

diag_log "RNK MAIN: running init";
PCS_RNK_THREAD_INIT = addMissionEventHandler ["EachFrame", {
	//this waits until the connection pool has been formed, basically, the database handles have been initialized
	private "_state";
	if (!isNil {uiNamespace getVariable "PCS_RNK_DLL_READY"}) exitWith
	{
		call PCS_RNK_RUN_THREAD;
		removeMissionEventHandler["EachFrame", PCS_RNK_THREAD_INIT];
		PCS_RNK_THREAD_INIT = nil;
		PCS_RNK_RUN_THREAD = nil;
		uiNamespace setVariable ["PCS_RNK_DLL_READY", true];
	};
	
	//this code runs if its the first instance of an ranked mission on the server
	_state = ["opfl", "GetDllState", ""] call PCS_CallExtension;
	diag_log format ["RANK MAIN: %1", _state];
	if (_state == 1) then
	{
		diag_log "RNK MAIN: loading main thread";
		call PCS_RNK_RUN_THREAD;
		removeMissionEventHandler["EachFrame", PCS_RNK_THREAD_INIT];
		PCS_RNK_THREAD_INIT = nil;
		PCS_RNK_RUN_THREAD = nil;
		uiNamespace setVariable ["PCS_RNK_DLL_READY", true];
		diag_log "RNK MAIN: loaded dll";
	}
	else
	{
		diag_log "WAITING FOR DLL...";
	};
}];
