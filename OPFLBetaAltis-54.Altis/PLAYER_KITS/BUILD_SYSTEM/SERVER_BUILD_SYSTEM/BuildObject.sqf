private "_bvfArray";
private "_building";
private "_position";
private "_direction";
private "_initLine";
private "_objecti";
private "_setVec";
private "_varName";

_bvfArray = + (_this select 0);

_building = _bvfArray select 0;
_position = _bvfArray select 1;
_direction = _bvfArray select 2;

_objecti = _building createVehicle [0,0,0];
_objecti setVectorUp [0,0,1];
_objecti setDir (_direction + (((PKS_BUILDING_TYPES getVariable _building) select 1) select 2));
_objecti setVectorUp ([surfaceNormal _position, [0,0,1]] select ((_position select 2) > 0.01));
_objecti setPosATL _position;
