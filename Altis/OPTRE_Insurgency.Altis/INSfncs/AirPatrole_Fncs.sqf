// AirPatrole_Fncs.sqf by Jigsor
air_spawn_center_fnc = {
	private ["_posnotfound","_counter","_goodPos","_dis","_cooX","_cooY","_wheX","_wheY","_Air_Center_Pos","_newPos","_marker2","_sudoNewPos","_eastbase1a","_westbase1a","_westbase2a","_whitelist1","_whitelist2","_whitelist3"];

	_dis = Rand_AirCntr_OfstMax;
	_cooX = (getPosATL center select 0);
	_cooY = (getPosATL center select 1);
	_wheX = random (_dis*2)-_dis;
	_wheY = random (_dis*2)-_dis;
	_Air_Center_Pos = [_cooX+_wheX,_cooY+_wheY,0];
	_posnotfound = [];
	_goodPos = [];
	_counter = 0;

	_newPos = _Air_Center_Pos isFlatEmpty [15,384,0.5,2,0,false,ObjNull];
	while {(count _newPos) < 1} do {
		_newPos = _Air_Center_Pos isFlatEmpty [10,384,0.7,2,0,false,ObjNull];
		_counter = _counter + 1;
		if (_counter > 5) exitWith {_goodPos = [];};
		sleep 0.5;
	};
	if (!(_newPos isEqualTo [])) then {
		_marker2 = createMarkerLocal ["tempAirCntrMrkr", _newPos];
		_marker2 setMarkerShapeLocal "ELLIPSE";
		"tempAirCntrMrkr" setMarkerSizeLocal [1, 1];
		"tempAirCntrMrkr" setMarkerShapeLocal "ICON";
		"tempAirCntrMrkr" setMarkerTypeLocal "EMPTY";//"mil_dot" , "EMPTY"

		//Blacklists
		_sudoNewPos = [ getMarkerPos "tempAirCntrMrkr" select 0, (getMarkerPos "tempAirCntrMrkr" select 1)];
		_westbase1a = [ getMarkerPos "Respawn_West" select 0, (getMarkerPos "Respawn_West" select 1)];
		_whitelist1 = [ getMarkerPos "airWhiteList1" select 0, (getMarkerPos "airWhiteList1" select 1)];
		_whitelist2 = [ getMarkerPos "airWhiteList2" select 0, (getMarkerPos "airWhiteList2" select 1)];
		_whitelist3 = [ getMarkerPos "airWhiteList3" select 0, (getMarkerPos "airWhiteList3" select 1)];

		if (_sudoNewPos distance _westbase1a >4002) then {
			if (_sudoNewPos distance _whitelist1 >4002) then {
				if (_sudoNewPos distance _whitelist2 >4002) then {
					if (_sudoNewPos distance _whitelist3 >4002) then {
						_goodPos = _goodPos + _sudoNewPos;//minimum distance from Whitelist markers is 4002
					};
				};
			};
		};
		deleteMarkerLocal "tempAirCntrMrkr";
	};
	if (_newPos isEqualTo []) exitWith {_posnotfound;};
	//if BlackListing return _goodPos instead of _newPos
	//_newPos
	_goodPos
};
Air_Dest_fnc = {
	//creates 3 markerks in triangle -- "cyclewpmrk", "spawnaire" "spawnairw" and one in center of triangle -- "oamarker"
	// center logic -- air_pat_pos other logics forEach other marker are placed around center logic
	private ["_AirWP_span""_posHpad","_posnewAO","_currentmarker","_wpcyclemark","_spwnaire","_spwnairepos","_spwnairedir","_spwnairw","_spwnairwpos","_spwnairwdir","_spwnairdire","_spwnairenewdir","_spwnairdirw","_spwnairwnewdir"];
	_AirWP_span = 3500;
	_posHpad = [ getPosATL air_pat_pos select 0, (getPosATL air_pat_pos select 1)];
	if (!isNil "oamarker") then
	{
		_posnewAO = [ getMarkerPos "oamarker" select 0, (getMarkerPos "oamarker" select 1)];
		if (_posHpad distance _posnewAO isEqualTo 0) exitwith {};
		if !(_posHpad distance _posnewAO isEqualTo 0) then {
			sleep 0.2;
			deleteMarker "oamarker";
			_currentmarker = createMarker ["oamarker", getPosATL air_pat_pos];
			_currentmarker setMarkerShape "ELLIPSE";
			"oamarker" setMarkerSize [1, 1];
			"oamarker" setMarkerShape "ICON";
			"oamarker" setMarkerType "Empty";//set marker type to "mil_dot" for debug. Set "Empty" for invisible
			"oamarker" setMarkerColor "ColorRed";//ColorRedAlpha "ColorRed"
			"oamarker" setMarkerText "Enemy Occupied";
			"oamarker" setMarkerPos (getPosATL air_pat_pos);
			publicVariable "oamarker";
			sleep 0.2;
			if (!isNil "cyclewpmrk") then {deleteMarker "cyclewpmrk";};
			_wpcyclemark = createMarker ["cyclewpmrk", getPosATL air_pat_pos];
			_wpcyclemark setMarkerShape "ELLIPSE";
			"cyclewpmrk" setMarkerSize [1, 1];
			"cyclewpmrk" setMarkerShape "ICON";
			"cyclewpmrk" setMarkerType "Empty";//set marker type to "mil_dot" for debug. Set "Empty" for invisible
			"cyclewpmrk" setMarkerColor "ColorRed";
			"cyclewpmrk" setMarkerText "WPcycle";
			"cyclewpmrk" setMarkerPos [(getMarkerPos "oamarker" select 0) + (_AirWP_span * sin floor(random 360)), (getMarkerPos "oamarker" select 1) + (_AirWP_span * cos floor(random 360)), 0];//cycle waypoint distance is _AirWP_span meters from AO marker
			publicVariable "cyclewpmrk";
			sleep 0.2;
			air_pat_cycle setPosATL getMarkerPos "cyclewpmrk";
			if (!isNil "spawnaire") then {deleteMarker "spawnaire";};
			_spwnaire = createMarker ["spawnaire", getPosATL air_pat_pos];
			_spwnaire setMarkerShape "ELLIPSE";
			_spwnairepos = getMarkerPos "cyclewpmrk";
			_spwnairedir = [_spwnairepos, air_pat_pos] call BIS_fnc_dirTo;
			"spawnaire" setMarkerSize [1, 1];
			"spawnaire" setMarkerShape "ICON";
			"spawnaire" setMarkerType "Empty";//set marker type to "mil_dot" for debug. Set "Empty" for invisible
			"spawnaire" setMarkerColor "ColorRed";
			"spawnaire" setMarkerText "SpawnAirEst";
			"spawnaire" setMarkerPos [(getMarkerPos "oamarker" select 0) + (_AirWP_span * sin (_spwnairedir -300)), (getMarkerPos "oamarker" select 1) + (_AirWP_span * cos (_spwnairedir -300)), 0];//East Air spawn point distance is _AirWP_span meters from AO marker
			_spwnairdire = getMarkerPos "spawnaire";
			_spwnairenewdir = [_spwnairdire, air_pat_pos] call BIS_fnc_dirTo;
			"spawnaire" setMarkerDir _spwnairenewdir;//point marker direction towards oamarker
			publicVariable "spawnaire";
			sleep 0.2;
			air_pat_east setPosATL getMarkerPos "spawnaire";
			air_pat_east setDir _spwnairenewdir;
			if (!isNil "spawnairw") then {deleteMarker "spawnairw";};
			_spwnairw = createMarker ["spawnairw", getPosATL air_pat_pos];
			_spwnairw setMarkerShape "ELLIPSE";
			"spawnairw" setMarkerSize [1, 1];
			"spawnairw" setMarkerShape "ICON";
			"spawnairw" setMarkerType "Empty";//set marker type to "mil_dot" for debug. Set "Empty" for invisible
			"spawnairw" setMarkerColor "ColorRed";
			"spawnairw" setMarkerText "Retreat";
			"spawnairw" setMarkerPos [(getMarkerPos "oamarker" select 0) + (_AirWP_span * sin (_spwnairedir -60)), (getMarkerPos "oamarker" select 1) + (_AirWP_span * cos (_spwnairedir -60)), 0];//East Air spawn point distance is _AirWP_span meters from AO marker
			_spwnairdirw = getMarkerPos "spawnairw";
			_spwnairwnewdir = [_spwnairdirw, air_pat_pos] call BIS_fnc_dirTo;
			"spawnairw" setMarkerDir _spwnairwnewdir;//point marker direction towards oamarker
			publicVariable "spawnairw";
			sleep 0.1;
			air_pat_west setPosATL getMarkerPos "spawnairw";
			air_pat_west setDir _spwnairwnewdir;
		};
	} else {
		if (isNil "oamarker") then {
			_currentmarker = createMarker ["oamarker", getPosATL air_pat_pos];
			_currentmarker setMarkerShape "ELLIPSE";
			"oamarker" setMarkerSize [1, 1];
			"oamarker" setMarkerShape "ICON";
			"oamarker" setMarkerType "Empty";//set marker type to "mil_dot" for debug. Set "Empty" for invisible
			"oamarker" setMarkerColor "ColorRed";
			"oamarker" setMarkerText "Enemy Occupied";
			"oamarker" setMarkerPos (getPosATL air_pat_pos);
			publicVariable "oamarker";
			sleep 0.2;
			_wpcyclemark = createMarker ["cyclewpmrk", getPosATL air_pat_pos];
			_wpcyclemark setMarkerShape "ELLIPSE";
			"cyclewpmrk" setMarkerSize [1, 1];
			"cyclewpmrk" setMarkerShape "ICON";
			"cyclewpmrk" setMarkerType "Empty";//set marker type to "mil_dot" for debug. Set "Empty" for invisible
			"cyclewpmrk" setMarkerColor "ColorRed";
			"cyclewpmrk" setMarkerText "WPcycle";
			"cyclewpmrk" setMarkerPos [(getMarkerPos "oamarker" select 0) + (_AirWP_span * sin floor(random 360)), (getMarkerPos "oamarker" select 1) + (_AirWP_span * cos floor(random 360)), 0];//cycle waypoint distance is _AirWP_span meters from AO marker
			publicVariable "cyclewpmrk";
			sleep 0.2;
			air_pat_cycle setPosATL getMarkerPos "cyclewpmrk";
			_spwnaire = createMarker ["spawnaire", getPosATL air_pat_pos];
			_spwnaire setMarkerShape "ELLIPSE";
			_spwnairepos = getMarkerPos "cyclewpmrk";
			_spwnairedir = [_spwnairepos, air_pat_pos] call BIS_fnc_dirTo;
			"spawnaire" setMarkerSize [1, 1];
			"spawnaire" setMarkerShape "ICON";
			"spawnaire" setMarkerType "Empty";//set marker type to "mil_dot" for debug. Set "Empty" for invisible
			"spawnaire" setMarkerColor "ColorRed";
			"spawnaire" setMarkerText "SpawnAirEst";
			"spawnaire" setMarkerPos [(getMarkerPos "oamarker" select 0) + (_AirWP_span * sin (_spwnairedir -300)), (getMarkerPos "oamarker" select 1) + (_AirWP_span * cos (_spwnairedir -300)), 0];//East Air spawn point distance is _AirWP_span meters from AO marker
			_spwnairdire = getMarkerPos "spawnaire";
			_spwnairenewdir = [_spwnairdire, air_pat_pos] call BIS_fnc_dirTo;
			"spawnaire" setMarkerDir _spwnairenewdir;//point marker direction towards oamarker
			publicVariable "spawnaire";
			sleep 0.2;
			air_pat_east setPosATL getMarkerPos "spawnaire";
			air_pat_east setDir _spwnairenewdir;
			_spwnairw = createMarker ["spawnairw", getPosATL air_pat_pos];
			_spwnairw setMarkerShape "ELLIPSE";
			"spawnairw" setMarkerSize [1, 1];
			"spawnairw" setMarkerShape "ICON";
			"spawnairw" setMarkerType "Empty";//set marker type to "mil_dot" for debug. Set "Empty" for invisible
			"spawnairw" setMarkerColor "ColorRed";
			"spawnairw" setMarkerText "Retreat";
			"spawnairw" setMarkerPos [(getMarkerPos "oamarker" select 0) + (_AirWP_span * sin (_spwnairedir -60)), (getMarkerPos "oamarker" select 1) + (_AirWP_span * cos (_spwnairedir -60)), 0];//East Air spawn point distance is _AirWP_span meters from AO marker
			_spwnairdirw = getMarkerPos "spawnairw";
			_spwnairwnewdir = [_spwnairdirw, air_pat_pos] call BIS_fnc_dirTo;
			"spawnairw" setMarkerDir _spwnairwnewdir;//point marker direction towards oamarker
			publicVariable "spawnairw";
			sleep 0.2;
			air_pat_west setPosATL getMarkerPos "spawnairw";
			air_pat_west setDir _spwnairwnewdir;
		};
	};
	true
};
AirEast_move_logic_fnc = {
	private ["_ranAEguard","_lastpos","_currentmarker","_newPosAELogic"];
	_ranAEguard = [ getPos EastAirLogic select 0, (getPos EastAirLogic select 1), 0];
	_lastpos = [ getMarkerPos "curAEspawnpos" select 0, (getMarkerPos "curAEspawnpos" select 1), 0];
	if (_ranAEguard distance _lastpos > 1) then	{
		EastAirLogic setPos getMarkerPos "spawnaire";
		_newPosAELogic = getPos EastAirLogic;
		if (!isNil "curAEspawnpos") then {deleteMarker "curAEspawnpos";};
		_currentmarker = createMarker ["curAEspawnpos", _newPosAELogic];
		_currentmarker setMarkerShape "ELLIPSE";
		"curAEspawnpos" setMarkerSize [2, 2];
		"curAEspawnpos" setMarkerShape "ICON";
		"curAEspawnpos" setMarkerType "Empty";//"mil_dot"
		"curAEspawnpos" setMarkerColor "ColorOrange";
		publicVariable "curAEspawnpos";
	};
	true
};
find_west_target_fnc = {
	// based on example by Mattar_Tharkari in BIS community forums http://forums.bistudio.com/showthread.php?145573-How-to-make-AI-vehicle-follow-chase-players/page2
	private ["_vcl","_dis","_wPArray","_i","_wp1","_tgtArray","_nrstWTgts","_cntrPos","_hunted","_primary_obj_loc","_curwp","_kah","_gamelogic","_CworldSize","_patrolRad","_towns","_future_time","_sqrt","_mh"];

	_vcl = _this select 0;
	_dis = _this select 1;
	_hunted = _this select 2;
	_future_time = time + AirRespawnDelay + 120;
	_gamelogic = CENTER;

	_CworldSize = getnumber (configfile >> "CfgWorlds" >> worldName >> "mapSize");
	if (!isNil "_CworldSize") then {
		if (_CworldSize != 0) then {
			_sqrt = sqrt 2;
			_mh = _CworldSize /_sqrt;
			_patrolRad = round(_mh / 2);
			_towns = nearestLocations [getPos _gamelogic, ["NameVillage","NameCity","NameCityCapital"], _patrolRad];
		} else {
			_towns = nearestLocations [getPosATL _gamelogic, ["NameVillage","NameCity","NameCityCapital"], 9000];
			};
	} else {
		_towns = nearestLocations [getPosATL _gamelogic, ["NameVillage","NameCity","NameCityCapital"], 9000];
	};

	//movement loop
	while {alive _vcl} do {
		//remove all previous wayPoints
		_wPArray = wayPoints (group _vcl);
		for "_i" from 0 to (count _wPArray -1) do {
			deleteWaypoint [(group _vcl), _i]
		};

		//add 1 WP it's all you need
		_wp1 = (group _vcl) addWaypoint [(getPos _vcl), 0];
		_wp1 setWaypointType "MOVE";

		if (PatroleWPmode < 1) then	{
			//chase nearest target
			if ((isNull _hunted) || (_vcl distance _hunted > _dis)) then {
				private "_chance";
				_vcl setVehicleAmmo 1;
				_vcl setFuel 1;
				_tgtArray = (position _vcl) nearEntities [["Air","CAManBase"],2000];//1500
				{
					if (captiveNum _x isEqualTo 1) then {
						_tgtArray = _tgtArray - [_x];
					}
				} forEach _tgtArray;

				_nrstWTgts = [];
				{
					if (side _x == WEST) then
					{ //change to EAST if need to follow EAST
						_nrstWTgts set [(count _nrstWTgts),_x];
					};
				} forEach _tgtArray;

				_cntrPos =  getPos (_nrstWTgts select 0);
				if (count _nrstWTgts !=0 && format ["%1", _cntrPos] != "[0,0,0]") then {
					//chase enemy if exist and have valid position
					_wp1 setWaypointPosition [_cntrPos, floor(random 50)];
					(group _vcl) setCurrentWaypoint _wp1;

					{_x reveal (_nrstWTgts select 0);} forEach (units group _vcl);

					_chance = floor(random 3);
					if (_chance >= 1) then {
						{
							_x doTarget (_nrstWTgts select 0);
							_x doFire (_nrstWTgts select 0);
						} forEach (units group _vcl);
					};
				};
				sleep 45;
			}
			else
			{
				private ["_chance","_vicPosArr","_targets"];
				while {!isNull _hunted} do {
					_vicPosArr = [];
					_targets = [];
					_vcl setvehicleammo 1;
					_vcl setfuel 1;

					_wPArray = waypoints (group _vcl);
					for "_i" from 0 to (count _wPArray -1) do {
						deleteWaypoint [(group _vcl), _i]
					};

					_wp1 = (group _vcl) addWaypoint [(getPos _vcl), 0];
					_wp1 setWaypointType "MOVE";

					{
						if ((alive _x) && (captiveNum _x isEqualTo 0)) then {
							_grpMemberPos = getPos _x;

							if (format ["%1", _grpMemberPos] != "[0,0,0]") then	{
								_vicPosArr pushBack _grpMemberPos;
								_targets pushBack _x;
							};
						};
					} forEach units (group _hunted);

					if (count _vicPosArr !=0) then {
						_sel = (count _vicPosArr) -1;
						_rnd_sel = floor random _sel;
						_attackPos = _vicPosArr select _rnd_sel;
						_victim = _targets select _rnd_sel;

						_wp1 setWaypointPosition [_attackPos, floor(random 50)];
						(group _vcl) setCurrentWaypoint _wp1;

						_cntrPos = getPos _victim;
						{
							_x reveal _victim;
							_x doTarget _cntrPos;
							_x doFire _cntrPos;
						} forEach (units group _vcl);
					};
					sleep 90;
				};

				while {isNull _hunted} do {
					if (count _towns !=0 && alive _vcl) then {
						_RandomTownPosition = position (_towns select 0);
						_towns deleteAt 0;

						_wPArray = wayPoints (group _vcl);
						for "_i" from 0 to (count _wPArray -1) do {
							deleteWaypoint [(group _vcl), _i]
						};

						_wp1 = (group _vcl) addWaypoint [(getPos _vcl), 0];
						_wp1 setWaypointType "MOVE";

						_wp1 setWaypointPosition [_RandomTownPosition, 0];
						(group _vcl) setCurrentWaypoint _wp1;
						sleep 200;
					};
					if (_towns isEqualTo [] || !alive _vcl) exitWith {};
					if (time > _future_time) then {[_vcl] spawn {(_this select 0) setFuel 0; sleep 60; if (alive (_this select 0)) then {(_this select 0) setdamage 1;};};};
				};

				_vcl setVehicleAmmo 1;
				_vcl setFuel 1;
				_tgtArray = (position _vcl) nearEntities [["Air","CAManBase"],2000];//1500
				{
					if (captiveNum _x isEqualTo 1) then {
						_tgtArray = _tgtArray - [_x];
					}
				} forEach _tgtArray;

				_nrstWTgts = [];
				{
					if (side _x == WEST) then
					{ //change to EAST if need to follow EAST
						_nrstWTgts set [(count _nrstWTgts),_x];
					};
				} forEach _tgtArray;

				_cntrPos =  getPos (_nrstWTgts select 0);

				if (count _nrstWTgts !=0 && format ["%1", _cntrPos] != "[0,0,0]") then {
					//chase enemy if exist and have valid position
					_wp1 setWaypointPosition [_cntrPos, floor(random 50)];
					(group _vcl) setCurrentWaypoint _wp1;

					{
						_x reveal (_nrstWTgts select 0);
						_x doTarget _cntrPos;
						_x doFire _cntrPos;
					} forEach (units group _vcl);
				};
				sleep 45;
			};
			if (time > _future_time) then {[_vcl] spawn {(_this select 0) setFuel 0; sleep 60; if (alive (_this select 0)) then {(_this select 0) setdamage 1;};};};
		}
        else
		{
			_vcl setVehicleAmmo 1;
			_vcl setFuel 1;
			//hunt random_w_player
			_wp1 setWaypointPosition [(getPos _hunted), floor(random 150)];
			(group _vcl) setCombatMode "RED";
			(group _vcl) setCurrentWaypoint _wp1;
			_wp1 setWaypointStatements ["true","_vcl reveal _hunted;"];//testing addition of this line

			{
				_x reveal _hunted;
				_x doTarget _hunted;
				_x doFire _hunted;
			} forEach (units group _vcl);
			sleep 45;
			waitUntil {isNull _hunted};// this will delay aircraft respawn until _hunted respawns as side affect

			_wPArray = wayPoints (group _vcl);
			for "_i" from 0 to (count _wPArray -1) do {
				deleteWaypoint [(group _vcl), _i]
			};

			_wp1 = (group _vcl) addWaypoint [(getPos _vcl), 0];
			_wp1 setWaypointType "SAD";
			_wp1 setWaypointPosition [(getPos air_pat_pos), floor(random 150)];
			(group _vcl) setCurrentWaypoint _wp1;
		};
		sleep 45;
	};
};
east_AO_guard_cycle_wp = {
	private ["_vcl","_vehgrp","_wPArray","_i","_wp0","_wp1","_wp2","_wp3","_wp4"];

	_vcl = _this select 0;

	//remove all previous wayPoints
	_wPArray = wayPoints (group _vcl);
	for "_i" from 0 to (count _wPArray -1) do {
		deleteWaypoint [(group _vcl), _i]
	};

	_vehgrp = group _vcl;

	_wp0 = _vehgrp addWaypoint [getMarkerPos "spawnaire", 250];
	_wp0 setWaypointType "MOVE";
	_wp0 setWaypointBehaviour "AWARE";
	_wp0 setWaypointCombatMode "RED";
	_wp0 setWaypointStatements ["true", ""];

	_wp1 = _vehgrp addWaypoint [getMarkerPos "oamarker", 250];
	_wp1 setWaypointType "MOVE";
	_wp1 setWaypointBehaviour "AWARE";
	_wp1 setWaypointCombatMode "RED";
	_wp1 setWaypointStatements ["true", ""];

	_wp2 = _vehgrp addWaypoint [getMarkerPos "cyclewpmrk", 250];
	_wp2 setWaypointType "MOVE";
	_wp2 setWaypointBehaviour "AWARE";
	_wp2 setWaypointCombatMode "RED";
	_wp2 setWaypointStatements ["true", ""];

	_wp3 = _vehgrp addWaypoint [getMarkerPos "spawnairw", 250];
	_wp3 setWaypointType "MOVE";
	_wp3 setWaypointBehaviour "AWARE";
	_wp3 setWaypointCombatMode "RED";
	_wp3 setWaypointStatements ["true", ""];

	_wp4 = _vehgrp addWaypoint [getMarkerPos "oamarker", 250];
	_wp4 setWaypointType "CYCLE";
	_wp4 setWaypointBehaviour "AWARE";
	_wp4 setWaypointCombatMode "RED";
	_wp4 setWaypointStatements ["true", "_vcl setVehicleAmmo 1;_vcl setFuel 1;"];
};
find_me1_fnc = {
	private "_missionPlayers";
	_missionPlayers = playableUnits;
	{
		if (side _x isEqualTo east) then {_missionPlayers = _missionPlayers - [_x];};
	} forEach _missionPlayers;// exclude east players
	if (count _missionPlayers < 1) exitWith {random_w_player1 = ObjNull; publicVariable "random_w_player1";};
	random_w_player1 = _missionPlayers select (floor (random (count _missionPlayers)));
	publicVariable "random_w_player1";
	if (DebugEnabled > 0) then {diag_log text format ["Variable West Human Target: %1", random_w_player1];};
	true
};
find_me2_fnc = {
	private "_missionPlayers";
	_missionPlayers = playableUnits;
	{
		if (side _x isEqualTo east) then {_missionPlayers = _missionPlayers - [_x];};
	} forEach _missionPlayers;// exclude east players
	if (count _missionPlayers < 1) exitWith {random_w_player2 = ObjNull; publicVariable "random_w_player2";};
	random_w_player2 = _missionPlayers select (floor (random (count _missionPlayers)));
	publicVariable "random_w_player2";
	if (DebugEnabled > 0) then {diag_log text format ["Variable West Human Target: %1", random_w_player2];};
	true
};
find_me3_fnc = {
	private "_missionPlayers";
	_missionPlayers = playableUnits;
	{
		if (side _x isEqualTo east) then {_missionPlayers = _missionPlayers - [_x];};
	} forEach _missionPlayers;// exclude east players
	if (count _missionPlayers < 1) exitWith {random_w_player3 = ObjNull; publicVariable "random_w_player3";};
	random_w_player3 = _missionPlayers select (floor (random (count _missionPlayers)));
	publicVariable "random_w_player3";
	if (DebugEnabled > 0) then {diag_log text format ["Variable West Human Target: %1", random_w_player3];};
	true
};
air_debug_mkrs = {
	private ["_marker","_new_marker","_airhunter","_marker_wp","_wp_marker","_wp_mkr_array","_aircraftName","_mkrtype"];
	_airhunter = _this select 0;
	_aircraftName = str(_airhunter);
	if (_airhunter == airhunterE2) then	{_mkrtype = "o_air";}else{_mkrtype = "o_plane";};

	sleep 5;
	if (alive leader _airhunter) then {while {count wayPoints (group _airhunter) < 1} do {sleep 6;};};

	_wp_mkr_array = [];
	for "_i" from 1 to (count (wayPoints _airhunter)) do {
		_marker_wp = format["%1 WP%2", _airhunter,_i];
		_wp_marker = createMarker [_marker_wp, getWPPos [_airhunter, _i]];
		_wp_marker setMarkerText _marker_wp;
		_wp_marker setMarkerType "waypoint";
		_wp_mkr_array pushBack _wp_marker;
	};

	_marker = "" + _aircraftName;
	_new_marker = createMarker [_marker, (position leader _airhunter)];
	_new_marker setMarkerText _marker;
	_new_marker setMarkerType _mkrtype;

	while {alive leader _airhunter} do {
		_new_marker setMarkerPos (position leader _airhunter);
		uiSleep 0.5;
	};

	deleteMarker _new_marker;
	{deleteMarker _x;} forEach _wp_mkr_array;
	true
};