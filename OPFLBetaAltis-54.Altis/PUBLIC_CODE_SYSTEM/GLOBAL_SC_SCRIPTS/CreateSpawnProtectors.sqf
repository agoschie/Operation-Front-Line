//local functions
_CREATE_INVISIBLE_SHIELD = 
{
	private "_position";
	private "_shield";
	private "_id";
	private "_marker";
	private "_visualize";

	_position = [_this select 0, _this select 1, _this select 2];
	_id = _this select 3;
	_visualize = _this select 4;

	_shield = "ProtectionZone_Ep1" createVehicleLocal (_position);
	_shield setPos _position;
	_shield setDir 0;
	_shield setObjectTexture [0,"#(argb,8,8,3)color(0,0,0,0,ca)"];

	if (_visualize) then
	{
		_marker = createMarkerLocal [format["SAFTEY_BUBBLE%1_BORDER", _id], _position];
		_marker setMarkerShape "ELLIPSE";
		_marker setMarkerBrush "BORDER";
		_marker setMarkerSizeLocal [25, 25];
		_marker setMarkerColor "ColorGreen";

		_marker = createMarkerLocal [format["SAFTEY_BUBBLE%1_DOT", _id], _position];
		_marker setMarkerShape "ELLIPSE";
		_marker setMarkerBrush "SOLID";
		_marker setMarkerSizeLocal [4, 4];
		_marker setMarkerColor "ColorGreen";
	};
};

//globalVariables
GOSCHIE_SCRIPTS_SAFETY_ZONE_COUNT = 1;

{
	_centerPosition = (getMarkerPos _x);

	_radiusShield = 25;
	_centerPositionX = _centerPosition select 0;
	_centerPositionY = _centerPosition select 1;
	_centerPositionZ = _centerPosition select 2;
	_zoneRadius = (getMarkerSize _x) select 0;
	
	//_shieldLayers = ceil (_zoneRadius / _radiusShield);
	
	private "_i";
	_i = _zoneRadius;
	while {_i > 0} do
	{
		_currentCirc = 2 * pi * _i;
		_arcAmount = ceil (_currentCirc / ((_radiusShield - ((sqrt(2) * _radiusShield) - _radiusShield)) * 2));
		_degreeIncrement = 360 / _arcAmount;
	
		_iB = 0;
		while {_iB < _arcAmount} do
		{
			private "_xPos";
			private "_yPos";
			private "_zPos";
			_xPos = _centerPositionX + (_i * sin (_iB * _degreeIncrement));
			_yPos = _centerPositionY + (_i * cos (_iB * _degreeIncrement));
			_zPos = 0;
			[_xPos, _yPos, _zPos, GOSCHIE_SCRIPTS_SAFETY_ZONE_COUNT, false] spawn _CREATE_INVISIBLE_SHIELD; 
			GOSCHIE_SCRIPTS_SAFETY_ZONE_COUNT = GOSCHIE_SCRIPTS_SAFETY_ZONE_COUNT + 1;
			
			_iB = _iB + 1;
		};
		_i = _i - ((_radiusShield - ((sqrt(2) * _radiusShield) - _radiusShield)) * 2);	
	};
	
} forEach GSC_SPAWN_PROTECTED_AREAS;