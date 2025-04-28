private "_angle";
_angle = _this select 0;
//player SideChat format ["BEGIN: %1", _angle];
if (isNil "PCS_SHOP_NormalizeAngle_SNP") then
{
	PCS_SHOP_NormalizeAngle_SNP = "logic" createVehicleLocal [0,0,0];
};
PCS_SHOP_NormalizeAngle_SNP setDir _angle;
_angle = getDir PCS_SHOP_NormalizeAngle_SNP;
if (360 == floor _angle) then
{
	_angle = _angle - 360;
};
//player SideChat format ["END: %1", _angle];
_angle;