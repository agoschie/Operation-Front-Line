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

private ["_return"];

_return = format ["%1,%2", _this select 1, (_this select 2) call PCS_DeparseArmaData];
diag_log _return;
_return = (_this select 0) callExtension _return;
_return = _return call PCS_ParseArmaData;
_return;