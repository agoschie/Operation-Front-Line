private ["_k", "_j", "_return"];
_k = vectorNormalized (_this select 0);
_j = vectorNormalized (_this select 1);

_return = [vectorNormalized (_j vectorCrossProduct _k), _j, _k];
_return;