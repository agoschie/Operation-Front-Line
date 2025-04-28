/***************************************************************************
PCS_syncWeather.sqf
Version: 0-1-0
Created by: Spyder and Goschie
28 Nov 2010
****************************************************************************/
private "_rain";
private "_fog";
private "_overcast";
_rain = _this select 0;
_fog = _this select 1;
_overcast = _this select 2;
// _wind = _this select 3;

0 setRain _rain;
0 setFog _fog;
0 setOvercast _overcast;
// 0 setWind _wind;

PCS_WEATHER_SYNCHRONIZED = true;