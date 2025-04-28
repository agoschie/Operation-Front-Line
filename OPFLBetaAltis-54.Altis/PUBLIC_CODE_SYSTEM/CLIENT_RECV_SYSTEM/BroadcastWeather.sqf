/***************************************************************************
PCS_broadcastWeather.sqf
Version: 0-1-0
Created by: Spyder and Goschie
28 Nov 2010
****************************************************************************/

_null = [[rain, fog, overcast], "PCS_SyncWeatherMsg", (_this select 0)] spawn PCS_MPCodeBroadcast;