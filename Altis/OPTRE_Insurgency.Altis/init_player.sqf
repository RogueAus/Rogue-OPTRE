// init_player.sqf by Jigsor //

if (isNil "oamarker") then {oamarker = [];};//air patrole center marker
"oamarker" addPublicVariableEventHandler {call compile format ["%1",_this select 1]};

if (DebugEnabled > 0) then {
	waitUntil {!isNull player && player == player};

	if (isNil "spawnaire") then {spawnaire = [];};
	if (isNil "spawnairw") then {spawnairw = [];};
	if (isNil "cyclewpmrk") then {cyclewpmrk = [];};

	"spawnaire" addPublicVariableEventHandler {call compile format ["%1",_this select 1]};
	"spawnairw" addPublicVariableEventHandler {call compile format ["%1",_this select 1]};
	"cyclewpmrk" addPublicVariableEventHandler {call compile format ["%1",_this select 1]};

	[] spawn {
		waitUntil {time > 3};
		if (local player) then {
			player allowDamage false;
			player addAction[("<t color='#ff1111'>") + (localize "STR_BMR_open_VA") + "</t>",{["Open",true] call BIS_fnc_arsenal;}];
			[] spawn {
				sleep 4;
				setTerrainGrid 50;
				["Teleport_mapclick","onMapSingleClick", {
					vehicle player setPos [_pos select 0,_pos select 1,0];
				}] call BIS_fnc_addStackedEventHandler;
			};
		};
	};

	if (tky_perfmon > 0) then {_nul1 = [tky_perfmon] execVM "scripts\tky_evo_performance_report.sqf";};
	{_x setMarkerAlphaLocal 1;} forEach Op4_mkrs;
	{_x setMarkerAlphaLocal 1;} forEach Blu4_mkrs;
};

[] spawn {
	waitUntil {!isNull player && player == player};

	// Player Variables	//

	private "_playertype";
	_playertype = typeOf (vehicle player);
	player setVariable ["BIS_noCoreConversations", true];
	enableSentences false;
	setTerrainGrid 25;
	gc_heading_on = false;
	status_hud_on = false;
	INS_SaveLoadout = nil;
	if (!isJIP) then {intel_objArray = [];};
	//if (local player) then {player setVariable ["BIS_enableRandomization", false]};// Disables randomization of gear
	if (AI_radio_volume isEqualTo 1) then {0 fadeRadio 0;};
	if ((INS_p_rev isEqualTo 4) || (INS_p_rev isEqualTo 5)) then {player call btc_qr_fnc_unit_init;};// BTC Quick Revive
	if (INS_GasGrenadeMod isEqualTo 1) then {player setVariable ["inSmoke",false];};
	if (Remove_grass_opt isEqualTo 1) then {tawvd_disablenone = true;};// Disables the grass Option 'None' button in Taw View Distance UI
	if (_playertype in INS_W_PlayerUAVop) then {player setVariable ["ghst_ugvsup", 0];};
	if (_playertype in INS_W_PlayerEng) then {player setVariable ["INS_farp_deployed", false];};
	if (_playertype in INS_W_PlayerEOD) then {0=[] execVM "scripts\minedetector.sqf";};
	
	// Fatigue and Stamina
	setStaminaScheme "FastDrain";
	if (Fatigue_ability isEqualTo 0) then {
		//Disable Fatigue/Stamina
		if (local Player) then {[player] spawn INS_full_stamina;};
	}else{
		if (Fatigue_ability isEqualTo 2) then {[] execVM 'scripts\QS_Fatigue.sqf';};
	};

	// Group Manager
	["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;

	// Object Actions //

	// Base Flag Pole
	INS_flag addAction[("<t size='1.5' shadow='2' color='#ff9900'>") + (localize "STR_BMR_halo_jump") + "</t>","ATM_airdrop\atm_airdrop.sqf", nil, 3.9];
	if (max_ai_recruits > 1) then {INS_flag addAction[("<t size='1.5' shadow='2' color='#ff9900'>") + (localize "STR_BMR_ai_halo_jump") + "</t>","scripts\INS_AI_Halo.sqf", nil, 3.8];};
	INS_flag addAction["<t size='1.5' shadow='2' color='#12F905'>Airfield</t>","call JIG_transfer_fnc", ["Airfield"], 3.7];
	INS_flag addAction["<t size='1.5' shadow='2' color='#12F905'>Dock</t>","call JIG_transfer_fnc", ["Dock"], 3.6];

	// Virtual Arsenal
	INS_Wep_box addAction[("<t size='1.5' shadow='2' color='#ff1111'>") + (localize "STR_BMR_open_VA") + "</t>",{["Open",true] call BIS_fnc_arsenal;}];
	INS_Wep_box addAction[("<t size='1.5' shadow='2' color='#00ffe9'>") + (localize "STR_BMR_load_VAprofile") + "</t>","=BTC=_revive\=BTC=_addAction.sqf",[[],JIG_load_VA_profile], 1, true, true, "", "true"];	
	MHQ_1 addAction[("<t color='#F56618'>") + (localize "STR_BMR_load_VAprofile") + "</t>","=BTC=_revive\=BTC=_addAction.sqf",[[],JIG_load_VA_profile_MHQ1], 1, true, true, "", "side _this != EAST"];
	MHQ_2 addAction[("<t color='#F56618'>") + (localize "STR_BMR_load_VAprofile") + "</t>","=BTC=_revive\=BTC=_addAction.sqf",[[],JIG_load_VA_profile_MHQ2], 1, true, true, "", "side _this != EAST"];
	MHQ_3 addAction[("<t color='#F56618'>") + (localize "STR_BMR_load_VAprofile") + "</t>","=BTC=_revive\=BTC=_addAction.sqf",[[],JIG_load_VA_profile_MHQ3], 1, true, true, "", "side _this != EAST"];

	// Blufor save respawn loadout
	INS_Wep_box addAction[("<t size='1.5' shadow='2' color='#ff9207'>") + (localize "STR_BMR_save_loadout") + "</t>", {call INS_RespawnLoadout}, [], 1, false, true, "", "side _this != EAST"];

	// Op4 MHQ
	Opfor_MHQ addAction[("<t color=""#12F905"">") + ("Deploy MHQ") + "</t>","scripts\deployOpforMHQ.sqf",nil,1, false, true, "", "side _this != INS_Blu_side"];

	// Op4 Weapon Box
	//INS_weps_Cbox addAction[("<t size='1.5' shadow='2' color='#ff1111'>") + (localize "STR_BMR_open_VA") + "</t>",{["Open",true] call BIS_fnc_arsenal;}];// uncomment to allow Op4 access to Virtual Arsenal.
	INS_weps_Cbox addAction[("<t size='1.5' shadow='2' color='#ff9207'>") + (localize "STR_BMR_save_loadout") + "</t>",{call INS_RespawnLoadout}, [], 1, false, true, "", "side _this != INS_Blu_side"];
	INS_weps_Cbox addAction[("<t size='1.5' shadow='2' color='#ff1111'>") + (localize "STR_BMR_load_saved_loadout") + "</t>",{(_this select 1) call INS_RestoreLoadout},nil,1, false, true, "", "side _this != INS_Blu_side"];
	INS_weps_Cbox addAction[("<t size='1.5' shadow='2' color='#12F905'>") + (localize "STR_BMR_restore_default_loadout") + "</t>",{call Op4_restore_loadout},nil,1, false, true, "", "side _this != INS_Blu_side"];

	// AI recruitment
	if (max_ai_recruits > 1) then {INS_Wep_box addAction[("<t size='1.5' shadow='2' color='#1d78ed'>") + (localize "STR_BMR_recruit_inf") + "</t>","bon_recruit_units\open_dialog.sqf", [], 1];};

	// Loadout Transfer
	[INS_Wep_box,true,false,false,false,false] call LT_fnc_LTaction;

	// Player actions for Engineer's Farp/vehicle service point
	Jig_m_obj addAction[("<t size='1.5' shadow='2' color='#12F905'>") + (localize "STR_BMR_maintenance_veh") + "</t>","=BTC=_revive\=BTC=_addAction.sqf",[[],INS_maintenance_veh], 8, true, true, "", "count (nearestObjects [position player, [""LandVehicle"",""Air""], 10]) > 0"];
	Jig_m_obj addAction[("<t size='1.5' shadow='2' color='#12F905'>") + (localize "STR_BMR_repair_wreck") + "</t>","=BTC=_revive\=BTC=_addAction.sqf",[[],BTC_repair_wreck], 8, true, true, "", "count (nearestObjects [position player, [""LandVehicle"",""Air""], 10]) > 0"];
	Jig_m_obj addAction[("<t size='1.5' shadow='2' color='#12F905'>") + (localize "STR_BMR_flip_veh") + "</t>","call INS_Flip_Veh", nil, 8];

	// Player Object Actions //

	[] spawn JIG_p_actions_resp;

	// Player event handlers //

	//Remove any stacked event handler left behind by any mission/rejoin if exists on player. It should happen once player disconnects or leaves any mission automatically. Shitty work around. Upvote Issue here: http://feedback.arma3.com/view.php?id=24841
		//To allow a particular pre-existing stacked event handler from a mod for example, add the name of the key to array StackedEHkeysWhiteList in INS_definitions.sqf
		//Detect a stacked EH in debug by type in example line below. indexVarX returns event key string.
		//_data = missionNameSpace getVariable "BIS_stackedEventhandlers_oneachframe"; indexVarX = _data select count _data - 1;
	{
		_event = _x;
		_namespaceId = "BIS_stackedEventHandlers_";
		_namespaceEvent = _namespaceId + _event;
		_data = missionNameSpace getVariable [_namespaceEvent, []];
		{
			private ["_itemId","_allowed"];
			_allowed = _data select count _data -1 select 0;
			if (_allowed in StackedEHkeysWhiteList) then {
				_data deleteAt count _data -1;
			}else{
				_itemId = [_x, 0, "", [""]] call BIS_fnc_param;
				[_itemId,_event] call bis_fnc_removeStackedEventHandler;
			};
		} foreach _data;
	} forEach ["oneachframe", "onpreloadstarted", "onpreloadfinished", "onmapsingleclick", "onplayerconnected", "onplayerdisconnected"];

	[] spawn {
		sleep 5;
		waitUntil {!isNull (findDisplay 46)};
		handle = (findDisplay 46) displayAddEventHandler ["KeyDown", "_this call DH_fnc_keyPresses"];
	};
	player addEventHandler ["killed", {_nul = _this call killedInfo_fnc}];
	player addEventHandler ["Respawn", {[] spawn JIG_p_actions_resp; (_this select 0) spawn INS_RestoreLoadout; (_this select 0) spawn INS_UI_pref}];
	If (side player == east) then {player addEventHandler ["killed", {handle = [_this select 0] execVM "scripts\MoveOp4Base.sqf";}];};
	if (!isServer) then	{"PVEH_netSay3D" addPublicVariableEventHandler {private "_array"; _array = _this select 1; (_array select 0) say3D (_array select 1);};};

	if ((INS_p_rev isEqualTo 4) || (INS_p_rev isEqualTo 5)) then {
		player addEventHandler ["Respawn", {
			[(_this select 0)] spawn {
				waitUntil {sleep 1; alive (_this select 0)};
				if (captive (_this select 0)) then {(_this select 0) setCaptive false};
			};
		}];
	};

	if (INS_GasGrenadeMod isEqualTo 1) then {
		player addEventHandler ["Fired", {
			if ((_this select 4) in INS_Gas_Grenades) then {
				(_this select 6) spawn {
					private "_grenadePos";
					waitUntil { vectorMagnitudeSqr velocity _this <= 0.5};
					_grenadePos = getPos _this;
					sleep 0.2;
					ToxicGasLoc = _grenadePos;
					publicVariableServer "ToxicGasLoc";
				};
			};
		}];

		smokeNearSEHID = [ "smokeNear", "onEachFrame", {
			if (!(player getVariable ["inSmoke",false]) && { [] call GAS_smokeNear }) then {
				_inSmokeThread = [] spawn GAS_inSmoke;
			};
		}] call BIS_fnc_addStackedEventHandler;
	};

	// Routines //

	// Intro and side settings
	if (DebugEnabled isEqualTo 0) then {
		If (side player == east) then {
			if (INS_play_op4 isEqualTo 0) exitWith {};
			{_x setMarkerAlphaLocal 1;} forEach Op4_mkrs;
			{_x setMarkerAlphaLocal 0;} forEach Blu4_mkrs;
			deleteMarkerLocal "bluforFarp";
			[] spawn INS_intro_op4;
			[] spawn {sleep 10; [player] call Op4_spawn_pos;};
			[] spawn {
				loadout_handler = [player] execVM "scripts\DefLoadoutOp4.sqf";
				waitUntil { scriptDone loadout_handler };
				loadout = [player] call getLoadout;
				if (INS_MHQ_enabled) then {
					private ["_op4","_mhqObj","_mhqPos"];
					_op4 = true;
					_mhqObj = objNull;
					_mhqObj = ["Opfor_MHQ"] call mhq_obj_fnc;
					_mhqPos = getPos Opfor_MHQ; _nul = [_mhqObj,_op4,_mhqPos] spawn INS_MHQ_mkr;
					INS_Op4_flag addAction["<t size='1.5' shadow='2' color='#ED2744'>Transfer to Opfor_MHQ</t>", "call JIG_transfer_fnc", ["Opfor_MHQ"], 1];
				};
				if (!isNil "MHQ_1") then {removeAllActions MHQ_1;};
				if (!isNil "MHQ_2") then {removeAllActions MHQ_2;};
				if (!isNil "MHQ_3") then {removeAllActions MHQ_3;};
			};
		};
		If (side player == west) then {
			{_x setMarkerAlphaLocal 1;} forEach Blu4_mkrs;
			{_x setMarkerAlphaLocal 0;} forEach Op4_mkrs;
			[] spawn INS_intro;
			[] spawn {
				sleep 15;
				loadout = [player] call getLoadout;
				if (INS_MHQ_enabled) then {
					private ["_op4","_mhqPos","_mhqObj1","_mhqObj2","_mhqObj3"];
					_op4 = false;
					_mhqObj1 = objNull;
					_mhqObj2 = objNull;
					_mhqObj3 = objNull;
					_mhqObj1 = ["MHQ_1"] call mhq_obj_fnc;
					_mhqPos = getPos MHQ_1; _nul = [_mhqObj1,_op4,_mhqPos] spawn INS_MHQ_mkr;
					_mhqObj2 = ["MHQ_2"] call mhq_obj_fnc;
					_mhqPos = getPos MHQ_2; _nul = [_mhqObj2,_op4,_mhqPos] spawn INS_MHQ_mkr;
					_mhqObj3 = ["MHQ_3"] call mhq_obj_fnc;
					_mhqPos = getPos MHQ_3; _nul = [_mhqObj3,_op4,_mhqPos] spawn INS_MHQ_mkr;
					INS_flag addAction["<t size='1.5' shadow='2' color='#ED2744'>Transfer to MHQ_1</t>", "call JIG_transfer_fnc", ["MHQ_1"], 4.2];
					INS_flag addAction["<t size='1.5' shadow='2' color='#ED2744'>Transfer to MHQ_2</t>", "call JIG_transfer_fnc", ["MHQ_2"], 4.1];
					INS_flag addAction["<t size='1.5' shadow='2' color='#ED2744'>Transfer to MHQ_3</t>", "call JIG_transfer_fnc", ["MHQ_3"], 4];
				};
			};
		};
	}
	else
	{
		If (side player == east) then {
			if (INS_play_op4 isEqualTo 0) exitWith {};
			[] spawn {[player] call Op4_spawn_pos;};
			[] spawn {
				loadout_handler = [player] execVM "scripts\DefLoadoutOp4.sqf";
				waitUntil { scriptDone loadout_handler };
				loadout = [player] call getLoadout;
				if (INS_MHQ_enabled) then {
					private ["_op4","_mhqObj","_mhqPos"];
					_op4 = true;
					_mhqObj = objNull;
					_mhqObj = ["Opfor_MHQ"] call mhq_obj_fnc;
					_mhqPos = getPos Opfor_MHQ; _nul = [_mhqObj,_op4,_mhqPos] spawn INS_MHQ_mkr;
					INS_Op4_flag addAction["<t size='1.5' shadow='2' color='#ED2744'>Transfer to Opfor_MHQ</t>", "call JIG_transfer_fnc", ["Opfor_MHQ"], 1];
				}
			};
		};
		If (side player == west) then {
			[] spawn {loadout = [player] call getLoadout;};
			if (INS_MHQ_enabled) then {
				private ["_op4","_mhqPos","_mhqObj1","_mhqObj2","_mhqObj3"];
				_op4 = false;
				_mhqObj1 = objNull;
				_mhqObj2 = objNull;
				_mhqObj3 = objNull;
				_mhqObj1 = ["MHQ_1"] call mhq_obj_fnc;
				_mhqPos = getPos MHQ_1; _nul = [_mhqObj1,_op4,_mhqPos] spawn INS_MHQ_mkr;
				_mhqObj2 = ["MHQ_2"] call mhq_obj_fnc;
				_mhqPos = getPos MHQ_2; _nul = [_mhqObj2,_op4,_mhqPos] spawn INS_MHQ_mkr;
				_mhqObj3 = ["MHQ_3"] call mhq_obj_fnc;
				_mhqPos = getPos MHQ_3; _nul = [_mhqObj3,_op4,_mhqPos] spawn INS_MHQ_mkr;
				INS_flag addAction["<t size='1.5' shadow='2' color='#ED2744'>Transfer to MHQ_1</t>", "call JIG_transfer_fnc", ["MHQ_1"], 4.2];
				INS_flag addAction["<t size='1.5' shadow='2' color='#ED2744'>Transfer to MHQ_2</t>", "call JIG_transfer_fnc", ["MHQ_2"], 4.1];
				INS_flag addAction["<t size='1.5' shadow='2' color='#ED2744'>Transfer to MHQ_3</t>", "call JIG_transfer_fnc", ["MHQ_3"], 4];
			};
		};
	};

	// 3rd Person PoV to vehicles only
	if (limitPOV isEqualTo 1) then {
		[player] spawn PVPscene_POV;
		player addEventHandler ["Respawn", {[(_this select 0)] spawn PVPscene_POV;}];
	};

	// Ambient Radio Chatter in/near Vehicles (TPW code)
	if (ambRadioChatter isEqualTo 1) then {
		[] spawn {
		while {true} do	{
			private ["_sound","_veh"];
			if (player != vehicle player) then {
				playMusic format ["RadioAmbient%1",floor (random 31)];
				}
				else
				{
				_veh = ((position player) nearEntities [["Air","Landvehicle"], 10]) select 0;
				if !(isNil "_veh") then	{
					_sound = format ["A3\Sounds_F\sfx\radio\ambient_radio%1.wss",floor (random 31)];
					playsound3d [_sound,_veh,true,getPosasl _veh,1,1,50];
					};
				};
			sleep (1 + random 59);
			};
		};
	};

	// Vehicle Reward incentive initialized if Mechanized Armor threat enabled.
	if (MecArmPb > 1) then {
		[] spawn {
			waitUntil{not isNull player};
			private ["_uid","_text"];
			_uid = (getPlayerUID player);
			_text = (localize "STR_BMR_veh_awarded");
			rewardp = "";
			"rewardp" addPublicVariableEventHandler {call compile format ["%1",_this select 1]};
			while {true} do	{
				if (rewardp isEqualTo "") then {
					sleep 10;
				}
				else
				{
					if ((local player) and (rewardp == _uid)) then {
						//[activated_cache_pos] spawn JIG_circling_cam;// optional cache cam
						player setVariable ["createEnabled", true];
						_id = player addAction[("<t size='1.5' shadow='2' color=""#12F905"">") + (localize "STR_BMR_veh_reward") + "</t>",{call JIG_map_click}, [], 10, false, true];// Use it or loose it when player dies.
						[_text] spawn JIG_MPsideChatWest_fnc;
						rewardp = "";
						publicVariable "rewardp";
					};
				};
			};
		};
	};

	// Ambient Combat Sound
	if (ambCombSound isEqualTo 1) then {s=[objective_pos_logic,23,11] execVM "scripts\fn_Battle.sqf";};

	// Restrict Aircraft Pilot Seat to Pilots Only
	[] spawn {
		if ((count INS_PlayerPilot) isEqualto 0) exitWith {};
		if ((typeOf player) in INS_PlayerPilot) exitWith {};
		If (side player == east) exitWith {};// exclude Op4 players
		private "_veh";
		while {true} do {
			if (vehicle player != player) then {
				_veh = vehicle player;
				if ((_veh isKindOf "Plane") || {((_veh isKindOf "Helicopter") && !(_veh isKindOf "ParachuteBase"))}) then {
					if (driver _veh == player) then {
						if (isEngineOn _veh) then {_veh engineOn false};
						player action ["GetOut", _veh];
						hintSilent localize "STR_BMR_restrict_pilot";
					};
				};
			};
			sleep 1;
		};
	};

	// INS MHQ respawn actions and markers
	if (INS_MHQ_enabled) then {
		[] spawn {
			waitUntil{not isNull player};
			private "_op4";

			_op4 = if (side player == east) then {TRUE}else{FALSE};

			"INS_MHQ_killed" addPublicVariableEventHandler {call compile format ["%1",_this select 1]};

			while {true} do	{
				if (INS_MHQ_killed isEqualTo "") then {
					sleep 5;
				}
				else
				{
					if (local player) then {
						sleep 5;
						private ["_mhqPos","_mhqAcc","_mhqObj"];
						_mhqAcc = [INS_MHQ_killed,_op4] call mhq_actions2_fnc;
						_mhqObj = objNull;
						_mhqObj = [INS_MHQ_killed] call mhq_obj_fnc;
						_mhqPos = getPosASL _mhqObj;
						_nul = [_mhqObj,_op4,_mhqPos] spawn INS_MHQ_mkr;
						INS_MHQ_killed = "";
					};
				};
			};
		};
	};
};