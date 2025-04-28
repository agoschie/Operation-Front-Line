private ["_return", "_unit"];
_return = [_this spawn { while {alive _this} do {_this playMoveNow "amovpknlmstpsraswrfldnon_gear"; 
												sleep 1; 
												_this playMoveNow "amovpercmstpsraswrfldnon_gear"; 
												sleep 1;};}, _this, false];
(uiNamespace getVariable "PKS_AHL") pushBack _return;
_return;