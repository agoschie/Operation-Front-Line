private ["_idList", "_textList", "_return"];
_idList = 23524;

if (PCS_RNK_ON) then
{
	_textList = "";
}
else
{
	_textList = format [
	"Waiting for Players! x%4 DOG TAGS PER KILL!\nWEST: %1/%3,  EAST: %2/%3",  
	PCS_RNK_PLAYER_THRESHOLD min (playersNumber west),
	PCS_RNK_PLAYER_THRESHOLD min playersNumber east,
	PCS_RNK_PLAYER_THRESHOLD, 
	PCS_RNK_WFP_DT_MULTIPLIER
	];
};		  
		 
_return = [_idList, _textList];
_return;