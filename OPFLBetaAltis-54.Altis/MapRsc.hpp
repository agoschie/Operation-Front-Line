/*
///////////////////////////////////////////////////////////////////////////
/// Styles
///////////////////////////////////////////////////////////////////////////

// Control types

#define CT_MAP_MAIN       101

#define ST_PICTURE        48


///////////////////////////////////////////////////////////////////////////
/// Base Classes
///////////////////////////////////////////////////////////////////////////


class RscMapControl
{
	type = CT_MAP_MAIN;
	style = ST_PICTURE;
	moveOnEdges = 0;
	shadow = 0;
	ptsPerSquareSea = 5;
	ptsPerSquareTxt = 20;
	ptsPerSquareCLn = 10;
	ptsPerSquareExp = 10;
	ptsPerSquareCost = 10;
	ptsPerSquareFor = 9;
	ptsPerSquareForEdge = 9;
	ptsPerSquareRoad = 6;
	ptsPerSquareObj = 9;
	showCountourInterval = 0;
	scaleMin = 0.001;
	scaleMax = 1.0;
	scaleDefault = 0.16;
	maxSatelliteAlpha = 0.85;
	alphaFadeStartScale = 2;
	alphaFadeEndScale = 2;
	colorBackground[] = {0.969,0.957,0.949,1.0};
	colorText[] = {0,0,0,0};
	colorSea[] = {0.467,0.631,0.851,0.5};
	colorForest[] = {0.624,0.78,0.388,0.5};
	colorForestBorder[] = {0.0,0.0,0.0,0.0};
	colorRocks[] = {0.0,0.0,0.0,0.3};
	colorRocksBorder[] = {0.0,0.0,0.0,0.0};
	colorLevels[] = {0.286,0.177,0.094,0.5};
	colorMainCountlines[] = {0.572,0.354,0.188,0.5};
	colorCountlines[] = {0.572,0.354,0.188,0.25};
	colorMainCountlinesWater[] = {0.491,0.577,0.702,0.6};
	colorCountlinesWater[] = {0.491,0.577,0.702,0.3};
	colorPowerLines[] = {0.1,0.1,0.1,1.0};
	colorRailWay[] = {0.8,0.2,0.0,1.0};
	colorNames[] = {0.1,0.1,0.1,0.9};
	colorInactive[] = {1.0,1.0,1.0,0.5};
	colorOutside[] = {0.0,0.0,0.0,1.0};
	colorTracks[] = {0.84,0.76,0.65,0.15};
	colorTracksFill[] = {0.84,0.76,0.65,1.0};
	colorRoads[] = {0.7,0.7,0.7,1.0};
	colorRoadsFill[] = {1.0,1.0,1.0,1.0};
	colorMainRoads[] = {0.9,0.5,0.3,1.0};
	colorMainRoadsFill[] = {1.0,0.6,0.4,1.0};
	colorGrid[] = {0.1,0.1,0.1,0.6};
	colorGridMap[] = {0.1,0.1,0.1,0.6};
	font = "TahomaB";
	sizeEx = 0.040000;
	fontLabel = "PuristaMedium";
	sizeExLabel = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	fontGrid = "TahomaB";
	sizeExGrid = 0.02;
	fontUnits = "TahomaB";
	sizeExUnits = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	fontNames = "EtelkaNarrowMediumPro";
	sizeExNames = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8) * 2";
	fontInfo = "PuristaMedium";
	sizeExInfo = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	fontLevel = "TahomaB";
	sizeExLevel = 0.02;
	text = "#(argb,8,8,3)color(1,1,1,1)";
	class Legend
	{
		x = "SafeZoneX + 					(			((safezoneW / safezoneH) min 1.2) / 40)";
		y = "SafeZoneY + safezoneH - 4.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		w = "10 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
		h = "3.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		font = "PuristaMedium";
		sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		colorBackground[] = {1,1,1,0.5};
		color[] = {0,0,0,1};
	};
	class Task
	{
		icon = "\A3\ui_f\data\map\mapcontrol\taskIcon_CA.paa";
		iconCreated = "\A3\ui_f\data\map\mapcontrol\taskIconCreated_CA.paa";
		iconCanceled = "\A3\ui_f\data\map\mapcontrol\taskIconCanceled_CA.paa";
		iconDone = "\A3\ui_f\data\map\mapcontrol\taskIconDone_CA.paa";
		iconFailed = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_CA.paa";
		color[] = {"(profilenamespace getvariable ['IGUI_TEXT_RGB_R',0])","(profilenamespace getvariable ['IGUI_TEXT_RGB_G',1])","(profilenamespace getvariable ['IGUI_TEXT_RGB_B',1])","(profilenamespace getvariable ['IGUI_TEXT_RGB_A',0.8])"};
		colorCreated[] = {1,1,1,1};
		colorCanceled[] = {0.7,0.7,0.7,1};
		colorDone[] = {0.7,1,0.3,1};
		colorFailed[] = {1,0.3,0.2,1};
		size = 27;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};
	class Waypoint {
		icon = "\A3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
		color[] = {0.00, 0.00, 0.00, 1.00};
		size = 24;
		importance = 1.00;
		coefMin = 1.00;
		coefMax = 1.00;
	};
	class WaypointCompleted {
		icon = "\A3\ui_f\data\map\mapcontrol\waypointCompleted_ca.paa";
		color[] = {0.00, 0.00, 0.00, 1.00};
		size = 24;
		importance = 1.00;
		coefMin = 1.00;
		coefMax = 1.00;
	};
	class ActiveMarker {
		color[] = {0.30, 0.10, 0.90, 1.00};
		size = 50;
	};
	class CustomMark
	{
		icon = "\A3\ui_f\data\map\mapcontrol\custommark_ca.paa";
		size = 24;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
		color[] = {0,0,0,1};
	};
	class Command
	{
		icon = "\A3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
		size = 18;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
		color[] = {1,1,1,1};
	};
	class Bush
	{
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		color[] = {0.45,0.64,0.33,0.4};
		size = "14/2";
		importance = "0.2 * 14 * 0.05 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Rock
	{
		icon = "\A3\ui_f\data\map\mapcontrol\rock_ca.paa";
		color[] = {0.1,0.1,0.1,0.8};
		size = 12;
		importance = "0.5 * 12 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class SmallTree
	{
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		color[] = {0.45,0.64,0.33,0.4};
		size = 12;
		importance = "0.6 * 12 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Tree
	{
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		color[] = {0.45,0.64,0.33,0.4};
		size = 12;
		importance = "0.9 * 16 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class busstop
	{
		icon = "\A3\ui_f\data\map\mapcontrol\busstop_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class fuelstation
	{
		icon = "\A3\ui_f\data\map\mapcontrol\fuelstation_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class hospital
	{
		icon = "\A3\ui_f\data\map\mapcontrol\hospital_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class church
	{
		icon = "\A3\ui_f\data\map\mapcontrol\church_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class lighthouse
	{
		icon = "\A3\ui_f\data\map\mapcontrol\lighthouse_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class power
	{
		icon = "\A3\ui_f\data\map\mapcontrol\power_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class powersolar
	{
		icon = "\A3\ui_f\data\map\mapcontrol\powersolar_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class powerwave
	{
		icon = "\A3\ui_f\data\map\mapcontrol\powerwave_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class powerwind
	{
		icon = "\A3\ui_f\data\map\mapcontrol\powerwind_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class quay
	{
		icon = "\A3\ui_f\data\map\mapcontrol\quay_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class transmitter
	{
		icon = "\A3\ui_f\data\map\mapcontrol\transmitter_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class watertower
	{
		icon = "\A3\ui_f\data\map\mapcontrol\watertower_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class Cross
	{
		icon = "\A3\ui_f\data\map\mapcontrol\Cross_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {0,0,0,1};
	};
	class Chapel
	{
		icon = "\A3\ui_f\data\map\mapcontrol\Chapel_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {0,0,0,1};
	};
	class Shipwreck
	{
		icon = "\A3\ui_f\data\map\mapcontrol\Shipwreck_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {0,0,0,1};
	};
	class Bunker
	{
		icon = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
		size = 14;
		importance = "1.5 * 14 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
		color[] = {0,0,0,1};
	};
	class Fortress
	{
		icon = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
		size = 16;
		importance = "2 * 16 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
		color[] = {0,0,0,1};
	};
	class Fountain
	{
		icon = "\A3\ui_f\data\map\mapcontrol\fountain_ca.paa";
		size = 11;
		importance = "1 * 12 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
		color[] = {0,0,0,1};
	};
	class Ruin
	{
		icon = "\A3\ui_f\data\map\mapcontrol\ruin_ca.paa";
		size = 16;
		importance = "1.2 * 16 * 0.05";
		coefMin = 1;
		coefMax = 4;
		color[] = {0,0,0,1};
	};
	class Stack
	{
		icon = "\A3\ui_f\data\map\mapcontrol\stack_ca.paa";
		size = 20;
		importance = "2 * 16 * 0.05";
		coefMin = 0.9;
		coefMax = 4;
		color[] = {0,0,0,1};
	};
	class Tourism
	{
		icon = "\A3\ui_f\data\map\mapcontrol\tourism_ca.paa";
		size = 16;
		importance = "1 * 16 * 0.05";
		coefMin = 0.7;
		coefMax = 4;
		color[] = {0,0,0,1};
	};
	class ViewTower
	{
		icon = "\A3\ui_f\data\map\mapcontrol\viewtower_ca.paa";
		size = 16;
		importance = "2.5 * 16 * 0.05";
		coefMin = 0.5;
		coefMax = 4;
		color[] = {0,0,0,1};
	};
};
*/

///////////////////////////////////////////////////////////////////////////
/// Styles
///////////////////////////////////////////////////////////////////////////

// Control types

#define CT_MAP_MAIN       101

#define ST_PICTURE        48


///////////////////////////////////////////////////////////////////////////
/// Base Classes
///////////////////////////////////////////////////////////////////////////


class RscMapControl
{
	//type = CT_MAP_MAIN;
	//style = ST_PICTURE;
	x = "SafeZoneX";
				y = "SafeZoneY - 100";
				w = "SafeZoneW";
				h = "SafeZoneH";
				style = ST_PICTURE;
				type = CT_MAP_MAIN;
				scaleMin = 1e-006;
				scaleMax = 1000;
				scaleDefault = 2;
				font = "TahomaB";
				sizeEx = 0.0;
				maxSatelliteAlpha = 0.0;
				colorBackground[] = {0,0,0,0};
				colorLevels[] = {0,0,0,0};
				colorSea[] = {0,0,0,0};
				colorForest[] = {0,0,0,0};
				colorRocks[] = {0,0,0,0};
				colorCountlines[] = {0,0,0,0};
				colorMainCountlines[] = {0,0,0,0};
				colorCountlinesWater[] = {0,0,0,0};
				colorMainCountlinesWater[] = {0,0,0,0};
				colorPowerLines[] = {0,0,0,0};
				colorRailWay[] = {0,0,0,0};
				colorForestBorder[] = {0,0,0,0};
				colorRocksBorder[] = {0,0,0,0};
				colorNames[] = {0,0,0,0};
				colorInactive[] = {0,0,0,0};
				colorOutside[] = {0,0,0,0};
				colorText[] = {0,0,0,0};
				colorGrid[] = {0,0,0,0};
				colorGridMap[] = {0,0,0,0};
				colorTracks[] = {0,0,0,0};
				colorTracksFill[] = {0,0,0,0};
				colorRoads[] = {0,0,0,0};
				colorRoadsFill[] = {0,0,0,0};
				colorMainRoads[] = {0,0,0,0};
				colorMainRoadsFill[] = {0,0,0,0};
				ShowCountourInterval = 0;
				shadow = 0;
				text = "";
				alphaFadeStartScale = 0.0;
				alphaFadeEndScale = 0.0;
				fontLabel = "TahomaB";
				sizeExLabel = 0.0;
				fontGrid = "TahomaB";
				sizeExGrid = 0.0;
				fontUnits = "TahomaB";
				sizeExUnits = 0.0;
				fontNames = "TahomaB";
				sizeExNames = 0.0;
				fontInfo = "TahomaB";
				sizeExInfo = 0.0;
				fontLevel = "TahomaB";
				sizeExLevel = 0.0;
				stickX[] = {0.0,{ "Gamma",0,0.0 }};
				stickY[] = {0.0,{ "Gamma",0,0.0 }};
				ptsPerSquareSea = 0;
				ptsPerSquareTxt = 0;
				ptsPerSquareCLn = 0;
				ptsPerSquareExp = 0;
				ptsPerSquareCost = 0;
				ptsPerSquareFor = 0;
				ptsPerSquareForEdge = 0;
				ptsPerSquareRoad = 0;
				ptsPerSquareObj = 0;
				class Task
				{
					icon = "";
					color[] = {0,0,0,0};
					iconCreated = "";
					colorCreated[] = {0,0,0,0};
					iconCanceled = "";
					colorCanceled[] = {0,0,0,0};
					iconDone = "";
					colorDone[] = {0,0,0,0};
					iconFailed = "";
					colorFailed[] = {0,0,0,0};
					size = 0;
					importance = 0;
					coefMin = 0;
					coefMax = 0;
				};
				class CustomMark
				{
					icon = "";
					color[] = {0,0,0,0};
					size = 0;
					importance = 0;
					coefMin = 0;
					coefMax = 0;
				};
				class Bunker
				{
					icon = "";
					color[] = {0,0,0,0};
					size = 0;
					importance = 0;
					coefMin = 0;
					coefMax = 0;
				};
				class Bush
				{
					icon = "";
					color[] = {0,0,0,0};
					size = 0;
					importance = 0;
					coefMin = 0;
					coefMax = 0;
				};
				class BusStop
				{
					icon = "";
					color[] = {0,0,0,0};
					size = 0;
					importance = 0;
					coefMin = 0;
					coefMax = 0;
				};
				class Command
				{
					icon = "";
					color[] = {0,0,0,0};
					size = 0;
					importance = 0;
					coefMin = 0;
					coefMax = 0;
				};
				class Cross
				{
					icon = "";
					color[] = {0,0,0,0};
					size = 0;
					importance = 0;
					coefMin = 0;
					coefMax = 0;
				};
				class Fortress
				{
					icon = "";
					color[] = {0,0,0,0};
					size = 0;
					importance = 0;
					coefMin = 0;
					coefMax = 0;
				};
				class Fuelstation
				{
					icon = "";
					color[] = {0,0,0,0};
					size = 0;
					importance = 0;
					coefMin = 0;
					coefMax = 0;
				};
				class Fountain
				{
					icon = "";
					color[] = {0,0,0,0};
					size = 0;
					importance = 0;
					coefMin = 0;
					coefMax = 0;
				};
				class Hospital
				{
					icon = "";
					color[] = {0,0,0,0};
					size = 0;
					importance = 0;
					coefMin = 0;
					coefMax = 0;
				};
				class Chapel
				{
					icon = "";
					color[] = {0,0,0,0};
					size = 0;
					importance = 0;
					coefMin = 0;
					coefMax = 0;
				};
				class Church
				{
					icon = "";
					color[] = {0,0,0,0};
					size = 0;
					importance = 0;
					coefMin = 0;
					coefMax = 0;
				};
				class Lighthouse
				{
					icon = "";
					color[] = {0,0,0,0};
					size = 0;
					importance = 0;
					coefMin = 0;
					coefMax = 0;
				};
				class Quay
				{
					icon = "";
					color[] = {0,0,0,0};
					size = 0;
					importance = 0;
					coefMin = 0;
					coefMax = 0;
				};
				class Rock
				{
					icon = "";
					color[] = {0,0,0,0};
					size = 0;
					importance = 0;
					coefMin = 0;
					coefMax = 0;
				};
				class Ruin
				{
					icon = "";
					color[] = {0,0,0,0};
					size = 0;
					importance = 0;
					coefMin = 0;
					coefMax = 0;
				};
				class SmallTree
				{
					icon = "";
					color[] = {0,0,0,0};
					size = 0;
					importance = 0;
					coefMin = 0;
					coefMax = 0;
				};
				class Stack
				{
					icon = "";
					color[] = {0,0,0,0};
					size = 0;
					importance = 0;
					coefMin = 0;
					coefMax = 0;
				};
				class Tree
				{
					icon = "";
					color[] = {0,0,0,0};
					size = 0;
					importance = 0;
					coefMin = 0;
					coefMax = 0;
				};
				class Tourism
				{
					icon = "";
					color[] = {0,0,0,0};
					size = 0;
					importance = 0;
					coefMin = 0;
					coefMax = 0;
				};
				class Transmitter
				{
					icon = "";
					color[] = {0,0,0,0};
					size = 0;
					importance = 0;
					coefMin = 0;
					coefMax = 0;
				};
				class ViewTower
				{
					icon = "";
					color[] = {0,0,0,0};
					size = 0;
					importance = 0;
					coefMin = 0;
					coefMax = 0;
				};
				class Watertower
				{
					icon = "";
					color[] = {0,0,0,0};
					size = 0;
					importance = 0;
					coefMin = 0;
					coefMax = 0;
				};
				class Waypoint
				{
					icon = "";
					color[] = {0,0,0,0};
					size = 0;
					importance = 0;
					coefMin = 0;
					coefMax = 0;
				};
				class WaypointCompleted
				{
					icon = "";
					color[] = {0,0,0,0};
					size = 0;
					importance = 0;
					coefMin = 0;
					coefMax = 0;
				};
				class ActiveMarker
				{
					icon = "";
					color[] = {0,0,0,0};
					size = 0;
					importance = 0;
					coefMin = 0;
					coefMax = 0;
				};
				class PowerSolar
				{
					icon = "";
					color[] = {0,0,0,0};
					size = 0;
					importance = 0;
					coefMin = 0;
					coefMax = 0;
				};
				class PowerWave
				{
					icon = "";
					color[] = {0,0,0,0};
					size = 0;
					importance = 0;
					coefMin = 0;
					coefMax = 0;
				};
				class PowerWind
				{
					icon = "";
					color[] = {0,0,0,0};
					size = 0;
					importance = 0;
					coefMin = 0;
					coefMax = 0;
				};
				class Shipwreck
				{
					icon = "";
					color[] = {0,0,0,0};
					size = 0;
					importance = 0;
					coefMin = 0;
					coefMax = 0;
				};
};