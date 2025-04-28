private "_arg";
private "_soundName";
_arg = _this select 0;

if ("OBJECT" == typeName _arg) then
{
	_soundName = _arg getVariable "SOUND";
	_arg setPosASL (getPosASL player);
	_arg say _soundName;
}
else
{
	_arg = (missionNamespace getVariable (format ["GLOBAL_SCRIPTS_SOUND_%1", _arg]));
	_soundName = _arg getVariable "SOUND";
	_arg setPosASL (getPosASL player);
	playSound _soundName;
};

