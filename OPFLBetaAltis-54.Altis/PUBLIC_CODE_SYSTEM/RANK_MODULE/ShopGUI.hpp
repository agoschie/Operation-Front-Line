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

#define R_SCREEN_UNIT_W(w) (SCALAR * (3/4) * w * safeZoneH / 100)
#define R_SCREEN_UNIT_H(h) (SCALAR * h * safeZoneH / 100)

#define UI_GRID_POS_X(x) (safeZoneX + (SCALAR * pixelW * pixelGrid * x))
#define UI_GRID_POS_Y(y) (safeZoneY + (SCALAR * pixelH * pixelGrid * y))
#define UI_GRID_W(w) (SCALAR * pixelW * pixelGrid * w) // One grid width
#define UI_GRID_H(h) (SCALAR * pixelH * pixelGrid * h) // One grid height
#define UI_GUTTER_W (pixelW * 2)       // One “gutter” width
#define UI_GUTTER_H (pixelH * 2)       // One “gutter” height

#define TEXT_S(s) (SCALAR * sqrt(safeZoneW*safeZoneH*s*s))
/***************************************************************************
End
****************************************************************************/

class PCS_SHOP_RscText 
{ 
	access = 0; 
	type = CT_STATIC; 
	style = ST_POS; 
	font = "TahomaB"; 
	//sizeEx = 0.04; 
	sizeEx = TEXT_S(0.025);
	colorBackground[] = {1,1,1,0}; 
	colorText[] = {1,1,1,1}; 
	text = ""; 
	fixedWidth = 0; 
	shadow = 0;
	w = SZ_SCREEN_UNIT_W(10);
	h = SZ_SCREEN_UNIT_H(12);
};

class PCS_SHOP_RscFrame
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

class PCS_SHOP_RscBackground
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

class PCS_SHOP_RscBackgroundFrame
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

class PCS_SHOP_RscListBox 
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

class PCS_SHOP_RscButton 
{ 
	access = 0; 
	type = CT_BUTTON; 
	style = ST_LEFT; 
	x = 0; 
	y = 0; 
	w = SZ_SCREEN_UNIT_W(5);
	h = SZ_SCREEN_UNIT_H(3);
	sizeEx = TEXT_S(0.018);
	text = " View";
	font = "TahomaB"; 
	colorText[] = {1,1,1,1}; 
	colorDisabled[] = {0.5,0.5,0.5,1}; 
	colorBackground[] = {0.46,0.502,0.495,1};  
	colorBackgroundDisabled[] = {0.7,0.7,0.7,0.5}; 
	colorBackgroundActive[] = {0,0.5,0,0.25}; 
	offsetX = 0.004; 
	offsetY = 0.004; 
	offsetPressedX = 0.002; 
	offsetPressedY = 0.002; 
	colorFocused[] = {0.46,0.502,0.495,1};
	colorShadow[] = {0.15,0.15,0.15,0.9}; 
	shadow = 0; 
	colorBorder[] = {0,0,0,1}; 
	borderSize = 0; 
	soundEnter[] = {"",0.1,1}; 
	soundPush[] = {"",0.1,1}; 
	soundClick[] = {"",0.1,1}; 
	soundEscape[] = {"",0.1,1}; 
};

class PCS_SHOP_RscControlsGroup  
{
	type = CT_CONTROLS_GROUP;
	idc = -1;
	style = ST_POS;
        x = 0;     y = 0; w = 1; h = 1;
	shadow=0;
	class VScrollbar 
	{
		width = 0.021;
		autoScrollSpeed = -1;
		autoScrollDelay = 5;
		autoScrollRewind = 0;
        shadow=1;
		color[] = {0.07,0.07,0.07,1};
		colorActive[] = {0.07,0.07,0.07,1};
		colorDisabled[] = {1,1,1,1};
		thumb = "#(argb,8,8,3)color(1,1,1,1)";
		arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
		arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
		border = "#(argb,8,8,3)color(1,1,1,1)";
	};
	
	class HScrollbar 
	{
		height = 0.028;
        shadow=0;
	};
	
	class ScrollBar
	{
        color[] = {0.07,0.07,0.07,1};
		colorActive[] = {0.07,0.07,0.07,1};
		colorDisabled[] = {1,1,1,1};
		thumb = "#(argb,8,8,3)color(1,1,1,1)";
		arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
		arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
		border = "#(argb,8,8,3)color(1,1,1,1)";
	};
	//class Controls{};// an empty class telling the engine, no custom, additional controls
};

class ShopDialog
{
	idd = -1; 
	movingEnable = false; 
	enableSimulation = false;
	onLoad = "_this call PCS_SHOP_Load";
	onUnload = "call PCS_SHOP_Unload";

	class controlsBackground
	{
		class GUI_Static_BackgroundFrameSide : PCS_SHOP_RscText
		{
			idc = 1007;
			x = POS_SCREEN_UNIT_X(65);
			y = POS_SCREEN_UNIT_Y(20); 
			w = SZ_SCREEN_UNIT_W(30); 
			h = SZ_SCREEN_UNIT_H(60); 
			colorBackground[] = {0,0,0,0.85};
			colorText[] = {1,1,1,1};
			text = "";
			sizeEx = TEXT_S(0.02);
		};
		class GUI_Static_BackgroundFrameOuter : PCS_SHOP_RscText
		{
			idc = 1001;
			x = POS_SCREEN_UNIT_X(15);
			y = POS_SCREEN_UNIT_Y(17.2); 
			w = SZ_SCREEN_UNIT_W(80); 
			h = SZ_SCREEN_UNIT_H(2.5); 
			colorBackground[] = {0,0.55,0,0.7};
			colorText[] = {1,1,1,1};
			text = "Shop";
			font = "PuristaBold";
			sizeEx = TEXT_S(0.02);
		};
		class GUI_Static_BackgroundFrameScroll : PCS_SHOP_RscText
		{
			idc = 1002;
			x = POS_SCREEN_UNIT_X(15);
			y = POS_SCREEN_UNIT_Y(20); 
			w = SZ_SCREEN_UNIT_W(50); 
			h = SZ_SCREEN_UNIT_H(60); 
			colorBackground[] = {0.4,0.4,0.4,1};
			colorText[] = {0.9,0.9,0.9,1};
			text = "";
			sizeEx = TEXT_S(0.02);
		};
		class GUI_Static_BackgroundFrameLine1 : PCS_SHOP_RscText
		{
			idc = -1;
			x = POS_SCREEN_UNIT_X(65);
			y = POS_SCREEN_UNIT_Y(44); 
			w = SZ_SCREEN_UNIT_W(30); 
			h = SZ_SCREEN_UNIT_H(0.2); 
			colorBackground[] = {0,0.5,0,0.2};
			colorText[] = {1,1,1,0};
			text = "";
			sizeEx = TEXT_S(0.02);
		};
		class GUI_Static_BackgroundFrameLine2 : PCS_SHOP_RscText
		{
			idc = -1;
			x = POS_SCREEN_UNIT_X(65);
			y = POS_SCREEN_UNIT_Y(40); 
			w = SZ_SCREEN_UNIT_W(30); 
			h = SZ_SCREEN_UNIT_H(0.2); 
			colorBackground[] = {0,0.5,0,0.2};
			colorText[] = {1,1,1,0};
			text = "";
			sizeEx = TEXT_S(0.02);
		};
		class GUI_Static_BackgroundFrameLine3 : PCS_SHOP_RscText
		{
			idc = -1;
			x = POS_SCREEN_UNIT_X(65);
			y = POS_SCREEN_UNIT_Y(36); 
			w = SZ_SCREEN_UNIT_W(30); 
			h = SZ_SCREEN_UNIT_H(0.2); 
			colorBackground[] = {0,0.5,0,0.2};
			colorText[] = {1,1,1,0};
			text = "";
			sizeEx = TEXT_S(0.02);
		};
		class GUI_Static_BackgroundFrameLine4 : PCS_SHOP_RscText
		{
			idc = -1;
			x = POS_SCREEN_UNIT_X(65);
			y = POS_SCREEN_UNIT_Y(32); 
			w = SZ_SCREEN_UNIT_W(30); 
			h = SZ_SCREEN_UNIT_H(0.2); 
			colorBackground[] = {0,0.5,0,0.2};
			colorText[] = {1,1,1,0};
			text = "";
			sizeEx = TEXT_S(0.02);
		};
		class GUI_Static_BackgroundFrameLine5 : PCS_SHOP_RscText
		{
			idc = -1;
			x = POS_SCREEN_UNIT_X(65);
			y = POS_SCREEN_UNIT_Y(28); 
			w = SZ_SCREEN_UNIT_W(30); 
			h = SZ_SCREEN_UNIT_H(0.2); 
			colorBackground[] = {0,0.5,0,0.2};
			colorText[] = {1,1,1,0};
			text = "";
			sizeEx = TEXT_S(0.02);
		};
		class GUI_Static_BackgroundFrameLine6 : PCS_SHOP_RscText
		{
			idc = -1;
			x = POS_SCREEN_UNIT_X(65);
			y = POS_SCREEN_UNIT_Y(24); 
			w = SZ_SCREEN_UNIT_W(30); 
			h = SZ_SCREEN_UNIT_H(0.2); 
			colorBackground[] = {0,0.5,0,0.2};
			colorText[] = {1,1,1,0};
			text = "";
			sizeEx = TEXT_S(0.02);
		};
		class GUI_Static_BackgroundFrameLine7 : PCS_SHOP_RscText
		{
			idc = -1;
			x = POS_SCREEN_UNIT_X(65);
			y = POS_SCREEN_UNIT_Y(20); 
			w = SZ_SCREEN_UNIT_W(30); 
			h = SZ_SCREEN_UNIT_H(0.2); 
			colorBackground[] = {0,0.5,0,0.2};
			colorText[] = {1,1,1,0};
			text = "";
			sizeEx = TEXT_S(0.02);
		};
		/*
		class GUI_Static_BackgroundFrameLine8 : PCS_SHOP_RscText
		{
			idc = -1;
			x = POS_SCREEN_UNIT_X(65);
			y = POS_SCREEN_UNIT_Y(20); 
			w = SZ_SCREEN_UNIT_W(30); 
			h = SZ_SCREEN_UNIT_H(0.2); 
			colorBackground[] = {0,0.5,0,0.2};
			colorText[] = {1,1,1,0};
			text = "";
			sizeEx = TEXT_S(0.02);
		};
		
		class GUI_Static_BackgroundFrameLine9 : PCS_SHOP_RscText
		{
			idc = -1;
			x = POS_SCREEN_UNIT_X(65);
			y = POS_SCREEN_UNIT_Y(28); 
			w = SZ_SCREEN_UNIT_W(30); 
			h = SZ_SCREEN_UNIT_H(0.2); 
			colorBackground[] = {0,0.5,0,0.2};
			colorText[] = {1,1,1,0};
			text = "";
			sizeEx = TEXT_S(0.02);
		};
		class GUI_Static_BackgroundFrameLine10 : PCS_SHOP_RscText
		{
			idc = -1;
			x = POS_SCREEN_UNIT_X(65);
			y = POS_SCREEN_UNIT_Y(26); 
			w = SZ_SCREEN_UNIT_W(30); 
			h = SZ_SCREEN_UNIT_H(0.2); 
			colorBackground[] = {0,0.5,0,0.2};
			colorText[] = {1,1,1,0};
			text = "";
			sizeEx = TEXT_S(0.02);
		};
		class GUI_Static_BackgroundFrameLine11 : PCS_SHOP_RscText
		{
			idc = -1;
			x = POS_SCREEN_UNIT_X(65);
			y = POS_SCREEN_UNIT_Y(24); 
			w = SZ_SCREEN_UNIT_W(30); 
			h = SZ_SCREEN_UNIT_H(0.2); 
			colorBackground[] = {0,0.5,0,0.2};
			colorText[] = {1,1,1,0};
			text = "";
			sizeEx = TEXT_S(0.02);
		};
		class GUI_Static_BackgroundFrameLine12 : PCS_SHOP_RscText
		{
			idc = -1;
			x = POS_SCREEN_UNIT_X(65);
			y = POS_SCREEN_UNIT_Y(22); 
			w = SZ_SCREEN_UNIT_W(30); 
			h = SZ_SCREEN_UNIT_H(0.2); 
			colorBackground[] = {0,0.5,0,0.2};
			colorText[] = {1,1,1,0};
			text = "";
			sizeEx = TEXT_S(0.02);
		};
		*/
		class GUI_Static_BackgroundFrameLine13 : PCS_SHOP_RscText
		{
			idc = -1;
			x = POS_SCREEN_UNIT_X(65) + SZ_SCREEN_UNIT_H(4) * (3/4);
			y = POS_SCREEN_UNIT_Y(20); 
			w = SZ_SCREEN_UNIT_H(0.2); 
			h = SZ_SCREEN_UNIT_H(24); 
			colorBackground[] = {0,0.5,0,0.2};
			colorText[] = {1,1,1,0};
			text = "";
			sizeEx = TEXT_S(0.02);
		};
		class GUI_Static_BackgroundFrameLine14 : PCS_SHOP_RscText
		{
			idc = -1;
			x = POS_SCREEN_UNIT_X(65) + SZ_SCREEN_UNIT_H(8) * (3/4);
			y = POS_SCREEN_UNIT_Y(20); 
			w = SZ_SCREEN_UNIT_H(0.2); 
			h = SZ_SCREEN_UNIT_H(24); 
			colorBackground[] = {0,0.5,0,0.2};
			colorText[] = {1,1,1,0};
			text = "";
			sizeEx = TEXT_S(0.02);
		};
		class GUI_Static_BackgroundFrameLine15 : PCS_SHOP_RscText
		{
			idc = -1;
			x = POS_SCREEN_UNIT_X(65) + SZ_SCREEN_UNIT_H(12) * (3/4);
			y = POS_SCREEN_UNIT_Y(20); 
			w = SZ_SCREEN_UNIT_H(0.2); 
			h = SZ_SCREEN_UNIT_H(24); 
			colorBackground[] = {0,0.5,0,0.2};
			colorText[] = {1,1,1,0};
			text = "";
			sizeEx = TEXT_S(0.02);
		};
		class GUI_Static_BackgroundFrameLine16 : PCS_SHOP_RscText
		{
			idc = -1;
			x = POS_SCREEN_UNIT_X(65) + SZ_SCREEN_UNIT_H(16) * (3/4);
			y = POS_SCREEN_UNIT_Y(20); 
			w = SZ_SCREEN_UNIT_H(0.2); 
			h = SZ_SCREEN_UNIT_H(24); 
			colorBackground[] = {0,0.5,0,0.2};
			colorText[] = {1,1,1,0};
			text = "";
			sizeEx = TEXT_S(0.02);
		};
		class GUI_Static_BackgroundFrameLine17 : PCS_SHOP_RscText
		{
			idc = -1;
			x = POS_SCREEN_UNIT_X(65) + SZ_SCREEN_UNIT_H(20) * (3/4);
			y = POS_SCREEN_UNIT_Y(20); 
			w = SZ_SCREEN_UNIT_H(0.2); 
			h = SZ_SCREEN_UNIT_H(24); 
			colorBackground[] = {0,0.5,0,0.2};
			colorText[] = {1,1,1,0};
			text = "";
			sizeEx = TEXT_S(0.02);
		};
		class GUI_Static_BackgroundFrameLine18 : PCS_SHOP_RscText
		{
			idc = -1;
			x = POS_SCREEN_UNIT_X(65) + SZ_SCREEN_UNIT_H(24) * (3/4);
			y = POS_SCREEN_UNIT_Y(20); 
			w = SZ_SCREEN_UNIT_H(0.2); 
			h = SZ_SCREEN_UNIT_H(24); 
			colorBackground[] = {0,0.5,0,0.2};
			colorText[] = {1,1,1,0};
			text = "";
			sizeEx = TEXT_S(0.02);
		};
		class GUI_Static_BackgroundFrameLine19 : PCS_SHOP_RscText
		{
			idc = -1;
			x = POS_SCREEN_UNIT_X(65) + SZ_SCREEN_UNIT_H(28) * (3/4);
			y = POS_SCREEN_UNIT_Y(20); 
			w = SZ_SCREEN_UNIT_H(0.2); 
			h = SZ_SCREEN_UNIT_H(24); 
			colorBackground[] = {0,0.5,0,0.2};
			colorText[] = {1,1,1,0};
			text = "";
			sizeEx = TEXT_S(0.02);
		};
		class GUI_Static_BackgroundFrameLine20 : PCS_SHOP_RscText
		{
			idc = -1;
			x = POS_SCREEN_UNIT_X(65) + SZ_SCREEN_UNIT_H(32) * (3/4);
			y = POS_SCREEN_UNIT_Y(20); 
			w = SZ_SCREEN_UNIT_H(0.2); 
			h = SZ_SCREEN_UNIT_H(24); 
			colorBackground[] = {0,0.5,0,0.2};
			colorText[] = {1,1,1,0};
			text = "";
			sizeEx = TEXT_S(0.02);
		};
		class GUI_Static_BackgroundFrameLine21 : PCS_SHOP_RscText
		{
			idc = -1;
			x = POS_SCREEN_UNIT_X(65) + SZ_SCREEN_UNIT_H(36) * (3/4);
			y = POS_SCREEN_UNIT_Y(20); 
			w = SZ_SCREEN_UNIT_H(0.2); 
			h = SZ_SCREEN_UNIT_H(24); 
			colorBackground[] = {0,0.5,0,0.2};
			colorText[] = {1,1,1,0};
			text = "";
			sizeEx = TEXT_S(0.02);
		};
		class GUI_Static_BackgroundFrameLine22 : PCS_SHOP_RscText
		{
			idc = -1;
			x = POS_SCREEN_UNIT_X(65) + SZ_SCREEN_UNIT_H(40) * (3/4);
			y = POS_SCREEN_UNIT_Y(20); 
			w = SZ_SCREEN_UNIT_H(0.2); 
			h = SZ_SCREEN_UNIT_H(24); 
			colorBackground[] = {0,0.5,0,0.2};
			colorText[] = {1,1,1,0};
			text = "";
			sizeEx = TEXT_S(0.02);
		};
		class GUI_Static_BackgroundFrameLine23 : PCS_SHOP_RscText
		{
			idc = -1;
			x = POS_SCREEN_UNIT_X(65) + SZ_SCREEN_UNIT_H(44) * (3/4);
			y = POS_SCREEN_UNIT_Y(20); 
			w = SZ_SCREEN_UNIT_H(0.2); 
			h = SZ_SCREEN_UNIT_H(24); 
			colorBackground[] = {0,0.5,0,0.2};
			colorText[] = {1,1,1,0};
			text = "";
			sizeEx = TEXT_S(0.02);
		};
		class GUI_Static_BackgroundFrameLine24 : PCS_SHOP_RscText
		{
			idc = -1;
			x = POS_SCREEN_UNIT_X(65) + SZ_SCREEN_UNIT_H(48) * (3/4);
			y = POS_SCREEN_UNIT_Y(20); 
			w = SZ_SCREEN_UNIT_H(0.2); 
			h = SZ_SCREEN_UNIT_H(24); 
			colorBackground[] = {0,0.5,0,0.2};
			colorText[] = {1,1,1,0};
			text = "";
			sizeEx = TEXT_S(0.02);
		};
		/*
		class GUI_Static_BackgroundFrameLine25 : PCS_SHOP_RscText
		{
			idc = -1;
			x = POS_SCREEN_UNIT_X(65) + SZ_SCREEN_UNIT_H(26) * (3/4);
			y = POS_SCREEN_UNIT_Y(20); 
			w = SZ_SCREEN_UNIT_H(0.2); 
			h = SZ_SCREEN_UNIT_H(24); 
			colorBackground[] = {0,0.5,0,0.2};
			colorText[] = {1,1,1,0};
			text = "";
			sizeEx = TEXT_S(0.02);
		};
		class GUI_Static_BackgroundFrameLine26 : PCS_SHOP_RscText
		{
			idc = -1;
			x = POS_SCREEN_UNIT_X(65) + SZ_SCREEN_UNIT_H(28) * (3/4);
			y = POS_SCREEN_UNIT_Y(20); 
			w = SZ_SCREEN_UNIT_H(0.2); 
			h = SZ_SCREEN_UNIT_H(24); 
			colorBackground[] = {0,0.5,0,0.2};
			colorText[] = {1,1,1,0};
			text = "";
			sizeEx = TEXT_S(0.02);
		};
		class GUI_Static_BackgroundFrameLine27 : PCS_SHOP_RscText
		{
			idc = -1;
			x = POS_SCREEN_UNIT_X(65) + SZ_SCREEN_UNIT_H(30) * (3/4);
			y = POS_SCREEN_UNIT_Y(20); 
			w = SZ_SCREEN_UNIT_H(0.2); 
			h = SZ_SCREEN_UNIT_H(24); 
			colorBackground[] = {0,0.5,0,0.2};
			colorText[] = {1,1,1,0};
			text = "";
			sizeEx = TEXT_S(0.02);
		};
		
		class GUI_Static_BackgroundFrameLine28 : PCS_SHOP_RscText
		{
			idc = -1;
			x = POS_SCREEN_UNIT_X(65) + SZ_SCREEN_UNIT_H(32) * (3/4);
			y = POS_SCREEN_UNIT_Y(20); 
			w = SZ_SCREEN_UNIT_H(0.2); 
			h = SZ_SCREEN_UNIT_H(24); 
			colorBackground[] = {0,0.5,0,0.2};
			colorText[] = {1,1,1,0};
			text = "";
			sizeEx = TEXT_S(0.02);
		};
		class GUI_Static_BackgroundFrameLine29 : PCS_SHOP_RscText
		{
			idc = -1;
			x = POS_SCREEN_UNIT_X(65) + SZ_SCREEN_UNIT_H(34) * (3/4);
			y = POS_SCREEN_UNIT_Y(20); 
			w = SZ_SCREEN_UNIT_H(0.2); 
			h = SZ_SCREEN_UNIT_H(24); 
			colorBackground[] = {0,0.5,0,0.2};
			colorText[] = {1,1,1,0};
			text = "";
			sizeEx = TEXT_S(0.02);
		};
		class GUI_Static_BackgroundFrameLine30 : PCS_SHOP_RscText
		{
			idc = -1;
			x = POS_SCREEN_UNIT_X(65) + SZ_SCREEN_UNIT_H(36) * (3/4);
			y = POS_SCREEN_UNIT_Y(20); 
			w = SZ_SCREEN_UNIT_H(0.2); 
			h = SZ_SCREEN_UNIT_H(24); 
			colorBackground[] = {0,0.5,0,0.2};
			colorText[] = {1,1,1,0};
			text = "";
			sizeEx = TEXT_S(0.02);
		};
		class GUI_Static_BackgroundFrameLine31 : PCS_SHOP_RscText
		{
			idc = -1;
			x = POS_SCREEN_UNIT_X(65) + SZ_SCREEN_UNIT_H(38) * (3/4);
			y = POS_SCREEN_UNIT_Y(20); 
			w = SZ_SCREEN_UNIT_H(0.2); 
			h = SZ_SCREEN_UNIT_H(24); 
			colorBackground[] = {0,0.5,0,0.2};
			colorText[] = {1,1,1,0};
			text = "";
			sizeEx = TEXT_S(0.02);
		};
		*/
		class GUI_Static_BackgroundFrameSideGrey : PCS_SHOP_RscText
		{
			idc = -1;
			x = POS_SCREEN_UNIT_X(65);
			y = POS_SCREEN_UNIT_Y(44); 
			w = SZ_SCREEN_UNIT_W(30); 
			h = SZ_SCREEN_UNIT_H(36); 
			colorBackground[] = {0.48,0.522,0.515,1};
			colorText[] = {1,1,1,0};
			text = "";
			sizeEx = TEXT_S(0.02);
		};
		
		
	};
	
	class controls
	{
	class MyControls : PCS_SHOP_RscControlsGroup
	{
		x = POS_SCREEN_UNIT_X(15); //(safeZoneX + (SafezoneW * 0.0363));  // scalability code which resizes correctly no matter what gui size or screen dimensions is used
		y = POS_SCREEN_UNIT_Y(20); //(safeZoneY + (SafezoneH * 0.132));   // scalability code which resizes correctly no matter what gui size or screen dimensions is used
		w = SZ_SCREEN_UNIT_W(50); //(SafezoneW  * 0.31);                 // scalability code which resizes correctly no matter what gui size or screen dimensions is used
		h = SZ_SCREEN_UNIT_H(60); //(SafezoneH  * 0.752);                // scalability code which resizes correctly no matter what gui size or screen dimensions is used
		colorBackground[] = {0,0,0,1};
		
		class controls
		{
			class GUI_Static_BackgroundFrameInner : PCS_SHOP_RscBackgroundFrame
			{
				idc = 1003;
				w = SZ_SCREEN_UNIT_W(50);
				h = SZ_SCREEN_UNIT_H(250);
				x = 0;
				y = 0;
				colorBackground[] = {0.48,0.522,0.515,1};
				
			};
			
			class GUI_Static_Background : PCS_SHOP_RscBackground
			{
				idc = 1004;
				w = SZ_SCREEN_UNIT_W(50);
				h = SZ_SCREEN_UNIT_H(250);
				x = 0;
				y = 0;
				colorText[] = {1, 1, 1, 1};
				colorBackground[] = {0.48,0.522,0.515,1};
				
			};
			
			//starts at idc 1008
			//APC's
			class GUI_Static_APCTitle : PCS_SHOP_RscText
			{
				idc  = -1;
				x = SZ_SCREEN_UNIT_W(0.4); 
				y = SZ_SCREEN_UNIT_H(0.5);
				w = SZ_SCREEN_UNIT_W(20);
				h = SZ_SCREEN_UNIT_H(2.8); 
				colorBackground[] = {0,0.55,0,0.7};
				colorText[] = {1,1,1,1};
				font = "PuristaBold";
				text = "APC's";
				sizeEx = TEXT_S(0.02);
				
			};
			class GUI_Static_APCCount : PCS_SHOP_RscText
			{
				idc  = 1201;
				x = SZ_SCREEN_UNIT_W(20.5); 
				y = SZ_SCREEN_UNIT_H(0.5);
				w = SZ_SCREEN_UNIT_W(5);
				h = SZ_SCREEN_UNIT_H(2.8); 
				colorBackground[] = {0,0,0,0};
				colorText[] = {0,1,0,1};
				text = "0 / 1";
				sizeEx = TEXT_S(0.02);
				
			};
			
			class GUI_Button_View1 : PCS_SHOP_RscButton
			{
				idc = 1008;
				action = "1 call PCS_SHOP_View";
				x = SZ_SCREEN_UNIT_W(4);
				y = SZ_SCREEN_UNIT_H(18);
			};
			
			class GUI_Button_View2 : PCS_SHOP_RscButton
			{
				idc = 1009;
				action = "2 call PCS_SHOP_View";
				x = SZ_SCREEN_UNIT_W(14);
				y = SZ_SCREEN_UNIT_H(18);
			};
			
			class GUI_Button_View3 : PCS_SHOP_RscButton
			{
				idc = 1010;
				action = "3 call PCS_SHOP_View";
				x = SZ_SCREEN_UNIT_W(24);
				y = SZ_SCREEN_UNIT_H(18);
			};
			
			class GUI_Button_View4 : PCS_SHOP_RscButton
			{
				idc = 1011;
				action = "4 call PCS_SHOP_View";
				x = SZ_SCREEN_UNIT_W(34);
				y = SZ_SCREEN_UNIT_H(18);
			};
			
			class GUI_Button_View5 : PCS_SHOP_RscButton
			{
				idc = 1012;
				action = "5 call PCS_SHOP_View";
				x = SZ_SCREEN_UNIT_W(4);
				y = SZ_SCREEN_UNIT_H(35);
			};
			
			class GUI_Button_View6 : PCS_SHOP_RscButton
			{
				idc = 1013;
				action = "6 call PCS_SHOP_View";
				x = SZ_SCREEN_UNIT_W(14);
				y = SZ_SCREEN_UNIT_H(35);
			};
			
			class GUI_Button_View7 : PCS_SHOP_RscButton
			{
				idc = 1014;
				action = "7 call PCS_SHOP_View";
				x = SZ_SCREEN_UNIT_W(24);
				y = SZ_SCREEN_UNIT_H(35);
			};
			
			class GUI_Static_PictureBox1 : PCS_SHOP_RscText
			{
				idc = 1108;
				style = ST_PICTURE;
				text = __EVAL(getText (configfile >> "CfgVehicles" >> "O_APC_Wheeled_02_rcws_F" >> "editorPreview"));
				x = SZ_SCREEN_UNIT_W(2);
				y = SZ_SCREEN_UNIT_H(5);
			};
			
			class GUI_Static_PictureBox2 : PCS_SHOP_RscText
			{
				idc = 1109;
				style = ST_PICTURE;
				text = __EVAL(getText (configFile >> "CfgVehicles" >> "O_APC_Tracked_02_cannon_F" >> "editorPreview"));
				x = SZ_SCREEN_UNIT_W(12);
				y = SZ_SCREEN_UNIT_H(5);
			};
			
			class GUI_Static_PictureBox3 : PCS_SHOP_RscText
			{
				idc = 1110;
				style = ST_PICTURE;
				text = __EVAL(getText (configFile >> "CfgVehicles" >> "B_APC_Wheeled_01_cannon_F" >> "editorPreview"));
				x = SZ_SCREEN_UNIT_W(22);
				y = SZ_SCREEN_UNIT_H(5);
			};
			
			class GUI_Static_PictureBox4 : PCS_SHOP_RscText
			{
				idc = 1111;
				style = ST_PICTURE;
				text = __EVAL(getText (configFile >> "CfgVehicles" >> "B_APC_Tracked_01_rcws_F" >> "editorPreview"));
				x = SZ_SCREEN_UNIT_W(32);
				y = SZ_SCREEN_UNIT_H(5);
			};
			
			class GUI_Static_PictureBox5 : PCS_SHOP_RscText
			{
				idc = 1112;
				style = ST_PICTURE;
				text = __EVAL(getText (configFile >> "CfgVehicles" >> "B_APC_Tracked_01_CRV_F" >> "editorPreview"));
				x = SZ_SCREEN_UNIT_W(2);
				y = SZ_SCREEN_UNIT_H(22);
			};
			
			class GUI_Static_PictureBox6 : PCS_SHOP_RscText
			{
				idc = 1113;
				style = ST_PICTURE;
				text = __EVAL(getText (configFile >> "CfgVehicles" >> "I_APC_tracked_03_cannon_F" >> "editorPreview"));
				x = SZ_SCREEN_UNIT_W(12);
				y = SZ_SCREEN_UNIT_H(22);
			};
			
			class GUI_Static_PictureBox7 : PCS_SHOP_RscText
			{
				idc = 1114;
				style = ST_PICTURE;
				text = __EVAL(getText (configFile >> "CfgVehicles" >> "I_APC_Wheeled_03_cannon_F" >> "editorPreview"));
				x = SZ_SCREEN_UNIT_W(22);
				y = SZ_SCREEN_UNIT_H(22);
			};
			
			//AFV's
			class GUI_Static_AFVTitle : PCS_SHOP_RscText
			{
				idc  = -1;
				x = SZ_SCREEN_UNIT_W(0.4); 
				y = SZ_SCREEN_UNIT_H(0.5) + SZ_SCREEN_UNIT_H(45);
				w = SZ_SCREEN_UNIT_W(20); 
				h = SZ_SCREEN_UNIT_H(2.8); 
				colorBackground[] = {0,0.55,0,0.7};
				colorText[] = {1,1,1,1};
				text = "AFV's";
				font = "PuristaBold";
				sizeEx = TEXT_S(0.02);
				
			};
			class GUI_Static_AFVCount : PCS_SHOP_RscText
			{
				idc  = 1202;
				x = SZ_SCREEN_UNIT_W(20.5); 
				y = SZ_SCREEN_UNIT_H(0.5) + SZ_SCREEN_UNIT_H(45);
				w = SZ_SCREEN_UNIT_W(5); 
				h = SZ_SCREEN_UNIT_H(2.8); 
				colorBackground[] = {0,0,0,0};
				colorText[] = {0,1,0,1};
				text = "0 / 1";
				sizeEx = TEXT_S(0.02);
				
			};
			
			class GUI_Button_View8 : PCS_SHOP_RscButton
			{
				idc = 1015;
				action = "8 call PCS_SHOP_View";
				x = SZ_SCREEN_UNIT_W(4);
				y = SZ_SCREEN_UNIT_H(18) + SZ_SCREEN_UNIT_H(45);
			};
			
			class GUI_Button_View9 : PCS_SHOP_RscButton
			{
				idc = 1016;
				action = "9 call PCS_SHOP_View";
				x = SZ_SCREEN_UNIT_W(14);
				y = SZ_SCREEN_UNIT_H(18) + SZ_SCREEN_UNIT_H(45);
			};
			
			class GUI_Button_View10 : PCS_SHOP_RscButton
			{
				idc = 1017;
				action = "10 call PCS_SHOP_View";
				x = SZ_SCREEN_UNIT_W(24);
				y = SZ_SCREEN_UNIT_H(18) + SZ_SCREEN_UNIT_H(45);
			};
			
			class GUI_Button_View11 : PCS_SHOP_RscButton
			{
				idc = 1018;
				action = "11 call PCS_SHOP_View";
				x = SZ_SCREEN_UNIT_W(34);
				y = SZ_SCREEN_UNIT_H(18) + SZ_SCREEN_UNIT_H(45);
			};
			
			class GUI_Button_View12 : PCS_SHOP_RscButton
			{
				idc = 1019;
				action = "12 call PCS_SHOP_View";
				x = SZ_SCREEN_UNIT_W(4);
				y = SZ_SCREEN_UNIT_H(35) + SZ_SCREEN_UNIT_H(45);
			};
			
			class GUI_Static_PictureBox8 : PCS_SHOP_RscText
			{
				idc = 1115;
				style = ST_PICTURE;
				text = __EVAL(getText (configFile >> "CfgVehicles" >> "O_APC_Tracked_02_AA_F" >> "editorPreview"));
				x = SZ_SCREEN_UNIT_W(2);
				y = SZ_SCREEN_UNIT_H(5) + SZ_SCREEN_UNIT_H(45);
			};
			
			class GUI_Static_PictureBox9 : PCS_SHOP_RscText
			{
				idc = 1116;
				style = ST_PICTURE;
				text = __EVAL(getText (configFile >> "CfgVehicles" >> "B_APC_Tracked_01_AA_F" >> "editorPreview"));
				x = SZ_SCREEN_UNIT_W(12);
				y = SZ_SCREEN_UNIT_H(5) + SZ_SCREEN_UNIT_H(45);
			};
			
			class GUI_Static_PictureBox10 : PCS_SHOP_RscText
			{
				idc = 1117;
				style = ST_PICTURE;
				text = __EVAL(getText (configFile >> "CfgVehicles" >> "O_MBT_02_arty_F" >> "editorPreview"));
				x = SZ_SCREEN_UNIT_W(22);
				y = SZ_SCREEN_UNIT_H(5) + SZ_SCREEN_UNIT_H(45);
			};
			
			class GUI_Static_PictureBox11 : PCS_SHOP_RscText
			{
				idc = 1118;
				style = ST_PICTURE;
				text = __EVAL(getText (configFile >> "CfgVehicles" >> "B_MBT_01_arty_F" >> "editorPreview"));
				x = SZ_SCREEN_UNIT_W(32);
				y = SZ_SCREEN_UNIT_H(5) + SZ_SCREEN_UNIT_H(45);
			};
			
			class GUI_Static_PictureBox12 : PCS_SHOP_RscText
			{
				idc = 1119;
				style = ST_PICTURE;
				text = __EVAL(getText (configFile >> "CfgVehicles" >> "B_MBT_01_mlrs_F" >> "editorPreview"));
				x = SZ_SCREEN_UNIT_W(2);
				y = SZ_SCREEN_UNIT_H(22) + SZ_SCREEN_UNIT_H(45);
			};
			
			//Tanks
			class GUI_Static_TankTitle : PCS_SHOP_RscText
			{
				idc  = -1;
				x = SZ_SCREEN_UNIT_W(0.4); 
				y = SZ_SCREEN_UNIT_H(0.5) + SZ_SCREEN_UNIT_H(90);
				w = SZ_SCREEN_UNIT_W(20); 
				h = SZ_SCREEN_UNIT_H(2.8); 
				colorBackground[] = {0,0.55,0,0.7};
				colorText[] = {1,1,1,1};
				text = "Tanks";
				font = "PuristaBold";
				sizeEx = TEXT_S(0.02);
			};
			class GUI_Static_TankCount : PCS_SHOP_RscText
			{
				idc  = 1203;
				x = SZ_SCREEN_UNIT_W(20.5); 
				y = SZ_SCREEN_UNIT_H(0.5) + SZ_SCREEN_UNIT_H(90);
				w = SZ_SCREEN_UNIT_W(5); 
				h = SZ_SCREEN_UNIT_H(2.8); 
				colorBackground[] = {0,0,0,0};
				colorText[] = {0,1,0,1};
				text = "0 / 1";
				sizeEx = TEXT_S(0.02);
			};
			
			class GUI_Button_View13 : PCS_SHOP_RscButton
			{
				idc = 1020;
				action = "13 call PCS_SHOP_View";
				x = SZ_SCREEN_UNIT_W(4);
				y = SZ_SCREEN_UNIT_H(18) + SZ_SCREEN_UNIT_H(90);
			};
			
			class GUI_Button_View14 : PCS_SHOP_RscButton
			{
				idc = 1021;
				action = "14 call PCS_SHOP_View";
				x = SZ_SCREEN_UNIT_W(14);
				y = SZ_SCREEN_UNIT_H(18) + SZ_SCREEN_UNIT_H(90);
			};
			
			class GUI_Static_PictureBox13 : PCS_SHOP_RscText
			{
				idc = 1120;
				style = ST_PICTURE;
				text = __EVAL(getText (configFile >> "CfgVehicles" >> "I_MBT_03_cannon_F" >> "editorPreview"));
				x = SZ_SCREEN_UNIT_W(2);
				y = SZ_SCREEN_UNIT_H(5) + SZ_SCREEN_UNIT_H(90);
			};
			
			class GUI_Static_PictureBox14 : PCS_SHOP_RscText
			{
				idc = 1121;
				style = ST_PICTURE;
				text = __EVAL(getText (configFile >> "CfgVehicles" >> "B_MBT_01_TUSK_F" >> "editorPreview"));
				x = SZ_SCREEN_UNIT_W(12);
				y = SZ_SCREEN_UNIT_H(5) + SZ_SCREEN_UNIT_H(90);
			};
			
			//Helicopters
			class GUI_Static_HelicopterTitle : PCS_SHOP_RscText
			{
				idc  = -1;
				x = SZ_SCREEN_UNIT_W(0.4); 
				y = SZ_SCREEN_UNIT_H(0.5) + SZ_SCREEN_UNIT_H(135);
				w = SZ_SCREEN_UNIT_W(20); 
				h = SZ_SCREEN_UNIT_H(2.8); 
				colorBackground[] = {0,0.55,0,0.7};
				colorText[] = {1,1,1,1};
				text = "Helicopters";
				font = "PuristaBold";
				sizeEx = TEXT_S(0.02);
				
			};
			class GUI_Static_HelicopterCount : PCS_SHOP_RscText
			{
				idc  = 1204;
				x = SZ_SCREEN_UNIT_W(20.5); 
				y = SZ_SCREEN_UNIT_H(0.5) + SZ_SCREEN_UNIT_H(135);
				w = SZ_SCREEN_UNIT_W(5); 
				h = SZ_SCREEN_UNIT_H(2.8); 
				colorBackground[] = {0,0,0,0};
				colorText[] = {0,1,0,1};
				text = "0 / 1";
				sizeEx = TEXT_S(0.02);
				
			};
			
			class GUI_Button_View15 : PCS_SHOP_RscButton
			{
				idc = 1022;
				action = "15 call PCS_SHOP_View";
				x = SZ_SCREEN_UNIT_W(4);
				y = SZ_SCREEN_UNIT_H(18) + SZ_SCREEN_UNIT_H(135);
			};
			
			class GUI_Button_View16 : PCS_SHOP_RscButton
			{
				idc = 1023;
				action = "16 call PCS_SHOP_View";
				x = SZ_SCREEN_UNIT_W(14);
				y = SZ_SCREEN_UNIT_H(18) + SZ_SCREEN_UNIT_H(135);
			};
			
			class GUI_Button_View17 : PCS_SHOP_RscButton
			{
				idc = 1024;
				action = "17 call PCS_SHOP_View";
				x = SZ_SCREEN_UNIT_W(24);
				y = SZ_SCREEN_UNIT_H(18) + SZ_SCREEN_UNIT_H(135);
			};
			
			class GUI_Button_View18 : PCS_SHOP_RscButton
			{
				idc = 1025;
				action = "18 call PCS_SHOP_View";
				x = SZ_SCREEN_UNIT_W(34);
				y = SZ_SCREEN_UNIT_H(18) + SZ_SCREEN_UNIT_H(135);
			};
			
			class GUI_Button_View19 : PCS_SHOP_RscButton
			{
				idc = 1026;
				action = "19 call PCS_SHOP_View";
				x = SZ_SCREEN_UNIT_W(4);
				y = SZ_SCREEN_UNIT_H(35) + SZ_SCREEN_UNIT_H(135);
			};
			
			class GUI_Static_PictureBox15 : PCS_SHOP_RscText
			{
				idc = 1122;
				style = ST_PICTURE;
				text = __EVAL(getText (configFile >> "CfgVehicles" >> "B_Heli_Transport_01_F" >> "editorPreview"));
				x = SZ_SCREEN_UNIT_W(2);
				y = SZ_SCREEN_UNIT_H(5) + SZ_SCREEN_UNIT_H(135);
			};
			
			class GUI_Static_PictureBox16 : PCS_SHOP_RscText
			{
				idc = 1123;
				style = ST_PICTURE;
				text = __EVAL(getText (configFile >> "CfgVehicles" >> "O_Heli_Light_02_dynamicLoadout_F" >> "editorPreview"));
				x = SZ_SCREEN_UNIT_W(12);
				y = SZ_SCREEN_UNIT_H(5) + SZ_SCREEN_UNIT_H(135);
			};
			
			class GUI_Static_PictureBox17 : PCS_SHOP_RscText
			{
				idc = 1124;
				style = ST_PICTURE;
				text = __EVAL(getText (configFile >> "CfgVehicles" >> "I_Heli_light_03_dynamicLoadout_F" >> "editorPreview"));
				x = SZ_SCREEN_UNIT_W(22);
				y = SZ_SCREEN_UNIT_H(5) + SZ_SCREEN_UNIT_H(135);
			};
			
			class GUI_Static_PictureBox18 : PCS_SHOP_RscText
			{
				idc = 1125;
				style = ST_PICTURE;
				text = __EVAL(getText (configFile >> "CfgVehicles" >> "O_Heli_Attack_02_black_F" >> "editorPreview"));
				x = SZ_SCREEN_UNIT_W(32);
				y = SZ_SCREEN_UNIT_H(5) + SZ_SCREEN_UNIT_H(135);
			};
			
			class GUI_Static_PictureBox19 : PCS_SHOP_RscText
			{
				idc = 1126;
				style = ST_PICTURE;
				text = __EVAL(getText (configFile >> "CfgVehicles" >> "B_Heli_Attack_01_dynamicLoadout_F" >> "editorPreview"));
				x = SZ_SCREEN_UNIT_W(2);
				y = SZ_SCREEN_UNIT_H(22) + SZ_SCREEN_UNIT_H(135);
			};
			
			//Planes
			class GUI_Static_PlanesTitle : PCS_SHOP_RscText
			{
				idc  = -1;
				x = SZ_SCREEN_UNIT_W(0.4); 
				y = SZ_SCREEN_UNIT_H(0.5) + SZ_SCREEN_UNIT_H(180);
				w = SZ_SCREEN_UNIT_W(20); 
				h = SZ_SCREEN_UNIT_H(2.8); 
				colorBackground[] = {0,0.55,0,0.7};
				colorText[] = {1,1,1,1};
				text = "Planes";
				font = "PuristaBold";
				sizeEx = TEXT_S(0.02);
				
			};
			class GUI_Static_PlanesCount : PCS_SHOP_RscText
			{
				idc  = 1205;
				x = SZ_SCREEN_UNIT_W(20.5); 
				y = SZ_SCREEN_UNIT_H(0.5) + SZ_SCREEN_UNIT_H(180);
				w = SZ_SCREEN_UNIT_W(5); 
				h = SZ_SCREEN_UNIT_H(2.8); 
				colorBackground[] = {0,0,0,0};
				colorText[] = {0,1,0,1};
				text = "0 / 1";
				sizeEx = TEXT_S(0.02);
				
			};
			
			class GUI_Button_View20 : PCS_SHOP_RscButton
			{
				idc = 1027;
				action = "20 call PCS_SHOP_View";
				x = SZ_SCREEN_UNIT_W(4);
				y = SZ_SCREEN_UNIT_H(18) + SZ_SCREEN_UNIT_H(180);
			};
			
			class GUI_Button_View21 : PCS_SHOP_RscButton
			{
				idc = 1028;
				action = "21 call PCS_SHOP_View";
				x = SZ_SCREEN_UNIT_W(14);
				y = SZ_SCREEN_UNIT_H(18) + SZ_SCREEN_UNIT_H(180);
			};
			
			class GUI_Button_View22 : PCS_SHOP_RscButton
			{
				idc = 1029;
				action = "22 call PCS_SHOP_View";
				x = SZ_SCREEN_UNIT_W(24);
				y = SZ_SCREEN_UNIT_H(18) + SZ_SCREEN_UNIT_H(180);
			};
			
			class GUI_Button_View23 : PCS_SHOP_RscButton
			{
				idc = 1030;
				action = "23 call PCS_SHOP_View";
				x = SZ_SCREEN_UNIT_W(34);
				y = SZ_SCREEN_UNIT_H(18) + SZ_SCREEN_UNIT_H(180);
			};
			
			class GUI_Static_PictureBox20 : PCS_SHOP_RscText
			{
				idc = 1127;
				style = ST_PICTURE;
				text = __EVAL(getText (configFile >> "CfgVehicles" >> "C_Plane_Civil_01_F" >> "editorPreview"));
				x = SZ_SCREEN_UNIT_W(2);
				y = SZ_SCREEN_UNIT_H(5) + SZ_SCREEN_UNIT_H(180);
			};
			
			class GUI_Static_PictureBox21 : PCS_SHOP_RscText
			{
				idc = 1128;
				style = ST_PICTURE;
				text = __EVAL(getText (configFile >> "CfgVehicles" >> "I_Plane_Fighter_03_CAS_F" >> "editorPreview"));
				x = SZ_SCREEN_UNIT_W(12);
				y = SZ_SCREEN_UNIT_H(5) + SZ_SCREEN_UNIT_H(180);
			};
			
			class GUI_Static_PictureBox22 : PCS_SHOP_RscText
			{
				idc = 1129;
				style = ST_PICTURE;
				text = __EVAL(getText (configFile >> "CfgVehicles" >> "O_Plane_Fighter_02_F" >> "editorPreview"));
				x = SZ_SCREEN_UNIT_W(22);
				y = SZ_SCREEN_UNIT_H(5) + SZ_SCREEN_UNIT_H(180);
			};
			
			class GUI_Static_PictureBox23 : PCS_SHOP_RscText
			{
				idc = 1130;
				style = ST_PICTURE;
				text = __EVAL(getText (configFile >> "CfgVehicles" >> "B_Plane_Fighter_01_F" >> "editorPreview"));
				x = SZ_SCREEN_UNIT_W(32);
				y = SZ_SCREEN_UNIT_H(5) + SZ_SCREEN_UNIT_H(180);
			};
			
			//Aristocratic Superiority
			class GUI_Static_AristocratTitle : PCS_SHOP_RscText
			{
				idc  = -1;
				x = SZ_SCREEN_UNIT_W(0.4); 
				y = SZ_SCREEN_UNIT_H(0.5) + SZ_SCREEN_UNIT_H(225);
				w = SZ_SCREEN_UNIT_W(20); 
				h = SZ_SCREEN_UNIT_H(2.8); 
				colorBackground[] = {0,0.55,0,0.7};
				colorText[] = {1,1,1,1};
				text = "Aristocratic Superiority";
				font = "PuristaBold";
				sizeEx = TEXT_S(0.02);
				
			};
			class GUI_Static_AristocratCount : PCS_SHOP_RscText
			{
				idc  = 1206;
				x = SZ_SCREEN_UNIT_W(20.5); 
				y = SZ_SCREEN_UNIT_H(0.5) + SZ_SCREEN_UNIT_H(225);
				w = SZ_SCREEN_UNIT_W(5); 
				h = SZ_SCREEN_UNIT_H(2.8); 
				colorBackground[] = {0,0,0,0};
				colorText[] = {0,1,0,1};
				text = "0 / 1";
				sizeEx = TEXT_S(0.02);
				
			};
			
			class GUI_Button_View24 : PCS_SHOP_RscButton
			{
				idc = 1031;
				action = "24 call PCS_SHOP_View";
				x = SZ_SCREEN_UNIT_W(4);
				y = SZ_SCREEN_UNIT_H(18) + SZ_SCREEN_UNIT_H(225);
			};
			
			class GUI_Static_PictureBox24 : PCS_SHOP_RscText
			{
				idc = 1131;
				style = ST_PICTURE;
				text = __EVAL(getText (configFile >> "CfgVehicles" >> "C_Offroad_02_unarmed_F" >> "editorPreview"));
				x = SZ_SCREEN_UNIT_W(2);
				y = SZ_SCREEN_UNIT_H(5) + SZ_SCREEN_UNIT_H(225);
			};
			
		};
	};
	
	class GUI_Static_ObjectName : PCS_SHOP_RscText
	{
		idc = 1200;
		x = POS_SCREEN_UNIT_X(65) + SZ_SCREEN_UNIT_W(0.5);
		y = POS_SCREEN_UNIT_Y(20) + SZ_SCREEN_UNIT_H(0.5); 
		w = SZ_SCREEN_UNIT_W(20); 
		h = SZ_SCREEN_UNIT_H(3); 
		colorBackground[] = {0,0,0,0};
		colorText[] = {0,1,0,1};
		font = "PuristaBold";
		text = "Name";
		sizeEx = TEXT_S(0.02);
	};
	
	class GUI_Static_ObjectType : PCS_SHOP_RscText
	{
		idc = 1210;
		x = POS_SCREEN_UNIT_X(65) + SZ_SCREEN_UNIT_W(0.5);
		y = POS_SCREEN_UNIT_Y(20) + SZ_SCREEN_UNIT_H(0.5) + SZ_SCREEN_UNIT_H(25); 
		w = SZ_SCREEN_UNIT_W(30); 
		h = SZ_SCREEN_UNIT_H(3); 
		colorBackground[] = {0,0,0,0};
		colorText[] = {1,1,1,1};
		font = "PuristaBold";
		text = "TYPE: ";
		sizeEx = TEXT_S(0.015);
	};
	
	class GUI_Static_ObjectCost : PCS_SHOP_RscText
	{
		idc = 1211;
		x = POS_SCREEN_UNIT_X(65) + SZ_SCREEN_UNIT_W(0.5);
		y = POS_SCREEN_UNIT_Y(20) + SZ_SCREEN_UNIT_H(0.5) + SZ_SCREEN_UNIT_H(37); 
		w = SZ_SCREEN_UNIT_W(30); 
		h = SZ_SCREEN_UNIT_H(4); 
		colorBackground[] = {0,0,0,0};
		colorText[] = {0.1,0.9,0,1};
		font = "PuristaBold";
		text = "COST: ";
		sizeEx = TEXT_S(0.02);
	};
	
	class GUI_Static_ObjectStockTime : PCS_SHOP_RscText
	{
		idc = 1212;
		x = POS_SCREEN_UNIT_X(65) + SZ_SCREEN_UNIT_W(0.5);
		y = POS_SCREEN_UNIT_Y(20) + SZ_SCREEN_UNIT_H(0.5) + SZ_SCREEN_UNIT_H(28); 
		w = SZ_SCREEN_UNIT_W(30); 
		h = SZ_SCREEN_UNIT_H(3); 
		colorBackground[] = {0,0,0,0};
		colorText[] = {1,1,1,1};
		font = "PuristaBold";
		text = "STOCK TIME: ";
		sizeEx = TEXT_S(0.015);
	};
	
	class GUI_Static_ObjectDescription : PCS_SHOP_RscText
	{
		idc = 1213;
		x = POS_SCREEN_UNIT_X(65) + SZ_SCREEN_UNIT_W(0.5);
		y = POS_SCREEN_UNIT_Y(20) + SZ_SCREEN_UNIT_H(0.5) + SZ_SCREEN_UNIT_H(31); 
		w = SZ_SCREEN_UNIT_W(30); 
		h = SZ_SCREEN_UNIT_H(3); 
		colorBackground[] = {0,0,0,0};
		colorText[] = {1,1,1,1};
		font = "PuristaBold";
		text = "DESCRIPTION: ";
		sizeEx = TEXT_S(0.015);
	};
	class GUI_Button_Buy : PCS_SHOP_RscButton
	{
		idc = 1214;
		action = "call PCS_SHOP_Buy";
		x = POS_SCREEN_UNIT_X(65) + SZ_SCREEN_UNIT_W(10);
		y = POS_SCREEN_UNIT_Y(20) + SZ_SCREEN_UNIT_H(0.5) + SZ_SCREEN_UNIT_H(45);
		w = SZ_SCREEN_UNIT_W(6);
		h = SZ_SCREEN_UNIT_H(6);
		colorBackground[] = {0.5,0.5,0,1};
		colorFocused[] = {0.5,0.5,0,1};
		colorText[] = {0,0,0,1};
		colorBackgroundActive[] = {1,1,0,1};
		text = "   BUY";
		
	};
	
	};
	class Objects
	{
 
		class Can
		{
 
			//onObjectMoved = "systemChat str _this";
			idc = 1006; 
			type = 82;
			model = __EVAL(getText (configfile >> "CfgVehicles" >> "C_Van_01_transport_F" >> "model"));
			scale = 1/20;
 
			direction[] = {1, 0, 0};
			up[] = {0, 1, 0}; 
 
			//position[] = {0,0,0.2}; optional
 
			xBack = 0;
			yBack = 0;
			zBack = 1.2;
 
			//positionBack[] = {0,0,1.2}; optional
 
			x = POS_SCREEN_UNIT_X(80);
			y = POS_SCREEN_UNIT_Y(32);
			z = 1.2 * ((pixelGrid * pixelH) / 0.015873);
 
			inBack = 0;
			enableZoom = 0;
			zoomDuration = 0.001;
		};
	};
};