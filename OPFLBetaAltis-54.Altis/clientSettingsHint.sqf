//////////////////////////////////////////////////////////////////
// Function file for Armed Assault clientSettingsHint.sqf
// Created by: [2]18|PVT.Pirin
//////////////////////////////////////////////////////////////////
hintCurrentWeather = "";

switch (paramsarray select 1) do {
  case 0: { 0 setOvercast 0; 0 setRain 0; 0 setFog 0; hintCurrentWeather = "Clear"; };
  case 1: { 0 setOvercast 1; 0 setRain 1; 0 setFog 0.2; hintCurrentWeather = "Stormy"; };
  case 2: { 0 setOvercast 0.7; 0 setRain 0; 0 setFog 0; hintCurrentWeather = "Cloudy"; };
  case 3: { 0 setOvercast 0.7; 0 setRain 1; 0 setFog 0.7; hintCurrentWeather = "Foggy"; };
};

publicVariable "hintCurrentWeather";