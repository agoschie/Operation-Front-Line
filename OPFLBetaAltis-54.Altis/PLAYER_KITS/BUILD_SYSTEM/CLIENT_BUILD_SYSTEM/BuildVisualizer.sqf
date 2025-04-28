private "_virtualObject";
private "_positionPlayer";
private "_dirPlayer";
private "_wait";
_virtualObject = objNull;

waitUntil {!isNil "PKS_BUILD_VISUALIZER"};

waitUntil
{
	if (0 < count PKS_BUILD_VISUALIZER) then
	{
		_dirPlayer = getDir player;
		_positionPlayer = [getPosASL player, ((PKS_BUILDING_TYPES getVariable PKS_BUILD_VISUALIZER) select 1) select 3, _dirPlayer] call GSC_PolarVector;
		_positionPlayer = ASLToATL _positionPlayer;
		_positionPlayer set [2, [0, 0 max (_positionPlayer select 2)] select (((getPosATL player) select 2) > 0.01)];
		_virtualObject = (PKS_BUILDING_TYPES getVariable PKS_BUILD_VISUALIZER) select 2;
		_virtualObject setVectorUp [0,0,1];
		_virtualObject setDir (_dirPlayer + (((PKS_BUILDING_TYPES getVariable PKS_BUILD_VISUALIZER) select 1) select 2));
		_virtualObject setVectorUp ([surfaceNormal _positionPlayer,[0,0,1]] select ((_positionPlayer select 2) > 0.01));
		_virtualObject setPosATL _positionPlayer;
		_virtualObject disableCollisionWith player;
		_virtualObject hideObject false;
	}
	else
	{
		if (!isNull _virtualObject) then
		{
			_virtualObject hideObject true;
			_virtualObject setDir 0;
			_virtualObject setPosASL [0,0,0];
			_virtualObject = objNull;
		};
	};
	false
};

/*
while {_wait == 1} do
{
	_arguments = PKS_BUILD_VISUALIZER;
	
	if ((count _arguments) > 0) then
	{
		if ((_class == (_arguments select 0)) && (_degreeI == (_arguments select 2))) then
		{
			_positionPlayer = getPosATL player;
			_dirPlayer = getDir player;
			//player sideChat format ["DIST FROM PLAYER: %1", _distFromPlayer];
			_positionPlayer = [_positionPlayer, _distFromPlayer, _dirPlayer] call GSC_PolarVector;
			PKS_BUILD_ROOF_FINDER setPosATL [(_positionPlayer select 0), (_positionPlayer select 1), ((_positionPlayer select 2) + 1)];
			_roofHeight = ((_positionPlayer select 2) + 1) - ((getPos PKS_BUILD_ROOF_FINDER) select 2);

			_positionPlayer = [(_positionPlayer select 0), (_positionPlayer select 1), _roofHeight];
			_dirPlayer = _dirPlayer + _degreeI;
			_virtualObject setDir _dirPlayer;
			_virtualObject setPos _positionPlayer;
		}
		else
		{
			if (!isNull _virtualObject) then
			{
				deleteVehicle _virtualObject;
			};
			_degreeI = (_arguments select 2);
			_class = (_arguments select 0);
			_virtualObject = _class createVehicleLocal ([(getPosATL player), 100, 0] call GSC_PolarVector);
			_distFromPlayer = (2 + ceil(((sizeOf _class) / 2)));
		};
	}
	else
	{
		if (!isNull _virtualObject) then
		{
			deleteVehicle _virtualObject;
			_class = "none";
			_degreeI = 0;
		};
	};
			
	sleep 0.1;
};
*/