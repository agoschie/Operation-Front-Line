//add to this array (watch commas!) to make another global variable/settings, these are examples
DYNAMIC_SETTINGS_LIST = [
	[
		"RTMS_IS_ON",
		"Rotation Menu System",
		2,
		["off", "on"],
		[false, true],
		"Rotation Menu System on or off?",
		{}
	],
	
	[
		"OPFL_SOUND_VOLUME",
		"Flag Beep Volume",
		6,
		["0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%"],
		[0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1],
		"Changes the volume of all mission sounds.\n\n A good example is the beeping you hear when you enter a flag area\n
		DEFAULT IS 50%",
		{0 fadeMusic (_this select 1);}
	]
];

//format

//[
//	variable name <string>,
//	display name <string>,
//	starting value index <integer>, *starts at 1*
//	array of value display names, best as strings <array>,
//	array of values corresponding to each name ^ <array>,
//	description text <string>
//  *OPTIONAL* new saved value event <code>, *gets passed [variableNameString, newValue, oldValue] as arguments*
//],
//comma if not last element ^