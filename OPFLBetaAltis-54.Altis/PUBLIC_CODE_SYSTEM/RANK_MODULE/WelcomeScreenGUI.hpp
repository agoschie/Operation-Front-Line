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

#define FontM             "PuristaMedium"

// Returns sizes and positions, 100 is length/height of the screen
#define SCALAR 1
#define SZ_SCREEN_UNIT_W(w) (SCALAR * w * safeZoneW / 100)
#define SZ_SCREEN_UNIT_H(h) (SCALAR * h * safeZoneH / 100)
#define POS_SCREEN_UNIT_X(x) (safeZoneX + (SCALAR * x * safeZoneW / 100))
#define POS_SCREEN_UNIT_Y(y) (safeZoneY + (SCALAR * y * safeZoneH / 100))
#define TEXT_S(s) (SCALAR * sqrt(safeZoneW*safeZoneH*s*s))
/***************************************************************************
End
****************************************************************************/

class PCS_RNK_RscText 
{ 
	access = 0; 
	type = CT_STATIC; 
	style = ST_POS; 
	w = 0.1; 
	h = 0.05; //x and y are not part of a global class since each rsctext will be positioned 'somewhere' 
	font = "TahomaB"; 
	//sizeEx = 0.04; 
	sizeEx = TEXT_S(0.025);
	colorBackground[] = {0,0,0,0}; 
	colorText[] = {1,1,1,1}; 
	text = ""; 
	fixedWidth = 0; 
	shadow = 0; 
};

class PCS_RNK_RscFrame
{
	access = 0;
	type = CT_STATIC;
	style = 64;
	shadow = 2;
	colorBackground[] = {0,0,0,0};
	colorText[] = {1,1,1,1};
	font = "puristaMedium";
	sizeEx = 0.02;
	text = "";
};

class PCS_RNK_RscBackground
{
	access = 0;
	type = CT_STATIC;
	style = ST_POS;
	shadow = 0;
	colorBackground[] = {0,0,0,1};
	colorText[] = {1,1,1,1};
	font = "puristaMedium";
	sizeEx = 0.02;
	text = "";
};

class PCS_RNK_RscBackgroundFrame
{
	access = 0;
	type = CT_STATIC;
	style = ST_BACKGROUND;
	shadow = 0;
	colorBackground[] = {0,0,0,1};
	colorText[] = {1,1,1,1};
	font = "puristaMedium";
	sizeEx = 0.02;
	text = "";
};

class PCS_RNK_RscListBox 
{ 
	access = 0; 
	type = 5; 
	style = 0; 
	w = 0.4; 
	h = 0.4; 
	font = "TahomaB"; 
	sizeEx = TEXT_S(0.025);
	rowHeight = 0.1; 
	colorText[] = {1,1,1,1}; 
	colorScrollbar[] = {1,1,0,1}; 
	colorSelect[] = {1,1,1,1}; 
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
	 class ListScrollBar 
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

class PCS_RNK_RscButton 
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
	colorText[] = {0,1,0,1}; 
	colorDisabled[] = {0,0,0,0}; 
	colorBackground[] = {0,0,0,0}; 
	colorBackgroundDisabled[] = {0,0,0,0}; 
	colorBackgroundActive[] = {0,0.5,0,0.25}; 
	offsetX = 0.004; 
	offsetY = 0.004; 
	offsetPressedX = 0.002; 
	offsetPressedY = 0.002; 
	colorFocused[] = {0,0,0,0}; 
	colorShadow[] = {0,0,0,0}; 
	shadow = 0; 
	colorBorder[] = {0,0,0,1}; 
	borderSize = 0; 
	soundEnter[] = {"",0.1,1}; 
	soundPush[] = {"",0.1,1}; 
	soundClick[] = {"",0.1,1}; 
	soundEscape[] = {"",0.1,1}; 
};

class PCS_RNKGUI
{
	idd = -1; 
	onLoad = "_this call PCS_RNK_LoadGUI";
	onUnload = "_this call PCS_RNK_UnloadGUI";
	movingEnable = false; 
	enableSimulation = false;
	objects[] = { }; 
	
	class controlsBackground
	{
		class GUI_Static_BackgroundFrame : PCS_RNK_RscBackgroundFrame
		{
			idc = 1001;
			w = SZ_SCREEN_UNIT_W(100);
			h = SZ_SCREEN_UNIT_H(100);
			x = POS_SCREEN_UNIT_X(0);
			y = POS_SCREEN_UNIT_Y(0);
			colorBackground[] = {0,0,0,1};
			
		};
		
		class GUI_Static_Background : PCS_RNK_RscBackground
		{
			idc = 1002;
			w = SZ_SCREEN_UNIT_W(100);
			h = SZ_SCREEN_UNIT_H(100);
			x = POS_SCREEN_UNIT_X(0);
			y = POS_SCREEN_UNIT_Y(0);
			colorText[] = {1, 1, 1, 1};
			colorBackground[] = {0,0,0,1};
			
		};
	};
	
	class controls
	{
		class GUI_Button_Decline : PCS_RNK_RscButton
		{
			idc = 1003;
			action = "PCS_UNIQUE call PCS_RNK_DeclineButton";
			x = POS_SCREEN_UNIT_X(40);
			y = POS_SCREEN_UNIT_Y(85);
			w = SZ_SCREEN_UNIT_W(8);
			h = SZ_SCREEN_UNIT_H(4);
			//sizeEx = 0.025;
			sizeEx = TEXT_S(0.018);
			text = "Decline";
		};
		
		class GUI_Button_Agree : PCS_RNK_RscButton
		{
			idc = 1008;
			action = "PCS_UNIQUE call PCS_RNK_AgreedButton";
			x = POS_SCREEN_UNIT_X(55);
			y = POS_SCREEN_UNIT_Y(85);
			w = SZ_SCREEN_UNIT_W(8);
			h = SZ_SCREEN_UNIT_H(4);
			//sizeEx = 0.025;
			sizeEx = TEXT_S(0.018);
			text = "Agree";
		};
		
		
		class GUI_Static_TitleText : PCS_RNK_RscText
		{
			idc = 1004;
			x = POS_SCREEN_UNIT_X(15);
			y = POS_SCREEN_UNIT_Y(15);
			w = SZ_SCREEN_UNIT_W(25);
			h = SZ_SCREEN_UNIT_H(5);
			text = "RULES: ";
			//sizeEx = 0.05;
			sizeEx = TEXT_S(0.032);
			colorText[] = {0,1,0,1};
			colorBackground[] = {0,0,0,0};
		};
		
		class GUI_Static_Clock : PCS_RNK_RscText
		{
			idc = 1005;
			x = POS_SCREEN_UNIT_X(1);
			y = POS_SCREEN_UNIT_Y(94);
			w = SZ_SCREEN_UNIT_W(25);
			h = SZ_SCREEN_UNIT_H(5);
			text = "...";
			//sizeEx = 0.05;
			sizeEx = TEXT_S(0.032);
			colorText[] = {0,1,0,1};
			colorBackground[] = {0,0,0,0};
		};
		
		class GUI_Static_RulesList : PCS_RNK_RscText
		{
			idc = 1013;
			style = ST_MULTI;
			lineSpacing = 1;
			x = POS_SCREEN_UNIT_X(20);
			y = POS_SCREEN_UNIT_Y(24);
			w = SZ_SCREEN_UNIT_W(55);
			h = SZ_SCREEN_UNIT_H(54);
			text = __EVAL(loadFile "OPFLRules.txt");
			//sizeEx = 0.05;
			sizeEx = TEXT_S(0.018);
			colorText[] = {0,1,0,1};
			colorBackground[] = {0,0,0,0};
		};
	};
};