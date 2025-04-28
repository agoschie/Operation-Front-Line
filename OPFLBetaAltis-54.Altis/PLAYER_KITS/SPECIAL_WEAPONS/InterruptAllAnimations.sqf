if (!((uiNamespace getVariable "PKS_AHL") isEqualTo [])) then
{
	{
		_x set [2, true];
	} foreach (uiNamespace getVariable "PKS_AHL");
};