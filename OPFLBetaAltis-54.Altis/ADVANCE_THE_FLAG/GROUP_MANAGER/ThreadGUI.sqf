disableSerialization;

private ["_handle","_display", "_listBoxAvailable", "_listBoxGroup", "_myGroup", "_availableGroups", "_leaderName", "_leaderTextBox", "_temp"];
_display = uiNamespace getVariable "OPFL_GUI_DISPLAY";
_listBoxAvailable = _display displayCtrl 1006;
_listBoxGroup = _display displayCtrl 1007;
_leaderTextBox = _display displayCtrl 1015;

_myGroup = (units group player) apply {[_x, _x call GSC_Name, alive _x, _x call OPFL_CurrentState]};
{
	_listBoxGroup lbAdd format ["%1 %2", _x select 1, ["(Dead)", ""] select (_x select 2)];
	_listBoxGroup lbSetData [_forEachIndex, netId (_x select 0)];
	_listBoxGroup lbSetColor [_forEachIndex, [1,1,1,1]];
	_listBoxGroup lbSetPicture [_forEachIndex, (_x select 3) call OPFL_CurrentIcon];
	_listBoxGroup lbSetPictureColor [_forEachIndex, [1,1,1,1]];
} foreach _myGroup;	

_leaderName = (group player) getVariable ["OPFL_GROUP_ID", groupId group player];
if (OPFL_IS_LEADER && ((player call GSC_Name) != (_leaderName))) then
{
	_leaderName = player call GSC_Name;
};
_leaderTextBox ctrlSetText format ["%1", _leaderName];

_availableGroups = (allGroups apply {[-1, [_x, _x getVariable ["OPFL_GROUP_ID", groupId _x], count units _x]] select ((playerSide == ([leader _x] call GSC_Side)) && (!isNil {_x getVariable "OPFL_IS_OPEN_GROUP"}))});
_availableGroups = _availableGroups - [-1];
_temp = [];
{
	_temp append toArray format ["%1%2", (_x select 1), "                                    "];
	//sqf loops are slow
	_temp resize 30;
	_temp append toArray format ["  %1", (_x select 2)];
	_listBoxAvailable lbAdd (toString _temp);
	_temp resize 0; //use the same array, locality
				
	_listBoxAvailable lbSetData [_forEachIndex, netId (_x select 0)];
	_listBoxAvailable lbSetColor [_forEachIndex, [1,1,0,1]];
				
} foreach _availableGroups;

uiNamespace setVariable ["OPFL_GUI_THREAD_ARG", [_display, _listBoxAvailable, _listBoxGroup, _leaderTextBox]];
uiNamespace setVariable ["OPFL_GUI_THREAD_LF", [_myGroup, _availableGroups, _leaderName]];

_handle = addMissionEventHandler ["EachFrame", 
{
	private ["_display", "_listBoxAvailable", "_myGroup", "_availableGroups", "_listBoxGroup", "_leaderName", "_temp", "_leaderTextBox", "_lastSel"];
	_args = uiNamespace getVariable "OPFL_GUI_THREAD_ARG";
	_display = _args select 0;
	_listBoxAvailable = _args select 1;
	_listBoxGroup = _args select 2;
	_leaderTextBox = _args select 3;
	
	_args = uiNamespace getVariable "OPFL_GUI_THREAD_LF";
	
	_myGroup = _args select 0;
	_availableGroups = _args select 1;
	_leaderName = _args select 2;
	
	if (alive player) then
	{
		_temp = (units group player) apply {[_x, _x call GSC_Name, alive _x, _x call OPFL_CurrentState]};
		if (!(_temp isEqualTo _myGroup)) then
		{
			//update
			_lastSel = lbCurSel _listBoxGroup;
			if (_lastSel > -1) then
			{
				_lastSel = _listBoxGroup lbData _lastSel;
			}
			else
			{
				_lastSel = "";
			};
			_listBoxGroup lbSetCurSel -1;
			lbClear _listBoxGroup;
			
			_myGroup = _temp;
			
			{
				_listBoxGroup lbAdd format ["%1 %2", _x select 1, ["(Dead)", ""] select (_x select 2)];
				_listBoxGroup lbSetData [_forEachIndex, netId (_x select 0)];
				_listBoxGroup lbSetColor [_forEachIndex, [1,1,1,1]];
				_listBoxGroup lbSetPicture [_forEachIndex, (_x select 3) call OPFL_CurrentIcon];
				_listBoxGroup lbSetPictureColor [_forEachIndex, [1,1,1,1]];
				if (_lastSel == netId (_x select 0)) then
				{
					_lastSel = _forEachIndex;
					_listBoxGroup lbSetCurSel _lastSel;
				};
			} foreach _myGroup;
			//if (_lastSel != "") then
			//{
			//	_listBoxGroup lbSetCurSel _lastSel;
			//};
		};
		
		
		_temp = (group player) getVariable ["OPFL_GROUP_ID", groupId group player];
		if (OPFL_IS_LEADER && ((player call GSC_Name) != _temp)) then
		{
			_temp = player call GSC_Name;
		};
		if (!(_temp isEqualTo _leaderName)) then
		{
			//update
			_leaderName = _temp;
			_leaderTextBox ctrlSetText format ["%1", _leaderName];
		};
		
		
		_temp = (allGroups apply {[-1, [_x, _x getVariable ["OPFL_GROUP_ID", groupId _x], count units _x]] select ((playerSide == ([leader _x] call GSC_Side)) && (!isNil {_x getVariable "OPFL_IS_OPEN_GROUP"}))});
		_temp = _temp - [-1];
		if (!(_temp isEqualTo _availableGroups)) then
		{
			//update
			_lastSel = lbCurSel _listBoxAvailable;
			if (_lastSel > -1) then
			{
				_lastSel = _listBoxAvailable lbData _lastSel;
			}
			else
			{
				_lastSel = "";
			};
			_listBoxAvailable lbSetCurSel -1;
			lbClear _listBoxAvailable;
			_availableGroups = _temp;
			
			_temp = [];
			{
				_temp append toArray format ["%1%2", (_x select 1), "                                    "];
				//sqf loops are slow
				_temp resize 30;
				_temp append toArray format ["  %1", (_x select 2)];
				_listBoxAvailable lbAdd (toString _temp);
				_temp resize 0; //use the same array, locality
				
				_listBoxAvailable lbSetData [_forEachIndex, netId (_x select 0)];
				_listBoxAvailable lbSetColor [_forEachIndex, [1,1,0,1]];
				if (_lastSel == netId (_x select 0)) then
				{
					_lastSel = _forEachIndex;
					_listBoxAvailable lbSetCurSel _lastSel;
				};
			} foreach _availableGroups;
			//if (_lastSel != "") then
			//{
			//	_listBoxAvailable lbSetCurSel _lastSel;
			//};
		};
		
		if (-1 < lbCurSel _listBoxAvailable) then
		{
			_temp = groupFromNetId (_listBoxAvailable lbData (lbCurSel _listBoxAvailable));
		}
		else
		{
			_temp = grpNull;
		};
		if (isNull _temp) then
		{
			(_display displayCtrl 1003) ctrlEnable false;
		}
		else
		{
			if (((_temp getVariable ["OPFL_GROUP_ID", groupId _temp]) == _leaderName) || (((uiNamespace getVariable "OPFL_GUI_BOX_SELECTED") select 0) != _listBoxAvailable)) then
			{
				(_display displayCtrl 1003) ctrlEnable false;
			}
			else
			{
				(_display displayCtrl 1003) ctrlEnable true;
			};
		};
		
		_temp = group player;
		if (OPFL_IS_LEADER && (_leaderName == (player call GSC_Name))) then
		{
			if (isNil {_temp getVariable "OPFL_IS_OPEN_GROUP"}) then
			{
				(_display displayCtrl 1008) ctrlEnable true;
				(_display displayCtrl 1009) ctrlEnable false;
			}
			else
			{
				(_display displayCtrl 1008) ctrlEnable false;
				(_display displayCtrl 1009) ctrlEnable true;
			};
		}
		else
		{
			(_display displayCtrl 1008) ctrlEnable false;
			(_display displayCtrl 1009) ctrlEnable false;
		};
		
		if (-1 < lbCurSel _listBoxGroup) then
		{
			_temp = objectFromNetId (_listBoxGroup lbData (lbCurSel _listBoxGroup));
		}
		else
		{
			_temp = objNull;
		};
		if (isNull _temp) then
		{
			(_display displayCtrl 1010) ctrlEnable false;
		}
		else
		{
			if (!alive _temp || (OPFL_IS_LEADER && (2 > count units _temp)) || (((uiNamespace getVariable "OPFL_GUI_BOX_SELECTED") select 0) != _listBoxGroup)) then
			{
				(_display displayCtrl 1010) ctrlEnable false;
			}
			else
			{
				(_display displayCtrl 1010) ctrlEnable true;
			};
		};
		
		_temp = group player;
		if (OPFL_IS_LEADER && (2 > count units _temp)) then
		{
			(_display displayCtrl 1011) ctrlEnable false;
		}
		else
		{
			(_display displayCtrl 1011) ctrlEnable true;
		};
		
		uiNamespace setVariable ["OPFL_GUI_THREAD_LF", [_myGroup, _availableGroups, _leaderName]];
	}
	else
	{
		closeDialog 0;
	};
}];

uiNamespace setVariable ["OPFL_GUI_THREAD", _handle];