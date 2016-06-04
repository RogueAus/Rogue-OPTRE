//Objectives\pilot_rescue.sqf by Jigsor

sleep 2;
private ["_newZone","_type","_rnum","_pilot_grp","_handle","_op4_side","_blu4_side","_tsk_failed","_hero","_objmkr","_wreck","_VarName","_pilot","_grp","_stat_grp","_wp","_tskW","_tasktopicW","_taskdescW","_tskE","_tasktopicE","_taskdescE","_nearUnits","_hero_speed","_pilotVarName","_end_loop","_base_pos"];

_newZone = _this select 0;
_type = _this select 1;
_op4_side = INS_Op4_side;
_blu4_side = INS_Blu_side;
_pilot_grp = grpNull;
_hero = objNull;
_tsk_failed = false;
_end_loop = false;
_rnum = str(round (random 999));
_base_p = (getMarkerPos "Respawn_West");

// Positional info
objective_pos_logic setPos _newZone;

_objmkr = createMarker ["ObjectiveMkr", _newZone];
"ObjectiveMkr" setMarkerShape "ELLIPSE";
"ObjectiveMkr" setMarkerSize [2, 2];
"ObjectiveMkr" setMarkerShape "ICON";
"ObjectiveMkr" setMarkerType "mil_dot";
"ObjectiveMkr" setMarkerColor "ColorRed";
"ObjectiveMkr" setMarkerText "Pilot Rescue";

// Spawn Objective Objects
_wreck = createVehicle [_type, _newZone, [], 0, "None"];
sleep jig_tvt_globalsleep;

_wreck setDir (random 359);
_wreck setVectorUp [0,0,1];
_wreck enableSimulationGlobal false;
_wreck allowdamage false;

_VarName = "OspreyWreck";
_wreck setVehicleVarName _VarName;
_wreck Call Compile Format ["%1=_This ; PublicVariable ""%1""",_VarName];

_pilot_grp = createGroup INS_Blu_side;
_pilot = _pilot_grp createUnit ["B_Pilot_F", _newZone, [], 0, "NONE"];
sleep jig_tvt_globalsleep;

_pilot addeventhandler ["killed","[(_this select 0)] spawn remove_carcass_fnc"];

_pilotVarName = "DownedPilot";
_pilot setVehicleVarName _pilotVarName;
_pilot Call Compile Format ["%1=_This ; PublicVariable ""%1""",_pilotVarName];

_pilot setUnitPos "UP";
_pilot disableAI "MOVE";
_pilot allowfleeing 0;
_pilot setBehaviour "Careless";
removeallweapons _pilot;
_pilot setCaptive true;
[ [ _pilot, "AmovPercMstpSsurWnonDnon" ], "switchMoveEverywhere" ] call BIS_fnc_MP;

// Spawn Objective enemy defences
_grp = [_newZone,10] call spawn_Op4_grp;
_stat_grp = [_newZone,3] call spawn_Op4_StatDef;

_stat_grp setCombatMode "RED";

_handle=[_grp, position objective_pos_logic, 75] call BIS_fnc_taskPatrol;

if (DebugEnabled > 0) then {[_grp] spawn INS_Tsk_GrpMkrs;};

// create west task
_tskW = "tskW_Pilot_Rescue" + _rnum;
_tasktopicW = localize "STR_BMR_Tsk_topicW_rdp";
_taskdescW = localize "STR_BMR_Tsk_descW_rdp";
[_tskW,_tasktopicW,_taskdescW,WEST,[],"created",_newZone] call SHK_Taskmaster_add;
sleep 5;

// create east task
_tskE = "tskE_Pilot_Rescue" + _rnum;
_tasktopicE = localize "STR_BMR_Tsk_topicE_rdp";
_taskdescE = localize "STR_BMR_Tsk_descE_rdp";
[_tskE,_tasktopicE,_taskdescE,EAST,[],"created",_newZone] call SHK_Taskmaster_add;

if (INS_environment isEqualTo 1) then {if (daytime > 3.00 && daytime < 5.00) then {[] spawn {[[], "INS_fog_effect"] call BIS_fnc_mp;};};};

// pilot hold position until rescued or dead
for [{_loop=0}, {_loop<1}, {_loop=_loop}] do
{
	if (not (alive _pilot)) exitWith {_end_loop = true;_loop=1;};
	_nearUnits = nearestObjects [_pilot, ["CAManBase"], 5];
	_nearUnits deleteAt 0;
	
	{
		if (side _x == _op4_side) then {_nearUnits = _nearUnits - [_x];};
	} count _nearUnits;

	{
		_hero_speed = speed _x;
		_pos = (getPos _x);
		if ((_hero_speed > 8) || (_pos select 2 > 3)) then {
			_nearUnits = _nearUnits - [_x];
		};
	} count _nearUnits;

	if ((count _nearUnits > 0) and (side (_nearUnits select 0) == _blu4_side)) exitWith {_hero = _nearUnits select 0; _end_loop=true; _loop=1;};	
	sleep 3;
};
waitUntil {sleep 1; _end_loop};

if (alive _pilot) then {
	[_pilot] join (group _hero);
	_pilot setdamage 0;
	_pilot setCaptive false;
	_pilot enableAI "MOVE";
	sleep 0.01;
	[ [ _pilot, "" ], "switchMoveEverywhere" ] call BIS_fnc_MP;
	sleep 0.5;
	_pilot setUnitPos "UP";
	_pilot doFollow (leader group _hero);
};

// wait until pilot dead or returned to base
waitUntil {sleep 3; (not (alive _pilot)) || (position _pilot distance _base_p < 100)};

if (not (alive _pilot)) then {[_tskW, "failed"] call SHK_Taskmaster_upd; [_tskE, "succeeded"] call SHK_Taskmaster_upd;};
if ((position _pilot) distance _base_p < 100) then {[_tskW, "succeeded"] call SHK_Taskmaster_upd; [_tskE, "failed"] call SHK_Taskmaster_upd; sleep 20;};

// clean up
"ObjectiveMkr" setMarkerAlpha 0;
sleep 60;

if (!isNull _pilot) then {[_pilot] joinSilent grpNull; sleep 1; deleteVehicle _pilot;};
sleep 30;

{deleteVehicle _x; sleep 0.1} forEach (units _grp);
{deleteVehicle _x; sleep 0.1} forEach (units _stat_grp);
deleteGroup _grp;
deleteGroup _stat_grp;
deleteGroup _pilot_grp;

{if (typeof _x in INS_Op4_stat_weps) then {deleteVehicle _x; sleep 0.1}} forEach (NearestObjects [objective_pos_logic, [], 40]);
{if (typeof _x in objective_ruins) then {deleteVehicle _x; sleep 0.1}} forEach (NearestObjects [objective_pos_logic, [], 30]);
if (!isNull _wreck) then {deleteVehicle _wreck; sleep 0.1;};

deleteMarker "ObjectiveMkr";

if (true) exitWith {sleep 20; nul = [] execVM "Objectives\random_objectives.sqf";};