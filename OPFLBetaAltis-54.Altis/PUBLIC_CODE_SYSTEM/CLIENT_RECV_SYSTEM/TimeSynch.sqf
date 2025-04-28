if (isServer) then
{
	private "_delay";
	private "_wait";
	_wait = 1;
	_delay = 5;
	while {_wait == 1} do
	{
		sleep _delay;
		PCS_TIME_SYNCH = date;
		publicVariable "PCS_TIME_SYNCH";
	};
}
else
{
	"PCS_TIME_SYNCH" addPublicVariableEventHandler
	{
		private "_publicName";
		private "_publicValue";
		private "_minute";
		private "_hour";
		private "_day";
		private "_month";
		private "_year";
		private "_cYear";
		private "_cMonth";
		private "_cDay";
		private "_cHour";
		private "_cMinute";
		private "_cDate";
	
		_publicName = _this select 0;
		_publicValue = _this select 1;
	
		_year = _publicValue select 0;
		_month = _publicValue select 1;
		_day = _publicValue select 2;
		_hour = _publicValue select 3;
		_minute = _publicValue select 4;
	
		_cDate = date;
		_cYear = _cDate select 0;
		_cMonth = _cDate select 1;
		_cDay = _cDate select 2;
		_cHour = _cDate select 3;
		_cMinute = _cDate select 4;
	
		if
		(
		(_year != _cYear) ||
		(_month != _cMonth) ||
		(_day != _cDay) ||
		(_hour != _cHour) ||
		((abs (_minute - _cMinute)) >= 5)
		) then
		{
			setDate _publicValue;
			hint format (["TIME SYNCH: %2\%3\%1 %4:%5"] + _publicValue);
		};
	};
};