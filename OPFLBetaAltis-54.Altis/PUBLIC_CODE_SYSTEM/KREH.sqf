"PCS_KREH_INPUT" addPublicVariableEventHandler
{
	if ((((_this select 1) select 1) call PCS_IDToUID) == "") exitWith {};
	private ["_cluster"];
	_cluster = floor random 4;
	for "_i" from 0 to 3 do
	{
		if (_i == _cluster) then
		{
			missionNamespace setVariable [format ["PCS_RK_%1", (_this select 1) select 0], ["KEY_A", "KEY_B"]];
			(((_this select 1) select 1) call PCS_IDToTemp) publicVariableClient format ["PCS_RK_%1", (_this select 1) select 0];
		}
		else
		{
			private ["_randVar", "_oldVar"];
			_randVar = (8 + floor random 9) call GSC_CreateRandomKey;
			_randVar = _randVar call GSC_MapKeyToVarName;
			if (_randVar == ((_this select 1) select 0)) then
			{
				_randVar = format ["%1i", _randVar];
			};
			if (_randVar == _oldVar) then
			{
				_randVar = format ["%1i", _randVar];
			};
			_oldVar = _randVar;
			_randVar = format ["PCS_RK_%1", _randVar];
			missionNamespace setVariable [_randVar, [((8 + floor random 9) call GSC_CreateRandomKey) call GSC_MapKeyToVarName, ((8 + floor random 9) call GSC_CreateRandomKey) call GSC_MapKeyToVarName]];
			(((_this select 1) select 1) call PCS_IDToTemp) publicVariableClient _randVar;
		};
	};
};

PCS_PEHKREH_READY = true;