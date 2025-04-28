private ["_return", "_unit"];
_return = [_this spawn { while {alive _this} do {_this playMoveNow "ainvpknlmstpslaywrfldnon_medic"; waitUntil {0 == moveTime _this}; sleep 0.01;};}, _this];
_return;