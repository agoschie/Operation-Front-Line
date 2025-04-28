if (!isNil "OPFL_PSPAWN_LOCK") exitWith {};
private ["_flagPos"];
_flagPos = (OPFL_F_FLAG getVariable "FLAG_ZONE_STATE") select 2;
_flagPos = [_flagPos] call GSC_AxisIntersectPoint;

OPFL_PSPAWN_LOCK = true;
OPFL_VALID_SPOT = false;

openMap true;

OPFL_CURSOR_MARKER = createMarkerLocal ["OPFL_CURSOR_MARKER", [0,0]];
OPFL_CURSOR_MARKER setMarkerShapeLocal "ICON";
OPFL_CURSOR_MARKER setMarkerTypeLocal "respawn_para";
OPFL_CURSOR_MARKER setMarkerDirLocal 0;
OPFL_CURSOR_MARKER setMarkerSizeLocal [1.5, 1.5];
OPFL_FRAME_SKIPPER = 0;

OPFL_SPAWN_LINE = createMarkerLocal ["OPFL_SPAWN_LINE", ([_flagPos] call GSC_AxisIntersectPoint)];
OPFL_SPAWN_LINE setMarkerShapeLocal "RECTANGLE";
OPFL_SPAWN_LINE setMarkerBrushLocal "SOLID";
OPFL_SPAWN_LINE setMarkerDirLocal (markerDir "BP_AXIS_CONNECTOR");
OPFL_SPAWN_LINE setMarkerColorLocal "ColorYellow";
OPFL_SPAWN_LINE setMarkerAlphaLocal 0.5;
OPFL_SPAWN_LINE setMarkerSizeLocal [([([(markerPos "BP_AXIS_CONNECTOR"), (markerPos OPFL_SPAWN_LINE)] call GSC_2dDistance)] call GSC_FieldWidth), 5];

[[0,0], 
 getMarkerPos "BP_TAG_WEST", 
 0, 
 "ColorBlack",
 "OPFL_NO_SPAWN"] call GSC_DrawMarkerConnection;

OPFL_MAP_CURSOR_EH = addMissionEventHandler ["EachFrame", {
	if (isNil "OPFL_CURSOR_MARKER") exitWith {};
	
	private ["_flagPos", "_linePos", "_axisInter", "_mousePos"];
	_flagPos = (OPFL_F_FLAG getVariable "FLAG_ZONE_STATE") select 2;
	_flagPos = [_flagPos] call GSC_AxisIntersectPoint;
	_flagPos set [2, 0];
	deleteMarkerLocal "OPFL_NO_SPAWN";
	
	_mousePos = ((findDisplay 12) displayCtrl 51) posScreenToWorld getMousePosition;
	
	OPFL_CURSOR_MARKER setMarkerPosLocal _mousePos;
	
	if (OPFL_FRAME_SKIPPER < 3) then
	{
		OPFL_FRAME_SKIPPER = OPFL_FRAME_SKIPPER + 1;
	};
	
	if (playerSide == west) then
	{
		if (([_flagPos, getMarkerPos "BP_TAG_WEST"] call GSC_2dDistance) > (OPFL_PARACHUTE_DISTANCE + 5)) then
		{
			OPFL_VALID_SPOT = true;
			_linePos = getMarkerPos "BP_TAG_WEST";
			_linePos set [2, 0];
			_linePos = vectorNormalized (_linePos vectorDiff _flagPos);
			_linePos = _linePos vectorMultiply OPFL_PARACHUTE_DISTANCE;
			_linePos = _linePos vectorAdd _flagPos;
			
			OPFL_SPAWN_LINE setMarkerPosLocal _linePos;
			OPFL_SPAWN_LINE setMarkerSizeLocal [([([(markerPos "BP_AXIS_CONNECTOR"), (markerPos OPFL_SPAWN_LINE)] call GSC_2dDistance)] call GSC_FieldWidth), 5];
			
		}
		else
		{
			OPFL_VALID_SPOT = false;
			OPFL_SPAWN_LINE setMarkerSizeLocal [0,0];
			OPFL_SPAWN_LINE setMarkerPosLocal getMarkerPos "BP_TAG_WEST";
		};
		
		[getMarkerPos "OPFL_SPAWN_LINE", 
		getMarkerPos "BP_TAG_EAST", 
		0, 
		"ColorYellow",
		"OPFL_NO_SPAWN"] call GSC_DrawMarkerConnection;
	};

	if (playerSide == east) then
	{
		if (([_flagPos, getMarkerPos "BP_TAG_EAST"] call GSC_2dDistance) > (OPFL_PARACHUTE_DISTANCE + 5)) then
		{
			OPFL_VALID_SPOT = true;
			_linePos = getMarkerPos "BP_TAG_EAST";
			_linePos set [2, 0];
			_linePos = vectorNormalized (_linePos vectorDiff _flagPos);
			_linePos = _linePos vectorMultiply OPFL_PARACHUTE_DISTANCE;
			_linePos = _linePos vectorAdd _flagPos;
			
			OPFL_SPAWN_LINE setMarkerPosLocal _linePos;
			OPFL_SPAWN_LINE setMarkerSizeLocal [([([(markerPos "BP_AXIS_CONNECTOR"), (markerPos OPFL_SPAWN_LINE)] call GSC_2dDistance)] call GSC_FieldWidth), 5];
		}
		else
		{
			OPFL_VALID_SPOT = false;
			OPFL_SPAWN_LINE setMarkerSizeLocal [0,0];
			OPFL_SPAWN_LINE setMarkerPosLocal getMarkerPos "BP_TAG_EAST";
		};
		
		[getMarkerPos "OPFL_SPAWN_LINE", 
		getMarkerPos "BP_TAG_WEST", 
		0, 
		"ColorYellow",
		"OPFL_NO_SPAWN"] call GSC_DrawMarkerConnection
	};
	
	"OPFL_NO_SPAWN" setMarkerSizeLocal [(markerSize "BATTLE_FIELD_AREA") select 0,(markerSize "OPFL_NO_SPAWN") select 1];
	if (OPFL_VALID_SPOT) then
	{
		if ([_mousePos, "OPFL_NO_SPAWN"] call MSO_fnc_InArea) then
		{
			OPFL_VALID_SPOT = false;
		}
		else
		{
			OPFL_VALID_SPOT = true;
			"OPFL_NO_SPAWN" setMarkerSizeLocal [0,0];
		};
	};
}];

OPFL_MAP_CLICK_EH = addMissionEventHandler ["MapSingleClick", {
	if (OPFL_FRAME_SKIPPER < 3 || isNil "OPFL_MAP_CLICK_EH") exitWith {};
	
	private ["_position"];
	_position = _this select 1;
	
	removeMissionEventHandler ["Map", OPFL_MAP_EH];
	removeMissionEventHandler ["EachFrame", OPFL_MAP_CURSOR_EH];
	
	OPFL_MAP_CLICK_EH spawn
	{
		removeMissionEventHandler ["MapSingleClick", _this];
		OPFL_PSPAWN_LOCK = nil;
	};
		
	deleteMarkerLocal OPFL_CURSOR_MARKER;
	deleteMarkerLocal OPFL_SPAWN_LINE;
	deleteMarkerLocal "OPFL_NO_SPAWN";
		
	OPFL_MAP_EH = nil;
	OPFL_MAP_CLICK_EH = nil;
	OPFL_MAP_CURSOR_EH = nil;
	OPFL_CURSOR_MARKER = nil;
		
	openMap false;
	if (OPFL_VALID_SPOT) then
	{
		if ([_position, "BATTLE_FIELD_AREA"] call MSO_fnc_InArea) then
		{
			[player, _position] call OPFL_Client_ParachuteTeleport;
		}
		else
		{
			hint "DO NOT SPAWN OUT OF BATTLE FIELD AREA";
		};
	}
	else
	{
		hint "DO NOT SPAWN IN FRONT OF BACK LINE!";
	};
		
}];

OPFL_MAP_EH = addMissionEventHandler ["Map", {
	if (!(_this select 0) && !isNil "OPFL_MAP_EH") then
	{
		OPFL_MAP_EH spawn
		{
			removeMissionEventHandler ["Map", _this];
			OPFL_PSPAWN_LOCK = nil;
		};
		
		
		removeMissionEventHandler ["MapSingleClick", OPFL_MAP_CLICK_EH];
		removeMissionEventHandler ["EachFrame", OPFL_MAP_CURSOR_EH];
		
		deleteMarkerLocal OPFL_CURSOR_MARKER;
		deleteMarkerLocal OPFL_SPAWN_LINE;
		deleteMarkerLocal "OPFL_NO_SPAWN";
		
		OPFL_MAP_EH = nil;
		OPFL_MAP_CLICK_EH = nil;
		OPFL_MAP_CURSOR_EH = nil;
		OPFL_CURSOR_MARKER = nil;
	};
}];