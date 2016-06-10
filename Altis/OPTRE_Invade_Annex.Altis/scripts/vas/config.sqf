//Allow player to respawn with his loadout? If true unit will respawn with all ammo from initial save! Set to false to disable this and rely on other scripts!
vas_onRespawn = false;
//Preload Weapon Config?
vas_preload = true;
//If limiting weapons its probably best to set this to true so people aren't loading custom loadouts with restricted gear.
vas_disableLoadSave = false;
//Amount of save/load slots
vas_customslots = 19; //9 is actually 10 slots, starts from 0 to whatever you set, so always remember when setting a number to minus by 1, i.e 12 will be 11.
//Disable 'VAS hasn't finished loading' Check !!! ONLY RECOMMENDED FOR THOSE THAT USE ACRE AND OTHER LARGE ADDONS !!!
vas_disableSafetyCheck = false;
/*
	NOTES ON EDITING!
	YOU MUST PUT VALID CLASS NAMES IN THE VARIABLES IN AN ARRAY FORMAT, NOT DOING SO WILL RESULT IN BREAKING THE SYSTEM!
	PLACE THE CLASS NAMES OF GUNS/ITEMS/MAGAZINES/BACKPACKS/GOGGLES IN THE CORRECT ARRAYS! TO DISABLE A SELECTION I.E
	GOGGLES vas_goggles = [""]; AND THAT WILL DISABLE THE ITEM SELECTION FOR WHATEVER VARIABLE YOU ARE WANTING TO DISABLE!

														EXAMPLE
	vas_weapons = ["srifle_EBR_ARCO_point_grip_F","arifle_Khaybar_Holo_mzls_F","arifle_TRG21_GL_F","Binocular"];
	vas_magazines = ["30Rnd_65x39_case_mag","20Rnd_762x45_Mag","30Rnd_65x39_caseless_green"];
	vas_items = ["ItemMap","ItemGPS","NVGoggles"];
	vas_backpacks = ["B_Bergen_sgg_Exp","B_AssaultPack_rgr_Medic"];
	vas_goggles = [""];

												Example for side specific (TvT)
	switch(playerSide) do
	{
		//Blufor
		case west:
		{
			vas_weapons = ["srifle_EBR_F","arifle_MX_GL_F"];
			vas_items = ["muzzle_snds_H","muzzle_snds_B","muzzle_snds_L","muzzle_snds_H_MG"]; //Removes suppressors from VAS
			vas_goggles = ["G_Diving"]; //Remove diving goggles from VAS
		};
		//Opfor
		case west:
		{
			vas_weapons = ["srifle_EBR_F","arifle_MX_GL_F"];
			vas_items = ["muzzle_snds_H","muzzle_snds_B","muzzle_snds_L","muzzle_snds_H_MG"]; //Removes suppressors from VAS
			vas_goggles = ["G_Diving"]; //Remove diving goggles from VAS
		};
	};
*/

//If the arrays below are empty (as they are now) all weapons, magazines, items, backpacks and goggles will be available
//Want to limit VAS to specific weapons? Place the classnames in the array!
vas_weapons = [
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
];
//Want to limit VAS to specific magazines? Place the classnames in the array!
vas_magazines = [
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
];
//Want to limit VAS to specific items? Place the classnames in the array!
vas_items = [
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
];
//Want to limit backpacks? Place the classnames in the array!
vas_backpacks = [
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
];
//Want to limit goggles? Place the classnames in the array!
vas_glasses = [];


/*
	NOTES ON EDITING:
	THIS IS THE SAME AS THE ABOVE VARIABLES, YOU NEED TO KNOW THE CLASS NAME OF THE ITEM YOU ARE RESTRICTING. THIS DOES NOT WORK IN
	CONJUNCTION WITH THE ABOVE METHOD, THIs IS ONLY FOR RESTRICTING / LIMITING ITEMS FROM VAS AND NOTHING MORE

														EXAMPLE
	vas_r_weapons = ["srifle_EBR_F","arifle_MX_GL_F"];
	vas_r_items = ["muzzle_snds_H","muzzle_snds_B","muzzle_snds_L","muzzle_snds_H_MG"]; //Removes suppressors from VAS
	vas_r_goggles = ["G_Diving"]; //Remove diving goggles from VAS

												Example for side specific (TvT)
	switch(playerSide) do
	{
		//Blufor
		case west:
		{
			vas_r_weapons = ["srifle_EBR_F","arifle_MX_GL_F"];
			vas_r_items = ["muzzle_snds_H","muzzle_snds_B","muzzle_snds_L","muzzle_snds_H_MG"]; //Removes suppressors from VAS
			vas_r_goggles = ["G_Diving"]; //Remove diving goggles from VAS
		};
		//Opfor
		case west:
		{
			vas_r_weapons = ["srifle_EBR_F","arifle_MX_GL_F"];
			vas_r_items = ["muzzle_snds_H","muzzle_snds_B","muzzle_snds_L","muzzle_snds_H_MG"]; //Removes suppressors from VAS
			vas_r_goggles = ["G_Diving"]; //Remove diving goggles from VAS
		};
	};
*/

//Below are variables you can use to restrict certain items from being used.
//Weapons to remove from VAS
vas_r_weapons = [];
//Backpacks to remove from VAS
vas_r_backpacks = [
	"O_Mortar_01_support_F",
	"I_Mortar_01_support_F",
	"O_Mortar_01_weapon_F",
	"I_Mortar_01_weapon_F",
	"O_UAV_01_backpack_F",
	"I_UAV_01_backpack_F",
	"O_HMG_01_support_F",
	"I_HMG_01_support_F",
	"O_HMG_01_support_high_F",
	"I_HMG_01_support_high_F",
 	"O_HMG_01_weapon_F",
 	"I_HMG_01_weapon_F",
 	//"B_HMG_01_A_weapon_F",
 	"O_HMG_01_A_weapon_F",
 	"I_HMG_01_A_weapon_F",
  	"O_GMG_01_weapon_F",
  	"I_GMG_01_weapon_F",
  	//"B_GMG_01_A_weapon_F",
  	"O_GMG_01_A_weapon_F",
  	"I_GMG_01_A_weapon_F",
   	"O_HMG_01_high_weapon_F",
  	"I_HMG_01_high_weapon_F",
   	//"B_HMG_01_A_high_weapon_F",
   	"O_HMG_01_A_high_weapon_F",
   	"I_HMG_01_A_high_weapon_F",
   	"O_GMG_01_high_weapon_F",
   	"I_GMG_01_high_weapon_F",
   	//"B_GMG_01_A_high_weapon_F",
   	"O_GMG_01_A_high_weapon_F",
   	"I_GMG_01_A_high_weapon_F",
	"I_AT_01_weapon_F",
	"O_AT_01_weapon_F",
	"I_AA_01_weapon_F",
	"O_AA_01_weapon_F"
];

//Magazines to remove from VAS
vas_r_magazines = [];

//Items to remove from VAS
vas_r_items = [
	"I_UavTerminal",
	"O_UavTerminal",
	"U_C_Commoner1_1",
	"U_C_Commoner1_2",
	"U_C_Commoner1_3",
	"U_C_Commoner1_4",
	"U_C_Commoner1_5",
	"U_C_Commoner1_6",
	"U_C_Commoner2_1",
	"U_C_Commoner2_2",
	"U_C_Commoner2_3",
	"U_C_Commoner2_4",
	"U_C_Commoner2_5",
	"U_C_Commoner2_6",
	"U_I_GhillieSuit",
	"U_O_GhillieSuit",
	"U_I_Wetsuit",
	"U_O_Wetsuit",
	"U_NikosBody",
	"U_OrestesBody",
	"U_AttisBody",
	"U_AntigonaBody",
	"U_IG_Menelaos",
	"U_C_Novak",
	"U_OI_Scientist",
	"U_C_Poor_1",
	"U_C_Poor_2",
	"U_C_Scavenger_1",
	"U_C_Scavenger_2",
	"U_C_Farmer",
	"U_C_Fisherman",
	"U_C_WorkerOveralls",
	"U_C_FishermanOveralls",
	"U_C_PriestBody",
	"U_C_Poor_shorts_1",
	"U_C_Poor_shorts_2",
	"U_C_Commoner_shorts",
	"U_C_HunterBody_brn",
	"U_O_CombatUniform_ocamo",
	"U_O_CombatUniform_oucamo",
	"U_O_SpecopsUniform_blk",
	"U_O_SpecopsUniform_ocamo",
	"U_O_OfficerUniform_ocamo",
	"U_O_GhillieSuit",
	"U_O_PilotCoveralls",
	"U_O_Wetsuit",
	"U_I_CombatUniform",
	"U_I_CombatUniform_shortsleeve",
	"U_I_CombatUniform_tshirt",
	"U_I_OfficerUniform",
	"U_I_GhillieSuit",
	"U_I_HeliPilotCoveralls",
	"U_I_pilotCoveralls",
	"U_I_Wetsuit",
	"U_C_TeeSurfer_shorts_1",
	"U_C_TeeSurfer_shorts_2",
	"U_B_CombatUniform_sgg",
	"U_B_CombatUniform_sgg_tshirt",
	"U_B_CombatUniform_sgg_vest",
	"U_B_CombatUniform_wdl",
	"U_B_CombatUniform_wdl_tshirt",
	"U_B_CombatUniform_wdl_vest",
	"U_BasicBody"
];

//Goggles to remove from VAS
vas_r_glasses = [];