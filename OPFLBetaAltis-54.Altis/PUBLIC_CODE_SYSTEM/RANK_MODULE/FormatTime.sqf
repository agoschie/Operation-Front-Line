private "_playtime";
private "_ZH";
private "_ZM";
private "_ZS";
private "_sZH";
private "_sZM";
private "_sZS";
private "_playtimeHMS";

_playtime = _this select 0;

_ZH = floor (_playtime / 3600);
_ZM = floor ((_playtime / 60) - (_ZH * 60));
_ZS = (_playtime - ((_ZH * 3600) + (_ZM * 60)));
if (_ZH < 10) then
{
	_sZH = format ["0%1", _ZH];
}
else
{
	_sZH = _ZH;
};
if (_ZM < 10) then
{
	_sZM = format ["0%1", _ZM];
}
else
{
	_sZM = _ZM;
};
if (_ZS < 10) then
{
	_sZS = format ["0%1", _ZS];
}
else
{
	_sZS = _ZS;
};

_playtimeHMS = format["%1:%2:%3", _sZH, _sZM, _sZS];
_playtimeHMS;