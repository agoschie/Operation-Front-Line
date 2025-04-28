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
private ["_i"];
_i = -1;

if (15 == {_i = _i + 1; (_x == typeName (_this select _i))} count ["STRING", "SCALAR", "SCALAR", "SCALAR", "SCALAR", "SCALAR", "SCALAR", "SCALAR", "SCALAR", "SCALAR", "SCALAR", "SCALAR", "SCALAR", "SCALAR", "SCALAR"]) then
{

	//this block is activated if we are saving the database stats to the record and activating it.
	if (_this select 15) exitWith
	{
		_i = 1;
		private "_arr";
		_arr = PCS_RNK_RECORDS getVariable (_this select 0);
		_arr set [1, _this select 16];
		_arr = _arr select 0;
		while {_i < 15} do
		{
			_arr set [_i, _this select _i];
			_i = _i + 1;
		};
		_i = true;
	};
	
	//create the new record, but use the progress of the his last connection to the server
	PCS_RNK_RECORDS setVariable [_this select 0, [(_this - [false, _this select 16]), _this select 16, PCS_RNK_RECORDS getVariable [_this select 0, 0]]];
	PCS_RNK_ACTIVE_RECORDS pushBackUnique (_this select 0);
	_i = true;
}
else
{
	_i = false;
	diag_log "RANK MODULE ERROR: Bad record format";
};
_i;