private ["_id", "_send", "_person"];

_id = _this;
_send = [];
_person = objNull;

if (([_id] call PCS_TempID) < 1) exitWith {};

_null = 
{
	_person = _x select 0;
	if (!isNil {_person getVariable "OPFL_RP_POS"}) then
	{
		_send pushBack (netId _person);
		_send pushBack (_person getVariable "OPFL_RP_VOTE");
		_send append (_person getVariable "OPFL_RP_POS");
	};
	false
} count OPFL_RP_LIST;

if (_send isEqualTo []) then
{
	_send = "";
}
else
{
	//compress data into string
	_send = _send joinString "|";
};

[_send, "OPFL_SynchAllRP", _id, "PIPE_KEY_B"] call PCS_MPCodeBroadcast_Atomic;