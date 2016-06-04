
private["_handled","_ctrl","_code","_shift","_ctrlKey","_alt"];
_handled = false;
_ctrl = _this select 0;
_code = _this select 1;
_shift = _this select 2;
_ctrlKey = _this select 3;
_alt = _this select 4;

switch (_code) do
{
	//Holster / recall weapon.
	case 35:
	{
		if(_shift && !_ctrlKey && currentWeapon player != "") then {
			pa_cur_wep = currentWeapon player;
			player action ["SwitchWeapon", player, player, 100];
			player switchcamera cameraView;
		};
		
		if(!_shift && _ctrlKey && !isNil "pa_cur_wep" && {(pa_cur_wep != "")}) then {
			if(pa_cur_wep in [primaryWeapon player,secondaryWeapon player,handgunWeapon player]) then {
				player selectWeapon pa_cur_wep;
			};
		};
		_handled = true;
	};
	
	//Space key for Jumping
	case 57:
	{
		if(isNil "jumpActionTime") then {jumpActionTime = 0;};
		if(_shift && {animationState player != "AovrPercMrunSrasWrflDf"} && {isTouchingGround player} && {stance player == "STAND"} && {speed player > 2} && {!life_is_arrested} && {(velocity player) select 2 < 2.5} && {time - jumpActionTime > 1.5}) then {
			jumpActionTime = time; //Update the time.
			[player,true] spawn "scripts\jump.sqf"; //Local execution
			[[player,false],"scripts\jump.sqf",nil,FALSE] spawn_BIS_fnc_MP; //Global execution 
			_handled = true;
		};
	};
};
_handled;