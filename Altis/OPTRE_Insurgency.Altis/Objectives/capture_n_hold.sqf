//capture_n_hold.sqf by Jigsor

sleep 2;
private ["_newZone","_type","_rnum","_cap_rad","_VarName","_uncaped","_caped","_ins_debug","_objmkr","_outpost","_grp","_stat_grp","_handle","_tskW","_tasktopicW","_taskdescW","_tskE","_tasktopicE","_taskdescE","_manArray","_text","_rwave","_hold_rad","_defender_rad","_currTime","_defenderArr","_defcnt","_holdTime"];

_newZone = _this select 0;
_type = _this select 1;
_rnum = str(round (random 999));
_cap_rad = 25;
_hold_rad = 50;
_defender_rad = 200;
_VarName = "OutPost1";
_uncaped = true;
_caped = true;
_ins_debug = if (DebugEnabled isEqualTo 1) then {TRUE}else{FALSE};

//Positional info
objective_pos_logic setPos _newZone;
_objmkr = createMarker ["ObjectiveMkr", _newZone];
"ObjectiveMkr" setMarkerShape "ELLIPSE";
"ObjectiveMkr" setMarkerSize [2, 2];
"ObjectiveMkr" setMarkerShape "ICON";
"ObjectiveMkr" setMarkerType "mil_dot";
"ObjectiveMkr" setMarkerColor "ColorRed";
"ObjectiveMkr" setMarkerText "Capture and Hold";

//Spawn Objective Object
_outpost = createVehicle [_type, _newZone, [], 0, "None"];
sleep jig_tvt_globalsleep;

_outpost setDir (random 359);
_outpost setVectorUp [0,0,1];
_outpost setVehicleVarName _VarName;
_outpost Call Compile Format ["%1=_This ; PublicVariable ""%1""",_VarName];

//Spawn Objective enemy defences
_grp = [_newZone,10] call spawn_Op4_grp;
_stat_grp = [_newZone,3] call spawn_Op4_StatDef;

//movement
_stat_grp setCombatMode "RED";
_handle=[_grp, position objective_pos_logic, 75] call BIS_fnc_taskPatrol;
if (_ins_debug) then {[_grp] spawn INS_Tsk_GrpMkrs;};

//create west task
_tskW = "tskW_Cap_n_Hold" + _rnum;
_tasktopicW = localize "STR_BMR_Tsk_topicW_cnho";
_taskdescW = localize "STR_BMR_Tsk_descW_cnho";
[_tskW,_tasktopicW,_taskdescW,WEST,[],"created",_newZone] call SHK_Taskmaster_add;
sleep 5;
//create east task
_tskE = "tskE_Cap_n_Hold" + _rnum;
_tasktopicE = localize "STR_BMR_Tsk_topicE_cnho";
_taskdescE = localize "STR_BMR_Tsk_descE_cnho";
[_tskE,_tasktopicE,_taskdescE,EAST,[],"created",_newZone] call SHK_Taskmaster_add;

if (INS_environment isEqualTo 1) then {if (daytime > 3.00 && daytime < 5.00) then {[] spawn {[[], "INS_fog_effect"] call BIS_fnc_mp;};};};

while {_uncaped} do {
	_manArray = objective_pos_logic nearEntities [["CAManBase"], _cap_rad];

	{
		if ((!(side _x == INS_Blu_side)) || (captiveNum _x isEqualTo 1)) then {
			_manArray = _manArray - [_x];
		};
	} forEach _manArray;

	if ((count _manArray) > 0) exitWith {_uncaped = false};
	sleep 4;
};
waitUntil {!_uncaped};

if (isNil "timesup") then {timesup = false;};
"timesup" addPublicVariableEventHandler {call compile format ["%1",_this select 1]};

_text = format [localize "STR_BMR_outpost_caped"];
[[_text],"JIG_MPsideChatWest_fnc"] call BIS_fnc_mp;

_defenderArr = objective_pos_logic nearEntities [["CAManBase"], _defender_rad];
{
	if ((!(side _x == INS_Blu_side)) || (captiveNum _x isEqualTo 1)) then {
		_defenderArr = _defenderArr - [_x];
	};
} forEach _defenderArr;

if (isNil "_defenderArr") then {_defenderArr = [];};
_defcnt = count _defenderArr;

switch (true) do {
	case (_defcnt isEqualTo 2) : {_holdTime = 6;};
	case (_defcnt isEqualTo 3) : {_holdTime = 7;};
	case (_defcnt isEqualTo 4) : {_holdTime = 8;};
	case (_defcnt isEqualTo 5) : {_holdTime = 9;};
	case (_defcnt isEqualTo 6) : {_holdTime = 10;};
	case (_defcnt isEqualTo 7) : {_holdTime = 11;};
	case (_defcnt > 7) : {_holdTime = 12;};
	default {_holdTime = 6;};
};

_currTime = time;
if (_ins_debug) then {diag_log format["TIMER PARAMETERS Server Time %1 Timer Length %2 Defenders %3", _currTime, _holdTime, _defcnt];};

//[[[_currTime,false,_holdTime," Hold Outpost"],"scripts\Timer.sqf"],"BIS_fnc_execVM",true] call BIS_fnc_MP;//with JIP persistance
[[[_currTime,false,_holdTime," Hold Outpost"],"scripts\Timer.sqf"],"BIS_fnc_execVM"] call BIS_fnc_MP;// without JIP persistance

_rwave = [_newZone,_ins_debug] spawn {

	private ["_newZone","_start_dis","_cnhWaveUnits","_cnhWaveGrps","_start_pos1","_midLength","_midDir","_midPos","_pointC","_ins_debug","_rgrp1","_newPosw","_wp","_bellDir"];

	_newZone = _this select 0;
	_ins_debug = _this select 1;
	_cnhWaveUnits = [];
	_cnhWaveGrps = [];
	curvePosArr = [];
	makewave = true;

	"makewave" addPublicVariableEventHandler {call compile format ["%1",_this select 1]};

	while {makewave} do	{
		if (round(random(1)) isEqualTo 0) then {_bellDir = 90;}else{_bellDir = 270;};

		//Thanks to Larrow for this next block. Creates 2D obtuse isosceles triangle points.
		_start_dis = [400,500] call BIS_fnc_randomInt;
		_start_pos1 = [_newZone, 10, _start_dis, 10, 0, 0.6, 0] call BIS_fnc_findSafePos;
		_midLength = ( _newZone distance _start_pos1 ) / 2;
		_midDir = [ objective_pos_logic, _start_pos1 ] call BIS_fnc_relativeDirTo;
		_midPos = [ _newZone, _midLength, _midDir ] call BIS_fnc_relPos;
		_pointC = [ _midPos, _midLength - 1, (_midDir + _bellDir) ] call BIS_fnc_relPos;

		if (count curvePosArr > 0) then {curvePosArr = curvePosArr - curvePosArr;};

		curvePosArr = [_start_pos1,_newZone,_pointC,12,false,_ins_debug] call rej_fnc_bezier;

		private "_count";
		_count = 0;

		while {curvePosArr isEqualTo []} do	{
			curvePosArr = [_start_pos1,_newZone,_pointC,12,false,_ins_debug] call rej_fnc_bezier;
			if (!(curvePosArr isEqualTo [])) exitWith {curvePosArr;};
			_count = _count + 1;
			if (_count > 3) exitWith {if (_ins_debug) then {hintSilent "Empty curvePosArr";}; curvePosArr = [];};
			sleep 3;
		};
		if (curvePosArr isEqualTo []) exitWith {makewave = false; publicVariable "makewave";};

		if (count curvePosArr > 0) then	{
			_rgrp1 = [_start_pos1,6] call spawn_Op4_grp;

			_cnhWaveGrps pushBack _rgrp1;
			{_cnhWaveUnits pushBack _x;} forEach (units _rgrp1);

			//reinforcement/wave group movement
			for "_i" from 0 to (count curvePosArr) -1 do {
				private "_newPosx";
				_newPosx = (curvePosArr select 0);

				_wp = _rgrp1 addWaypoint [_newPosx, 0];
				_wp setWaypointType "MOVE";
				_wp setWaypointSpeed "NORMAL";
				_wp setWaypointBehaviour "AWARE";
				_wp setWaypointFormation "COLUMN";
				_wp setWaypointCompletionRadius 20;

				curvePosArr deleteAt 0;
				sleep 0.2;
			};
			if (_ins_debug) then {[_rgrp1] spawn INS_Tsk_GrpMkrs;};

			sleep 55;
			if (!makewave) exitWith {};
		};
	};

	sleep 20;
	{deleteVehicle _x; sleep 0.1} forEach (units _rgrp1);
	deleteGroup _rgrp1; sleep 0.1;

	[_cnhWaveUnits,_cnhWaveGrps] spawn {
		private ["_unitsArr","_grpsArr"];
		_unitsArr = _this select 0;
		_grpsArr = _this select 1;
		sleep 120;
		{if (alive _x) then {deleteVehicle _x; sleep 0.1}} forEach _unitsArr;
		{deleteGroup _x} count _grpsArr;
	};
};

while {_caped} do {
	_manArray = objective_pos_logic nearEntities [["CAManBase","Landvehicle"],_hold_rad];

	{
		if ((!(side _x == INS_Blu_side)) || (captiveNum _x isEqualTo 1)) then {
			_manArray = _manArray - [_x];
		};
	} forEach _manArray;

	if ((count _manArray) < 1) exitWith	{
		makewave = false;publicVariable "makewave"; sleep 2;
		killtime = true;publicVariable "killtime"; sleep 2;
		[_tskE, "succeeded"] call SHK_Taskmaster_upd;
		[_tskW, "failed"] call SHK_Taskmaster_upd;
		_caped = false;
	};

	if (timesup) exitWith {
		makewave = false;publicVariable "makewave"; sleep 2;
		killtime = true;publicVariable "killtime"; sleep 2;
		[_tskW, "succeeded"] call SHK_Taskmaster_upd;
		[_tskE, "failed"] call SHK_Taskmaster_upd;
		_caped = false;
	};
	sleep 4;
};

//clean up
"ObjectiveMkr" setMarkerAlpha 0;
sleep 90;

if (!isNull _outpost) then {deleteVehicle _outpost; sleep 0.1;};
{deleteVehicle _x; sleep 0.1} forEach (units _grp);
{deleteVehicle _x; sleep 0.1} forEach (units _stat_grp);
deleteGroup _grp;
deleteGroup _stat_grp;

{if (typeOf _x in INS_men_list) then {deleteVehicle _x; sleep 0.1}} forEach (NearestObjects [objective_pos_logic, [], 40]);
{if (typeOf _x in INS_Op4_stat_weps) then {deleteVehicle _x; sleep 0.1}} forEach (NearestObjects [objective_pos_logic, [], 40]);
{if (typeOf _x in objective_ruins) then {deleteVehicle _x; sleep 0.1}} forEach (NearestObjects [objective_pos_logic, [], 30]);

deleteMarker "ObjectiveMkr";

if (true) exitWith {sleep 20; nul = [] execVM "Objectives\random_objectives.sqf";};