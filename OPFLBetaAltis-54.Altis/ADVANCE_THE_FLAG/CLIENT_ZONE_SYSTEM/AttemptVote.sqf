private ["_rp", "_person", "_pos"];
_rp = _this select 0;
_person = _rp getVariable "RP_PLAYER";
_pos = _rp getVariable "RP_POS";
if (!isNull _person) then
{
	if ((player != _person) && alive _person) then
	{
		if (_rp getVariable "RP_CAN_VOTE") then
		{
			_rp setVariable ["RP_CAN_VOTE", false];
			[[_person, PCS_UNIQUE, _pos], "OPFL_FortifyRP", PCS_S_SERVER, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;
			player say "VoteRP";
		}
		else
		{
			hint "ALREADY VOTED";
		};
	};
};