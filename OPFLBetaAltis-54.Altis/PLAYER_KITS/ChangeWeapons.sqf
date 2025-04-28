private ["_dir", "_primary", "_kit", "_indices", "_player"];
_kit = _this select 0;
_dir = _this select 1;
_primary = _this select 2;
_player = _this select 3;

if ((_kit != PLAYER_KIT) || (!alive _player) || (_kit == "WestDefault") || (_kit == "EastDefault")) exitWith {};

_indices = PLAYER_KIT call PKS_GetKitIndices;

if (_primary) then
{
	//primary
	
	if (_dir) then
	{
		//right
		if ((_indices select 0) < (_indices select 2)) then
		{
			_indices set [0, (_indices select 0) + 1];
			//[_player] call PKS_FillKit;
			PKS_NEED_REFILL = true;
		};
	}
	else
	{
		//left
		if ((_indices select 0) > 0) then
		{
			_indices set [0, (_indices select 0) - 1];
			//[_player] call PKS_FillKit;
			PKS_NEED_REFILL = true;
		};
	};
}
else
{
	//scope
	
	if (_dir) then
	{
		//right
		if ((_indices select 1) < (_indices select 3)) then
		{
			_indices set [1, (_indices select 1) + 1];
			//[_player] call PKS_FillKit;
			PKS_NEED_REFILL = true;
		};
	}
	else
	{
		//left
		if ((_indices select 1) > 0) then
		{
			_indices set [1, (_indices select 1) - 1];
			//[_player] call PKS_FillKit;
			PKS_NEED_REFILL = true;
		};
	};
	
};