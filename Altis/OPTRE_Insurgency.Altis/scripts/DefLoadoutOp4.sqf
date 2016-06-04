// DefLoadoutOp4.sqf by Jigsor
private "_player";
_player = _this select 0;
waitUntil {alive _player};

// CSAT (A3)
if (INS_op_faction isEqualTo 1) exitWith
{
	removeAllAssignedItems _player;
	{_player linkItem _x} forEach ["ItemMap","ItemCompass","ItemRadio","ItemGPS","ItemWatch","NVGoggles_OPFOR"];
};

removeAllWeapons _player;
removeAllAssignedItems _player;
removeAllContainers _player;
removeHeadgear _player;
removeGoggles _player;

switch (INS_op_faction) do
{
	case 2 : // AAF (A3)
	{
		_player forceAddUniform "U_I_CombatUniform";
		_player addVest "V_PlateCarrierIA2_dgtl";
		_player addBackpack "B_AssaultPack_dgtl";
		_player addHeadgear "H_HelmetIA";//"H_HelmetIA_camo" "H_HelmetIA_net"

		_player setFace "GreekHead_A3_01";
		_player setSpeaker "Male02GRE";

		_player addItemToUniform "FirstAidKit";
		_player addItemToUniform "30Rnd_556x45_Stanag";

		{_player addItemToBackpack "FirstAidKit"} foreach [1,2];
		{_player addItemToBackpack "HandGrenade"} foreach [1,2,3,4];
		{_player addItemToBackpack "APERSTripMine_Wire_Mag"} foreach [1,2];
		{_player addItemToBackpack "APERSBoundingMine_Range_Mag"} foreach [1,2];
		_player addItemToBackpack "SLAMDirectionalMine_Wire_Mag";
		_player addItemToBackpack "DemoCharge_Remote_Mag";

		_player addMagazines ["HandGrenade", 4];

		_player addMagazine "SmokeShell";
		_player addMagazine "SmokeShell";
		_player addMagazine "SmokeShellGreen";
		_player addMagazine "SmokeShellGreen";
		_player addMagazine "Chemlight_green";
		_player addMagazine "Chemlight_green";

		_player addWeapon "Binocular";

		[_player,"arifle_Mk20_ACO_F",10] call BIS_fnc_AddWeapon;//"arifle_Mk20_ACO_F" compatible mags = "30Rnd_556x45_Stanag"
		[_player,"hgun_ACPC2_F",5] call BIS_fnc_AddWeapon;//"hgun_ACPC2_F" compatible mags = "9Rnd_45ACP_Mag"

		_player removePrimaryWeaponItem "optic_ACO_grn";
		_player addprimaryweaponitem "optic_Hamr";
		_player addprimaryweaponitem "acc_flashlight";//"optic_Hamr","optic_Arco","optic_MRCO","acc_flashlight"

		{_player linkItem _x} forEach ["ItemMap","ItemCompass","ItemRadio","ItemGPS","ItemWatch","NVGoggles_INDEP"];
	};
	case 3 : // African Conflict (@african_conflict@nato_russian_sf_weapons)
	{
		_player forceAddUniform "U_mas_afr_O_uniform1";
		_player addVest "V_mas_afr_PlateCarrierIA1_B";//"V_mas_afr_PlateCarrier1_rgr"
		_player addBackpack "B_mas_AssaultPack_mul";
		_player addHeadgear "H_mas_afr_HelmetO";

		_player setFace "AfricanHead_01";//"AfricanHead_01","AfricanHead_02","AfricanHead_03"

		{_player addItemToUniform "FirstAidKit"} foreach [1,2];
		_player addItemToUniform "SmokeShell";
		_player addItemToUniform "SmokeShellGreen";
		_player addItemToUniform "Chemlight_green";

		_player addItemToVest "30Rnd_mas_762x39_T_mag";

		{_player addItemToBackpack "HandGrenade"} foreach [1,2,3,4];
		{_player addItemToBackpack "APERSTripMine_Wire_Mag"} foreach [1,2];
		{_player addItemToBackpack "APERSBoundingMine_Range_Mag"} foreach [1,2];
		_player addItemToBackpack "SLAMDirectionalMine_Wire_Mag";
		_player addItemToBackpack "DemoCharge_Remote_Mag";
		_player addItemToBackpack "FirstAidKit";

		_player addMagazine "SmokeShell";
		_player addMagazine "SmokeShellGreen";
		_player addMagazine "Chemlight_green";

		_player addWeapon "Binocular";

		[_player,"arifle_mas_ak_74m_sf_gl_h","30Rnd_mas_545x39_mag"] call BIS_fnc_AddWeapon;
		[_player,"LMG_mas_m72_F",3,"100Rnd_mas_762x39_T_mag"] call BIS_fnc_AddWeapon;//"LMG_mas_m72_F" compatible mags = "30Rnd_mas_762x39_mag", "30Rnd_mas_762x39_T_mag", "100Rnd_mas_762x39_mag", "100Rnd_mas_762x39_T_mag"

		{_player linkItem _x} forEach ["ItemMap","ItemCompass","ItemRadio","ItemGPS","ItemWatch","NVGoggles_OPFOR"];
	};
	case 4 : // CAF Aggressors (@CAF_AG1.5)
	{
		_rand_unif = nil;
		_rand_hg = nil;

		while {isNil "_rand_unif"} do {
			_rand_unif = INS_civClothes select (floor random (count INS_civClothes));
			sleep 0.1;
		};
		_player forceAddUniform _rand_unif;

		_player addVest "V_BandollierB_cbr";
		/*
		while {isNil "_rand_hg"} do {
			_rand_hg = INS_civHeadgear select (floor random (count INS_civHeadgear));
			sleep 0.1;
		};
		_player addHeadgear _rand_hg;
		*/
		_player addHeadgear "H_CAF_AG_TURBAN";//"H_CAF_AG_TURBAN","H_caf_ag_wrap"

		_player setFace "Default";
		_player setSpeaker "Male01PER";

		_player addItemToUniform "FirstAidKit";

		_player addItemToVest "HandGrenade";
		{_player addItemToVest "FirstAidKit"} foreach [1,2];

		_player addMagazine "SmokeShell";

		_player addWeapon "Binocular";

		[_player,"caf_AK47",7] call BIS_fnc_AddWeapon;
		[_player,"hgun_ACPC2_F",1] call BIS_fnc_AddWeapon;//"hgun_ACPC2_F" compatible mags = "9Rnd_45ACP_Mag"
		
		_player addItemToUniform "CAF_30Rnd_762x39_AK";

		{_player linkItem _x} forEach ["ItemMap","ItemCompass","ItemRadio","ItemGPS","ItemWatch","NVGoggles_OPFOR"];
	};
	case 5 : // Leight's Opfor Pack (@rhs_afrf3;@rhs_usf3;@leights_opfor)
	{
		_player forceAddUniform "LOP_U_ISTS_Fatigue_01";
		for "_i" from 1 to 3 do {_player addItemToUniform "FirstAidKit";};
		for "_i" from 1 to 5 do {_player addItemToUniform "rhs_VOG25P";};
		for "_i" from 1 to 2 do {_player addItemToUniform "rhs_mag_9x19_17";};

		_player addVest "LOP_6sh46";
		for "_i" from 1 to 3 do {_player addItemToVest "rhs_mag_rgd5";};
		for "_i" from 1 to 6 do {_player addItemToVest "rhs_30Rnd_545x39_AK";};
		for "_i" from 1 to 2 do {_player addItemToVest "rhs_mag_an_m14_th3";};
		_player addItemToVest "rhs_mag_plamyam";
		for "_i" from 1 to 2 do {_player addItemToVest "Chemlight_blue";};
		for "_i" from 1 to 2 do {_player addItemToVest "rhs_mag_m18_yellow";};
		for "_i" from 1 to 2 do {_player addItemToVest "rhs_mag_m18_green";};

		_player addBackpack "B_FieldPack_khk";
		for "_i" from 1 to 3 do {_player addItemToBackpack "FirstAidKit";};
		for "_i" from 1 to 2 do {_player addItemToBackpack "rhs_30Rnd_545x39_AK";};
		for "_i" from 1 to 2 do {_player addItemToBackpack "APERSBoundingMine_Range_Mag";};
		for "_i" from 1 to 2 do {_player addItemToBackpack "APERSTripMine_Wire_Mag";};
		_player addItemToBackpack "SLAMDirectionalMine_Wire_Mag";
		_player addItemToBackpack "IEDUrbanSmall_Remote_Mag";
		_player addItemToBackpack "rhs_mag_plamyam";
		_player addItemToBackpack "rhs_mag_9x19_17";

		_player addHeadgear "LOP_H_Shemag_BLK";

		[_player,"rhs_weap_ak74m_gp25",1] call BIS_fnc_AddWeapon;
		_player addPrimaryWeaponItem "rhs_acc_1p29";
		[_player,"rhs_weap_pya",1] call BIS_fnc_AddWeapon;

		_player linkItem "ItemMap";
		_player linkItem "ItemCompass";
		_player linkItem "ItemWatch";
		_player linkItem "ItemRadio";
		_player linkItem "ItemGPS";
		_player linkItem "NVGoggles_OPFOR";

		_player setFace "PersianHead_A3_02";
		_player setSpeaker "Male03PER";
	};
	case 6 : // Syrian Army (@mec;@cup)
	{
		_player forceAddUniform "MEC_SAA_BDU_rolled";
		_player addVest "V_TacVest_oli";
		_player addBackpack "B_Bergen_rgr";
		_player addHeadgear "MEC_SAA_BDU_Helmet";

		_player setFace "PersianHead_A3_02";
		_player setSpeaker "Male01PER";

		_player addItemToUniform "FirstAidKit";
		_player addItemToUniform "CUP_30Rnd_Sa58_M";
		//_player addItemToUniform "1Rnd_HE_Grenade_shell";

		{_player addItemToBackpack "FirstAidKit"} foreach [1,2];
		{_player addItemToBackpack "HandGrenade"} foreach [1,2,3];
		{_player addItemToBackpack "APERSTripMine_Wire_Mag"} foreach [1,2];
		{_player addItemToBackpack "APERSBoundingMine_Range_Mag"} foreach [1,2];
		//{_player addItemToBackpack "1Rnd_HE_Grenade_shell"} foreach [1,3];
		_player addItemToBackpack "DemoCharge_Remote_Mag";

		//_player addMagazines ["HandGrenade", 1];

		_player addMagazine "SmokeShell";
		_player addMagazine "SmokeShell";
		_player addMagazine "SmokeShellGreen";
		_player addMagazine "SmokeShellGreen";
		_player addMagazine "Chemlight_green";
		_player addMagazine "Chemlight_green";

		_player addWeapon "Binocular";

		[_player,"CUP_arifle_Sa58RIS1",10] call BIS_fnc_AddWeapon;//"CUP_arifle_Sa58RIS1" compatible mags = "CUP_30Rnd_Sa58_M","CUP_30Rnd_Sa58_M_TracerG","CUP_30Rnd_Sa58_M_TracerR","CUP_30Rnd_Sa58_M_TracerY"
		[_player,"hgun_mas_uzi_F",5] call BIS_fnc_AddWeapon;//"hgun_mas_uzi_F" compatible mags = "25Rnd_mas_9x19_Mag"

		_player addprimaryweaponitem "muzzle_snds_B";
		_player addprimaryweaponitem "optic_Hamr";
		_player addHandgunItem "muzzle_snds_L";
		_player addHandgunItem "optic_mas_MRD";

		{_player linkItem _x} forEach ["ItemMap","ItemCompass","ItemRadio","ItemGPS","ItemWatch","NVGoggles_OPFOR"];
	};
	case 7 : // Taliban (@mec;@cup)
	{
		_rand_unif = nil;
		_rand_hg = nil;
		_tal_hg = ["MEC_pakol_grey","MEC_pakol_black","MEC_pakol_brown"];
		_tal_unif = ["MEC_dishda_vestA","MEC_dishda_vestB","MEC_dishda_vest"];

		while {isNil "_rand_hg"} do {
			_rand_hg = _tal_hg select (floor random (count _tal_hg));
			sleep 0.1;
		};

		while {isNil "_rand_unif"} do {
			_rand_unif = _tal_unif select (floor random (count _tal_unif));
			sleep 0.1;
		};

		_player forceAddUniform _rand_unif;
		_player addVest "V_BandollierB_cbr";
		_player addHeadgear _rand_hg;
		_player forceAddUniform _rand_unif;
		_player addVest "V_BandollierB_oli";
		_player addBackpack "B_Bergen_blk";
		_player addHeadgear _rand_hg;

		_player setFace "PersianHead_A3_02";
		_player setSpeaker "Male01PER";

		_player addItemToUniform "FirstAidKit";
		_player addItemToUniform "CUP_30Rnd_Sa58_M";

		{_player addItemToBackpack "FirstAidKit"} foreach [1,2];
		{_player addItemToBackpack "HandGrenade"} foreach [1,2,3];
		{_player addItemToBackpack "APERSTripMine_Wire_Mag"} foreach [1,2];
		{_player addItemToBackpack "APERSBoundingMine_Range_Mag"} foreach [1,2];
		_player addItemToBackpack "DemoCharge_Remote_Mag";

		_player addMagazine "SmokeShell";
		_player addMagazine "SmokeShell";
		_player addMagazine "SmokeShellGreen";
		_player addMagazine "SmokeShellGreen";
		_player addMagazine "Chemlight_green";
		_player addMagazine "Chemlight_green";

		_player addWeapon "Binocular";

		[_player,"CUP_arifle_Sa58RIS1",10] call BIS_fnc_AddWeapon;//"CUP_arifle_Sa58RIS1" compatible mags = "CUP_30Rnd_Sa58_M","CUP_30Rnd_Sa58_M_TracerG","CUP_30Rnd_Sa58_M_TracerR","CUP_30Rnd_Sa58_M_TracerY"
		[_player,"hgun_mas_uzi_F",5] call BIS_fnc_AddWeapon;//"hgun_mas_uzi_F" compatible mags = "25Rnd_mas_9x19_Mag"

		_player addprimaryweaponitem "muzzle_snds_B";
		_player addprimaryweaponitem "optic_Hamr";
		_player addHandgunItem "muzzle_snds_L";
		_player addHandgunItem "optic_mas_MRD";

		{_player linkItem _x} forEach ["ItemMap","ItemCompass","ItemRadio","ItemGPS","ItemWatch","NVGoggles_OPFOR"];
	};
	case 8 : // Hezbollah (@mec;@cup)
	{
		_player forceAddUniform "MEC_SAA_BDU_rolled";
		_player addVest "V_TacVest_oli";//"V_HarnessO_brn"
		_player addBackpack "B_Bergen_rgr";//"B_Kitbag_rgr"
		_player addHeadgear "MEC_SAA_BDU_Helmet";

		_player setFace "PersianHead_A3_02";
		_player setSpeaker "Male02PER";

		_player addItemToUniform "FirstAidKit";
		_player addItemToUniform "CUP_30Rnd_Sa58_M";

		{_player addItemToBackpack "FirstAidKit"} foreach [1,2];
		{_player addItemToBackpack "HandGrenade"} foreach [1,2,3];
		{_player addItemToBackpack "APERSTripMine_Wire_Mag"} foreach [1,2];
		{_player addItemToBackpack "APERSBoundingMine_Range_Mag"} foreach [1,2];
		_player addItemToBackpack "DemoCharge_Remote_Mag";

		_player addMagazine "SmokeShell";
		_player addMagazine "SmokeShell";
		_player addMagazine "SmokeShellGreen";
		_player addMagazine "SmokeShellGreen";
		_player addMagazine "Chemlight_green";
		_player addMagazine "Chemlight_green";

		_player addWeapon "Binocular";

		[_player,"CUP_arifle_Sa58RIS1",10] call BIS_fnc_AddWeapon;//"CUP_arifle_Sa58RIS1" compatible mags = "CUP_30Rnd_Sa58_M","CUP_30Rnd_Sa58_M_TracerG","CUP_30Rnd_Sa58_M_TracerR","CUP_30Rnd_Sa58_M_TracerY"
		[_player,"hgun_mas_uzi_F",5] call BIS_fnc_AddWeapon;//"hgun_mas_uzi_F" compatible mags = "25Rnd_mas_9x19_Mag"

		_player addprimaryweaponitem "muzzle_snds_B";
		_player addprimaryweaponitem "optic_Hamr";
		_player addHandgunItem "muzzle_snds_L";
		_player addHandgunItem "optic_mas_MRD";

		{_player linkItem _x} forEach ["ItemMap","ItemCompass","ItemRadio","ItemGPS","ItemWatch","G_Balaclava_blk","NVGoggles_OPFOR"];//"G_Balaclava_blk"
	};
	case 9 : // Sud Russians (@evw)
	{
		_player forceAddUniform "U_SUD_USSR_Uniform01";
		_player addVest "V_sud_ussr_vest04";
		_player addBackpack "B_SUD_ALICE";//"B_Bergen_rgr"
		_player addHeadgear "H_sud_ussr_helmet01";//"H_Bandanna_khk"

		_player setFace "WhiteHead_10";
		_player setSpeaker "Male01RUS";

		{_player addItemToUniform "SUD_30Rnd_545x39_AK"} foreach [1,2];
		_player addItemToUniform "FirstAidKit";

		{_player addItemToBackpack "FirstAidKit"} foreach [1,2];
		{_player addItemToBackpack "HandGrenade"} foreach [1,2];
		{_player addItemToBackpack "SUD_1Rnd_HE_GP25"} foreach [1,2,3,4];
		{_player addItemToBackpack "APERSTripMine_Wire_Mag"} foreach [1,2];
		{_player addItemToBackpack "APERSBoundingMine_Range_Mag"} foreach [1,2];
		_player addItemToBackpack "DemoCharge_Remote_Mag";

		_player addMagazine "SmokeShell";
		_player addMagazine "SmokeShell";
		_player addMagazine "SmokeShellGreen";
		_player addMagazine "SmokeShellGreen";
		_player addMagazine "Chemlight_green";
		_player addMagazine "Chemlight_green";

		_player addWeapon "Binocular";

		[_player,"arifle_SUD_AK74_GL",7] call BIS_fnc_AddWeapon;//"arifle_SUD_AKS74UB" compatible mags = "SUD_30Rnd_545x39_AK"
		[_player,"hgun_Rook40_F",3] call BIS_fnc_AddWeapon;//"hgun_Rook40_F" compatible mags = "30Rnd_9x21_Mag"

		{_player linkItem _x} forEach ["ItemMap","ItemCompass","ItemRadio","ItemGPS","ItemWatch","NVGoggles_OPFOR"];//"SUD_NVG"
	};
	case 10 : // RHS - Armed Forces of the Russian Federation (@rhs_afrf3)
	{
		_player forceAddUniform "rhs_uniform_flora";
		_player addVest "rhs_6b23_rifleman";
		_player addBackpack "rhs_assault_umbts";
		_player addHeadgear "rhs_6b27m";

		_player setFace "GreekHead_A3_01";
		_player setSpeaker "rhs_Male01RUS";

		_player addItemToUniform "FirstAidKit";
		_player addItemToUniform "rhs_30Rnd_545x39_7N10_AK";

		{_player addItemToVest "rhs_VOG25"} foreach [1,2];//gp25 ammo
		{_player addItemToVest "rhs_VOG25P"} foreach [1,2];//gp25 ammo

		{_player addItemToBackpack "FirstAidKit"} foreach [1,2];
		{_player addItemToBackpack "rhs_mag_plamyam"} foreach [1,2];//flashbang
		_player addItemToBackpack "APERSTripMine_Wire_Mag";
		_player addItemToBackpack "APERSBoundingMine_Range_Mag";
		_player addItemToBackpack "DemoCharge_Remote_Mag";
		
		_player addMagazine "rhs_mag_rgd5";//hand grenade
		_player addMagazine "SmokeShell";
		_player addMagazine "SmokeShellGreen";
		_player addMagazine "SmokeShellGreen";
		_player addMagazine "Chemlight_green";
		_player addMagazine "Chemlight_green";
		_player addMagazine "9Rnd_45ACP_Mag";

		_player addWeapon "Binocular";

		[_player,"rhs_weap_ak74m_gp25",9] call BIS_fnc_AddWeapon;
		[_player,"hgun_ACPC2_F",2] call BIS_fnc_AddWeapon;//"hgun_ACPC2_F" compatible mags = "9Rnd_45ACP_Mag"

		_player addprimaryweaponitem "rhs_acc_1p29";

		{_player linkItem _x} forEach ["ItemMap","ItemCompass","ItemRadio","ItemGPS","ItemWatch","NVGoggles_OPFOR"];
	};
	case 11 : // Iraqi-Syrian Conflict - Islamic State (@iraqi_syrian_conflict;@cup;@asdg_jr;@mas_nato_rus_sf_veh)
	{
		_player forceAddUniform "IS_uniform_rifleman_o";
		_player addItemToUniform "FirstAidKit";
		_player addItemToUniform "CUP_30Rnd_Sa58_M_TracerG";
		for "_i" from 1 to 3 do {_player addItemToUniform "CUP_1Rnd_SmokeRed_M203";};
		_player addItemToUniform "CUP_HandGrenade_M67";

		_player addVest "SP_OpforRig1_Tan";
		for "_i" from 1 to 4 do {_player addItemToVest "CUP_30Rnd_Sa58_M_TracerG";};
		for "_i" from 1 to 3 do {_player addItemToVest "CUP_30Rnd_9x19_UZI";};
		_player addItemToVest "CUP_30Rnd_Sa58_M_TracerR";

		_player addBackpack "CUP_B_USPack_Coyote";
		for "_i" from 1 to 3 do {_player addItemToBackpack "FirstAidKit";};
		for "_i" from 1 to 3 do {_player addItemToBackpack "CUP_1Rnd_HE_M203";};
		for "_i" from 1 to 2 do {_player addItemToBackpack "CUP_1Rnd_HEDP_M203";};
		for "_i" from 1 to 2 do {_player addItemToBackpack "Chemlight_blue";};
		for "_i" from 1 to 2 do {_player addItemToBackpack "CUP_HandGrenade_M67";};
		_player addItemToBackpack "CUP_IED_V2_M";
		for "_i" from 1 to 2 do {_player addItemToBackpack "APERSBoundingMine_Range_Mag";};
		_player addItemToBackpack "APERSTripMine_Wire_Mag";
		for "_i" from 1 to 3 do {_player addItemToBackpack "CUP_30Rnd_Sa58_M_TracerG";};

		_player addHeadgear "H_ShemagOpen_tan";

		[_player,"CUP_arifle_Sa58RIS2_gl",1] call BIS_fnc_AddWeapon;
		_player addPrimaryWeaponItem "CUP_acc_ANPEQ_2";
		_player addPrimaryWeaponItem "CUP_optic_ACOG";
		[_player,"CUP_hgun_MicroUzi",1] call BIS_fnc_AddWeapon;

		_player linkItem "ItemMap";
		_player linkItem "ItemCompass";
		_player linkItem "ItemWatch";
		_player linkItem "ItemRadio";
		_player linkItem "ItemGPS";
		_player linkItem "NVGoggles_OPFOR";

		_player setFace "PersianHead_A3_02";
		_player setSpeaker "Male03PER";
	};
};
/*
British Voices ["Male01ENGB","Male02ENGB","Male03ENGB","Male04ENGB"];
primaryWeaponItems player, magazinecargo player
*/