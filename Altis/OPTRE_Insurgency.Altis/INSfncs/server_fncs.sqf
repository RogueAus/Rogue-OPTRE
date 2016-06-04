remove_carcass_fnc = {
	// Deletes dead bodies and destroyed vehicles. Code by BIS
	_unit = _this select 0;
	sleep 2;
	if (not (_unit isKindOf "Man")) then {
		{_x setPos position _unit} forEach crew _unit;
		sleep 45.0;
		deleteVehicle _unit;
	};
	if (_unit isKindOf "Man") then {
		if(not ((vehicle _unit) isKindOf "Man")) then {_unit setPos (position vehicle _unit)};
		sleep 60.0;
		hideBody _unit;
		_unit removeAllEventHandlers "killed";
	};
};
BTC_m_fnc_only_server = {
	_array = _this select 1;
	_type  = _array select 0;
	if (_type isEqualTo 0) then	{
		private ["_veh"];
		_veh = _array select 1;
		_veh spawn BTC_server_repair_wreck;
	}
	else
	{};
};
BTC_AIunit_init = {
	// sets skill of a unit if ASR AI is not detected
	_unit = _this select 0;
	if (isClass(configFile >> "cfgPatches" >> "asr_ai_main")) exitWith {};
	_unit setSkill ["aimingAccuracy", BTC_AI_skill];
	_unit setSkill ["aimingShake", 0.6];
	_unit setSkill ["aimingSpeed", 0.5];
	_unit setSkill ["endurance", 0.6];
	_unit setSkill ["spotDistance", 0.6];
	_unit setSkill ["spotTime", 0.5];
	_unit setSkill ["courage", 0.5];
	_unit setSkill ["reloadSpeed", 1];
	if (_unit isEqualTo (leader group _x)) then	{
		_unit setSkill ["commanding", 1];
	};
	_unit setSkill ["general", 0.6];
};
BTC_AI_init = {
	// sets skill of a group if ASR AI is not detected
	_group = _this select 0;
	if (isClass(configFile >> "cfgPatches" >> "asr_ai_main")) exitWith {};
	{
		_x setSkill ["aimingAccuracy", BTC_AI_skill];
		_x setSkill ["aimingShake", 0.6];
		_x setSkill ["aimingSpeed", 0.5];
		_x setSkill ["endurance", 0.6];
		_x setSkill ["spotTime", 0.5];
		_x setSkill ["courage", 0.5];
		_x setSkill ["spotDistance", 0.6];
		_x setSkill ["reloadSpeed", 1];
		if (leader _group isEqualTo _x) then {
			_x setSkill ["commanding", 1];
		};
		_x setSkill ["general", 0.6];
	} forEach units _group;
};
paint_heli_fnc = {
	// by Jigsor.
	private "_veh";
	_veh = _this select 0;

	switch (true) do {
		case (toLower (worldName) isEqualTo "altis"):
		{// dark grey
			_veh setObjectTextureGlobal [0,"#(argb,8,8,3)color(0.518,0.519,0.455,0.2)"];
			_veh setObjectTextureGlobal [1,"#(argb,8,8,3)color(0.518,0.519,0.455,0.2)"];
			_veh setObjectTextureGlobal [2,"#(argb,8,8,3)color(0.518,0.519,0.455,0.2)"];
		};
		case (toLower (worldName) isEqualTo "fallujah"):
		{// sand color
			_veh setObjectTextureGlobal [0,"#(argb,8,8,3)color(0.96,0.88,0.69,0.35)"];
			_veh setObjectTextureGlobal [1,"#(argb,8,8,3)color(0.96,0.88,0.69,0.35)"];
			_veh setObjectTextureGlobal [2,"#(argb,8,8,3)color(0.96,0.88,0.69,0.35)"];
		};
		case (toLower (worldName) isEqualTo "pja305"):
		{// green
			_veh setObjectTextureGlobal [0,"#(argb,8,8,3)color(0.550,0.620,0.4,0.1)"];
			_veh setObjectTextureGlobal [1,"#(argb,8,8,3)color(0.550,0.620,0.4,0.1)"];
			_veh setObjectTextureGlobal [2,"#(argb,8,8,3)color(0.550,0.620,0.4,0.1)"];
		};
		case (toLower (worldName) isEqualTo "takistan"):
		{// sand color
			_veh setObjectTextureGlobal [0,"#(argb,8,8,3)color(0.96,0.88,0.69,0.35)"];
			_veh setObjectTextureGlobal [1,"#(argb,8,8,3)color(0.96,0.88,0.69,0.35)"];
			_veh setObjectTextureGlobal [2,"#(argb,8,8,3)color(0.96,0.88,0.69,0.35)"];
		};
		case (toLower (worldName) isEqualTo "zargabad"):
		{// sand color
			_veh setObjectTextureGlobal [0,"#(argb,8,8,3)color(0.96,0.88,0.69,0.35)"];
			_veh setObjectTextureGlobal [1,"#(argb,8,8,3)color(0.96,0.88,0.69,0.35)"];
			_veh setObjectTextureGlobal [2,"#(argb,8,8,3)color(0.96,0.88,0.69,0.35)"];
		};
		case (toLower (worldName) isEqualTo "stratis"):
		{// dark grey
			_veh setObjectTextureGlobal [0,"#(argb,8,8,3)color(0.518,0.519,0.455,0.2)"];
			_veh setObjectTextureGlobal [1,"#(argb,8,8,3)color(0.518,0.519,0.455,0.2)"];
			_veh setObjectTextureGlobal [2,"#(argb,8,8,3)color(0.518,0.519,0.455,0.2)"];
		};
		case (toLower (worldName) isEqualTo "fata"):
		{// sand color
			_veh setObjectTextureGlobal [0,"#(argb,8,8,3)color(0.96,0.88,0.69,0.35)"];
			_veh setObjectTextureGlobal [1,"#(argb,8,8,3)color(0.96,0.88,0.69,0.35)"];
			_veh setObjectTextureGlobal [2,"#(argb,8,8,3)color(0.96,0.88,0.69,0.35)"];
		};
		case (toLower (worldName) isEqualTo "sara"):
		{// dark grey
			_veh setObjectTextureGlobal [0,"#(argb,8,8,3)color(0.518,0.519,0.455,0.2)"];
			_veh setObjectTextureGlobal [1,"#(argb,8,8,3)color(0.518,0.519,0.455,0.2)"];
			_veh setObjectTextureGlobal [2,"#(argb,8,8,3)color(0.518,0.519,0.455,0.2)"];
		};
		case (toLower (worldName) isEqualTo "kunduz"):
		{// sand color
			_veh setObjectTextureGlobal [0,"#(argb,8,8,3)color(0.96,0.88,0.69,0.35)"];
			_veh setObjectTextureGlobal [1,"#(argb,8,8,3)color(0.96,0.88,0.69,0.35)"];
			_veh setObjectTextureGlobal [2,"#(argb,8,8,3)color(0.96,0.88,0.69,0.35)"];
		};
		case (toLower (worldName) isEqualTo "pja310"):
		{// sand color
			_veh setObjectTextureGlobal [0,"#(argb,8,8,3)color(0.96,0.88,0.69,0.35)"];
			_veh setObjectTextureGlobal [1,"#(argb,8,8,3)color(0.96,0.88,0.69,0.35)"];
			_veh setObjectTextureGlobal [2,"#(argb,8,8,3)color(0.96,0.88,0.69,0.35)"];
		};
		case (toLower (worldName) isEqualTo "bornholm"):
		{// green
			_veh setObjectTextureGlobal [0,"#(argb,8,8,3)color(0.550,0.620,0.4,0.1)"];
			_veh setObjectTextureGlobal [1,"#(argb,8,8,3)color(0.550,0.620,0.4,0.1)"];
			_veh setObjectTextureGlobal [2,"#(argb,8,8,3)color(0.550,0.620,0.4,0.1)"];
		};
		case (toLower (worldName) isEqualTo "mog"):
		{// sand color
			_veh setObjectTextureGlobal [0,"#(argb,8,8,3)color(0.96,0.88,0.69,0.35)"];
			_veh setObjectTextureGlobal [1,"#(argb,8,8,3)color(0.96,0.88,0.69,0.35)"];
			_veh setObjectTextureGlobal [2,"#(argb,8,8,3)color(0.96,0.88,0.69,0.35)"];
		};
		case (toLower (worldName) isEqualTo "clafghan"):
		{// sand color
			_veh setObjectTextureGlobal [0,"#(argb,8,8,3)color(0.96,0.88,0.69,0.35)"];
			_veh setObjectTextureGlobal [1,"#(argb,8,8,3)color(0.96,0.88,0.69,0.35)"];
			_veh setObjectTextureGlobal [2,"#(argb,8,8,3)color(0.96,0.88,0.69,0.35)"];
		};
		default {};
	};
};
add_UAV_crew = {
	// add crew to UAV/UGV.
	private "_veh";
	_veh = _this select 0;
	createVehicleCrew _veh;
};
add_veh_flare = {
	// add flares
	private "_veh";
	_veh = _this select 0;
	_veh addweapon "CMFlareLauncher";
	_veh addmagazine "120Rnd_CMFlare_Chaff_Magazine";
};
remove_veh_ti = {
	// remove vehicle thermal imaging
	private "_veh";
	_veh = _this select 0;
	_veh disableTIEquipment true;
};
fnc_ghst_build_positions = {
	/*
	//building positions function for one building
	//_build_positions = _building call fnc_ghst_find_positions;
	*/
	private ["_i","_p","_b"];
	_i = 0;
	_b = [];
	_build_positions = [];
	_pIsEmpty = false;

	while { ! _pIsEmpty } do {
		_p = _this buildingPos _i;

		if (( str _p != "[0,0,0]" ) and !(_this iskindof "Piers_base_F")) then {
			_b = _b + [_p];
		}else{
			_pIsEmpty = true;
		};
		_i = _i + 1;
	};
	if ((count _b > 0) and !(isNil "_b")) then {
		_build_positions = _build_positions + _b;
	};

	_build_positions
};
fnc_ghst_rand_position = {
	/*
	//Find Random Position in a rectangle radius
	//_pos = [[1,1,2],[300,500,60]] call fnc_ghst_rand_position;
	//_pos = ["marker",[]] call fnc_ghst_rand_position;
	*/
	private ["_dir","_position_mark","_radx","_rady","_pos","_xpos","_ypos"];

	_pos_mark = _this select 0;//position or marker
	_radarray = _this select 1;//array of x,y radius and direction
	_wateronly = if (count _this > 2) then {_this select 2;} else {false;};//get position in water only

	if (typeName _pos_mark == typeName []) then {
		_position_mark = _pos_mark;//position array
		_radx = _radarray select 0;//radius A if position is Not a marker
		_rady = _radarray select 1;//radius B if position is Not a marker
		_dir = _radarray select 2;
		if (isNil "_dir") then {
		_dir = (random 360) * -1;//random direction if not given
		}else{
		_dir = (_radarray select 2) * -1;//specified direction
		};
	}else{
		_position_mark = (getmarkerpos _pos_mark);//getmarker position
		_radx = (getMarkerSize _pos_mark) select 0;//radius A if position is a marker
		_rady = (getMarkerSize _pos_mark) select 1;//radius b if position is a marker
		_dir = (markerDir _pos_mark) * -1;//Marker Direction
	};
	_loop = true;
	while {_loop} do {
		_rx = (random (_radx * 2)) - _radx;
		_ry = (random (_rady * 2)) - _rady;
		if (_dir != 0) then {
			_xpos = (abs(_position_mark select 0)) + ((cos _dir) * _rx - (sin _dir) * _ry);
			_ypos = (abs(_position_mark select 1)) + ((sin _dir) * _rx + (cos _dir) * _ry);
		}else{
			_xpos = (abs(_position_mark select 0)) + _rx;
			_ypos = (abs(_position_mark select 1)) + _ry;
		};
		_pos = [_xpos,_ypos,0];
		if (!_wateronly and !(surfaceIsWater [_pos select 0,_pos select 1])) then {_loop = false};
		if (_wateronly and (surfaceIsWater [_pos select 0,_pos select 1])) then {_loop = false};
	};
	_pos
};
JIG_ammmoCache_damage = {
	// Restrict damage to be taken only when satchel or charge used, delete cache box, add score to explosive setter, side chat who destroyed cache, add vehicle reward to cache destroyer. by Jigsor
    _cache = _this select 0;
    _damage = _this select 2;
    _source = _this select 3;
    _ammo = _this select 4;
    _out = 0;

    if ((_ammo == "satchelCharge_remote_ammo") || (_ammo == "demoCharge_remote_ammo") || (_ammo == "satchelCharge_remote_ammo_scripted") || (_ammo == "demoCharge_remote_ammo_scripted")) then {
        _cache spawn {
            sleep 0.1;
            _this setDamage 1;
            sleep 2;

			//Block from Insurgency by Fireball, Kol9yN
			private ["_pos","_dur","_count","_veh","_bObj"];
			_pos = getPosATL(_this);

			_bObj = nearestBuilding _pos;
			[[_bObj, true], "allowDamage", false] call BIS_fnc_MP;

			curTime	= time;
			_dur = 5 + random 5;
			deleteVehicle _this;
			"Bo_Air_LGB" createVehicle _pos;
			while{ (time - curTime) < _dur } do {
			_veh = "Bo_Air_LGB" createVehicle _pos;
			_veh setVectorDirAndUp [[(random 1) -0.5,(random 1)-0.5,(random 1) -0.5],[0,(random -1.5),(random 1) -0.5]];//Jig adding
			sleep random 1;
			};
			"Bo_Air_LGB" createVehicle _pos; 
        };
		[_source] spawn {
			_source = _this select 0;
			if (side _source == INS_Blu_side) then {
				_pScore = 20;
				_source addrating 2000;
				_source addScore _pScore;
				paddscore = [_source, _pscore]; publicVariable "paddscore";
				[West,"HQ"] sideChat "+20 points";
				if (!isNull _source) then {
					rewardp = getPlayerUID _source;
					publicVariable "rewardp";
					_destroyerName = name _source;
					_text = format [localize "STR_BMR_who_destroyed_ammocache",_destroyerName];
					[[_text],"JIG_MPsideChatWest_fnc"] call BIS_fnc_mp;
				};
			}else{
				_pScore = -10;
				_source addScore _pScore;
				paddscore = [_source, _pscore]; publicVariable "paddscore";
				[East,"HQ"] sideChat "-10 points";
				};
			};
		};
    _out
};
JIG_tower_damage = {
	// Restrict damage to be taken only when satchel or charge used, delete undamaged tower model, add score to explosive setter, side chat who destroyed tower. by Jigsor
    _tower = _this select 0;
    _damage = _this select 2;
    _source = _this select 3;
    _ammo = _this select 4;
    _out = 0;

	if ((_ammo == "satchelCharge_remote_ammo") || (_ammo == "demoCharge_remote_ammo") || (_ammo == "satchelCharge_remote_ammo_scripted") || (_ammo == "demoCharge_remote_ammo_scripted")) then {
        _tower spawn {
            sleep 0.1;
            _this setDamage 1;
            sleep 3;
            deleteVehicle _this;
        };
		if (!isNull _source) then {
			_destroyerName = name _source;
			_text = format [localize "STR_BMR_who_destroyed_tower",_destroyerName];
			[[_text],"JIG_MPsideChatWest_fnc"] call BIS_fnc_mp;
		};
    };
    _out
};
killed_ss_bmbr_fnc = {
	// Add suicide bomber evidence and chance of deadMan switch by SupahG33K
	// Add point/rating back to killer of civilian bomber. by Jigsor
	_bmbr = _this select 0;
	_killer = _this select 1;
	_pRating = rating _killer;// Jig adding low rating deterrent for killing innocent civilians.

	if (!isNull _killer) then {// no deadman switch if bomb detonates
		//SupahG33K - random deadMan-switch detonation. Small explosion when bomber killed (not full power)
		_detChance = floor(random 100);
		if((_detChance < 33) || (_pRating < 10000)) then {
			_bmbr spawn {
				_maxtype = (count suicide_bmbr_deadman)-1;
				_miniexplosive = suicide_bmbr_deadman select (round random _maxtype);
				_explosive = _miniexplosive createVehicle (position _this);
				sleep jig_tvt_globalsleep;
				_explosive setDamage 1;
			};
		};
	};

	//SupahG33K - Add small grenade to body for identification purposes
	_maxTypeEvidence = (count suicide_bmbr_miniweps)-1;
	_miniExplosiveEvidence = suicide_bmbr_miniweps select (round random _maxTypeEvidence);
	_bmbr addItemToUniform _miniExplosiveEvidence;
	_bmbr addMagazines [_miniExplosiveEvidence,1];

	_pScore = 1;
	_killer addrating 1000;
	_killer addScore _pScore;
	paddscore = [_killer, _pscore]; publicVariable "paddscore";
	true
};
bmbr_spawnpos_fnc = {
	// Suicide bomber random position. by Jigsor
	private ["_posnotfound","_counter","_goodPos","_cooX","_cooY","_startPos","_newPos","_marker2","_sudoNewPos","_eastbase1a","_westbase1a","_westbase2a","_wheX","_wheY","_disX","_disY"];

	_cooX = _this select 0;
	_cooY = _this select 1;
	_disX = [110,135] call BIS_fnc_randomInt;
	_disY = [110,135] call BIS_fnc_randomInt;
	_wheX = random (_disX*2)-_disX;
	_wheY = random (_disY*2)-_disY;
	_startPos = [_cooX+_wheX,_cooY+_wheY,0];
	_posnotfound = [];
	_goodPos = [];
	_counter = 0;

	_newPos = _startPos isFlatEmpty [15,384,0.5,2,0,false,ObjNull];
	while {(count _newPos) < 1} do {
		_newPos = _startPos isFlatEmpty [10,384,0.7,2,0,false,ObjNull];
		_counter = _counter + 1;
		if (DebugEnabled > 0) then {hintSilent "finding suitable pos for sstBomber";};
		if (_counter > 5) exitWith {_goodPos = [];};
		sleep 1;
	};

	if (!(_newPos isEqualTo [])) then {
		if (!isNil "tempBMRBmrkr") then {deleteMarkerLocal "tempBMRBmrkr";};
		_marker2 = createMarkerLocal ["tempBMRBmrkr", _newPos];
		_marker2 setMarkerShapeLocal "ELLIPSE";
		"tempBMRBmrkr" setMarkerSizeLocal [1, 1];
		"tempBMRBmrkr" setMarkerShapeLocal "ICON";
		"tempBMRBmrkr" setMarkerTypeLocal "EMPTY";//"mil_dot"
	};

	if (_newPos isEqualTo []) exitWith {_posnotfound;};
	_newPos
};
sta_spawnpos_fnc = {
	// Objective static placement. by Jigsor
	private ["_posnotfound","_counter","_dis","_cooX","_cooY","_wheX","_wheY","_startPos","_newPos","_marker2","_sudoNewPos","_eastbase1a","_westbase1a","_westbase2a"];

	_cooX = _this select 0;
	_cooY = _this select 1;
	_dis = 150;
	_wheX = random (_dis*2)-_dis;
	_wheY = random (_dis*2)-_dis;
	_startPos = [_cooX+_wheX,_cooY+_wheY,0];
	_posnotfound = [];
	_counter = 0;
	_newPos = _startPos isFlatEmpty [20,384,0.4,2,0,false,ObjNull];

	while {(count _newPos) < 1} do {
		_newPos = _startPos isFlatEmpty [14,384,0.6,2,0,false,ObjNull];
		_counter = _counter + 1;
		if (_counter > 5) exitWith {_posnotfound = [];};
		sleep 0.5;
	};

	if (_newPos isEqualTo []) exitWith {_posnotfound;};
	_newPos;
};
miss_object_pos_fnc = {
	// Objective position. by Jigsor
	private ["_posnotfound","_counter","_goodPos","_dis","_cooX","_cooY","_wheX","_wheY","_ObjRandomPos","_newPos","_marker2"];

	_cooX = _this select 0;
	_cooY = _this select 1;
	_dis = 150;
	_wheX = random (_dis*2)-_dis;
	_wheY = random (_dis*2)-_dis;
	_ObjRandomPos = [_cooX+_wheX,_cooY+_wheY,0];
	_posnotfound = [];
	_goodPos = [];
	_newPos = _ObjRandomPos isFlatEmpty [25,384,0.4,2,0,false,ObjNull];

	while {(count _newPos) < 1} do {
		_newPos = _ObjRandomPos isFlatEmpty [20,384,0.6,2,0,false,ObjNull];
		_dis = _dis + 50;
		_wheX = random (_dis*2)-_dis;
		_wheY = random (_dis*2)-_dis;
		_ObjRandomPos = [_cooX+_wheX,_cooY+_wheY,0];
		if (_dis > 550) exitWith {_goodPos = [];};
		sleep 0.5;
	};

	if (!(_newPos isEqualTo [])) then {
		if (!isNil "tempObjMkr") then {deleteMarkerLocal "tempObjMkr";};
		_marker2 = createMarkerLocal ["tempObjMkr", _newPos];
		_marker2 setMarkerShapeLocal "ELLIPSE";
		"tempObjMkr" setMarkerSizeLocal [1, 1];
		"tempObjMkr" setMarkerShapeLocal "ICON";
		"tempObjMkr" setMarkerTypeLocal "mil_dot";//"EMPTY"
	};
	if (_newPos isEqualTo []) exitWith {_posnotfound;};
	_newPos;
};
opfor_NVG = {
	// Add NVG to all existing enemy AI units by Jigsor.
	private "_ai";
	_ai = allUnits;
	{if (isPlayer _x) then {_ai =_ai - [_x];};} count _ai;
	{
		if (side _x isEqualTo resistance) then {
			_x unlinkItem "NVGoggles_INDEP";
			_x linkItem "NVGoggles_INDEP";
		}else{
			if (side _x isEqualTo east) then {
				_x unlinkItem "NVGoggles_OPFOR";
				_x linkItem "NVGoggles_OPFOR";
			};
		};
		_x addPrimaryWeaponItem "acc_flashlight";
		_x enableGunLights "forceOn";//"AUTO"
	} forEach _ai;
};
editorAI_GasMask = {
	// Add Gas Masks to all existing AI units by Jigsor.
	private "_ai";
	_ai = allUnits;
	{if (isPlayer _x) then {_ai =_ai - [_x];};} count _ai;
	{
		removeHeadgear _x;
		if (side _x isEqualTo resistance) then {_x addHeadgear "H_CrewHelmetHeli_I";};
		if (side _x isEqualTo east) then {_x addHeadgear "H_CrewHelmetHeli_O";};
		If (side _x isEqualTo west) then {_x addHeadgear "H_CrewHelmetHeli_B";};
	} count _ai;
};
JIPmkr_updateClient_fnc = {
	// Local client maker states update. by Jigsor
	_coloredMarkers=server getVariable "IntelMarkers";
	if (isNil {server getVariable "IntelMarkers"}) exitWith {};
	{
		_x setMarkerType (getMarkerType _x);
		_x setMarkercolor (getMarkercolor _x);
		_x setMarkerAlpha (MarkerAlpha _x);
	} forEach _coloredMarkers;
	true
};
curr_EOSmkr_states_fnc = {
	private ["_colorArr","_coloredEOSmkrs","_color"];
	_colorArr = [];
	_coloredEOSmkrs=server getVariable "EOSmarkers";
	{
		_color = getMarkercolor _x;
		_colorArr pushBack _color;
	} forEach _coloredEOSmkrs;
	server setVariable ["EOSmkrStates",_colorArr,true];
	true
};
find_bombee_fnc = {
	// Find suicide bomber player target. by Jigsor
	private ["_missionPlayers","_bombee_speed"];
	_missionPlayers = playableUnits;

	{
		_bombee_speed = speed _x;
		_pos = (getPosATL _x);
		if ((_bombee_speed > 8) || (_pos select 2 > 3)) then {_missionPlayers = _missionPlayers - [_x];};
	} count _missionPlayers;// exclude players in moving vehicles, exclude above ground players such as players in aircraft or in high structures

	{if (side _x isEqualTo east) then {_missionPlayers = _missionPlayers - [_x];};} count _missionPlayers;// exclude east players

	if (count _missionPlayers > 0) then	{
		random_w_player4 = _missionPlayers select (floor (random (count _missionPlayers)));
		publicVariable "random_w_player4";
	};
	true
};
find_civ_bomber_fnc = {
	//Look for a suitable draftee by SupahG33K. Slightly modified by Jigsor.
	private ["_foundCiv","_civs","_closestEntity","_text"];
	_foundCiv = false;

	if (isNil "random_w_player4") exitWith {true};  //No/Bad target

	_civs = random_w_player4 nearEntities ["CAManBase",300];
	_civs deleteAt 0;

	//Filter _civs array for CIVILIANS, take the closest one found
	{
		if (count _civs != 0) then {
			_closestEntity = _civs select 0;
			if ((side _closestEntity == CIVILIAN) && {(!isPlayer _closestEntity)}) then {
				random_civ_bomber = _closestEntity;
				publicVariable "random_civ_bomber";
				_foundCiv = true;
				//diag_log text format ["SupahG33K - Civilian Jihadi Draftee found object: %1", random_civ_bomber];
				//_text = format ["SupahG33K - Civilian Jihadi Draftee found object: %1 class: %2", random_civ_bomber, typeOf random_civ_bomber]; [_text,"JIG_MPhint_fnc"] call BIS_fnc_mp;
			}else{
				_civs deleteAt 0;
			};
		};
		if(_foundCiv) exitWith{_foundCiv};  //Found a candidate, bail
	} forEach _civs;
	true
};
spawn_Op4_grp = {
	// Creates infantry group. by Jigsor
	private ["_newZone","_grp_size","_grp","_unit_type","_damage","_unit"];
	_newZone = _this select 0;
	_grp_size = _this select 1;
	_grp = createGroup INS_Op4_side;

	for "_i" from 0 to (_grp_size - 2) do {
		_unit_type = INS_men_list select (round (random ((count INS_men_list) - 1)));
		_unit = _grp createUnit [_unit_type, _newZone, [], 0, "NONE"];
		sleep 0.5;
	};
	_grp createUnit [INS_Op4_medic, _newZone, [], 0, "NONE"];
	sleep 0.5;

	if (BTC_p_skill isEqualTo 1) then {[_grp] call BTC_AI_init;};
	(group _unit) setVariable ["zbe_cacheDisabled",false];

	{
	_x addeventhandler ["killed","[(_this select 0)] spawn remove_carcass_fnc"];
	if (EOS_DAMAGE_MULTIPLIER != 1) then {
			_x removeAllEventHandlers "HandleDamage";
			_x addEventHandler ["HandleDamage",{_damage = (_this select 2)*EOS_DAMAGE_MULTIPLIER;_damage}];
		};
	} forEach (units _grp);

	_grp
};
spawn_Op4_StatDef = {
	// Static Gunner group creation and placements. by Jigsor
	private ["_newZone","_grp_size","_stat_grp","_offset_pos1","_offset_pos2","_offset_pos3","_stat_type1","_stat_type2","_stat_type3","_unit_type","_damage","_static1","_static2","_static3","_StaticArray1","_StaticArray2","_StaticArray3"];

	_newZone = _this select 0;
	_grp_size = _this select 1;
	_stat_grp = createGroup INS_Op4_side;
	_stat_type1 = INS_Op4_stat_weps select 0;
	_stat_type2 = INS_Op4_stat_weps select 1;
	_stat_type3 = INS_Op4_stat_weps select 2;
	_offset_pos1 = [(_newZone select 0) + 5, (_newZone select 1) + 5, 0];
	_offset_pos2 = [(_newZone select 0) - 5, (_newZone select 1) + 5, 0];
	_offset_pos3 = [(_newZone select 0), (_newZone select 1) - 5, 0];

	for "_i" from 0 to (_grp_size - 2) do {
		_unit_type = INS_men_list select (round (random ((count INS_men_list) - 1)));
		_stat_grp createUnit [_unit_type, _newZone, [], 0, "NONE"];
		sleep 0.5;
	};
	_stat_grp createUnit [INS_Op4_Eng, _newZone, [], 0, "NONE"];
	sleep 0.5;

	if (BTC_p_skill isEqualTo 1) then {[_stat_grp] call BTC_AI_init;};

	{
	_x addeventhandler ["killed","[(_this select 0)] spawn remove_carcass_fnc"];
	if (EOS_DAMAGE_MULTIPLIER != 1) then {
			_x removeAllEventHandlers "HandleDamage";
			_x addEventHandler ["HandleDamage",{_damage = (_this select 2)*EOS_DAMAGE_MULTIPLIER;_damage}];
		};
	} forEach (units _stat_grp);

	_static1 = createVehicle [_stat_type1, _offset_pos1, [], 0, "None"]; sleep jig_tvt_globalsleep;
	_static2 = createVehicle [_stat_type2, _offset_pos2, [], 0, "None"]; sleep jig_tvt_globalsleep;
	_static3 = createVehicle [_stat_type1, _offset_pos3, [], 0, "None"]; sleep jig_tvt_globalsleep;

	_static1 setDir 0;
	_static2 setDir 120;
	_static3 setDir 240;
	(units _stat_grp select 0) assignAsGunner _static1; sleep jig_tvt_globalsleep;
	(units _stat_grp select 1) assignAsGunner _static2; sleep jig_tvt_globalsleep;
	(units _stat_grp select 2) assignAsGunner _static3; sleep jig_tvt_globalsleep;
	(units _stat_grp select 0) moveInGunner _static1; sleep jig_tvt_globalsleep;
	(units _stat_grp select 1) moveInGunner _static2; sleep jig_tvt_globalsleep;
	(units _stat_grp select 2) moveInGunner _static3; sleep jig_tvt_globalsleep;

	_StaticArray1 = [_static1];
	_StaticArray2 = [_static2];
	_StaticArray3 = [_static1,_static2,_static3];
	sleep 2;
	nul = [_newZone, _StaticArray1, 110, 2, [0,33], true, false] execVM "scripts\SHK_buildingpos.sqf";
	//nul = [_newZone, _StaticArray2, 110, 2, [1,33], true, false] execVM "scripts\SHK_buildingpos.sqf";

	_stat_grp
};
INS_Tsk_GrpMkrs = {
	private ["_cid","_marker","_new_marker","_grp","_wp_marker","_wp_mkr_array"];
	_grp = _this select 0;
	_wp_mkr_array = [];

	for "_i" from 1 to (count (waypoints _grp)) do {
		_marker = format["%1 WP%2", objective_pos_logic,_i];
		_wp_marker = createMarker [_marker, getWPPos [_grp, _i]];
		_wp_marker setMarkerText _marker;
		_wp_marker setMarkerType "waypoint";
		_wp_mkr_array = _wp_mkr_array + [_wp_marker];
	};

	_cid = floor(random 1000);
	_marker = format["Tsk Defence Grp_%1", _cid];
	_new_marker = createMarker [_marker, (position leader _grp)];
	_new_marker setMarkerText _marker;
	_new_marker setMarkerType "o_inf";

	while {alive leader _grp} do {
		_new_marker setMarkerPos (position leader _grp);
		uiSleep 0.5;
	};
	deleteMarker _new_marker;
	{deleteMarker _x;} forEach _wp_mkr_array;
};
Veh_taskPatrol_mod = {
	// BIS_fnc_taskPatrol modified by Demonized to fix some vehicle bugs not moving when speed or behaviour was not defined for each wp.
	_grp = _this select 0;
	_pos = _this select 1;
	_maxDist = _this select 2;

	for "_i" from 0 to (2 + (floor (random 3))) do {
		_newPos = [_pos, 50, _maxDist, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
		_wp = _grp addWaypoint [_newPos, 0];
		_wp setWaypointType "MOVE";
		_wp setWaypointSpeed "LIMITED";
		_wp setWaypointBehaviour "SAFE";
		_wp setWaypointFormation "COLUMN";//"STAG COLUMN"
		_wp setWaypointCompletionRadius 20;
	};

	_wp = _grp addWaypoint [_pos, 0];
	_wp setWaypointType "CYCLE";
	_wp setWaypointCompletionRadius 20;
	true
};
remove_charge_fnc = {
	// remove charge/satchel from ammo cache's cargo space by Jigsor.
	private ["_crate","_all_mags","_type"];
	_crate = _this select 0;
	_all_mags = magazineCargo _crate;
	{
		_type = [_x] call BIS_fnc_itemType;
		if ((_type select 1) == "mine") then {
			_all_mags = _all_mags - [_x];
		};
	} count _all_mags;
	clearMagazineCargoGlobal _crate;
	{_crate addMagazineCargoGlobal [_x, 1];} count _all_mags;
	//hint str (_all_mags);
	true
};
INS_MHQ_VarName = {
	private "_veh";
	_veh = _this select 0;
	INS_MHQ_killed = VehicleVarName _veh;
	publicVariable "INS_MHQ_killed";
	true
};
GAS_smoke_AIdamage = {
	// Give damage to AI not wearing gas mask in toxic smoke by Jigsor
	private ["_currPos","_aiArray","_maxtype","_sound","_odd"];
	_currPos = _this;
	_maxtype = (count Choke_Sounds);
	_odd = 1;

	// loop time based on approximate life time of smoke grenade (21 seconds)
	for '_i' from 1 to 10 do {
		_aiArray = _currPos nearEntities [["CAManBase"],15];
		{if ((isPlayer _x) || (headgear _x in INS_gasMaskH) || (goggles _x in INS_gasMaskG)) then {_aiArray = _aiArray - [_x];};} count _aiArray;
		{
			if (_aiArray isEqualTo []) exitWith {};
			if (_odd isEqualTo 1) then {
				_sound = Choke_Sounds select (floor random _maxtype);
				playsound3d [_sound, _x, false, getPosasl _x, 14,1,40];
				_odd = 2;
			}else{
				_odd = 1;
			};
			uiSleep (random 0.21);
			_x setDamage (damage _x + 0.14);
		} count _aiArray;
		uiSleep 2.1;
	};
	ToxicGasLoc = [];
};