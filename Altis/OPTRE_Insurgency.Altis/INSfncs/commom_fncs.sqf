//commom_fncs.sqf by Jigsor

// Global hint
JIG_MPhint_fnc = {if (!isDedicated && hasInterface) then { hintSilent _this };};
JIG_MPsideChatWest_fnc = { [West,"HQ"] SideChat (_this select 0); };
JIG_MPsideChatEast_fnc = { [East,"HQ"] SideChat (_this select 0); };
JIG_MPTitleText_fnc = {
	if (!isDedicated && hasInterface) then {
		_text = _this select 0;
		copyToClipboard str(_text);
		sleep 3;
		cutText [_text,"PLAIN"];
	};
};
INS_missing_mods = {
	if (!isDedicated && hasInterface) then {
		player sideChat "BMR Insurgency warning. This machine is missing mods and will not trigger spawning of enemy AI. Check mod installations.";
	}else{
		diag_log "BMR Insurgency warning. This machine is missing mods and will not spawn enemy AI. Check mod installations.";
	};
};
Hide_Mkr_fnc = {
	private ["_mkrarray","_hidden_side"];
	if (isDedicated || !hasInterface) exitWith {};
	_mkrarray = _this select 0;
	_hidden_side = _this select 1;
	if (side player == _hidden_side) then {
		{
			_x setMarkerAlphaLocal 0;
		} forEach _mkrarray;
	};
	true
};
JIPmkr_updateServer_fnc = {
	// Stores all current intel markers' states to variable "IntelMarkers". by Jigsor
	private ["_JIPmkr","_coloredMarkers"];

	_JIPmkr = _this select 0;
	{
		if (isNil {server getVariable "IntelMarkers"}) then {
			_coloredMarkers=[];
			_coloredMarkers set [count _coloredMarkers,_x];
			server setVariable ["IntelMarkers",_coloredMarkers,true];
		}else{
			_coloredMarkers=server getVariable "IntelMarkers";
			if (isNil "_coloredMarkers") then {_coloredMarkers=[];};
			_coloredMarkers set [count _coloredMarkers,_x];
			server setVariable ["IntelMarkers",_coloredMarkers,true];
		};
	}forEach _JIPmkr;
	true
};
disableEOSmkrs_fnc = {
	private "_arr";
	waitUntil {!isNil "EOS_Spawn"}; sleep 1;
	_arr=server getVariable "EOSmkrStates";
	{
		if (getMarkerColor _x == "ColorGreen") then {
			_x setMarkerColorLocal "colorblack";
			_x setmarkerAlpha 0;
		};
	} forEach _arr;
	true
};
anti_collision = {
	// fixes wheels stuck in ground/vehicles exploding when entering bug by Jigsor.
	private "_obj";
	_obj = _this select 0;
	_obj setVectorUP (surfaceNormal [(getPosATL _obj) select 0,(getPosATL _obj) select 1]);
	_obj setPos [(getPosATL _obj) select 0,(getPosATL _obj) select 1,((getPos _obj) select 2) + 0.3];
	true
};
Playable_Op4_disabled = {
	if (!isServer && hasInterface) then {
		player enableSimulationGlobal false;
		("BMR_Layer_end2" call BIS_fnc_rscLayer) cutText [ "Opfor player slots are currently disabled. Please rejoin and choose a Blufor slot.", "BLACK OUT", 1, true ];
		sleep 10;
		endMission "END2";
	};
};
Kicked_for_TKing = {
	if (!isServer && hasInterface) then {
		player enableSimulationGlobal false;
		("BMR_Layer_end3" call BIS_fnc_rscLayer) cutText [ "You have been kicked for team killing for mission duration!", "BLACK OUT", 1, true ];
		sleep 10;
		endMission "END3";
	};
};
INS_full_stamina = {
	private "_unit";
	_unit = _this select 0;
	_unit enableStamina false;
	_unit enableFatigue false;
	_unit forceWalk false;
	_unit setCustomAimCoef 0.2;//weapon sway 1=max, 0=min
	_unit setAnimSpeedCoef 1;//animation speed 1=max, 0=min
	true
};
mhq_actions_fnc = {
	// Add action for VA and quick VA profile to respawned MHQs. by Jigsor
	private ["_veh","_var"];
	_veh = _this select 0;
	_var = _this select 1;

	switch (true) do {
		case (_var isEqualTo "MHQ_1") : {_veh addAction [("<t color='#F56618'>") + (localize "STR_BMR_load_VAprofile") + "</t>","=BTC=_revive\=BTC=_addAction.sqf",[[(_this select 1)],JIG_load_VA_profile_MHQ1], 1, true, true, "", "true"]; _veh addAction[("<t color='#ff1111'>") + ("Open Virtual Arsenal") + "</t>",{["Open",true] call BIS_fnc_arsenal;}];};
		case (_var isEqualTo "MHQ_2") : {_veh addAction [("<t color='#F56618'>") + (localize "STR_BMR_load_VAprofile") + "</t>","=BTC=_revive\=BTC=_addAction.sqf",[[(_this select 1)],JIG_load_VA_profile_MHQ2], 1, true, true, "", "true"]; _veh addAction[("<t color='#ff1111'>") + ("Open Virtual Arsenal") + "</t>",{["Open",true] call BIS_fnc_arsenal;}];};
		case (_var isEqualTo "MHQ_3") : {_veh addAction [("<t color='#F56618'>") + (localize "STR_BMR_load_VAprofile") + "</t>","=BTC=_revive\=BTC=_addAction.sqf",[[(_this select 1)],JIG_load_VA_profile_MHQ3], 1, true, true, "", "true"]; _veh addAction[("<t color='#ff1111'>") + ("Open Virtual Arsenal") + "</t>",{["Open",true] call BIS_fnc_arsenal;}];};
		case (_var isEqualTo "Opfor_MHQ") : {_veh addAction [("<t color='#12F905'>") + ("Deploy MHQ") + "</t>","scripts\deployOpforMHQ.sqf",nil,1, false, true, "", "side _this != INS_Blu_side"];};
		//case (_var isEqualTo "Opfor_MHQ") : {_veh addAction [("<t color='#12F905'>") + ("Deploy MHQ") + "</t>","scripts\deployOpforMHQ.sqf",nil,1, false, true, "", "side _this != INS_Blu_side"]; _veh addAction [("<t color=""#12F905"">") + ("Restore Loadout") + "</t>",{call Op4_restore_loadout},nil,1, false, true, "", "side _this != INS_Blu_side"];};
		case (_var isEqualTo "") : {};
	};
};
Op4_restore_loadout = {
	_caller = _this select 1;
	[_caller] execVM "scripts\DefLoadoutOp4.sqf";
};
JIG_load_VA_profile_MHQ1 = {
	if (!isNil {profileNamespace getVariable "bis_fnc_saveInventory_data"}) then {
		private ["_name_index","_VA_Loadouts_Count"];
		_VA_Loadouts_Count = count (profileNamespace getVariable "bis_fnc_saveInventory_data");
		_name_index = 0;
		for "_i" from 0 to (_VA_Loadouts_Count/2) -1 do	{
			[_i,_name_index] spawn {
				private ["_name_index","_loadout_name"];
				_name_index = _this select 1;
				_loadout_name = profileNamespace getVariable "bis_fnc_saveInventory_data" select _name_index;
				_id = MHQ_1 addAction [("<t color=""#00ffe9"">") + ("Load " + format ["%1",_loadout_name]) + "</t>","=BTC=_revive\=BTC=_addAction.sqf",[[player,[profileNamespace, format ["%1", _loadout_name]]],BIS_fnc_loadInventory],8,true,true,"","true"];
				sleep 15;
				MHQ_1 removeAction _id;
			};
			_name_index = _name_index + 2;
		};
	};
};
JIG_load_VA_profile_MHQ2 = {
	if (!isNil {profileNamespace getVariable "bis_fnc_saveInventory_data"}) then {
		private ["_name_index","_VA_Loadouts_Count"];
		_VA_Loadouts_Count = count (profileNamespace getVariable "bis_fnc_saveInventory_data");
		_name_index = 0;
		for "_i" from 0 to (_VA_Loadouts_Count/2) -1 do	{
			[_i,_name_index] spawn {
				private ["_name_index","_loadout_name"];
				_name_index = _this select 1;
				_loadout_name = profileNamespace getVariable "bis_fnc_saveInventory_data" select _name_index;
				_id = MHQ_2 addAction [("<t color=""#00ffe9"">") + ("Load " + format ["%1",_loadout_name]) + "</t>","=BTC=_revive\=BTC=_addAction.sqf",[[player,[profileNamespace, format ["%1", _loadout_name]]],BIS_fnc_loadInventory],8,true,true,"","true"];
				sleep 15;
				MHQ_2 removeAction _id;
			};
			_name_index = _name_index + 2;
		};
	};
};
JIG_load_VA_profile_MHQ3 = {
	if (!isNil {profileNamespace getVariable "bis_fnc_saveInventory_data"}) then {
		private ["_name_index","_VA_Loadouts_Count"];
		_VA_Loadouts_Count = count (profileNamespace getVariable "bis_fnc_saveInventory_data");
		_name_index = 0;
		for "_i" from 0 to (_VA_Loadouts_Count/2) -1 do {
			[_i,_name_index] spawn {
				private ["_name_index","_loadout_name"];
				_name_index = _this select 1;
				_loadout_name = profileNamespace getVariable "bis_fnc_saveInventory_data" select _name_index;
				_id = MHQ_3 addAction [("<t color=""#00ffe9"">") + ("Load " + format ["%1",_loadout_name]) + "</t>","=BTC=_revive\=BTC=_addAction.sqf",[[player,[profileNamespace, format ["%1", _loadout_name]]],BIS_fnc_loadInventory],8,true,true,"","true"];
				sleep 15;
				MHQ_3 removeAction _id;
			};
			_name_index = _name_index + 2;
		};
	};
};
mp_Say3D_fnc = {
	// code by Twirly
	private ["_obj","_snd"];
	_obj = _this select 0;
	_snd = _this select 1;

	PVEH_netSay3D = [_obj,_snd];
	publicVariable "PVEH_netSay3D";

	if (!isDedicated && hasInterface) then {_obj say3D _snd};
	true
};
fnc_mp_intel = {
	// Intel addaction. by Jigsor
	private ["_intelobj","_cachepos"];
	_intelobj = _this select 0;
	_cachepos = _this select 1;

	if (!isNull _intelobj) then {
		_intelobj addAction ["<t color='#ffff00'>Grab Intel</t>", "call JIG_intel_found", _cachepos, 6, true, true, "",""];
		intel_objArray pushBack _intelobj;
	};
	if (ObjNull in intel_objArray) then {{intel_objArray = intel_objArray - [objNull]} foreach intel_objArray;};
	publicVariable "intel_objArray";
	true
};
fnc_jip_mp_intel = {
	// JIP Intel addaction. by Jigsor
	private ["_intelobj","_cachepos"];
	_intelobj = _this select 0;
	_cachepos = _this select 1;

	if (!isNull _intelobj) then {
		_intelobj addAction ["<t color='#ffff00'>Grab Intel</t>", "call JIG_intel_found", _cachepos, 6, true, true, "",""];
	};
	true
};
INS_end_mssg = {
	if (!isDedicated && hasInterface) then {
		[] spawn {
			private ["_max","_video","_play"];
			_max = (count INS_ending_videos);
			_video = INS_ending_videos select (floor random _max);
			_play = [_video] spawn bis_fnc_playvideo;
			waitUntil {scriptDone _play};
			titleText [format["It Was an Honor to Serve with You, %1", name player], "PLAIN", 2.0];
			titleFadeOut 8;
			("BMR_Layer_end1" call BIS_fnc_rscLayer) cutRsc ["bmr_intro", "PLAIN"];
		};
	}else{
		sleep 23;
	};
	true
};
hv_tower_effect = {
	if (!isDedicated && hasInterface) then {
		private ["_emitter","_source","_lightningpos"];
		_emitter = objective_pos_logic;
		_lightningpos = [position objective_pos_logic select 0,position objective_pos_logic select 1,10];

		_source = "#particlesource" createVehiclelocal (getPos objective_pos_logic);
		_source setParticleCircle [0,[0,0,0]];
		_source setParticleRandom [0,[0.25,0.25,0], [0.175,0.175,0],0,0.25,[0,0,0,0.1],0,0];

		_source setParticleParams [["\A3\data_f\blesk1",1,0,1],"","SpaceObject",1,0.4,_lightningpos,[0,0,3],0,10,7.9,0.075,[1.2, 2, 4],[[0.1,0.1,0.1,1],[0.25,0.25,0.25,0.5],[0.5,0.5,0.5,0]],[0.08,0,0,0,0,0,5],0.5,0,"","",_emitter];
		_source setDropInterval 0.1;

		_i = 0;
		while {_i < 3} do {
			drop ["\A3\data_f\blesk1","","SpaceObject",1,0.1,_lightningpos,[0,0,3],0,10,7.9,0.075,[1.2,2,4],[[0.1,0.1,0.1,1],[0.25,0.25,0.25,0.5],[0.5,0.5,0.5,0]],[0.08,0,0,0,0,0,5],0.5,0,"","",""];
			_i = _i + 1;
			sleep 0.1;
		};
		deleteVehicle _source;
	};
	true
};
JIG_base_protection = {
	// Intrinsic destruction of enemy entering protection triggers trig_alarm1init and trig_alarm2init by Jigsor.
	if (!hasInterface && !isDedicated) exitWith {};
	private "_defend";
	_defend = [(_this select 0)] spawn {
		private "_unit";
		_unit = _this select 0;
		if (isDedicated && {isPlayer _unit}) exitWith {};
		if (isDedicated) then {
			sleep 0.899;
			(vehicle _unit) call BIS_fnc_neutralizeUnit;
		}else{
		// Give players 10 second warning to leave.
			if (!isServer && {local player && _unit == player}) exitWith {
				private ["_intrude_pos","_trigPos","_dis1","_dis2"];
				_intrude_pos = (getPosATL _unit);
				_trigPos = (position trig_alarm1init);
				_dis1 = (_intrude_pos distance _trigPos);

				for '_i' from 10 to 1 step -1 do {
					hint format ["You have entered a protected zone. You've got %1 seconds to leave", _i];
					uiSleep 1;
				}; hint "";
				sleep 0.13;

				_intrude_pos = (getPosATL _unit);
				_dis2 = (_intrude_pos distance _trigPos);
				if (_dis2 <= _dis1) then {(vehicle _unit) call BIS_fnc_neutralizeUnit;};
			};
			if (local player && _unit == player) then {
				private ["_intrude_pos","_trigPos","_dis1","_dis2"];
				_intrude_pos = (getPosATL _unit);
				_trigPos = (position trig_alarm1init);
				_dis1 = (_intrude_pos distance _trigPos);

				for '_i' from 10 to 1 step -1 do {
					hint format ["You have entered a protected zone. You've got %1 seconds to leave", _i];
					uiSleep 1;
				}; hint "";
				sleep 0.13;

				_intrude_pos = (getPosATL _unit);
				_dis2 = (_intrude_pos distance _trigPos);
				if (_dis2 <= _dis1) then {(vehicle _unit) call BIS_fnc_neutralizeUnit;};
			}else{
				sleep 0.899;
				(vehicle _unit) call BIS_fnc_neutralizeUnit;
			};
		};
	};
	true
};
fnc_mp_push = {
	if (!isDedicated && hasInterface) then {
		private "_veh";
		_veh = _this select 0;
		_veh addAction ["<t color='#FF9900'>Push</t>",{call Push_Vehicle},[],-1,false,true,"","_this distance _target < 8"];
	};
	true
};
Push_Acc = {
	private "_veh";
	_veh = _this select 0;
	[[_veh],"fnc_mp_push"] call BIS_fnc_MP;
	true
};
Push_Vehicle = {
	/* Boat push script - v0.1
	Pushes the boat in the direction the player is looking
	Created by BearBison */

	private ["_veh","_unit","_isWater"];
	_veh = _this select 0;
	_unit = _this select 1;
	_isWater = surfaceIsWater position _unit;
	if (_unit in _veh) exitWith {titleText[localize "STR_BMR_push_restrict2","PLAIN DOWN",1];};
	if (_isWater) exitWith {titleText[localize "STR_BMR_push_restrict1","PLAIN DOWN",1];};
	_veh setOwner (owner _unit);
	_unit playMove "AmovPercMstpSnonWnonDnon_AinvPercMstpSnonWnonDnon_Putdown";
	if (currentWeapon _unit == "") then {sleep 1;} else {sleep 2;};
	_veh setVelocity [(sin(direction _unit))*3, (cos(direction _unit))*3, 0];
	true
};
INS_fog_effect = {
	if (!isDedicated && hasInterface) then {null=["ObjectiveMkr",100,11,10,3,7,-0.3,0.1,0.5,1,1,1,13,12,15,true,2,2.1,0.1,4,6,0,3.5,17.5] execFSM "scripts\Fog.fsm";};
};
mhq_obj_fnc = {
	// returns MHQ vehicleVarname object
	private ["_var","_obj"];
	_var = _this select 0;
	_obj = objNull;
	switch (true) do {
		case (_var isEqualTo "MHQ_1") : {_obj = MHQ_1; if (vehicleVarname MHQ_1 isEqualTo "") then {MHQ_1 setVehicleVarname "MHQ_1"; MHQ_1 = _obj;};};
		case (_var isEqualTo "MHQ_2") : {_obj = MHQ_2; if (vehicleVarname MHQ_2 isEqualTo "") then {MHQ_2 setVehicleVarname "MHQ_2"; MHQ_2 = _obj;};};
		case (_var isEqualTo "MHQ_3") : {_obj = MHQ_3; if (vehicleVarname MHQ_3 isEqualTo "") then {MHQ_3 setVehicleVarname "MHQ_3"; MHQ_3 = _obj;};};
		case (_var isEqualTo "Opfor_MHQ") : {_obj = Opfor_MHQ; if (vehicleVarname Opfor_MHQ isEqualTo "") then {Opfor_MHQ setVehicleVarname "Opfor_MHQ"; Opfor_MHQ = _obj;};};
		case (_var isEqualTo "") : {};
		default {};
	};
	_obj
};
switchMoveEverywhere = compileFinal " _this select 0 switchMove (_this select 1); ";
INS_BluFor_Siren = compileFinal " if (isServer) then {
	[INS_BF_Siren,""siren""] call mp_Say3D_fnc;
	[[""Enemy Presence Detected at Base!""],""JIG_MPsideChatWest_fnc""] call BIS_fnc_mp;
	[INS_BF_Siren2,""siren""] call mp_Say3D_fnc;
	alarm1On = false;
}; ";