OPFL_GROUP_MANAGER_THREAD = addMissionEventHandler ["EachFrame", {
	private ["_grpList", "_id", "_leader", "_units"];
	{
		if (!isNull _x) then
		{
			_grpList = _x getVariable "OPFL_GROUP";
			_leader = leader _x;
			_id = (getPlayerUID _leader) call PCS_UIDToID;
			_units = units _x;
			
			if (_id in _grpList) then
			{
				if (_id != (_grpList select 0)) then
				{
					{
						if (((_grpList select 0) == ((getPlayerUID _x) call PCS_UIDToID)) && (alive _x)) exitWith
						{
							(group _x) selectLeader _x;
						};
					} foreach _units
				};
			};
		};
	} foreach OPFL_ACTIVE_GROUPS;
}];