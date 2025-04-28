disableSerialization;

private ["_handle", "_size", "_display", "_listBox", "_currentKitTextBox", "_selectedKitTextBox", 
	"_kitsLeftTextBox", "_inUseTextBox", "_descriptionTextBox", "_pictureBoxA", "_pictureBoxB", 
	"_selectData", "_lastVal", "_lastKit", "_x", "_currentColor", "_currentVal", "_lastCurrentKit", 
	"_openPlayer", "_primDescrip", "_scopeDescrip"];
_display = uiNamespace getVariable "PKS_GUI_DISPLAY";
_listBox = _display displayCtrl 1006;
_currentKitTextBox = _display displayCtrl 1005;
_selectedKitTextBox = (_display displayCtrl 1012);
_kitsLeftTextBox = (_display displayCtrl 1013);
_inUseTextBox = (_display displayCtrl 1014);
_descriptionTextBox = (_display displayCtrl 1015);
_size = lbSize _listBox;
_openPlayer = _this select 0;
_pictureBoxA = (_display displayCtrl 1023);
_pictureBoxB = (_display displayCtrl 1027);
_primDescrip = (_display displayCtrl 1022);
_scopeDescrip = (_display displayCtrl 1031);

_selectData = (_listBox lbData (lbCurSel _listBox)) call PKS_GetKitData;
_lastKit = _selectData select 6;
_lastVal = PKS_KIT_TABLE getVariable _lastKit;

_selectedKitTextBox ctrlSetText (_selectData select 0);
_kitsLeftTextBox ctrlSetText format ["%1", _lastVal];
_inUseTextBox ctrlSetText format ["%1", (_selectData select 5) - _lastVal];
_descriptionTextBox ctrlSetText (_lastKit call PKS_GetKitDescription);

_lastCurrentKit = PLAYER_KIT;
_currentKitTextBox ctrlSetText format ["MY KIT: %1", ((_lastCurrentKit call PKS_GetKitData) select 0)];

uiNamespace setVariable ["PKS_GUI_THREAD_ARG", [_display, _listBox, _currentKitTextBox, _selectedKitTextBox, _kitsLeftTextBox, _inUseTextBox, _descriptionTextBox, _size, _openPlayer, _pictureBoxA, _pictureBoxB, _primDescrip, _scopeDescrip]];
uiNamespace setVariable ["PKS_GUI_THREAD_LF", [_selectData, _lastKit, _lastVal, _lastCurrentKit]];

_handle = addMissionEventHandler ["EachFrame", 
{
	private ["_args", "_size", "_display", "_listBox", "_currentKitTextBox", "_selectedKitTextBox", 
	"_kitsLeftTextBox", "_inUseTextBox", "_descriptionTextBox", "_pictureBoxA", "_pictureBoxB", "_selectData", "_lastVal", "_lastKit", "_x", "_currentColor", "_currentVal", "_lastCurrentKit", "_openPlayer", "_lastKitSet"];
	_args = uiNamespace getVariable "PKS_GUI_THREAD_ARG";
	_display = _args select 0;
	_listBox = _args select 1;
	_currentKitTextBox = _args select 2;
	_selectedKitTextBox = _args select 3;
	_kitsLeftTextBox = _args select 4;
	_inUseTextBox = _args select 5;
	_descriptionTextBox = _args select 6;
	_size = _args select 7;
	_openPlayer =_args select 8;
	_pictureBoxA = _args select 9;
	_pictureBoxB = _args select 10;
	_primDescrip = _args select 11;
	_scopeDescrip = _args select 12;
	
	_args = uiNamespace getVariable "PKS_GUI_THREAD_LF";
	
	_selectData = _args select 0;
	_lastKit = _args select 1;
	_lastVal = _args select 2;
	_lastCurrentKit = _args select 3;
	
	if (alive _openPlayer) then
	{
		for "_x" from 0 to (_size - 1) step 1 do
		{
			_currentVal = PKS_KIT_TABLE getVariable (_listBox lbData _x);
			//_currentColor = (_listBox lbColor _x) select 1;
			
			if (_currentVal < 1) then
			{
				_listBox lbSetColor [_x, [0.8,0,0,1]];
			}
			else
			{
				_listBox lbSetColor [_x, [0,0.8,0,1]];
			};
		};
	
		_selectData = (_listBox lbData (lbCurSel _listBox)) call PKS_GetKitData;
		if ((_selectData select 6) != _lastKit) then
		{
			_lastKit = _selectData select 6;
			_lastVal = PKS_KIT_TABLE getVariable _lastKit;
			_selectedKitTextBox ctrlSetText (_selectData select 0);
			_kitsLeftTextBox ctrlSetText format ["%1", _lastVal];
			_inUseTextBox ctrlSetText format ["%1", (_selectData select 5) - _lastVal];
			_descriptionTextBox ctrlSetText (_lastKit call PKS_GetKitDescription);
			
		};
	
		if ((PKS_KIT_TABLE getVariable _lastKit) != _lastVal) then
		{
			_lastVal = PKS_KIT_TABLE getVariable _lastKit;
			_kitsLeftTextBox ctrlSetText format ["%1", _lastVal];
			_inUseTextBox ctrlSetText format ["%1", (_selectData select 5) - _lastVal];
		};
	
		if (_lastCurrentKit != PLAYER_KIT) then
		{
			_lastCurrentKit = PLAYER_KIT;
			_currentKitTextBox ctrlSetText format ["MY KIT: %1", ((_lastCurrentKit call PKS_GetKitData) select 0)];
			call PKS_UpdateWeaponPictures;
		};
		
		uiNamespace setVariable ["PKS_GUI_THREAD_LF", [_selectData, _lastKit, _lastVal, _lastCurrentKit]];
	}
	else
	{
		closeDialog 0;
	};
}];

uiNamespace setVariable ["PKS_GUI_THREAD", _handle];