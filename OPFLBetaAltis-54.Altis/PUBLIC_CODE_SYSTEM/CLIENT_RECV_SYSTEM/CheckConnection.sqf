private "_return";
private "_name";
private "_id";
_return = false;
_name = "";
_id = "";

//if this fails, then the player is already connected
if (!(_this in PCS_UID_CONNECTIONS_LIST)) then 
{
	//if this fails, then the player has already disconnected after his failed connection
	if (!(_this in PCS_UID_FAILED_LIST)) then
	{
		//if this fails, then the player was already able to obtain proper connections, or the player has taken way too long to repair his connection and needs to reconnect anyway
		if (!(_this in PCS_UID_INITIAL_LIST) && (PCS_PLAYER_CAPACITY > count PCS_UID_INITIAL_LIST)) then
		{
			[_this, _name, _id] call PCS_OnConnected;
			_return = true;
		};
	};
}
else
{
	_return = true;
};

_return;