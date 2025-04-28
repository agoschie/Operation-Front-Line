class CfgPatches
{
	class OPFLServer
	{
		units[]= {};
		weapons[]={};
		requiredVersion=1.0;
		requiredAddons[] = {};
		author[] = {"Goschie"};
	};
};

class CfgFunctions
{
	class OPFL
	{
		class InitResources
		{
			class OPFLServerInit 
			{
				file = "OPFLServer\init.sqf";
				preStart = 1;
			};
		};
	};
};
