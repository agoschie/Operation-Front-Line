/***************************************************************************
Definitions
****************************************************************************/
// Control types
#define CT_STATIC           0
#define CT_BUTTON           1
#define CT_EDIT             2
#define CT_SLIDER           3
#define CT_COMBO            4
#define CT_LISTBOX          5
#define CT_TOOLBOX          6
#define CT_CHECKBOXES       7
#define CT_PROGRESS         8
#define CT_HTML             9
#define CT_STATIC_SKEW      10
#define CT_ACTIVETEXT       11
#define CT_TREE             12
#define CT_STRUCTURED_TEXT  13
#define CT_CONTEXT_MENU     14
#define CT_CONTROLS_GROUP   15
#define CT_SHORTCUT_BUTTON  16 // Arma 2 - textured button

#define CT_XKEYDESC         40
#define CT_XBUTTON          41
#define CT_XLISTBOX         42
#define CT_XSLIDER          43
#define CT_XCOMBO           44
#define CT_ANIMATED_TEXTURE 45
#define CT_OBJECT           80
#define CT_OBJECT_ZOOM      81
#define CT_OBJECT_CONTAINER 82
#define CT_OBJECT_CONT_ANIM 83
#define CT_LINEBREAK        98
#define CT_USER             99
#define CT_MAP              100
#define CT_MAP_MAIN         101
#define CT_List_N_Box       102

// Static styles
#define ST_POS            0x0F
#define ST_HPOS           0x03
#define ST_VPOS           0x0C
#define ST_LEFT           0x00
#define ST_RIGHT          0x01
#define ST_CENTER         0x02
#define ST_DOWN           0x04
#define ST_UP             0x08
#define ST_VCENTER        0x0c

#define ST_TYPE           0xF0
#define ST_SINGLE         0
#define ST_MULTI          16
#define ST_TITLE_BAR      32
#define ST_PICTURE        48
#define ST_FRAME          64
#define ST_BACKGROUND     80
#define ST_GROUP_BOX      96
#define ST_GROUP_BOX2     112
#define ST_HUD_BACKGROUND 128
#define ST_TILE_PICTURE   144
#define ST_WITH_RECT      160
#define ST_LINE           176

#define ST_SHADOW         0x100
#define ST_NO_RECT        0x200
#define ST_KEEP_ASPECT_RATIO  0x800

#define ST_TITLE          ST_TITLE_BAR + ST_CENTER

// Slider styles
#define SL_DIR            0x400
#define SL_VERT           0
#define SL_HORZ           0x400

#define SL_TEXTURES       0x10

// Listbox styles
#define LB_TEXTURES       0x10
#define LB_MULTI          0x20

#define FontM             "TahomaB"

// Returns sizes and positions, 100 is length/height of the screen
#define SZ_SCREEN_UNIT_W(w) (w * safeZoneW / 100)
#define SZ_SCREEN_UNIT_H(h) (h * safeZoneH / 100)
#define POS_SCREEN_UNIT_X(x) (safeZoneX + (x * safeZoneW / 100))
#define POS_SCREEN_UNIT_Y(y) (safeZoneY + (y * safeZoneH / 100))
/***************************************************************************
End
****************************************************************************/

class DynamicSettings_RscText 
{ 
	access = 0; 
	type = CT_STATIC; 
	style = ST_POS; 
	w = 0.1; 
	h = 0.05; //x and y are not part of a global class since each rsctext will be positioned 'somewhere' 
	font = "TahomaB"; 
	sizeEx = 0.04; 
	colorBackground[] = {0,0,0,0}; 
	colorText[] = {1,1,1,1}; 
	text = ""; 
	fixedWidth = 0; 
	shadow = 0; 
};

class DynamicSettings_RscFrame
{
	access = 0;
	type = CT_STATIC;
	style = 64;
	shadow = 2;
	colorBackground[] = {0,0,0,0};
	colorText[] = {1,1,1,1};
	font = "TahomaB";
	sizeEx = 0.02;
	text = "";
};

class DynamicSettings_RscBackground
{
	access = 0;
	type = CT_STATIC;
	style = ST_POS;
	shadow = 0;
	colorBackground[] = {0,0,0,1};
	colorText[] = {1,1,1,1};
	font = "TahomaB";
	sizeEx = 0.02;
	text = "";
};

class DynamicSettings_RscBackgroundFrame
{
	access = 0;
	type = CT_STATIC;
	style = ST_BACKGROUND;
	shadow = 0;
	colorBackground[] = {0,0,0,1};
	colorText[] = {1,1,1,1};
	font = "TahomaB";
	sizeEx = 0.02;
	text = "";
};

class DynamicSettings_RscListBox 
{ 
	access = 0; 
	type = 5; 
	style = 0; 
	w = 0.4; 
	h = 0.4; 
	font = "TahomaB"; 
	sizeEx = 0.04; 
	rowHeight = 0.1; 
	colorText[] = {1,1,1,1}; 
	colorScrollbar[] = {1,1,0,1}; 
	colorSelect[] = {0,0,0,1}; 
	colorSelect2[] = {1,0.5,0,1}; 
	colorSelectBackground[] = {0.6,0.6,0.6,1}; 
	colorSelectBackground2[] = {0.2,0.2,0.2,1}; 
	colorBackground[] = {0,0,0,1}; 
	colorDisabled[] = {};
	maxHistoryDelay = 1.0; 
	soundSelect[] = {"",0.1,1}; 
	period = 1; 
	autoScrollSpeed = -1; 
	autoScrollDelay = 5; 
	autoScrollRewind = 0; 
	arrowEMPty = "#(argb,8,8,3)color(1,1,1,1)"; 
	arrowFull = "#(argb,8,8,3)color(1,1,1,1)"; 
	shadow = 0; 
	 class ScrollBar
	 { 
		color[] = {0.85,0.85,0,0.85}; 
		colorActive[] = {1,1,0,1}; 
		colorDisabled[] = {1,1,1,0.3}; 
		thumb = "#(argb,8,8,3)color(1,1,1,1)"; 
		arrowEMPty = "#(argb,8,8,3)color(1,1,1,1)"; 
		arrowFull = "#(argb,8,8,3)color(1,1,1,1)"; 
		border = "#(argb,8,8,3)color(1,1,1,1)"; 
		shadow = 0; 
	};
};

class DynamicSettings_RscButton 
{ 
	access = 0; 
	type = CT_BUTTON; 
	style = ST_LEFT; 
	x = 0; 
	y = 0; 
	w = 0.3; 
	h = 0.1; 
	text = ""; 
	font = "TahomaB"; 
	sizeEx = 0.04; 
	colorText[] = {0,0,0,1}; 
	colorDisabled[] = {0.3,0.3,0.3,1}; 
	colorBackground[] = {0.3,0.3,0.3,1}; 
	colorBackgroundDisabled[] = {0.6,0.6,0.6,1}; 
	colorBackgroundActive[] = {1,0.5,0,1}; 
	offsetX = 0.004; 
	offsetY = 0.004; 
	offsetPressedX = 0.002; 
	offsetPressedY = 0.002; 
	colorFocused[] = {0.3,0.3,0.3,1}; 
	colorShadow[] = {0,0,0,1}; 
	shadow = 0; 
	colorBorder[] = {0,0,0,1}; 
	borderSize = 0; 
	soundEnter[] = {"",0.1,1}; 
	soundPush[] = {"",0.1,1}; 
	soundClick[] = {"",0.1,1}; 
	soundEscape[] = {"",0.1,1}; 
};

class DynamicSettingsGUI
{
	idd = -1; 
	onLoad = "_this call DynamicSettings_LoadGUI";
	onUnload = "call DynamicSettings_CloseGUI";
	movingEnable = false; 
	enableSimulation = false;
	objects[] = { }; 
	
	class controlsBackground
	{
		class GUI_Static_BackgroundFrame : DynamicSettings_RscBackgroundFrame
		{
			idc = 1001;
			w = SZ_SCREEN_UNIT_W(70) + 0.01;
			h = SZ_SCREEN_UNIT_H(70) + (0.01 * 4/3);
			x = POS_SCREEN_UNIT_X(15) - 0.005;
			y = POS_SCREEN_UNIT_Y(15) - (0.005 * 4/3);
			colorBackground[] = {0.4,0.4,0.4,0};
			
		};
		
		class GUI_Static_Background : DynamicSettings_RscBackground
		{
			idc = 1002;
			style = ST_PICTURE;
			text = "DYNAMIC_SETTINGS\Pictures\BackgroundPic.paa";
			w = SZ_SCREEN_UNIT_W(70);
			h = SZ_SCREEN_UNIT_H(70);
			x = POS_SCREEN_UNIT_X(15);
			y = POS_SCREEN_UNIT_Y(15);
			colorBackground[] = {0.1,0.15,0.1,1};
			
		};
		
		class GUI_Static_SelectedSettingBackground : DynamicSettings_RscText
		{
			idc = 1003;
			x = POS_SCREEN_UNIT_X(41);
			y = POS_SCREEN_UNIT_Y(25);
			w = SZ_SCREEN_UNIT_W(37);
			h = SZ_SCREEN_UNIT_H(35);
			text = "";
			sizeEx = 0.038;
			colorText[] = {0,0,0,1};
			colorBackground[] = {0.33,0.33,0.33,1};
		};
		
		class GUI_Static_SelectedSettingText : DynamicSettings_RscText
		{
			idc = 1004;
			x = POS_SCREEN_UNIT_X(41);
			y = POS_SCREEN_UNIT_Y(25);
			w = SZ_SCREEN_UNIT_W(20);
			h = SZ_SCREEN_UNIT_H(5);
			text = "";
			sizeEx = 0.038;
			colorText[] = {0,0,0,1};
			colorBackground[] = {0.33,0.33,0.33,0};
		};
		
		class GUI_Static_DescriptionText : DynamicSettings_RscText
		{
			idc = 1005;
			x = POS_SCREEN_UNIT_X(41);
			y = POS_SCREEN_UNIT_Y(30);
			w = SZ_SCREEN_UNIT_W(20);
			h = SZ_SCREEN_UNIT_H(5);
			text = "DESCRIPTION: ";
			sizeEx = 0.038;
			colorText[] = {0,0,0,1};
			colorBackground[] = {0.33,0.33,0.33,0};
		};
		
		class GUI_Static_CoverFrame : DynamicSettings_RscText
		{
			idc = 1006;
			x = POS_SCREEN_UNIT_X(41);
			y = POS_SCREEN_UNIT_Y(25);
			w = SZ_SCREEN_UNIT_W(37);
			h = SZ_SCREEN_UNIT_H(35);
			colorText[] = {0,0,0,1};
			colorBackground[] = {0.33,0.33,0.33,0};
		};
	};
	
	class controls
	{
		
		class GUI_Button_Close : DynamicSettings_RscButton
		{
			idc = 1000;
			action = "closeDialog 0";
			x = POS_SCREEN_UNIT_X(78);
			y = POS_SCREEN_UNIT_Y(80);
			w = SZ_SCREEN_UNIT_W(5);
			h = SZ_SCREEN_UNIT_H(3);
			sizeEx = 0.02;
			text = "Close";
		};
		
		class GUI_Button_Save : DynamicSettings_RscButton
		{
			idc = 1007;
			action = "[] call DynamicSettings_SaveAllSettingsGUI";
			x = POS_SCREEN_UNIT_X(70);
			y = POS_SCREEN_UNIT_Y(80);
			w = SZ_SCREEN_UNIT_W(5);
			h = SZ_SCREEN_UNIT_H(3);
			sizeEx = 0.02;
			text = "SAVE";
		};
		
		class GUI_Button_Next : DynamicSettings_RscButton
		{
			idc = 1008;
			action = "[1] call DynamicSettings_ShiftSettingGUI";
			x = POS_SCREEN_UNIT_X(58);
			y = POS_SCREEN_UNIT_Y(62);
			w = SZ_SCREEN_UNIT_W(8);
			h = SZ_SCREEN_UNIT_H(4);
			sizeEx = 0.025;
			text = "Next <+>";
		};
		
		class GUI_Button_Last : DynamicSettings_RscButton
		{
			idc = 1009;
			action = "[-1] call DynamicSettings_ShiftSettingGUI";
			x = POS_SCREEN_UNIT_X(49);
			y = POS_SCREEN_UNIT_Y(62);
			w = SZ_SCREEN_UNIT_W(8);
			h = SZ_SCREEN_UNIT_H(4);
			sizeEx = 0.025;
			text = "Back <->";
		};
		
		class GUI_Static_TitleText : DynamicSettings_RscText
		{
			idc = 1010;
			x = POS_SCREEN_UNIT_X(15);
			y = POS_SCREEN_UNIT_Y(15);
			w = SZ_SCREEN_UNIT_W(20);
			h = SZ_SCREEN_UNIT_H(5);
			text = "<< SETTINGS >>";
			sizeEx = 0.05;
			colorText[] = {0,0,0,1};
			colorBackground[] = {0.33,0.33,0.33,1};
		};
		
		class GUI_Static_CurrentSettingText : DynamicSettings_RscText
		{
			idc = 1011;
			x = POS_SCREEN_UNIT_X(49);
			y = POS_SCREEN_UNIT_Y(67);
			w = SZ_SCREEN_UNIT_W(20);
			h = SZ_SCREEN_UNIT_H(5);
			text = "CURRENT:";
			sizeEx = 0.038;
			colorText[] = {0,0.8,0,1};
			colorBackground[] = {0.33,0.33,0.33,1};
		};
		
		class GUI_ListBox_SettingsList : DynamicSettings_RscListBox
		{
			idc = 1012;
			x = POS_SCREEN_UNIT_X(15);
			y = POS_SCREEN_UNIT_Y(25);
			w = SZ_SCREEN_UNIT_W(25);
			h = SZ_SCREEN_UNIT_H(50);
			colorBackground[] = {0.33,0.33,0.33,1};
			colorText[] = {0.5,0.45,0.5,1};
			onLBSelChanged = "_this call DynamicSettings_UpdateDisplayGUI";
		};
		
		class GUI_Static_SelectedSettingValue : DynamicSettings_RscText
		{
			idc = 1013;
			x = POS_SCREEN_UNIT_X(55);
			y = POS_SCREEN_UNIT_Y(25);
			w = SZ_SCREEN_UNIT_W(20);
			h = SZ_SCREEN_UNIT_H(5);
			colorText[] = {0.85,0.85,0.85,0.9};
			colorBackground[] = {0.33,0.33,0.33,0};
		};
		
		class GUI_Static_DescriptionValue : DynamicSettings_RscText
		{
			idc = 1014;
			style = 528;
			lineSpacing = 1;
			x = POS_SCREEN_UNIT_X(41);
			y = POS_SCREEN_UNIT_Y(35);
			w = SZ_SCREEN_UNIT_W(37);
			h = SZ_SCREEN_UNIT_H(25);
			colorText[] = {0.85,0.85,0.85,0.9};
			colorBackground[] = {0.33,0.33,0.33,0};
			sizeEx = 0.03;
		};
		
	};
};