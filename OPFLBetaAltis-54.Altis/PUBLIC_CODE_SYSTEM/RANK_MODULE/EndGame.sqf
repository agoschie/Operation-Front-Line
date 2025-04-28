/*
	0 UIDName,
	1 Rank,
	2 Level,
	3 Matches,
	4 Wins,
	5 Losses,
	6 Kills,
	7 Chickens
*/

PCS_RNK_RUNNING = false;
removeMissionEventHandler ["EachFrame", PCS_RNK_MAIN_EH];

private ["_record", "_temp", "_records", "_winTeam", "_side", "_points"];
_winTeam = _this select 0;
_records = [];
_points = 0;

{
	//Need to make it so a TDM wait for players match does not update rank.
	if (PCS_RNK_ON) then
	{
		_record = _x call PCS_RNK_GetRecord;
		_side = PCS_RNK_RECORDS getVariable format ["%1_SIDE", _x];
		_points = round ((_x call PCS_RNK_GetPoints) * 100 / ((sqrt (2)) * PCS_RNK_REAL_GL)); //we assume PCS_RNK_REAL_GL is non zero, this script must crash and fail to commit rank if its zero
		_temp = [] + _record;
		
		if (_winTeam == independent) then
		{
			_record set [1, [(_record select 1) + 1, _record select 1] select ((((_temp select 2) + _points) < 1000) || ((_temp select 1) == 8))];
			_record set [2, [[0, 1000] select ((_temp select 1) == 8), (_record select 2) + _points] select (((_temp select 2) + _points) < 1000)];
			_record set [3, (_record select 3) + 1];
			_record set [4, (_record select 4) + 1];
			_record set [5, (_record select 5) + 1];
		}
		else
		{
			if (_side == _winTeam) then
			{
				_record set [1, [(_record select 1) + 1, _record select 1] select ((((_temp select 2) + _points) < 1000) || ((_temp select 1) == 8))];
				_record set [2, [[0, 1000] select ((_temp select 1) == 8), (_record select 2) + _points] select (((_temp select 2) + _points) < 1000)];
				_record set [3, (_record select 3) + 1];
				_record set [4, (_record select 4) + 1];
				
				
			}
			else
			{
				_record set [1, [(_record select 1) - 1, _record select 1] select ((((_temp select 2) - (200 - _points)) > 0) || ((_temp select 1) < 2))];
				_record set [2, [[1000, 0] select ((_temp select 1) < 2), (_record select 2) - (200 - _points)] select (((_temp select 2) - (200 - _points)) > 0)];
				_record set [3, (_record select 3) + 1];
				_record set [5, (_record select 5) + 1];
			};
		};
	};
	_null = ["opfl", "PublishAccount", [(_x call PCS_RNK_GetHandle) select 0, _x call PCS_RNK_GetRecord]] call PCS_CallExtension;
} foreach (PCS_RNK_WEST_RECORDS + PCS_RNK_EAST_RECORDS);

if (1 > count PCS_RNK_ACTIVE_RECORDS) exitWith {};
PCS_RNK_ACTIVE_RECORDS = (PCS_RNK_ACTIVE_RECORDS apply {((_x call PCS_RNK_GetHandle) + [false])});
_null = ["opfl", "Commit", PCS_RNK_ACTIVE_RECORDS] call PCS_CallExtension;