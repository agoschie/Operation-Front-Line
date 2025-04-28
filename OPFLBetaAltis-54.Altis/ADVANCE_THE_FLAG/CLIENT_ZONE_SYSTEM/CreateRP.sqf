if (isNil "OPFL_LOCAL_RP_LIST") exitWith {};
private ["_blck", "_flag", "_menu", "_soundPath"];
_flag = objNull;
_blck = [_this select 0, 0, _this select 1];

if (!isNull (_this select 0)) then
{
	if (alive (_this select 0)) then
	{
		if ((_this select 0) == player) then
		{
			_blck pushBack playerSide;
		}
		else
		{
			_blck pushBack ([_blck select 0] call GSC_Side);
		};
		_flag = "FlagSmall_F" createVehicleLocal (_blck select 2);
		_flag setPosATL (_blck select 2);
		_flag allowDamage false;
		_flag enableSimulation false;
		player disableCollisionWith _flag;
		
		if ((_this select 0) != player) then
		{
			_flag addAction ["<img image='a3\ui_f\data\IGUI\Cfg\simpleTasks\types\interact_ca.paa'/> <t color='#FFFF00'> VOTE RP</t>", 
				{[_this, "OPFL_Client_AttemptVote"] call PCS_SpawnAtomic;}, 
				[], 
				101, 
				true, 
				true, 
				"", 
				"(player == vehicle player) && (_target getVariable 'RP_CAN_VOTE')"]
		};
		
		_flag setVariable ["RP_PLAYER", _blck select 0];
		_flag setVariable ["RP_POS", _blck select 2];
		_flag setVariable ["RP_CAN_VOTE", true];
		_flag setVariable ["RP_TIME", diag_tickTime + 30];
		
		_blck pushBack _flag;
		_blck pushBack ((_blck select 0) call GSC_Name);
		
		_flag = createMarkerLocal [format ["OPFL_RP_MARKER_%1", _blck select 5], _blck select 2];
		_flag setMarkerShapeLocal "ICON";
		_flag setMarkerTypeLocal "mil_flag";
		//_flag setMarkerTextLocal format ["RP: %1", _blck select 5];
		_flag setMarkerTextLocal "";
		_flag setMarkerDirLocal 0;
		_flag setMarkerSizeLocal [0.004 / (ctrlMapScale ((findDisplay 12) displayCtrl 51)), 0.004 / (ctrlMapScale ((findDisplay 12) displayCtrl 51))];
		_flag setMarkerColorLocal "ColorYellow";
		
		_blck pushBack _flag;
		
		OPFL_LOCAL_RP_LIST pushBack _blck;
		if ((_this select 0) == player) then
		{
			_soundPath = format ["dpl%1%2", floor random 3, "p"];
			playSound _soundPath;
			playSound "VoteRP";
		}
		/***
		//(_blck select 0) setVariable ["OPFL_VOTE_LOCK", nil];
		if (playerSide == (_blck select 3) && ((player distance (_blck select 4)) < viewDistance)) then
		{
			if ((_this select 0) == player) then
			{
				_soundPath = format ["dpl%1%2", floor random 3, "p"];
			}
			else
			{
				_soundPath = format ["dpl%1%2", floor random 3, ["L", "H", ""] select (floor random 3)];
			};
			playSound _soundPath;
			playSound "VoteRP";
		};
		***/
	};
};