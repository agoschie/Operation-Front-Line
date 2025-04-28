private ["_class", "_side", "_index", "_shopPos", "_obj"];
_side = _this select 0;
_class = ((uiNamespace getVariable format["PCS_SHOP_VEHICLES_LIST_%1", _side]) select (_this select 1)) select 0;
_shopPos = [getPosATL OPFL_WEST_SHOP, getPosATL OPFL_EAST_SHOP] select (_side == "E");
_shopPos = _shopPos findEmptyPosition [10, 50, _class];
_obj = _class createVehicle _shopPos;
_obj call GSC_EnableSZP;
TEST_OWNED_OBJECT = _obj;
_obj setPosATL _shopPos;
_obj lock true;
_obj setVariable ["PCS_SHOP_SIDE", _side, true];

_null = (_this + [_obj, _shopPos]) spawn
{
	private ["_side", "_index", "_uid", "_obj", "_pos", "_endTime"];
	_side = _this select 0;
	_index = _this select 1;
	_uid = _this select 2;
	_obj = _this select 3;
	_pos = _this select 4;
	_endTime = diag_tickTime + (((uiNamespace getVariable format["PCS_SHOP_VEHICLES_LIST_%1", _side]) select _index) select 5);
	
	waitUntil
	{
		if (alive _obj) then
		{
			if((_pos distance getPosATL _obj) > 10) then
			{
					if (((({alive _x} count crew _obj) > 0)) || !((_obj nearEntities ["Man", 10]) isEqualTo []) || (!((_obj nearEntities ["Man", 30]) isEqualTo []) && !([_obj] call GSC_IsDisabled))) then
					{
						_endTime = diag_tickTime + (((uiNamespace getVariable format["PCS_SHOP_VEHICLES_LIST_%1", _side]) select _index) select 5);
					};
			}
			else
			{
				_endTime = diag_tickTime + (((uiNamespace getVariable format["PCS_SHOP_VEHICLES_LIST_%1", _side]) select _index) select 5);
			};
		};
		(diag_tickTime > _endTime)
	};
	deleteVehicle _obj;
	PCS_RNK_SHOP_DATA setVariable [format ["SHOP_E%1_%2", _uid, _side], [PCS_RNK_SHOP_DATA getVariable [format ["SHOP_E%1_%2", _uid, _side], objNull], nil] select (isNull (PCS_RNK_SHOP_DATA getVariable [format ["SHOP_E%1_%2", _uid, _side], objNull]))];
	PCS_RNK_SHOP_DATA setVariable [format ["SHOP_%1_%2", ((uiNamespace getVariable format["PCS_SHOP_VEHICLES_LIST_%1", _side]) select _index) select 2, _side], (PCS_RNK_SHOP_DATA getVariable format ["SHOP_%1_%2", ((uiNamespace getVariable format["PCS_SHOP_VEHICLES_LIST_%1", _side]) select _index) select 2, _side]) - 1];
};
_obj;