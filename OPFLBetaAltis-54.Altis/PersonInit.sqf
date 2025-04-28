if (true) exitWith {};
_person = _this select 0;

// Server only
if (isServer) then {
	
};

// Player only
if (!isDedicated) then {

	waitUntil {(player == player) && (time > 10)};
	if (!local _person) exitWith {};
};