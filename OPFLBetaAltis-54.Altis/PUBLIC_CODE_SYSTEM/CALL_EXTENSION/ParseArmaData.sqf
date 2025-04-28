//this is a recursive function

	/**parse arma data/message **/
	/******
	$ = string
	# = float
	+ = unsigned int
	- = signed int
	* = void * address - example is 32bit address - *FFFFFFFF
	@ = array - example is mixed array - @[$some string, #45.5, +100, --100, *FFFFFFFF]

	string format of ArmaData is "$stringdata"
	string format of ArmaMessage is "functionName,$stringdata"
	or for instance an array of floats
	"functionName,@[#34.3,#45.0,#31.2,#80]" ect
	******/

#define AD_STRING '$'
#define AD_FLOAT '#'
#define AD_UNSIGNED '+'
#define AD_SIGNED '-'
#define AD_ADDRESS '*'
#define AD_ARRAY '@'
#define AD_NULL toString [0]
#define AD_SEPERATOR ','
#define AD_AS_RIGHT ']'
#define AD_AS_LEFT '['
#define AD_UNIT toString [31]
#define CMPR [AD_STRING, '#', AD_UNSIGNED, AD_SIGNED, AD_ADDRESS, AD_ARRAY]

private ["_data", "_return", "_go"];
_go = true;
if ("STRING" == typeName _this) then
{
	if (_this == "@[]") then
	{
		_return = [];
		_go = false;
	};
	_data = toArray _this;
}
else
{
	_data = _this - [-1];
};

if (_go) then
{
if ((toString [_data select 0]) == AD_ARRAY) then
{
	_data deleteRange [0, 2];
	_return = [];
	private ["_unpause", "_arr", "_field"];
	_unpause = true;
	_arr = 0;
	_field = [];
	{
	
		if (31 == _x) then
		{
			_unpause = !_unpause;
			_field pushBack _x;
		}
		else
		{
			if (((91 == _x) || (_x == 93)) && _unpause) then
			{
				_arr = _arr + 92 - _x;
				_field pushBack _x;
			}
			else
			{
				if ((44 == _x) && _unpause && (_arr < 1)) then
				{
					_return pushBack (_field call PCS_ParseArmaData);
					_field = [];
				}
				else
				{
					_field pushBack _x;
				};
			};
		};
	} foreach _data;
	_field deleteAt ((count _field) - 1); //final field, trim end of data array that got pushed in
	_return pushBack (_field call PCS_ParseArmaData);
}
else
{
	private "_temp";
	_temp = toString [_data select 0];
	if (_temp in [AD_STRING, '#', AD_UNSIGNED, AD_SIGNED, AD_ADDRESS, AD_ARRAY]) then
	{
		_data deleteAt 0;
		if (_temp == AD_STRING || _temp == AD_ADDRESS) then
		{
			if (_temp == AD_STRING) then
			{
				_return = toString (_data - (toArray AD_UNIT));
			}
			else
			{
				_return = composeText [toString (_data - (toArray AD_UNIT))]; //we will treat addresses as text instead of string
			};
		}
		else
		{
			_return = parseNumber (toString _data);
		};
	}
	else
	{
		_return = [];
		private "_noData";
		_noData = true;
		{
			_return pushBack _x;
			if ((toString [_x]) == AD_SEPERATOR) exitWith
			{
				_data set [_forEachIndex, -1];
				_return = [toString _return];
				_return pushBack (_data call PCS_ParseArmaData);
				_noData = false;
			};
			_data set [_forEachIndex, -1];
		} foreach _data;
		if (_noData) then
		{
			_return = toString _return;
		};
	};
};
};
_return;
