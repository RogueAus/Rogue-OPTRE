// AirPatrolEast.sqf by Jigsor
// runs from init_server.sqf
// nul = [] execVM "scripts\AirPatrolEast.sqf";

if (!isServer) exitWith {};
waitUntil{!(isNil "BIS_fnc_init")};
waitUntil {time > 10};

private ["_air_e_cntr","_currentmarker","_newPosAELogic","_newPosAELogicMrk","_aire1","_aire2","_aire3","_mrk_update","_ins_debug"];

_air_e_cntr = [];

_air_e_cntr = _air_e_cntr + call air_spawn_center_fnc;
while {count _air_e_cntr < 1} do {
	_air_e_cntr = _air_e_cntr + call air_spawn_center_fnc;
	sleep 2.4;
};

if (count _air_e_cntr > 0) then
{
	air_pat_pos setPos _air_e_cntr;
	sleep 0.1;
	_mrk_update = false;
	_mrk_update = call Air_Dest_fnc;
	waitUntil {sleep 1; _mrk_update};

	airhunterE1 = ObjNull;
	airhunterE2 = ObjNull;
	airhunterE3 = ObjNull;
	_ins_debug = if (DebugEnabled isEqualTo 1) then {TRUE}else{FALSE};

	if (_ins_debug) then
	{
		// show initial spawn position
		if !(getMarkerColor "curAEspawnpos" isEqualTo "") then {deleteMarker "curAEspawnpos";};
		_currentmarker = createMarker ["curAEspawnpos", getMarkerPos "spawnaire"];
		_currentmarker setMarkerShape "ELLIPSE";
		"curAEspawnpos" setMarkerSize [2, 2];
		"curAEspawnpos" setMarkerShape "ICON";
		"curAEspawnpos" setMarkerType "mil_dot";//"Empty"
		"curAEspawnpos" setMarkerColor "ColorOrange";
		"curAEspawnpos" setMarkerText "Initial Air Spawn";
		publicVariable "curAEspawnpos";
		sleep 2;
		_newPosAELogic = getPos EastAirLogic;
		_newPosAELogicMrk = getMarkerPos "curAEspawnpos";
	};
	/*
	// Modded Fixed Wing
	if ((EnableEnemyAir isEqualTo 2) || (EnableEnemyAir isEqualTo 3)) then
	{
		_aire1 = [_ins_debug] spawn
		{
			private "_ins_debug";
			_ins_debug = _this select 0;
			airhunterE1 = ObjNull;
			random_w_player1 = ObjNull;
			"airhunterE1" addPublicVariableEventHandler {call compile format ["%1",_this select 1]};
			"random_w_player1" addPublicVariableEventHandler {call compile format ["%1",_this select 1]};
			for [{_loop=0}, {_loop<1}, {_loop=_loop}] do
			{
				if ((isNull airhunterE1) || (not(alive airhunterE1))) then
				{
					private ["_speed","_SAdir","_randomAltitudes","_maxalt","_height","_randomTypes","_maxtype","_type","_vehicle","_veh","_vehgrp","_vel","_VarHunterName","_wp0","_spwnairdir","_poscreate"];

					sleep AirRespawnDelay;
					//call AirEast_move_logic_fnc;

					if (PatroleWPmode > 0) then
					{
						random_w_player1 = ObjNull;
						publicVariable "random_w_player1";
						sleep 3;
						call find_me1_fnc;
						sleep 3;
						if (_ins_debug) then {diag_log text format ["airhunterE1 West Human Target3: %1", random_w_player1];};
					};

					_poscreate = getMarkerPos "spawnaire";
					_speed = 180;
					_SAdir = getDir air_pat_east;
					_spwnairdir = [getPosATL air_pat_east, getPosATL air_pat_pos] call BIS_fnc_dirTo;
					_randomAltitudes = [275,375,475,575];
					_maxalt = (count _randomAltitudes)-1;
					_height = _randomAltitudes select (round random _maxalt);
					_maxtype = (count INS_OP4_mod_fixedWing)-1;
					_type = INS_OP4_mod_fixedWing select (round random _maxtype);

					_vehicle = [getPosATL air_pat_east, _SAdir, _type, EAST] call bis_fnc_spawnvehicle;
					sleep jig_tvt_globalsleep;
					_veh = _vehicle select 0;

					_vel = velocity _veh;
					_veh setpos [(_poscreate select 0) + (sin (_spwnairdir -180)), (_poscreate select 1) + (cos (_spwnairdir -180)), _height];
					_veh setVelocity [(_vel select 0)+(sin _SAdir*_speed),(_vel select 1)+(cos _SAdir*_speed),(_vel select 2)];

					_vehgrp = _vehicle select 2 ;// group of vehicle
					if (BTC_p_skill isEqualTo 1) then {[_vehgrp] call BTC_AI_init;};
					_veh addeventhandler ["killed","[(_this select 0)] spawn remove_carcass_fnc"];
					{_x addeventhandler ["killed","[(_this select 0)] spawn remove_carcass_fnc"]} forEach (units _vehgrp);
					_veh addeventhandler ["HandleDamage", {if (((_this select 4) isKindOf "MissileCore") || ((_this select 4) isKindOf "rocketCore")) then { 1; } else { _this select 2; }; }];// Destroy This Air Vehicle With 1 Missile or Rocket

					_VarHunterName = "airhunterE1";
					_veh setVehicleVarName _VarHunterName;
					_veh Call Compile Format ["%1=_This ; PublicVariable ""%1""",_VarHunterName];

					// Initial Waypoint
					_wp0 = _vehgrp addWaypoint [getPosATL air_pat_east, 200];
					_wp0 setWaypointType "MOVE";
					_wp0 setWaypointBehaviour "AWARE";
					_wp0 setWaypointCombatMode "green";
					_wp0 setWaypointStatements ["true", ""];

					if (_ins_debug) then {[airhunterE1] spawn {[airhunterE1] call air_debug_mkrs;};};

					if (!isNull random_w_player1) then
					{
						// Hunt Player
						nul = [airhunterE1,5000,random_w_player1] call find_west_target_fnc;
					}else{
						// Guard Towns
						nul = [airhunterE1] call east_AO_guard_cycle_wp;
					};

					waitUntil {sleep 1; (!alive _veh) || ((count crew _veh) < 1) || (!canmove _veh)};
					if (((count crew _veh) < 1) && (alive _veh)) then {_veh setDamage 1};
					{
						if (alive _x) then {_x setDamage 1; sleep 0.1}
					} forEach (crew _veh);
					if (!alive _veh) then
					{
						{
							if (alive _x) then {_x setDamage 1; sleep 0.1}
						} forEach (units _vehgrp);
					};
					if (alive _veh) then
					{
						_veh setDamage 1;
						{
							if (alive _x) then {_x setDamage 1; sleep 0.1}
						} forEach (units _vehgrp);
					};
				};
				sleep (1 + random 599);
			};
		};
	};
	sleep (1 + random 599);
	*/
	// Stock A3 Choppers
	if ((EnableEnemyAir isEqualTo 1) || (EnableEnemyAir isEqualTo 3)) then
	{
		_aire2 = [_ins_debug] spawn
		{
			private "_ins_debug";
			_ins_debug = _this select 0;
			airhunterE2 = ObjNull;
			random_w_player2 = ObjNull;
			"airhunterE2" addPublicVariableEventHandler {call compile format ["%1",_this select 1]};
			"random_w_player2" addPublicVariableEventHandler {call compile format ["%1",_this select 1]};
			for [{_loop=0}, {_loop<1}, {_loop=_loop}] do
			{
				if ((isNull airhunterE2) || (not(alive airhunterE2))) then
				{
					private ["_speed","_SAdir","_randomAltitudes","_maxalt","_height","_randomTypes","_maxtype","_type","_vehicle","_veh","_vehgrp","_vel","_VarHunterName","_wp0","_spwnairdir","_poscreate","_vehCrew"];

					sleep AirRespawnDelay;
					//call AirEast_move_logic_fnc;

					if (PatroleWPmode > 0) then
					{
						random_w_player2 = ObjNull;
						publicVariable "random_w_player2";
						sleep 3;
						call find_me2_fnc;
						sleep 3;
						if (_ins_debug) then {diag_log text format ["AirhunterE2 West Human Target2: %1", random_w_player2];};
					};

					_poscreate = getMarkerPos "spawnaire";
					_speed = 65;// starting speed
					_SAdir = getDir air_pat_east;// Velocity Direction
					_spwnairdir = [getPosATL air_pat_east, getPosATL air_pat_pos] call BIS_fnc_dirTo;// Spawn Direction
					_randomAltitudes = [70,80,90];// random altitudes
					_maxalt = (count _randomAltitudes)-1;// count random altitudes
					_height = _randomAltitudes select (round random _maxalt);// select random altitude
					_maxtype = (count INS_Op4_A3_helis)-1;// count types
					_type = INS_Op4_A3_helis select (round random _maxtype);// select random type

					_vehicle = [getPosATL air_pat_east, _SAdir, _type, EAST] call bis_fnc_spawnvehicle;
					sleep jig_tvt_globalsleep;
					_veh = _vehicle select 0;

					_vel = velocity _veh;
					_veh setpos [(_poscreate select 0) + (sin (_spwnairdir -180)), (_poscreate select 1) + (cos (_spwnairdir -180)), _height];
					_veh setVelocity [(_vel select 0)+(sin _SAdir*_speed),(_vel select 1)+(cos _SAdir*_speed),(_vel select 2)];

					_vehgrp = _vehicle select 2 ;// group of vehicle
					if (BTC_p_skill isEqualTo 1) then {[_vehgrp] call BTC_AI_init;};
					//_vehCrew = (group (crew _veh select 0)); {_x setVariable ["asr_ai_exclude",true];} foreach _vehCrew;

					_veh addeventhandler ["killed","[(_this select 0)] spawn remove_carcass_fnc"];
					{_x addeventhandler ["killed","[(_this select 0)] spawn remove_carcass_fnc"]} forEach (units _vehgrp);
					_veh addeventhandler ["HandleDamage", {if (((_this select 4) isKindOf "MissileCore") || ((_this select 4) isKindOf "rocketCore")) then { 1; } else { _this select 2; }; }];// Destroy This Air Vehicle With 1 Missile or Rocket

					_VarHunterName = "airhunterE2";
					_veh setVehicleVarName _VarHunterName;
					_veh Call Compile Format ["%1=_This ; PublicVariable ""%1""",_VarHunterName];

					// Initial Waypoint
					_wp0 = _vehgrp addWaypoint [getPosATL air_pat_east, 200];
					_wp0 setWaypointType "MOVE";
					_wp0 setWaypointBehaviour "AWARE";
					_wp0 setWaypointCombatMode "green";
					_wp0 setWaypointStatements ["true", ""];

					if (_ins_debug) then {[airhunterE2] spawn {[airhunterE2] call air_debug_mkrs;};};

					if (!isNull random_w_player2) then
					{
						// Hunt Player
						nul = [airhunterE2,5000,random_w_player2] call find_west_target_fnc;
					}else{
						// Guard Towns
						nul = [airhunterE2] call east_AO_guard_cycle_wp;
					};

					waitUntil {sleep 1; (!alive _veh) || ((count crew _veh) < 1) || (!canmove _veh)};
					if (((count crew _veh) < 1) && (alive _veh)) then {_veh setDamage 1};
					{
						if (alive _x) then {_x setDamage 1; sleep 0.1}
					} forEach (crew _veh);
					if (!alive _veh) then
					{
						{
							if (alive _x) then {_x setDamage 1; sleep 0.1}
						} forEach (units _vehgrp);
					};
					if (alive _veh) then
					{
						_veh setDamage 1;
						{
							if (alive _x) then {_x setDamage 1; sleep 0.1}
						} forEach (units _vehgrp);
					};
				};
				sleep (1 + random 599);
			};
		};
	};
	sleep (1 + random 599);

	// Stock A3 Fixed Wing
	if ((EnableEnemyAir isEqualTo 2) || (EnableEnemyAir isEqualTo 3)) then
	{
		_aire3 = [_ins_debug] spawn
		{
			private "_ins_debug";
			_ins_debug = _this select 0;
			airhunterE3 = ObjNull;
			random_w_player3 = ObjNull;
			"airhunterE3" addPublicVariableEventHandler {call compile format ["%1",_this select 1]};
			"random_w_player3" addPublicVariableEventHandler {call compile format ["%1",_this select 1]};
			for [{_loop=0}, {_loop<1}, {_loop=_loop}] do
			{
				if ((isNull airhunterE3) || (not(alive airhunterE3))) then
				{
					private ["_speed","_SAdir","_randomAltitudes","_maxalt","_height","_randomTypes","_maxtype","_type","_vehicle","_veh","_vehgrp","_vel","_VarHunterName","_wp0","_spwnairdir","_poscreate"];

					sleep AirRespawnDelay;
					//call AirEast_move_logic_fnc;

					if (PatroleWPmode > 0) then
					{
						random_w_player3 = ObjNull;
						publicVariable "random_w_player3";
						sleep 3;
						call find_me3_fnc;
						sleep 3;
						if (_ins_debug) then {diag_log text format ["AirhunterE3 West Human Target3: %1", random_w_player3];};
					};

					_poscreate = getMarkerPos "spawnaire";
					_speed = 180;// starting speed
					_SAdir = getDir air_pat_east;// Velocity Direction	
					_spwnairdir = [getPosATL air_pat_east, getPosATL air_pat_pos] call BIS_fnc_dirTo;// Spawn Direction
					_randomAltitudes = [275,375,475,575];// random altitudes
					_maxalt = (count _randomAltitudes)-1;// count random altitudes
					_height = _randomAltitudes select (round random _maxalt);// select random altitude
					_maxtype = (count INS_Op4_A3_fixedWing)-1;// count types
					_type = INS_Op4_A3_fixedWing select (round random _maxtype);// select random type

					_vehicle = [getPosATL air_pat_east, _SAdir, _type, EAST] call bis_fnc_spawnvehicle;
					sleep jig_tvt_globalsleep;
					_veh = _vehicle select 0;

					_vel = velocity _veh;
					_veh setpos [(_poscreate select 0) + (sin (_spwnairdir -180)), (_poscreate select 1) + (cos (_spwnairdir -180)), _height];
					_veh setVelocity [(_vel select 0)+(sin _SAdir*_speed),(_vel select 1)+(cos _SAdir*_speed),(_vel select 2)];

					_vehgrp = _vehicle select 2 ;// group of vehicle
					if (BTC_p_skill isEqualTo 1) then {[_vehgrp] call BTC_AI_init;};
					_veh addeventhandler ["killed","[(_this select 0)] spawn remove_carcass_fnc"];
					{_x addeventhandler ["killed","[(_this select 0)] spawn remove_carcass_fnc"]} forEach (units _vehgrp);
					_veh addeventhandler ["HandleDamage", {if (((_this select 4) isKindOf "MissileCore") || ((_this select 4) isKindOf "rocketCore")) then { 1; } else { _this select 2; }; }];// Destroy This Air Vehicle With 1 Missile or Rocket

					_VarHunterName = "airhunterE3";
					_veh setVehicleVarName _VarHunterName;
					_veh Call Compile Format ["%1=_This ; PublicVariable ""%1""",_VarHunterName];

					// Initial Waypoint
					_wp0 = _vehgrp addWaypoint [getPosATL air_pat_east, 200];
					_wp0 setWaypointType "MOVE";
					_wp0 setWaypointBehaviour "AWARE";
					_wp0 setWaypointCombatMode "green";
					_wp0 setWaypointStatements ["true", ""];

					if (_ins_debug) then {[airhunterE3] spawn {[airhunterE3] call air_debug_mkrs;};};

					if (!isNull random_w_player3) then
					{
						// Hunt Player
						nul = [airhunterE3,5000,random_w_player3] call find_west_target_fnc;
					}else{
						// Guard Towns
						nul = [airhunterE3] call east_AO_guard_cycle_wp;
					};

					waitUntil {sleep 1; (!alive _veh) || ((count crew _veh) < 1) || (!canmove _veh)};
					if (((count crew _veh) < 1) && (alive _veh)) then {_veh setDamage 1};
					{
						if (alive _x) then {_x setDamage 1; sleep 0.1}
					} forEach (crew _veh);
					if (!alive _veh) then
					{
						{
							if (alive _x) then {_x setDamage 1; sleep 0.1}
						} forEach (units _vehgrp);
					};
					if (alive _veh) then
					{
						_veh setDamage 1;
						{
							if (alive _x) then {_x setDamage 1; sleep 0.1}
						} forEach (units _vehgrp);
					};
				};
				sleep (1 + random 599);
			};
		};
	};
};