if (!isServer && isNull player) then {isJIP=true;} else {isJIP=false; if (didJIP) then {isJIP=true;};};
HC_1Present = false;
HC_2Present = false;

// Set friendly/enemy sides
_EastHQ = createCenter EAST;
_WestHQ = createCenter WEST;
_IndHQ = createCenter RESISTANCE;
EAST setFriend [WEST, 0];
WEST setFriend [EAST, 0];
RESISTANCE setFriend [WEST, 0];
RESISTANCE setFriend [EAST, 1];
EAST setFriend [RESISTANCE, 1];
WEST setFriend [RESISTANCE, 0];

if (isMultiplayer) then {enableSaving [false, false];};

// Init Headless Client
if (isMultiplayer) then {
	if (!hasInterface && !isDedicated) then
	{
		call compile preProcessFileLineNumbers "INSfncs\headless_client_fncs.sqf";
		diag_log format ["HEADLESSCLIENT: %1 Connected HEADLESSCLIENT ID: %2", name player, owner player];

		private "_enableLogs";
		_enableLogs = true;// set to false to disable logging to headless client(s) .rpt
		if (_enableLogs) then {
			[] spawn {
				waitUntil {time > 3};
				if (INS_mod_missing) then {[] spawn INS_missing_mods;};

				private "_AllEnemyGroups";
				while {true} do {
					sleep 60.123;
					_AllEnemyGroups=[];
					//{if (count units _x>0 and side _x==INS_Op4_side) then {_AllEnemyGroups pushBack _x}} forEach allGroups;// count non empty enemy groups
					{if (side _x==INS_Op4_side) then {_AllEnemyGroups pushBack _x;};} forEach allGroups;// count all enemy groups empty or not

					diag_log format ["HEADLESSCLIENT FPS: %1 TIME: %2 IDCLIENT: %3 TOTAL ENEMY GROUPS: %4", diag_fps, time, owner player, count _AllEnemyGroups];
				};
			};
		};
	};
} else {
	if (isServer) then {
		Any_HC_present = false;
		publicVariable "Any_HC_present";
	};
};

// Common Functions
call compile preprocessFile "INS_definitions.sqf";
call compile preProcessFileLineNumbers "INSfncs\commom_fncs.sqf";
call compile preprocessFile "=BTC=_TK_punishment\=BTC=_tk_init.sqf";
if (INS_p_rev < 4) then {
	call compile preprocessFile "=BTC=_revive\=BTC=_revive_init.sqf";
}else{
	if ((INS_p_rev isEqualTo 4) || (INS_p_rev isEqualTo 5)) then {
		call compile preprocessFile "=BTC=_q_revive\config.sqf";
	};
};
if (!IamHC) then {[] spawn {call compile preprocessFileLineNumbers "EPD\Ied_Init.sqf";};};

// EOS
switch (INS_op_faction) do
{
	case 1 : // CSAT (no mods)
	{
		[EAST,0,0]execVM "eos\OpenMe.sqf";
	};
	case 2 : // AAF (no mods)
	{
		[RESISTANCE,2,2]execVM "eos\OpenMe.sqf";
	};
	case 3 : // African Conflict with NATO SF and Russian Spetsnaz Weapons (@african_conflict;@nato_russian_sf_weapons)
	{
		if ((isClass(configFile >> "cfgPatches" >> "mas_afr_rebl_o")) &&
		{isClass(configFile >> "cfgPatches" >> "mas_weapons")}) then {
			activateAddons ["mas_afr_rebl_o","mas_weapons"];
			[EAST,3,4]execVM "eos\OpenMe.sqf";
		}else{INS_mod_missing = true;};
	};
	case 4 : // CAF Aggressors (@CAF_AG1.5)
	{
		if (isClass(configFile >> "cfgPatches" >> "caf_ag_faction_me_t")) then {
			activateAddons ["caf_ag_faction_me_t","caf_ag_faction_afr_p","caf_ag_faction_eeur_r","caf_ag_faction_me_civ","caf_ag_faction_afr_civ"];
			[EAST,13,15]execVM "eos\OpenMe.sqf";
		}else{INS_mod_missing = true;};
	};
	case 5 : // Leight's Opfor Pack - Islamic State of Takistan/Sahrani and Afghan Militia (@rhs_afrf3;@rhs_usf3;@leights_opfor)
	{
		if ((isClass(configFile >> "cfgPatches" >> "rhs_main")) &&
		{(isClass(configFile >> "cfgPatches" >> "lop_main"))}) then {
			activateAddons ["rhs_main","rhs_weapons","rhsusf_main","rhs_c_troops","rhs_c_btr","rhs_c_bmp","rhs_c_tanks","rhs_c_a2port_armor","RHS_A2_CarsImport","RHS_A2_AirImport","rhsusf_c_heavyweapons","rhsusf_c_weapons","rhs_c_a2port_air","lop_faction_ists","lop_faction_am","lop_faction_sla","lop_faction_ia","lop_faction_cdf","lop_faction_tak_civ"];
			[RESISTANCE,6,5]execVM "eos\OpenMe.sqf";
		}else{INS_mod_missing = true;};
	};
	case 6 : // Syrian Army and Middle Eastern Irregulars (Al Qaida) with CUP Weapons (@mec;@cup;@asdg_jr;@rds;@rds_tank;@cha_mi24)
	{
		if ((isClass(configFile >> "cfgPatches" >> "mec_core")) &&
		{(isClass(configFile >> "cfgPatches" >> "cup_weapons_weaponscore")) &&
		(isClass(configFile >> "cfgPatches" >> "asdg_jointrails")) &&
		(isClass(configFile >> "cfgPatches" >> "rds_staticweapons_core")) &&
		(isClass(configFile >> "cfgPatches" >> "rds_tanks")) &&
		(isClass(configFile >> "cfgPatches" >> "cha_mi24"))}) then {
			activateAddons ["mec_saa","mec_saa_tanks","mec_saa_staticweapons","mec_qudsforce","mec_irregulars","mec_irr_tanks","mec_irr_staticweapons_o","mec_irr_staticweapons","mec_civilians","cup_creatures_peaople_military_dummyset","mec_gme_tanks","asdg_jointrails"];
			[EAST,5,7]execVM "eos\OpenMe.sqf";
		}else{INS_mod_missing = true;};
	};
	case 7 : // Taliban and Islamic State with CUP Weapons (@mec;@cup;@asdg_jr;@rds;@rds_tank;@cha_mi24)
	{
		if ((isClass(configFile >> "cfgPatches" >> "mec_core")) &&
		{(isClass(configFile >> "cfgPatches" >> "cup_weapons_weaponscore")) &&
		(isClass(configFile >> "cfgPatches" >> "asdg_jointrails")) &&
		(isClass(configFile >> "cfgPatches" >> "rds_staticweapons_core")) &&
		(isClass(configFile >> "cfgPatches" >> "rds_tanks")) &&
		(isClass(configFile >> "cfgPatches" >> "cha_mi24"))}) then {
			activateAddons ["mec_saa","mec_saa_tanks","mec_saa_staticweapons","mec_taliban","mec_tal_tanks","mec_taliban_staticweapons","mec_is","mec_is_tanks","mec_is_staticweapons","mec_qudsforce","mec_irregulars","mec_civilians","cup_creatures_peaople_military_dummyset","asdg_jointrails"];
			[RESISTANCE,8,9]execVM "eos\OpenMe.sqf";
		}else{INS_mod_missing = true;};
	};
	case 8 : // Hamas and Hezbollah with CUP Weapons (@mec;@cup;@asdg_jr;@rds;@rds_tank;@cha_mi24)
	{
		if ((isClass(configFile >> "cfgPatches" >> "mec_core")) &&
		{(isClass(configFile >> "cfgPatches" >> "cup_weapons_weaponscore")) &&
		(isClass(configFile >> "cfgPatches" >> "asdg_jointrails")) &&
		(isClass(configFile >> "cfgPatches" >> "rds_staticweapons_core")) &&
		(isClass(configFile >> "cfgPatches" >> "rds_tanks")) &&
		(isClass(configFile >> "cfgPatches" >> "cha_mi24"))}) then {
			activateAddons ["mec_hamas","mec_bokoharam","mec_hezbollah","mec_is","mec_bok_tanks","mec_hamas_staticweapons","mec_hezbollah_staticweapons","mec_civilians","cup_creatures_peaople_military_dummyset","asdg_jointrails"];
			[EAST,10,11]execVM "eos\OpenMe.sqf";
		}else{INS_mod_missing = true;};
	};
	case 9 : // Sud Russians East Vs. West (@evw;@rds)
	{
		if ((isClass(configFile >> "cfgPatches" >> "sud_gw_v")) &&
		{(isClass(configFile >> "cfgPatches" >> "rds_staticweapons_core"))}) then {
			activateAddons ["sud_gw_v","sud_gw_u","sud_a10","sud_mi24","rds_staticweapons_core"];
			[EAST,12,12]execVM "eos\OpenMe.sqf";
		}else{INS_mod_missing = true;};
	};
	case 10 : // RHS - Armed Forces of the Russian Federation (@rhs_afrf3)
	{
		if (isClass(configFile >> "cfgPatches" >> "rhs_c_troops")) then {
			activateAddons ["rhs_c_troops","rhs_c_btr","rhs_c_bmp","rhs_c_tanks","rhs_c_a2port_armor","RHS_A2_CarsImport","RHS_A2_AirImport"];
			[EAST,16,16]execVM "eos\OpenMe.sqf";

			// (optional/not required) United States Armed Forces (@rhs_usf3)
			// Vehicles will show up in vehicle rewards.
			if (isClass(configFile >> "cfgPatches" >> "rhsusf_main")) then {
				activateAddons ["rhsusf_main","rhsusf_c_troops","RHS_US_A2Port_Armor","rhsusf_vehicles","rhs_c_a2port_car","RHS_US_A2_AirImport","rhsusf_c_hmmwv","rhsusf_c_m113","rhsusf_c_m109"];
			};
		}else{INS_mod_missing = true;};
	};
	case 11 : // Iraqi-Syrian Conflict (@iraqi_syrian_conflict;@cup_weapons;@mas_nato_rus_sf_veh;@rhs_afrf3;@rhs_usf3)
	{
		if ((isClass(configFile >> "cfgPatches" >> "Iraqi_Syrian_Conflict")) &&
		{(isClass(configFile >> "cfgPatches" >> "cup_weapons_weaponscore")) &&
		(isClass(configFile >> "cfgPatches" >> "asdg_jointrails")) &&
		(isClass(configFile >> "cfgPatches" >> "mas_vehicleweapons_Core")) &&
		(isClass(configFile >> "cfgPatches" >> "mas_tanks")) &&
		(isClass(configFile >> "cfgPatches" >> "mas_MI24")) &&
		(isClass(configFile >> "cfgPatches" >> "rhs_c_troops")) &&
		(isClass(configFile >> "cfgPatches" >> "rhsusf_main"))}) then {
			activateAddons ["Iraqi_Syrian_Conflict","iraqi_syrian_conflict_v","mas_UH1Y","mas_UH60M","mas_CH47","asdg_jointrails"];
			activateAddons ["rhs_c_troops","rhs_c_btr","rhs_c_bmp","rhs_c_tanks","rhs_c_a2port_armor","RHS_A2_CarsImport","RHS_A2_AirImport"];
			activateAddons ["rhsusf_main","rhsusf_c_troops","RHS_US_A2Port_Armor","rhsusf_vehicles","rhs_c_a2port_car","RHS_US_A2_AirImport","rhsusf_c_hmmwv","rhsusf_c_m113","rhsusf_c_m109"];
			[EAST,17,18]execVM "eos\OpenMe.sqf";
		}else{INS_mod_missing = true;};
	};
};
if (CiviFoot isEqualTo 1) then {[]execVM "eos_civ\OpenMeCiv.sqf";};// Civilians

// Common Scripts
execVM "Objectives\shk_taskmaster.sqf";
if (JigHeliExtraction isEqualTo 1) then {if (!IamHC) then {null = [] execVM "JIG_EX\extraction_init.sqf";};};
if (CiviMobiles isEqualTo 1) then {[2, 400, 500] execVM "scripts\MAD_traffic.sqf";};
if (INS_logistics isEqualTo 1) then {_logistic = execVM "=BTC=_Logistic\=BTC=_logistic_init.sqf";};
if (max_ai_recruits > 1) then {[] execVM "bon_recruit_units\init.sqf";};
execVM "scripts\zlt_fastrope.sqf";
execVM "JWC_CASFS\initCAS.sqf";
nul = ["mission"] execVM "hcam_init.sqf";
execVM "BTK\Cargo Drop\Start.sqf";
execVM "LT\init.sqf";

// Auxiliary AI Men Caching
if ((DebugEnabled isEqualTo 1) && (tky_perfmon > 0)) then {
	if (AI_SpawnDis > 1000) then {
		[AI_SpawnDis,9,true,1800]execVM "zbe_cache\main.sqf";
	}else{
		[1000,9,true,1500]execVM "zbe_cache\main.sqf";
	};
}else{
	if (AI_SpawnDis < 1000) then {
		[1000,10,false,1500]execVM "zbe_cache\main.sqf";
	}else{
		[AI_SpawnDis,10,false,1500]execVM "zbe_cache\main.sqf";
	};
};

// Init Server
if (isServer) then
{
	call compile preprocessFile "init_server.sqf";
	call compile preprocessFileLineNumbers "INSfncs\AirPatrole_Fncs.sqf";
	rej_fnc_bezier = compile preProcessFileLineNumbers "INSfncs\rej_fnc_bezier.sqf";
};

// Init Player
if (!isDedicated && hasInterface) then
{
	[] spawn {
		#include "add_diary.sqf"
		waitUntil {!isNull player && player == player};
		//private "_va_preload";
		//_va_preload = false;
		//_va_preload = ["Preload"] call BIS_fnc_arsenal;
		//waitUntil {_va_preload};
		if (DebugEnabled isEqualTo 0) then {["BIS_ScreenSetup", false] call BIS_fnc_blackOut;};
		call compile preprocessFile "INSfncs\client_fncs.sqf";
		call compile preprocessFile "ATM_airdrop\functions.sqf";
		getLoadout = compile preprocessFileLineNumbers 'scripts\get_loadout.sqf';
		setLoadout = compile preprocessFileLineNumbers 'scripts\set_loadout.sqf';
		player sideChat localize "STR_BMR_loading";

		if (!isServer) then {
			["BIS_introPreload", "onPreloadFinished", {
				// Remove event handler
				["BIS_introPreload", "onPreloadFinished"] call BIS_fnc_removeStackedEventHandler;

				// Flag
				missionNamespace setVariable ["BIS_readyForIntro", true];
			}] call BIS_fnc_addStackedEventHandler;

			waitUntil {
				!isNil { missionNamespace getVariable "BIS_readyForIntro" };
			};

			if (isJIP) then {uiSleep 3;};
		};

		call compile preprocessFile "init_player.sqf";
		[] call compile preprocessFile "INSui\UI\HUD.sqf";
		0 = [] execVM 'scripts\player_markers.sqf';
	};
};