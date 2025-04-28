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

private ["_data", "_return", "_count"];

_data = _this;
_return = "";

switch (typeName _data) do
{
	case "ARRAY": 
	{
		_return = format ["%1%2", AD_ARRAY, AD_AS_LEFT];
		_count =
		{
			_return	= format ["%1%2%3", _return, _x call PCS_DeparseArmaData, AD_SEPERATOR];
			true
		} count _data;
		if (_count > 0) then
		{
			_return = toArray _return;
			_return deleteAt ((count _return) - 1); //delete last comma
			_return = toString _return;
		};
		_return = format ["%1%2", _return, AD_AS_RIGHT];
		
	};
	case "BOOL": {_return = format ["%1%2", AD_UNSIGNED, [0, 1] select (_data)];};
	case "SCALAR": 
	{
		if (_data == round _data) then
		{
			_return = format ["%1%2", '-', _data]; //we do not have enough information to tell if its unsiqned (natural)	
		}
		else
		{
			_return = format ["%1%2", '#', _data];
		};
	};
	case "TEXT": {_return = format ["%1%2", AD_ADDRESS, _data];};
	default {_return = format ["%1%2%3%4", AD_STRING, AD_UNIT, _data, AD_UNIT];};
};
_return;



