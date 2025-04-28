OPFL_INIT_VARS = [] + (allVariables missionNamespace);

_null = [] spawn
{
	waitUntil
	{
		sleep 2;
		{
			diag_log _x;
		} foreach ((allVariables missionNamespace) - OPFL_INIT_VARS);
		false
	};
};