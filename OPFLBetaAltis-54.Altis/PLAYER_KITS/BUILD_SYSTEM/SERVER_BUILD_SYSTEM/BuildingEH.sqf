private "_SERVER_BUILD_OBJECT";
private "_wait";

_SERVER_BUILD_OBJECT = compile loadFile "SERVER_BUILD_SYSTEM\Server_BuildObject.sqf";

BUILDER_TERMINAL = ["NULL"];
_wait = 1;

while {_wait == 1} do
{
	private "_bvfArray";
	waitUntil{(BUILDER_TERMINAL select 0) != "NULL"};
	_bvfArray = + BUILDER_TERMINAL;
	BUILDER_TERMINAL = ["NULL"];
	_null = [_bvfArray] spawn _SERVER_BUILD_OBJECT;
	_bvfArray = nil;
};