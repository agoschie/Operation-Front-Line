#define NULL_STATE		0
#define DEAD_STATE		1
#define WOUNDED_STATE	2
#define SPAWN_STATE		3
#define PARA_STATE		4
#define	LOW_STATE		5
#define HAPPY_STATE		6

private ["_state"];
_state = _this;

if ("STRING" == typeName _state) exitWith
{
	if (isText (configFile >> "CfgVehicles" >> _state >> "Icon")) then
	{
		_state = getText (configFile >> "CfgVehicles" >> _state >> "Icon");
	}
	else
	{
		if (isText (configFile >> "CfgVehicles" >> _state >> "icon")) then
		{
			_state = getText (configFile >> "CfgVehicles" >> _state >> "icon");
			_state = getText (configFile >> "CfgVehicleIcons" >> _state);
		};
	};
	_state;
};

switch (_state) do
{
	case NULL_STATE:
	{
		_state = "a3\ui_f\data\Map\VehicleIcons\iconManVirtual_ca.paa";
	};
	
	case DEAD_STATE:
	{
		_state = "a3\ui_f\data\Map\Respawn\icon_dead_ca.paa";
	};
	
	case WOUNDED_STATE:
	{
		_state = "a3\ui_f\data\Map\VehicleIcons\pictureHeal_ca.paa";
	};
	
	case SPAWN_STATE:
	{
		_state = "a3\ui_f\data\Map\Markers\Nato\respawn_unknown_ca.paa";
	};
	
	case PARA_STATE:
	{
		_state = "a3\ui_f\data\Map\VehicleIcons\iconParachute_ca.paa";
	};
	
	case LOW_STATE:
	{
		_state = "a3\weapons_f\Data\ui\m_5rnd_127x108_ca.paa";
	};
	
	default
	{
		_state = "A3\ui_f\data\gui\Rsc\RscDisplayArsenal\face_ca.paa";
	};
};
_state;