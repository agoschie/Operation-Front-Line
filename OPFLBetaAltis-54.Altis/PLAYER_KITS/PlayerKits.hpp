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
#define SCALAR 0.75
#define SZ_SCREEN_UNIT_W(w) (SCALAR * w * safeZoneW / 100)
#define SZ_SCREEN_UNIT_H(h) (SCALAR * h * safeZoneH / 100)
#define POS_SCREEN_UNIT_X(x) (safeZoneX + (SCALAR * x * safeZoneW / 100))
#define POS_SCREEN_UNIT_Y(y) (safeZoneY + (SCALAR * y * safeZoneH / 100))
#define TEXT_S(s) (SCALAR * sqrt(safeZoneW*safeZoneH*s*s))
/***************************************************************************
End
****************************************************************************/

class PKS_RscText 
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

class PKS_RscFrame
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

class PKS_RscBackground
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

class PKS_RscBackgroundFrame
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

class PKS_RscListBox 
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

class PKS_RscButton 
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

class PKSGUI
{
	idd = -1; 
	onLoad = "_this call PKS_LoadGUI";
	onUnload = "_this call PKS_CloseGUI";
	movingEnable = false; 
	enableSimulation = false;
	objects[] = { }; 
	
	class controlsBackground
	{
		class GUI_Static_BackgroundFrame : PKS_RscBackgroundFrame
		{
			idc = 1001;
			w = SZ_SCREEN_UNIT_W(70) + 0.01;
			h = SZ_SCREEN_UNIT_H(85) + (0.01 * 4/3);
			x = POS_SCREEN_UNIT_X(15) - 0.005;
			y = POS_SCREEN_UNIT_Y(15) - (0.005 * 4/3);
			colorBackground[] = {0.4,0.4,0.4,1};
			
		};
		
		class GUI_Static_Background : PKS_RscBackground
		{
			idc = 1002;
			style = ST_PICTURE;
			text = "PLAYER_KITS\Pictures\PlayerKitsBackgroundPic.paa";
			w = SZ_SCREEN_UNIT_W(70);
			h = SZ_SCREEN_UNIT_H(85);
			x = POS_SCREEN_UNIT_X(15);
			y = POS_SCREEN_UNIT_Y(15);
			colorBackground[] = {0.4,0.4,0.4,1};
			
		};
		
		class GUI_Static_Background2 : PKS_RscBackground
		{
			idc = 1036;
			style = ST_PICTURE;
			text = "a3\ui_f\data\IGUI\RscTitles\HealthTextures\dust_lower_ca.paa";
			w = SZ_SCREEN_UNIT_W(70);
			h = SZ_SCREEN_UNIT_H(85);
			x = POS_SCREEN_UNIT_X(15);
			y = POS_SCREEN_UNIT_Y(15);
			colorBackground[] = {0.4,0.4,0.4,1};
			
		};
		
		class GUI_Static_Background3 : PKS_RscBackground
		{
			idc = 1037;
			style = ST_PICTURE;
			text = "a3\ui_f\data\IGUI\RscTitles\HealthTextures\blood_up_ca.paa";
			w = SZ_SCREEN_UNIT_W(70);
			h = SZ_SCREEN_UNIT_H(85);
			x = POS_SCREEN_UNIT_X(15);
			y = POS_SCREEN_UNIT_Y(15);
			colorBackground[] = {0.4,0.4,0.4,1};
			
		};
		
		class GUI_Static_SelectedKitBackground : PKS_RscText
		{
			idc = 1016;
			x = POS_SCREEN_UNIT_X(41);
			y = POS_SCREEN_UNIT_Y(25);
			w = SZ_SCREEN_UNIT_W(37);
			h = SZ_SCREEN_UNIT_H(35);
			text = "";
			//sizeEx = 0.038;
			sizeEx = TEXT_S(0.02);
			colorText[] = {0,0,0,1};
			colorBackground[] = {0.33,0.33,0.33,1};
		};
		
		class GUI_Static_DividerA : PKS_RscText
		{
			idc = 1024;
			x = POS_SCREEN_UNIT_X(41);
			y = POS_SCREEN_UNIT_Y(29.5);
			w = SZ_SCREEN_UNIT_W(37);
			h = SZ_SCREEN_UNIT_H(0.5);
			text = "";
			//sizeEx = 0.038;
			sizeEx = TEXT_S(0.02);
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,1};
		};
		
		class GUI_Static_DividerB : PKS_RscText
		{
			idc = 1025;
			x = POS_SCREEN_UNIT_X(41);
			y = POS_SCREEN_UNIT_Y(34.5);
			w = SZ_SCREEN_UNIT_W(37);
			h = SZ_SCREEN_UNIT_H(0.5);
			text = "";
			//sizeEx = 0.038;
			sizeEx = TEXT_S(0.02);
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,1};
		};
		
		class GUI_Static_DividerC : PKS_RscText
		{
			idc = 1026;
			x = POS_SCREEN_UNIT_X(41);
			y = POS_SCREEN_UNIT_Y(39.5);
			w = SZ_SCREEN_UNIT_W(37);
			h = SZ_SCREEN_UNIT_H(0.5);
			text = "";
			//sizeEx = 0.038;
			sizeEx = TEXT_S(0.02);
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,1};
		};
		
		class GUI_Static_SelectedKitText : PKS_RscText
		{
			idc = 1007;
			x = POS_SCREEN_UNIT_X(41);
			y = POS_SCREEN_UNIT_Y(25);
			w = SZ_SCREEN_UNIT_W(20);
			h = SZ_SCREEN_UNIT_H(5);
			text = "SELECTED KIT: ";
			sizeEx = TEXT_S(0.02);
			colorText[] = {0,0,0,1};
			colorBackground[] = {0.33,0.33,0.33,0};
		};
		
		class GUI_Static_KitsLeftText : PKS_RscText
		{
			idc = 1008;
			x = POS_SCREEN_UNIT_X(41);
			y = POS_SCREEN_UNIT_Y(30);
			w = SZ_SCREEN_UNIT_W(20);
			h = SZ_SCREEN_UNIT_H(5);
			text = "KITS LEFT: ";
			sizeEx = TEXT_S(0.02);
			colorText[] = {0,0,0,1};
			colorBackground[] = {0.33,0.33,0.33,0};
		};
		
		class GUI_Static_InUseText : PKS_RscText
		{
			idc = 1009;
			x = POS_SCREEN_UNIT_X(41);
			y = POS_SCREEN_UNIT_Y(35);
			w = SZ_SCREEN_UNIT_W(20);
			h = SZ_SCREEN_UNIT_H(5);
			text = "KITS IN USE: ";
			sizeEx = TEXT_S(0.02);
			colorText[] = {0,0,0,1};
			colorBackground[] = {0.33,0.33,0.33,0};
		};
		
		class GUI_Static_DescriptionText : PKS_RscText
		{
			idc = 1010;
			x = POS_SCREEN_UNIT_X(41);
			y = POS_SCREEN_UNIT_Y(40);
			w = SZ_SCREEN_UNIT_W(20);
			h = SZ_SCREEN_UNIT_H(5);
			text = "DESCRIPTION: ";
			sizeEx = TEXT_S(0.02);
			colorText[] = {0,0,0,1};
			colorBackground[] = {0.33,0.33,0.33,0};
		};
		
		class GUI_Static_CoverFrame : PKS_RscText
		{
			idc = 1011;
			x = POS_SCREEN_UNIT_X(41);
			y = POS_SCREEN_UNIT_Y(25);
			w = SZ_SCREEN_UNIT_W(37);
			h = SZ_SCREEN_UNIT_H(35);
			colorText[] = {0,0,0,1};
			colorBackground[] = {0.33,0.33,0.33,0};
		};
		
		class GUI_Static_PictureBoxABack : PKS_RscText
		{
			idc = 1029;
			x = POS_SCREEN_UNIT_X(20);
			y = POS_SCREEN_UNIT_Y(83);
			w = SZ_SCREEN_UNIT_W(17);
			h = SZ_SCREEN_UNIT_H(14);
			text = "";
			//sizeEx = 0.038;
			sizeEx = TEXT_S(0.020);
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,1};
		};
		
		class GUI_Static_PictureBoxBBack : PKS_RscText
		{
			idc = 1030;
			x = POS_SCREEN_UNIT_X(49);
			y = POS_SCREEN_UNIT_Y(83);
			w = SZ_SCREEN_UNIT_W(17);
			h = SZ_SCREEN_UNIT_H(14);
			text = "";
			//sizeEx = 0.038;
			sizeEx = TEXT_S(0.020);
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,1};
		};
		
		class GUI_Static_PrimaryWeapon : PKS_RscText
		{
			idc = 1022;
			style = 528;
			lineSpacing = 1;
			x = POS_SCREEN_UNIT_X(20);
			y = POS_SCREEN_UNIT_Y(78);
			w = SZ_SCREEN_UNIT_W(17);
			h = SZ_SCREEN_UNIT_H(21);
			text = "PRIMARY";
			//sizeEx = 0.038;
			sizeEx = TEXT_S(0.018);
			colorText[] = {1,1,1,1};
			colorBackground[] = {0.33,0.33,0.33,1};
		};
		
		class GUI_Static_Scope : PKS_RscText
		{
			idc = 1031;
			style = 528;
			lineSpacing = 1;
			x = POS_SCREEN_UNIT_X(49);
			y = POS_SCREEN_UNIT_Y(78);
			w = SZ_SCREEN_UNIT_W(17);
			h = SZ_SCREEN_UNIT_H(21);
			text = "SCOPE";
			//sizeEx = 0.038;
			sizeEx = TEXT_S(0.018);
			colorText[] = {1,1,1,1};
			colorBackground[] = {0.33,0.33,0.33,1};
		};
	};
	
	class controls
	{
		
		class GUI_Button_Close : PKS_RscButton
		{
			idc = 1000;
			action = "closeDialog 0";
			x = POS_SCREEN_UNIT_X(81.5);
			y = POS_SCREEN_UNIT_Y(15.5);
			w = SZ_SCREEN_UNIT_W(3);
			h = SZ_SCREEN_UNIT_H(3);
			//sizeEx = 0.02;
			sizeEx = TEXT_S(0.015);
			text = "X";
		};
		
		class GUI_Button_Select : PKS_RscButton
		{
			idc = 1003;
			action = "[] call PKS_SelectKitGUI";
			x = POS_SCREEN_UNIT_X(58);
			y = POS_SCREEN_UNIT_Y(62);
			w = SZ_SCREEN_UNIT_W(8);
			h = SZ_SCREEN_UNIT_H(4);
			//sizeEx = 0.025;
			sizeEx = TEXT_S(0.018);
			text = "SELECT";
		};
		
		class GUI_Button_Customize : PKS_RscButton
		{
			idc = 1017;
			action = "closeDialog 0";
			x = POS_SCREEN_UNIT_X(67);
			y = POS_SCREEN_UNIT_Y(62);
			w = SZ_SCREEN_UNIT_W(8);
			h = SZ_SCREEN_UNIT_H(4);
			sizeEx = TEXT_S(0.018);
			text = "CLOSE";
		};
		
		class GUI_Button_PLeft : PKS_RscButton
		{
			idc = 1018;
			action = "true call PKS_Left";
			x = POS_SCREEN_UNIT_X(16);
			y = POS_SCREEN_UNIT_Y(80);
			w = SZ_SCREEN_UNIT_W(3);
			h = SZ_SCREEN_UNIT_H(3);
			sizeEx = TEXT_S(0.014);
			text = "<<";
		};
		
		class GUI_Button_PRight : PKS_RscButton
		{
			idc = 1019;
			action = "true call PKS_Right";
			x = POS_SCREEN_UNIT_X(38);
			y = POS_SCREEN_UNIT_Y(80);
			w = SZ_SCREEN_UNIT_W(3);
			h = SZ_SCREEN_UNIT_H(3);
			sizeEx = TEXT_S(0.014);
			text = ">>";
		};
		
		class GUI_Button_SLeft : PKS_RscButton
		{
			idc = 1020;
			action = "false call PKS_Left";
			x = POS_SCREEN_UNIT_X(45);
			y = POS_SCREEN_UNIT_Y(80);
			w = SZ_SCREEN_UNIT_W(3);
			h = SZ_SCREEN_UNIT_H(3);
			sizeEx = TEXT_S(0.014);
			text = "<<";
		};
		
		class GUI_Button_SRight : PKS_RscButton
		{
			idc = 1021;
			action = "false call PKS_Right";
			x = POS_SCREEN_UNIT_X(67);
			y = POS_SCREEN_UNIT_Y(80);
			w = SZ_SCREEN_UNIT_W(3);
			h = SZ_SCREEN_UNIT_H(3);
			sizeEx = TEXT_S(0.014);
			text = ">>";
		};
		
		class GUI_Static_PictureBoxA : PKS_RscText
		{
			idc = 1023;
			style = ST_PICTURE;
			x = POS_SCREEN_UNIT_X(20);
			y = POS_SCREEN_UNIT_Y(82);
			w = SZ_SCREEN_UNIT_W(17);
			h = SZ_SCREEN_UNIT_H(17);
			text = "";
			//sizeEx = 0.038;
			sizeEx = TEXT_S(0.018);
			colorText[] = {1,1,1,1};
			colorBackground[] = {0.33,0.33,0.33,1};
		};
		
		class GUI_Static_PictureBoxB : PKS_RscText
		{
			idc = 1027;
			style = ST_PICTURE;
			x = POS_SCREEN_UNIT_X(49);
			y = POS_SCREEN_UNIT_Y(82);
			w = SZ_SCREEN_UNIT_W(17);
			h = SZ_SCREEN_UNIT_H(17);
			text = "";
			//sizeEx = 0.038;
			sizeEx = TEXT_S(0.018);
			colorText[] = {1,1,1,1};
			colorBackground[] = {0.33,0.33,0.33,1};
		};
		
		
		class GUI_Static_TitleText : PKS_RscText
		{
			idc = 1004;
			x = POS_SCREEN_UNIT_X(15);
			y = POS_SCREEN_UNIT_Y(15);
			w = SZ_SCREEN_UNIT_W(20);
			h = SZ_SCREEN_UNIT_H(5);
			text = "<< THE ARMORY >>";
			//sizeEx = 0.05;
			sizeEx = TEXT_S(0.032);
			colorText[] = {0,0,0,1};
			colorBackground[] = {0.33,0.33,0.33,1};
		};
		
		class GUI_Static_CurrentKitText : PKS_RscText
		{
			idc = 1005;
			x = POS_SCREEN_UNIT_X(58);
			y = POS_SCREEN_UNIT_Y(67);
			w = SZ_SCREEN_UNIT_W(20);
			h = SZ_SCREEN_UNIT_H(5);
			text = "MY KIT:";
			//sizeEx = 0.038;
			sizeEx = TEXT_S(0.02);
			colorText[] = {0.8,0.8,0,1};
			colorBackground[] = {0.33,0.33,0.33,1};
		};
		
		class GUI_ListBox_KitList : PKS_RscListBox
		{
			idc = 1006;
			x = POS_SCREEN_UNIT_X(15);
			y = POS_SCREEN_UNIT_Y(25);
			w = SZ_SCREEN_UNIT_W(25);
			h = SZ_SCREEN_UNIT_H(50);
			colorBackground[] = {0.33,0.33,0.33,1};
			colorText[] = {0.5,0.5,0.5,1};
			onLBSelChanged = "_this call PKS_ListBoxSelectGUI";
		};
		
		class GUI_Static_SelectedKitValue : PKS_RscText
		{
			idc = 1012;
			x = POS_SCREEN_UNIT_X(55);
			y = POS_SCREEN_UNIT_Y(25);
			w = SZ_SCREEN_UNIT_W(20);
			h = SZ_SCREEN_UNIT_H(5);
			colorText[] = {0.85,0.85,0.85,0.9};
			colorBackground[] = {0.33,0.33,0.33,0};
		};
		
		class GUI_Static_KitsLeftValue : PKS_RscText
		{
			idc = 1013;
			x = POS_SCREEN_UNIT_X(55);
			y = POS_SCREEN_UNIT_Y(30);
			w = SZ_SCREEN_UNIT_W(20);
			h = SZ_SCREEN_UNIT_H(5);
			colorText[] = {0.85,0.85,0.85,0.9};
			colorBackground[] = {0.33,0.33,0.33,0};
		};
		
		class GUI_Static_InUseValue : PKS_RscText
		{
			idc = 1014;
			x = POS_SCREEN_UNIT_X(55);
			y = POS_SCREEN_UNIT_Y(35);
			w = SZ_SCREEN_UNIT_W(20);
			h = SZ_SCREEN_UNIT_H(5);
			colorText[] = {0.85,0.85,0.85,0.9};
			colorBackground[] = {0.33,0.33,0.33,0};
		};
		
		class GUI_Static_DescriptionValue : PKS_RscText
		{
			idc = 1015;
			style = 528;
			lineSpacing = 1;
			x = POS_SCREEN_UNIT_X(41);
			y = POS_SCREEN_UNIT_Y(45);
			w = SZ_SCREEN_UNIT_W(37);
			h = SZ_SCREEN_UNIT_H(15);
			colorText[] = {0.85,0.85,0.85,0.9};
			colorBackground[] = {0.33,0.33,0.33,0};
			//sizeEx = 0.03;
			sizeEx = TEXT_S(0.019);
		};
		
		class GUI_Static_Screw1 : PKS_RscBackground
		{
			idc = 1032;
			style = ST_PICTURE;
			text = "PLAYER_KITS\Pictures\Screw4.paa";
			w = 0.05;
			h = 0.05;
			x = POS_SCREEN_UNIT_X(15.5);
			y = POS_SCREEN_UNIT_Y(20.5);
			colorText[] = {1,1,1,0};
			colorBackground[] = {1,1,1,0};
			
		};
		
		class GUI_Static_Screw2 : PKS_RscBackground
		{
			idc = 1033;
			style = ST_PICTURE;
			text = "PLAYER_KITS\Pictures\Screw4.paa";
			w = 0.05;
			h = 0.05;
			x = POS_SCREEN_UNIT_X(81.5);
			y = POS_SCREEN_UNIT_Y(20.5);
			colorText[] = {1,1,1,0};
			colorBackground[] = {1,1,1,0};
			
		};
		
		class GUI_Static_Screw3 : PKS_RscBackground
		{
			idc = 1034;
			style = ST_PICTURE;
			text = "PLAYER_KITS\Pictures\Screw4.paa";
			w = 0.05;
			h = 0.05;
			x = POS_SCREEN_UNIT_X(15.5);
			y = POS_SCREEN_UNIT_Y(96.5);
			colorText[] = {1,1,1,0};
			colorBackground[] = {1,1,1,0};
			
		};
		
		class GUI_Static_Screw4 : PKS_RscBackground
		{
			idc = 1035;
			style = ST_PICTURE;
			text = "PLAYER_KITS\Pictures\Screw4.paa";
			w = 0.05;
			h = 0.05;
			x = POS_SCREEN_UNIT_X(81.5);
			y = POS_SCREEN_UNIT_Y(96.5);
			colorText[] = {1,1,1,0};
			colorBackground[] = {1,1,1,0};
			
		};
	};
};