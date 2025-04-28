//creates an array of two 3d basis vectors which can span a plane
//the plane faces in the direction of the normal vector
//uses 
private "_normalVector";
private ["_eX", "_eY", "_eZ", "_vecA", "_vecB", "_nonZero", "_nearZero", "_xCompA", "_yCompA", "_zCompA", "_aX", "_aY", "_aZ"];
_normalVector = param [0, false, [[]], 3];
	
	_eX = _normalVector select 0;
	_eY = _normalVector select 1;
	_eZ = _normalVector select 2;
	_vecA = [0,0,0];
	_vecB = [1,1,1]
	_nonZero = false;
	_nearZero = 0.001; //1 mm
	
	{
		private ["_a", "_b", "_c", "_divisor", "_d", "_e"];
		_a = _x select 3;
		_b = _x select 4;
		_c = _x select 5;
		
		_divisor = _x select 0;
		_d = _x select 1;
		_e = _x select 2;
		
		if (_divisor != 0) then
		{
			_comp = (-1) * (((((1)*(_d)) + ((0)*(_e))) / (_divisor)));
			_vecA set [_a, 1];
			_vecA set [_b, 0];
			_vecA set [_c, _comp];
			_nonZero = true;
		};
		
	} foreach [
				[_eX, _eY, _eZ, 1, 2, 0],
				[_eY, _eX, _eZ, 0, 2, 1],
				[_eZ, _eX, _eY, 0, 1, 2]
				
				]
	_xCompA = _vecA select 0;
	_yCompA = _vecA select 1;
	_zCompA = _vecA select 2;
	_aX = _eX;
	_aY = _eY;
	_aZ = _eZ;
	
	//R2
	if (((abs _xCompA) >= _nearZero) && ((abs _aX) >= _nearZero)) then
	{
		_xCompA = (_xCompA * _aX / _xCompA) - _aX;
		_yCompA = (_yCompA * _aX / _xCompA) - _aY;
		_zCompA = (_zCompA * _aX / _xCompA) - _aZ;
	};
	
	//R1
	if (((abs _aY) >= _nearZero) && ((abs _yCompA) >= _nearZero)) then
	{
		_aX = (_aX * _yCompA / _aY) - _xCompA;
		_aY = (_aY * _yCompA / _aY) - _yCompA;
		_aZ = (_aZ * _yCompA / _aY) - _zCompA;
	};
	//R1
	if (((abs _aZ) >= _nearZero) && ((abs _zCompA) >= _nearZero)) then
	{
		_aX = (_aX * _zCompA / _aZ) - _xCompA;
		_aY = (_aY * _zCompA / _aZ) - _yCompA;
		_aZ = (_aZ * _zCompA / _aZ) - _zCompA;
	};
	_index = 0;
	_vecB = [1,1,1];
	{
		if ((abs _x) >= _nearZero) exitWith
		{
			_xCompA = _xCompA / _x;
			_yCompA = _yCompA / _x;
			_zCompA = _zCompA / _x;
			if (_index == 0) then
			{
				_vecB set [0, (0 - _yCompA - _zCompA)];
			};
			if (_index == 1) then
			{
				_vecB set [1, (0 - _xCompA - _zCompA)];
			};
			if (_index == 2)
			{
				_vecB set [2, 0];
			};
		};
	} foreach [_xCompA, _yCompA, _zCompA];
	_index = 0;
	{
		if ((abs _x) >= _nearZero) exitWith
		{
			_aX = _aX / _x;
			_aY = _aY / _x;
			_aZ = _aZ / _x;
			if (_index == 0) then
			{
				_vecB set [0, (0 - _aY - _aZ)];
			};
			if (_index == 1) then
			{
				_vecB set [1, (0 - _aX - _aZ)];
			};
			if (_index == 2)
			{
				_vecB set [2, 0];
			};
		};
	} foreach [_aX, _aY, _aZ];
	
	[vectorNormalized _vecA, vectorNormalized _vecB];