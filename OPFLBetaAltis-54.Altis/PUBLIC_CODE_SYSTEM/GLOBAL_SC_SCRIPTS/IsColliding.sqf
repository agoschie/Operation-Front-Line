private "_object";
private "_center";
private "_objectPos";
private "_houses";
private "_return";
private "_objectSize";
private "_house";
private "_housePos";
private "_houseBounds_min";
private "_houseBounds_max";
private "_dx";
private "_dy";
private "_minX";
private "_minY";
private "_maxX";
private "_maxY";
private "_totalHeight";

_object = _this select 0;
_return = [];
_house = "NONE";
_housePos = [0,0,0];
_totalHeight = 0;

_objectSize = sizeOf (typeOf _object);
_center = boundingCenter _object;
_objectPos = _object modelToWorld _center;

_houses = _objectPos nearObjects ["Building", 200];
_distance = 200;
{
	_center = boundingCenter _x;
	_currentHousePos = _x modelToWorld _center;
	
	_currentDistance = (_objectPos distance _currentHousePos);
	if (_currentDistance <= _distance) then
	{
		_house = _x;
		_housePos = _currentHousePos;
		_distance = _currentDistance;
	};
} foreach _houses;

if ("STRING" == (typeName _house)) exitWith {_return};

_objectPos = [_housePos,_objectPos, (getDir _house)] call MSO_fnc_vectRotate2D;
_houseBounds_min = (boundingBox _house) select 0;
_houseBounds_max = (boundingBox _house) select 1;

_minX = _houseBounds_min select 0;
_maxX = _houseBounds_max select 0;

_minY = _houseBounds_min select 1;
_maxY = _houseBounds_max select 1;

_dx = (_objectPos select 0) - (_housePos select 0);
_dy = (_objectPos select 1) - (_objectPos select 1);

if (((_dx > _minX) && (_dx < _maxX)) && ((_dy > _minY) && (_dy < _maxY))) then
{
	_totalHeight = (_houseBounds_max select 2) - (_houseBounds_min select 2);
	_return = [_house, _totalHeight];
};
_return;

