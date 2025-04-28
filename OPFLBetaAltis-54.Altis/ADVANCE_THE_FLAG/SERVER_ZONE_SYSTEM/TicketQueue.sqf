private "_executeState";

_executeState = OPFL_TICKET_QUEUE select 0;
switch (_executeState select 0) do
{
	case west:
	{
		if (_executeState select 1) then
		{
			OPFL_AMERICAN_TICKETS = OPFL_AMERICAN_TICKETS + 1;
		}
		else
		{
			OPFL_AMERICAN_TICKETS = OPFL_AMERICAN_TICKETS - 1;
		};
		publicVariable "OPFL_AMERICAN_TICKETS";
	};
	
	case east:
	{
		if (_executeState select 1) then
		{
			OPFL_RUSSIAN_TICKETS = OPFL_RUSSIAN_TICKETS + 1;
		}
		else
		{
			OPFL_RUSSIAN_TICKETS = OPFL_RUSSIAN_TICKETS - 1;
		};
		publicVariable "OPFL_RUSSIAN_TICKETS";
	};
	
	default
	{
		player sideChat "INVALID TICKET CHANGE!";
	};
};
OPFL_TICKET_QUEUE set [0, -1];
OPFL_TICKET_QUEUE = OPFL_TICKET_QUEUE - [-1];