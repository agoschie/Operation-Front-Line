private ["_id", "_text", "_return"];
_id = 23504;

if ((typeName UNITIME) == "STRING") then
{
	_text = UNITIME;
}
else
{
	_text = [(OPFL_GAME_TIME - UNITIME)] call GSC_FormatTime;
};
		 
_return = [_id, _text];
_return;
	