private "_body";
_body = _this select 0;

if (isNil {_body getVariable "OPFL_DELETE_LOCK"}) then
{
	deleteVehicle _body;
}
else
{
	[_body] spawn OPFL_Server_CleanBody;
};