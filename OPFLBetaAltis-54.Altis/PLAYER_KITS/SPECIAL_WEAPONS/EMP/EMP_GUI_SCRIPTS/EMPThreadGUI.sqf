disableSerialization;

private "_display";
private "_satConsole";
private "_lastTime";
private "_lastText";
private "_lastTextWEffect";
private "_lastEffect";
private "_consoleEffectRate";
_consoleEffectRate = 0.25;
_display = uiNamespace getVariable "EMP_GUI_DISPLAY";
_satConsole = _display displayCtrl 1015; 
_lastText = ctrlText _satConsole;
_lastTextWEffect = format ["%1\n_", _lastText];
_lastEffect = false;
_lastTime = 0;
waitUntil
{
	if (diag_tickTime >= (_lastTime + _consoleEffectRate)) then
	{
		if (_lastEffect) then
		{
			_satConsole ctrlSetText _lastText;
		}
		else
		{
			_satConsole ctrlSetText _lastTextWEffect;
		};	
		_lastTime = diag_tickTime;
		_lastEffect = !(_lastEffect);
	};
	false
};