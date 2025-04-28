private "_text";
private "_delay";

_delay = 20;

_text = "Welcome to Advance The Flag! Click LEARN TO PLAY in the map notes for more info! (open map, select notes)";

OPFL_SCREEN_HINT_TEXT = _text;

sleep _delay;


[_text, "OPFL_Client_ScreenHintRefresh"] call PCS_ExecAtomic;