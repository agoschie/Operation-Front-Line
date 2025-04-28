DYNAMIC_SETTINGS_ACTION = [
	player addAction ["<img image='a3\ui_f\data\IGUI\Cfg\simpleTasks\types\interact_ca.paa'/> <t color='#FFFF00'> MISSION SETTINGS</t>", 
				"DYNAMIC_SETTINGS\GUI_SCRIPTS\ActivateSettingsGUI.sqf", 
				[_x], 
				-101, 
				false, 
				true, 
				"", 
				"[_target] call DynamicSettings_ActionCondition"],
	
	player
];