// Made by Raz, data entry from Josh, Zissou and stuffed sheep Made on AhoyWorld this script features all magazines, most weapons, Nato backpacks, Nato items, Nato clothes. You may use this on your mission start, please keep us credited! Enjoy.
// _null = [this] execVM "scripts\VAserver.sqf";

if (!isServer) exitWith {};

private ["_box"];

_box = _this select 0;

["AmmoboxInit",[_box,false,{true}]] call BIS_fnc_arsenal;

[
	_box,
	[
	"OPTRE_kitbag_rgr_AA",
	"OPTRE_ANPRC_515",
	"OPTRE_ANPRC_521_Black",
	"OPTRE_ANPRC_521_Green",
	"OPTRE_kitbag_rgr_AT",
	"OPTRE_kitbag_rgr_EXP",
	"OPTRE_kitbag_rgr_ENG",
	"OPTRE_ILCS_Rucksack_Medical",
	"OPTRE_ILCS_Rucksack_Black",
	"OPTRE_ILCS_Rucksack_Green",
	"OPTRE_ILCS_Rucksack_Tan",
	"OPTRE_ILCS_Rucksack_Black_AT",
	"OPTRE_ILCS_Rucksack_Black_Pouches",
	"OPTRE_ILCS_Rucksack_Green_Pouches",
	"OPTRE_ILCS_Rucksack_Tan_Pouches"
],
	true
] call BIS_fnc_addVirtualBackpackCargo;
	
[
	_box,
	[
	//Mags
	"OPTRE_12Rnd_127x40_Mag",//M6C Handgun Magazine
	"OPTRE_16Rnd_127x40_Mag",//M6C Handgun Magazine
	"OPTRE_8Rnd_127x40_Mag",//M6G Magnum Magazine
	"OPTRE_8Rnd_127x40_Mag_Tracer",//M6G Magnum Magazine
	"OPTRE_8Rnd_127x40_AP_Mag",//M6G Magnum Magazine
	"OPTRE_60Rnd_5x23mm_Mag",//M7 SMG Magazine
	"OPTRE_60Rnd_5x23mm_Mag_tracer",//M7 SMG Magazine
	"OPTRE_48Rnd_5x23mm_Mag",//M7 SMG Magazine
	"OPTRE_48Rnd_5x23mm_Mag_tracer",//M7 SMG Magazine
	"OPTRE_48Rnd_5x23mm_JHP_Mag",//M7 SMG Magazine
	"OPTRE_48Rnd_5x23mm_FMJ_Mag",//M7 SMG Magazine
	"OPTRE_36Rnd_95x40_Mag",//Battle Rifle Magazine
	"OPTRE_36Rnd_95x40_Mag_Tracer",//Battle Rifle Magazine
	"OPTRE_15Rnd_762x51_Mag",//M392 DMR Magazine
	"OPTRE_15Rnd_762x51_Mag_Tracer",//M392 DMR Magazine
	"OPTRE_6Rnd_8Gauge_Pellets",//M45 Shotgun Magazine
	"OPTRE_6Rnd_8Gauge_Slugs",//M45 Shotgun Magazine
	"OPTRE_12Rnd_8Gauge_Pellets",//M45 Semi-Auto/Combat Magazine
	"OPTRE_12Rnd_8Gauge_Slugs",//M45 Semi-Auto/Combat Magazine
	"OPTRE_100Rnd_95x40_Box",//M73 LMG Magazine
	"OPTRE_100Rnd_95x40_Box_Tracer",//M73 LMG Magazine
	"OPTRE_200Rnd_95x40_Box",//M73 LMG Magazine
	"OPTRE_200Rnd_95x40_Box_Tracer",//M73 LMG Magazine
	"OPTRE_60Rnd_762x51_Mag",//MA5B Assault Rifle Magazine
	"OPTRE_60Rnd_762x51_Mag_Tracer",//MA5B Assault Rifle Magazine
	"OPTRE_4Rnd_145x114_APFSDS_Mag",//SRS99D Sniper Rifle Magazine
	"OPTRE_4Rnd_145x114_HVAP_Mag",//SRS99D Sniper Rifle Magazine
	"OPTRE_4Rnd_145x114_HEDP_Mag",//SRS99D Sniper Rifle Magazine
	"OPTRE_M41_Twin_HEAT",//M41 Rocket Launcher Magazine
	"OPTRE_M41_Twin_HEAP",//M41 Rocket Launcher Magazine
	//Grenades
	"OPTRE_M9_Frag",//M9 Frag Grenade
	"OPTRE_M8_Flare",//M8 Flare Grenade
	"OPTRE_M2_Smoke",//M3 Smoke Grenade
	"OPTRE_M2_Smoke_Red",//M3 Smoke Grenade - Red
	"OPTRE_M2_Smoke_Blue",//M3 Smoke Grenade - Blue
	"OPTRE_M2_Smoke_Green",//M3 Smoke Grenade - Green
	"OPTRE_M2_Smoke_Orange",//M3 Smoke Grenade - Orange
	"OPTRE_M2_Smoke_Purple",//M3 Smoke Grenade - Purple
	"OPTRE_M2_Smoke_Yellow",//M3 Smoke Grenade - Yellow
	"1Rnd_HE_Grenade_shell",//MA5B Assault Rifle Magazine
	"UGL_FlareWhite_F",//MA5B Assault Rifle Grenade
	"UGL_FlareGreen_F",//MA5B Assault Rifle Grenade
	"UGL_FlareRed_F",//MA5B Assault Rifle Grenade
	"UGL_FlareYellow_F",//MA5B Assault Rifle Grenade
	"UGL_FlareCIR_F",//MA5B Assault Rifle Grenade
	"1Rnd_Smoke_Grenade_shell",//MA5B Assault Rifle Grenade
	"1Rnd_SmokeRed_Grenade_shell",//MA5B Assault Rifle Grenade
	"1Rnd_SmokeGreen_Grenade_shell",//MA5B Assault Rifle Grenade
	"1Rnd_SmokeYellow_Grenade_shell",//MA5B Assault Rifle Grenade
	"1Rnd_SmokePurple_Grenade_shell",//MA5B Assault Rifle Grenade
	"1Rnd_SmokeBlue_Grenade_shell",//MA5B Assault Rifle Grenade
	"1Rnd_SmokeOrange_Grenade_shell"//MA5B Assault Rifle Grenade
],
	true
] call BIS_fnc_addVirtualMagazineCargo;

[
	_box,
	[
	"OPTRE_M6C",//M6C Handgun
	"OPTRE_M6G",//M6G Magnum
	"OPTRE_M7_Folded",//M7 SMG Folded
	"OPTRE_M7",//M7 SMG
	"OPTRE_BR55HB",//Battle Rifle
	"OPTRE_M392_DMR",//M392 DMR
	"OPTRE_M45",//M45 Shotgun 
	"OPTRE_M45A",//M45 Semi-Auto
	"OPTRE_M45E",//M45 Combat
	"OPTRE_M73_base",//M73 LMG
	"OPTRE_MA5BGL",//MA5B AR GL
	"OPTRE_SRS99D",//SRS99D Sniper Rifle
	"OPTRE_M41_SSR",//M41 Rocket Launcher
	"OPTRE_M41_SSR_G"//M41 Rocket Launcher Guided
],
	true
] call BIS_fnc_addVirtualWeaponCargo;
	
	
[
	_box,
	[
	//UNSC_UNIFORMS //ARI = Arid; DES = Desert; TRO = Tropical; WDL = Woodland; L= Light; M = Medium;
	//Recon Helmet
	"OPTRE_UNSC_Recon_Helmet",
	//Army Uniforms
	"OPTRE_UNSC_Army_Uniform_L_ARI",
	"OPTRE_UNSC_Army_Uniform_L_DES",
	"OPTRE_UNSC_Army_Uniform_L_TRO",
	"OPTRE_UNSC_Army_Uniform_L_WDL",
	"OPTRE_UNSC_Army_Uniform_M_ARI",
	"OPTRE_UNSC_Army_Uniform_M_DES",
	"OPTRE_UNSC_Army_Uniform_M_TRO",
	"OPTRE_UNSC_Army_Uniform_M_WDL",
	"OPTRE_UNSC_Army_Uniform_ARI",
	"OPTRE_UNSC_Army_Uniform_DES",
	"OPTRE_UNSC_Army_Uniform_TRO",
	"OPTRE_UNSC_Army_Uniform_WDL",
	//Army Vests
	"OPTRE_UNSC_M52_Vest_DES",
	"OPTRE_UNSC_M52_Vest_WDL",
	"OPTRE_UNSC_M52_Vest_Sniper_DES",
	"OPTRE_UNSC_M52_Vest_Sniper_WDL",
	"OPTRE_UNSC_M52_Vest_Vacuum_DES",
	"OPTRE_UNSC_M52_Vest_Vacuum_WDL",
	//Army Headgear
	"OPTRE_BoonieHat_Army_ARI",
	"OPTRE_BoonieHat_Army_DES",
	"OPTRE_BoonieHat_Army_TRO",
	"OPTRE_BoonieHat_Army_WDL",
	"OPTRE_UNSC_CH252_Helmet_DES",
	"OPTRE_UNSC_CH252_Helmet_WDL",
	"OPTRE_UNSC_CH252_Helmet_Sniper_DES",
	"OPTRE_UNSC_CH252_Helmet_Sniper_WDL",
	"OPTRE_UNSC_CH252_Helmet_Vacuum_DES",
	"OPTRE_UNSC_CH252_Helmet_Vacuum_WDL",
	"OPTRE_PatrolCap_Army_ARI",
	"OPTRE_PatrolCap_Army_DES",
	"OPTRE_PatrolCap_Army_TRO",
	"OPTRE_PatrolCap_Army_WDL",
	//Marine Uniforms
	"OPTRE_UNSC_Marine_Uniform",
	"OPTRE_UNSC_Marine_Uniform_L",
	"OPTRE_UNSC_Marine_Uniform_M",
	//Marine Vests
	"OPTRE_UNSC_Marine_Vest",
	"OPTRE_UNSC_Marine_Vest_Sniper",
	"OPTRE_UNSC_Marine_Vest_Vacuum",
	//Marine Headgear
	"OPTRE_BoonieHat_Marine",
	"OPTRE_UNSC_Marine_Helmet",
	"OPTRE_UNSC_Marine_Helmet_Sniper",
	"OPTRE_UNSC_Marine_Helmet_Vacuum",
	"OPTRE_PatrolCap_Marine",
	//ODST Uniforms
	"OPTRE_UNSC_ODST_Uniform",
	"OPTRE_UNSC_ODST_Uniform_Scorch",
	"OPTRE_UNSC_ODST_Uniform_Stirls",
	"OPTRE_UNSC_ODST_Uniform_TheDog",
	"OPTRE_UNSC_ODST_Uniform_Urban",
	"OPTRE_UNSC_ODST_Uniform_Zero",
	"OPTRE_UNSC_ODST_Uniform_L",
	"OPTRE_UNSC_ODST_Uniform_M",
	"OPTRE_UNSC_ODST_Uniform_Sniper",
	//ODST Vests
	"OPTRE_UNSC_ODST_Vest",
	"OPTRE_UNSC_ODST_Vest_Blue",
	"OPTRE_UNSC_ODST_Vest_Green",
	"OPTRE_UNSC_ODST_Vest_Orange",
	"OPTRE_UNSC_ODST_Vest_Purple",
	"OPTRE_UNSC_ODST_Vest_Red",
	"OPTRE_UNSC_ODST_Vest_Yellow",
	"OPTRE_UNSC_ODST_Vest_Scorch",
	"OPTRE_UNSC_ODST_Vest_Stirls",
	"OPTRE_UNSC_ODST_Vest_TheDog",
	"OPTRE_UNSC_ODST_Vest_Urban",
	"OPTRE_UNSC_ODST_Vest_Zero",
	//ODST Headgear
	"OPTRE_BoonieHat_ODST",
	"OPTRE_Cap_ODST",
	"OPTRE_UNSC_ODST_Helmet",
	"OPTRE_UNSC_ODST_Helmet_CBRN",
	"OPTRE_UNSC_ODST_Helmet_Comms",
	"OPTRE_UNSC_ODST_Helmet_Recon",
	"OPTRE_UNSC_ODST_Helmet_Sniper",
	"OPTRE_UNSC_ODST_Helmet_Blue",
	"OPTRE_UNSC_ODST_Helmet_Green",
	"OPTRE_UNSC_ODST_Helmet_Orange",
	"OPTRE_UNSC_ODST_Helmet_Purple",
	"OPTRE_UNSC_ODST_Helmet_Red",
	"OPTRE_UNSC_ODST_Helmet_Yellow",
	"OPTRE_UNSC_ODST_Helmet_Scorch",
	"OPTRE_UNSC_ODST_Helmet_Stirls",
	"OPTRE_UNSC_ODST_Helmet_TheDog",
	"OPTRE_UNSC_ODST_Helmet_Urban",
	"OPTRE_UNSC_ODST_Helmet_Zero",
	//Medical Uniforms
	"OPTRE_UNSC_Army_Uniform_Medic",
	"OPTRE_UNSC_ODST_Uniform_Medic",
	"OPTRE_UNSC_ODST_Uniform_Medic",
	//Medical Vests
	"OPTRE_UNSC_M52_Vest_MED",
	"OPTRE_UNSC_M52_Vest_Vacuum_MED",
	"OPTRE_UNSC_ODST_Vest_Medic",
	//Medical Headgear
	"OPTRE_UNSC_CH252_Helmet_MED",
	"OPTRE_UNSC_CH252_Helmet_Vacuum_MED",
	"OPTRE_UNSC_ODST_Helmet_Medic",
	//AirForce Gear
	"OPTRE_UNSC_Airforce_Uniform",
	"OPTRE_UNSC_Airforce_Vest",
	"OPTRE_BoonieHat_Airforce",
	"OPTRE_PatrolCap_Airforce",
	"H_PilotHelmetHeli_B",
	//UNSC Attachment IDs
	"OPTRE_M6C_RDS",//M6C Handgun Attachment
	"OPTRE_M6C_Laser",//M6C Handgun Attachment
	"OPTRE_M6C_compensator",//M6C Handgun Attachment
	"OPTRE_M6G_Scope",//M6G Magnum Attachment
	"OPTRE_M6G_Flashlight",//M6G Magnum Attachment
	"OPTRE_M6_silencer",//M6 Pistols Attachment
	"OPTRE_M7_Sight",//M7 SMG Attachment
	"OPTRE_M7_Flashlight",//M7 SMG Attachment
	"OPTRE_M7_silencer",//M7 SMG Attachment
	"OPTRE_M7_Laser",//M7 SMG Attachment
	"OPTRE_BR55HB_Scope",//Battle Rifle Attachment
	"OPTRE_M392_Scope",//M392 DMR Attachment
	"OPTRE_M45_Flashlight",//M45 Attachment
	"OPTRE_M45_Flashlight_red",//M45 Attachment
	"OPTRE_M73_SmartLink",//M73 LMG Attachment
	"OPTRE_MA5B_AmmoCounter",//MA5B Assault Rifle Attachment
	"OPTRE_MA5B_AmmoCounter_NoIS",//MA5B Assault Rifle Attachment
	"OPTRE_SRS99_Laser",//SRS99D Sniper Rifle Attachment
	"OPTRE_SRS99_Scope",//SRS99D Sniper Rifle Attachment
	"OPTRE_SRS99_Bipod",//SRS99D Sniper Rifle Attachment
	"bipod_01_F_blk",//M392 DMR, M73 LMG Attachment
	"muzzle_snds_B",//Battle Rifle, DMR, M73 LMG, Assault Rifle Attachment
	"acc_pointer_IR",//Battle Rifle, DMR, Shotgun, Assault Rifle Attachment
	"acc_flashlight",//Battle Rifle, DMR, Shotgun, Assault Rifle Attachment
	//UNSC ITEM IDs
	"OPTRE_NVG",
	"OPTRE_Biofoam",
	"OPTRE_MedKit",
	"ItemMap",
	"ItemCompass",
	"ItemWatch",
	"ItemRadio",
	"ItemGPS",
	"Rangefinder",
	"Laserdesignator",
	"ToolKit",
	"MineDetector",
	"B_UavTerminal"
],
	true
] call BIS_fnc_addVirtualItemCargo;