_this set [2, true];
(uiNamespace getVariable "PKS_AHL") deleteAt (_this find (uiNamespace getVariable "PKS_AHL"));
terminate (_this select 0);
if (!isNull (_this select 1)) then
{
	(_this select 1) playMoveNow "";
};
_this set [0, scriptNull];
_this set [1, objNull];