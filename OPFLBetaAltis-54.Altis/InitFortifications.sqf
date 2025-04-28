if (!(isNil "Engineer_Actions_List")) then
{
	{
		player removeAction _x;
	} foreach Engineer_Actions_List;
};
_add = false;

{
	if (_x == (typeOf player)) then
	{
		_add = true;
	};
} foreach FORT_USERS;

if (_add) then
{
	_null = [] spawn PKS_ClientBS_EngineerActionMenu;
};