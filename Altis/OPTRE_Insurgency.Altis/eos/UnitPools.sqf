private ["_tempArray","_InfPool","_MotPool","_ACHPool","_CHPool","_uavPool","_stPool","_shipPool","_diverPool","_crewPool","_heliCrew","_ArmPool"];
_faction=(_this select 0);
_type=(_this select 1);
_tempArray=[];

switch (_faction) do {
	case 0 : {// EAST CSAT FACTION
	_InfPool=	["O_SoldierU_SL_F","O_soldierU_repair_F","O_soldierU_medic_F","O_sniper_F","O_Soldier_A_F","O_Soldier_AA_F","O_Soldier_AAA_F","O_Soldier_AAR_F","O_Soldier_AAT_F","O_Soldier_AR_F","O_Soldier_AT_F","O_soldier_exp_F","O_Soldier_F","O_engineer_F","O_engineer_U_F","O_medic_F","O_recon_exp_F","O_recon_F","O_recon_JTAC_F","O_recon_LAT_F","O_recon_M_F","O_recon_medic_F","O_recon_TL_F","O_HeavyGunner_F"];	
	_ArmPool=	["O_APC_Tracked_02_AA_F","O_APC_Tracked_02_cannon_F","O_APC_Wheeled_02_rcws_F","O_MBT_02_arty_F","O_MBT_02_cannon_F"];
	_MotPool=	["O_Truck_02_covered_F","O_MRAP_02_gmg_F","O_MRAP_02_hmg_F","O_Truck_02_medical_F"];
	_ACHPool=	["O_Heli_Attack_02_black_F","O_Heli_Attack_02_F"];
	_CHPool=	["O_Heli_Light_02_F","O_Heli_Light_02_unarmed_F","O_Heli_Transport_04_covered_F"];//"O_Heli_Transport_04_bench_F"
	_uavPool=	["O_UAV_01_F","O_UAV_02_CAS_F","O_UGV_01_rcws_F"];
	_stPool=	["O_Mortar_01_F","O_Mortar_01_F","O_static_AT_F","O_static_AA_F","O_GMG_01_high_F","O_HMG_01_high_F"];
	_shipPool=	["O_Boat_Armed_01_hmg_F","O_Boat_Transport_01_F"];
	_diverPool=	["O_diver_exp_F","O_diver_F","O_diver_TL_F"];
	_crewPool=	["O_crew_F"];
	_heliCrew=	["O_helicrew_F","O_helipilot_F"];
};
	case 1 : {// WEST NATO FACTION
	_InfPool=	["B_sniper_F","B_Soldier_A_F","B_Soldier_AA_F","B_Soldier_AAA_F","B_Soldier_AAR_F","B_Soldier_AAT_F","B_Soldier_AR_F","B_Soldier_AT_F","B_soldier_exp_F","B_Soldier_F","B_engineer_F","B_medic_F","B_recon_exp_F","B_recon_F","B_recon_JTAC_F","B_recon_LAT_F","B_recon_M_F","B_recon_medic_F","B_recon_TL_F"];	
	_ArmPool=	["B_MBT_01_arty_F","B_MBT_01_cannon_F","B_MBT_01_mlrs_F","B_APC_Tracked_01_AA_F","B_APC_Tracked_01_CRV_F","B_APC_Tracked_01_rcws_F","B_APC_Wheeled_01_cannon_F","B_MBT_02_cannon_F"];
	_MotPool=	["B_Truck_01_covered_F","B_Truck_01_transport_F","B_MRAP_01_F","B_MRAP_01_gmg_F","B_MRAP_01_hmg_F","B_Truck_01_medical_F"];
	_ACHPool=	["B_Heli_Attack_01_F","B_Heli_Light_01_armed_F"];
	_CHPool=	["B_Heli_Light_01_F","B_Heli_Transport_01_camo_F","B_Heli_Transport_01_F"];
	_uavPool=	["B_UAV_01_F","B_UAV_01_CAS_F","B_UGV_01_rcws_F"];
	_stPool=	["B_Mortar_01_F","B_static_AT_F","B_static_AA_F"];
	_shipPool=	["B_Boat_Armed_01_minigun_F","B_Boat_Transport_01_F"];
	_diverPool=	["B_diver_exp_F","B_diver_F","B_diver_TL_F"];
	_crewPool=	["B_crew_F"];
	_heliCrew=	["B_helicrew_F","B_helipilot_F"];
};
	case 2 : {// INDEPENDENT AAF FACTION
	_InfPool=	["I_engineer_F","I_Soldier_A_F","I_Soldier_AA_F","I_Soldier_AAA_F","I_Soldier_AAR_F","I_Soldier_AAT_F","I_Soldier_AR_F","I_Soldier_AT_F","I_Soldier_exp_F","I_soldier_F","I_Soldier_GL_F","I_Soldier_repair_F"];	
	_ArmPool=	["I_APC_Wheeled_03_cannon_F","I_APC_tracked_03_cannon_F","I_MBT_03_cannon_F"];
	_MotPool=	["I_MRAP_03_F","I_MRAP_03_gmg_F","I_MRAP_03_hmg_F","I_Truck_02_medical_F"];
	_ACHPool=	["I_Heli_light_03_F"];
	_CHPool=	["I_Heli_Transport_02_F","I_Heli_light_03_unarmed_F","O_Heli_Transport_04_covered_F"];
	_uavPool=	["I_UAV_01_F","I_UAV_02_CAS_F","I_UGV_01_rcws_F"];
	_stPool=	["I_Mortar_01_F"];
	_shipPool=	["I_Boat_Transport_01_F","I_G_Boat_Transport_01_F","I_Boat_Armed_01_minigun_F"];
	_diverPool=	["I_diver_exp_F","I_diver_F","I_diver_TL_F"];
	_crewPool=	["I_crew_F"];
	_heliCrew=	["I_helicrew_F","I_helipilot_F"];
};
	case 3 : {// Masi Armed African Civilians (Rebel supporters EAST)
	_InfPool= 	["O_mas_afr_Rebel1_F","O_mas_afr_Rebel2_F","O_mas_afr_Rebel3_F","O_mas_afr_Rebel4_F","O_mas_afr_Rebel5_F","O_mas_afr_Rebel6_F","O_mas_afr_Rebel6a_F","O_mas_afr_Rebel7_F","O_mas_afr_Rebel8_F","O_mas_afr_Rebel8a_F"];
	_ArmPool= 	["O_mas_afr_GMG_01_high_F","O_mas_afr_HMG_01_F","O_mas_afr_HMG_01_high_F","O_MBT_02_cannon_F","O_APC_Tracked_02_cannon_F"];
	_MotPool= 	["O_mas_afr_Quadbike_01_F","O_mas_afr_GMG_01_F","O_mas_afr_Offroad_01s_armed_F","O_mas_afr_Offroad_01_armed_F"];
	_ACHPool= 	[];
	_CHPool=	["O_Heli_Light_02_F","O_Heli_Light_02_unarmed_F","O_Heli_Transport_04_covered_F"];
	_uavPool= 	[];
	_stPool= 	["O_mas_afr_Mortar_01_F"];
	_shipPool=	["O_Boat_Armed_01_hmg_F","O_Boat_Transport_01_F"];
	_diverPool= ["O_mas_afr_Rebel1_F"];
	_crewPool=  ["O_mas_afr_Rebel1_F","O_mas_afr_Rebel2_F"];
	_heliCrew=  ["O_mas_afr_Rebel2_F"];
};
	case 4 : {// Masi Africian Rebel Army (EAST)
	_InfPool= 	["O_mas_afr_Soldier_F","O_mas_afr_Soldier_GL_F","O_mas_afr_soldier_AR_F","O_mas_afr_soldier_MG_F","O_mas_afr_Soldier_lite_F","O_mas_afr_Soldier_off_F","O_mas_afr_Soldier_SL_F","O_mas_afr_soldier_M_F","O_mas_afr_soldier_LAT_F","O_mas_afr_soldier_LAA_F","O_mas_afr_medic_F","O_mas_afr_soldier_repair_F","O_mas_afr_soldier_exp_F","O_mas_afr_rusadv1_F","O_mas_afr_rusadv2_F","O_mas_afr_rusadv3_F"];//"O_mas_afr_Soldier_TL_Fn"
    _ArmPool= 	["O_mas_afr_GMG_01_F","O_mas_afr_HMG_01_high_F","O_MBT_02_cannon_F","O_APC_Tracked_02_cannon_F"];
    _MotPool= 	["O_mas_afr_Offroad_01_armed_F","O_mas_afr_Offroad_01s_armed_F","O_mas_afr_Offroad_01c_armed_F","O_mas_afr_Truck_02_logistic_F","O_mas_afr_Truck_02_transport_F"];
    _ACHPool= 	[];
	_CHPool= 	["O_Heli_Light_02_F","I_Heli_Transport_02_F","O_Heli_Transport_04_covered_F"];
	_uavPool= 	[];
	_stPool= 	["O_mas_afr_Mortar_01_F","O_mas_afr_static_AT_F","O_mas_afr_static_AA_F"];
	_shipPool=	["O_Boat_Armed_01_hmg_F","O_Boat_Transport_01_F"];
	_diverPool= ["O_diver_exp_F","O_diver_F","O_diver_TL_F"];
	_crewPool=	["O_mas_afr_soldier_AR_F","O_mas_afr_rusadv1_F"];
	_heliCrew=	["O_mas_afr_Soldier_GL_F","O_mas_afr_soldier_AR_F","O_mas_afr_rusadv1_F"];
};
	case 5 : {// Leight's Opfor Pack - Islamic State of Takistan and Sahrani
	_InfPool=	["LOP_ISTS_Infantry_TL","LOP_ISTS_Infantry_SL","LOP_ISTS_Infantry_Corpsman","LOP_ISTS_Infantry_AR","LOP_ISTS_Infantry_AT","LOP_ISTS_Infantry_Marksman","LOP_ISTS_Infantry_Engineer","LOP_ISTS_Infantry_GL"];
	_ArmPool=	["LOP_ISTS_BMP1","LOP_ISTS_BMP2","LOP_ISTS_BTR60","LOP_ISTS_M113_W","LOP_ISTS_T72BA","LOP_ISTS_ZSU234"];
	_MotPool=	["LOP_ISTS_Landrover_M2","LOP_ISTS_M1025_W_M2","LOP_ISTS_M1025_W_Mk19","LOP_ISTS_M1025_D","LOP_ISTS_M998_D_4DR","LOP_ISTS_Offroad_M2"];
	_ACHPool=	["O_Heli_Attack_02_black_F","O_Heli_Attack_02_F"];
	_CHPool=	["LOP_SLA_Mi8MT_Cargo","LOP_SLA_Mi8MTV3_FAB","LOP_SLA_Mi8MTV3_UPK23"];
	_uavPool=	[];
	_stPool=	["LOP_ISTS_Static_Mk19_TriPod","LOP_ISTS_Static_M2","LOP_ISTS_Static_M2_MiniTripod"];
	_shipPool=	["O_Boat_Armed_01_hmg_F","O_Boat_Transport_01_F"];
	_diverPool=	["I_diver_exp_F","I_diver_F","I_diver_TL_F"];
	_crewPool=	["LOP_ISTS_Infantry_SL","LOP_ISTS_Infantry_AR","LOP_ISTS_Infantry_AT","LOP_ISTS_Infantry_Engineer","LOP_ISTS_Infantry_GL"];
	_heliCrew=	["LOP_ISTS_Infantry_SL","LOP_ISTS_Infantry_AR","LOP_ISTS_Infantry_AT","LOP_ISTS_Infantry_Engineer","LOP_ISTS_Infantry_GL"];
};
	case 6 : {// Leight's Opfor Pack - Afghan militia
	_InfPool=	["LOP_AM_Infantry_TL","LOP_AM_Infantry_SL","LOP_AM_Infantry_Corpsman","LOP_AM_Infantry_AR","LOP_AM_Infantry_AT","LOP_AM_Infantry_Marksman","LOP_AM_Infantry_Engineer","LOP_AM_Infantry_GL"];
	_ArmPool=	["LOP_AM_BTR60","LOP_AM_M113_W","LOP_AM_T72BA"];
	_MotPool=	["LOP_AM_Landrover_M2","LOP_AM_Offroad_M2","LOP_IA_M1025_W_Mk19","LOP_IA_M1025_W_M2"];
	_ACHPool=	["O_Heli_Attack_02_black_F","O_Heli_Attack_02_F"];
	_CHPool=	["LOP_SLA_Mi8MT_Cargo","LOP_SLA_Mi8MTV3_FAB","LOP_SLA_Mi8MTV3_UPK23"];
	_uavPool=	[];
	_stPool=	["LOP_ISTS_Static_Mk19_TriPod","LOP_ISTS_Static_M2","O_static_AT_F","LOP_ISTS_Static_M2_MiniTripod","O_static_AA_F","O_G_Mortar_01_F"];
	_shipPool=	["O_Boat_Armed_01_hmg_F","O_Boat_Transport_01_F"];
	_diverPool=	["I_diver_exp_F","I_diver_F","I_diver_TL_F"];
	_crewPool=	["LOP_AM_Infantry_Engineer","LOP_AM_Infantry_GL","LOP_AM_Infantry_AT"];
	_heliCrew=	["LOP_AM_Infantry_SL","LOP_AM_Infantry_Engineer","LOP_AM_Infantry_GL","LOP_AM_Infantry_AT","LOP_AM_Infantry_AR"];
};
	case 7 : {// Middle Eastern Irregulars (EAST)
	_InfPool=	["MEC_IRR_RiflemanO","MEC_IRR_SquadLeaderO","MEC_IRR_MachineGunnerO","MEC_IRR_AutomaticRiflemanO","MEC_IRR_GrenadierO","MEC_IRR_ATSoldierO","MEC_IRR_RPG7SoldierO","MEC_IRR_AASoldierO","MEC_IRR_MedicO","MEC_IRR_MarksmanO","MEC_IRR_CrewmanO","MEC_IRR_RepairO","MEC_IRR_EngineerO","MEC_IRR_ExplosivesO"];//"MEC_IRR_RPG7GrenadierO",
	_ArmPool=	["MEC_IRR_BMP1","MEC_IRR_BMP2","MEC_IRR_T55","MEC_IRR_T72","MEC_IRR_ZSU23"];
	_MotPool=	["MEC_IRR_Offroad_01_armed_FO","MEC_IRR_Offroad_01s_armed_FO"];
	_CHPool=	["MEC_SAA_Hind","O_Heli_Light_02_F","O_Heli_Light_02_unarmed_F","O_Heli_Transport_04_covered_F"];
	_uavPool=	[];
	_stPool=	["MEC_IRR_ZU23_O","MEC_IRR_DSHKM_O","MEC_IRR_DSHkM_Mini_TriPod_O","MEC_IRR_KORD_O","MEC_IRR_KORD_high_O","MEC_IRR_AGS_O","MEC_IRR_Metis_O","MEC_IRR_SPG9_O","MEC_IRR_Igla_AA_pod_O","MEC_IRR_2b14_82mm_O","MEC_IRR_D30","MEC_IRR_D30_AT_O"];
	_shipPool=	["O_Boat_Armed_01_hmg_F","O_Boat_Transport_01_F"];
	_diverPool=	["MEC_IRR_EngineerO"];
	_crewPool=	["MEC_IRR_CrewmanO"];
	_heliCrew=	["MEC_IRR_RiflemanO","MEC_IRR_ATSoldierO","MEC_IRR_MedicO","MEC_IRR_AutomaticRiflemanO","MEC_IRR_RPG7SoldierO"];
};
	case 8 : {// Middle Eastern Conflict - Taliban
	_InfPool=	["MEC_TAL_AASoldier","MEC_TAL_ATSoldier","MEC_TAL_AutomaticRifleman","MEC_TAL_Crewman","MEC_TAL_Engineer","MEC_TAL_Explosives","MEC_TAL_Grenadier","MEC_TAL_MachineGunner","MEC_TAL_Marksman","MEC_TAL_Medic","MEC_TAL_Repair","MEC_TAL_Rifleman","MEC_TAL_RPG7Soldier","MEC_TAL_SquadLeader"];
	_ArmPool=	["MEC_TAL_BMP1","MEC_TAL_BMP2","MEC_TAL_T55","MEC_TAL_T72","MEC_TAL_ZSU23"];
	_MotPool=	["MEC_TAL_Offroad_01_armed_F","MEC_TAL_Offroad_01_F","MEC_TAL_Offroad_01s_armed_F","MEC_TAL_Offroad_01s_F"];
	_ACHPool=	["O_Heli_Attack_02_black_F","O_Heli_Attack_02_F","MEC_SAA_Hind"];
	_CHPool=	["O_Heli_Light_02_F","O_Heli_Light_02_unarmed_F","O_Heli_Transport_04_covered_F","MEC_SAA_Hind"];
	_uavPool=	[];
	_stPool=	["MEC_TAL_ZU23","MEC_TAL_DSHKM","MEC_TAL_AGS","MEC_TAL_DSHkM_Mini_TriPod","MEC_TAL_KORD","MEC_TAL_KORD_high","MEC_TAL_Metis","MEC_TAL_SPG9","MEC_TAL_Igla_AA_pod","MEC_TAL_2b14_82mm","MEC_TAL_D30","MEC_TAL_D30_AT"];
	_shipPool=	["O_Boat_Armed_01_hmg_F","O_Boat_Transport_01_F"];
	_diverPool=	["MEC_TAL_Engineer"];
	_crewPool=	["MEC_TAL_Crewman"];
	_heliCrew=	["MEC_TAL_Rifleman","MEC_TAL_MachineGunner","MEC_TAL_RPG7Soldier","MEC_TAL_AASoldier","MEC_TAL_Grenadier"];
};
	case 9 : {// Middle Eastern Conflict - Islamic State
	_InfPool=	["MEC_IS_AASoldier","MEC_IS_ATSoldier","MEC_IS_AutomaticRifleman","MEC_IS_Crewman","MEC_IS_Engineer","MEC_IS_Explosives","MEC_IS_Grenadier","MEC_IS_MachineGunner","MEC_IS_Marksman","MEC_IS_Medic","MEC_IS_Repair","MEC_IS_Rifleman","MEC_IS_RPG7Soldier","MEC_IS_SquadLeader"];//"MEC_IS_RPG7Grenadier",
	_ArmPool=	["MEC_IS_BMP1","MEC_IS_BMP2","MEC_IS_T55","MEC_IS_T72","MEC_IS_ZSU23"];
	_MotPool=	["MEC_IS_Offroad_01_armed_F","MEC_IS_Offroad_01_F","MEC_IS_Offroad_01s_armed_F","MEC_IS_Offroad_01s_F"];
	_ACHPool=	["O_Heli_Attack_02_black_F","O_Heli_Attack_02_F","MEC_SAA_Hind"];
	_CHPool=	["O_Heli_Light_02_F","O_Heli_Light_02_unarmed_F","O_Heli_Transport_04_covered_F","MEC_SAA_Hind"];
	_uavPool=	[];
	_stPool=	["MEC_TAL_ZU23","MEC_TAL_DSHKM","MEC_TAL_AGS","MEC_TAL_DSHkM_Mini_TriPod","MEC_TAL_KORD","MEC_TAL_KORD_high","MEC_TAL_Metis","MEC_TAL_SPG9","MEC_TAL_Igla_AA_pod","MEC_TAL_2b14_82mm","MEC_TAL_D30","MEC_TAL_D30_AT"];
	_shipPool=	["O_Boat_Armed_01_hmg_F","O_Boat_Transport_01_F"];
	_diverPool=	["MEC_IS_Engineer"];
	_crewPool=	["MEC_IS_Crewman"];
	_heliCrew=	["MEC_IS_Rifleman","MEC_IS_MachineGunner","MEC_IS_RPG7Soldier","MEC_IS_AASoldier","MEC_IS_Grenadier"];
};
	case 10 : {// Middle Eastern Conflict - Hamas
	_InfPool=	["MEC_HAM_AASoldier","MEC_HAM_ATSoldier","MEC_HAM_AutomaticRifleman","MEC_HAM_Crewman","MEC_HAM_Engineer","MEC_HAM_Explosives","MEC_HAM_Grenadier","MEC_HAM_MachineGunner","MEC_HAM_Marksman","MEC_HAM_Medic","MEC_HAM_Repair","MEC_HAM_Rifleman","MEC_HAM_RPG7Soldier","MEC_HAM_SquadLeader"];//"MEC_HAM_RPG7Grenadier"
	_ArmPool=	["MEC_BOK_BMP1","MEC_BOK_BMP2","MEC_BOK_T55","MEC_BOK_T72","MEC_BOK_ZSU23"];
	_MotPool=	["MEC_HAM_Offroad_01_armed","MEC_BOK_Offroad_01s_F","MEC_BOK_Offroad_01_armed_F","MEC_BOK_Offroad_01s_armed_F","MEC_HAM_Offroad_01","MEC_HAM_Offroad_01_armed","MEC_HEZ_Offroad_01_armed"];
	_ACHPool=	["O_Heli_Attack_02_black_F","O_Heli_Attack_02_F","MEC_SAA_Hind"];
	_CHPool=	["O_Heli_Light_02_F","O_Heli_Light_02_unarmed_F","O_Heli_Transport_04_covered_F","MEC_SAA_Hind"];
	_uavPool=	[];
	_stPool=	["MEC_HEZ_ZU23","MEC_HEZ_DSHKM","MEC_HEZ_AGS","MEC_HEZ_DSHkM_Mini_TriPod","MEC_HEZ_KORD","MEC_HEZ_KORD_high","MEC_HEZ_Metis","MEC_HEZ_SPG9","MEC_HEZ_Igla_AA_pod","MEC_HEZ_2b14_82mm","MEC_HEZ_D30","MEC_HEZ_D30_AT"];
	_shipPool=	["O_Boat_Armed_01_hmg_F","O_Boat_Transport_01_F"];
	_diverPool=	["MEC_HAM_Engineer"];
	_crewPool=	["MEC_HAM_Crewman"];
	_heliCrew=	["MEC_HAM_Rifleman","MEC_HAM_MachineGunner","MEC_HAM_RPG7Soldier","MEC_HAM_AASoldier","MEC_HAM_Grenadier"];
};
	case 11 : {// Middle Eastern Conflict - Hezbollah
	_InfPool=	["MEC_HEZ_AASoldier","MEC_HEZ_ATSoldier","MEC_HEZ_AutomaticRifleman","MEC_HEZ_Crewman","MEC_HEZ_Engineer","MEC_HEZ_Explosives","MEC_HEZ_MachineGunner","MEC_HEZ_Marksman","MEC_HEZ_Medic","MEC_HEZ_Repair","MEC_HEZ_Rifleman","MEC_HEZ_Grenadier","MEC_HEZ_RPG7Soldier","MEC_HEZ_SquadLeader"];//"MEC_HEZ_RPG7Grenadier",
	_ArmPool=	["MEC_BOK_BMP1","MEC_BOK_BMP2","MEC_BOK_T55","MEC_BOK_T72","MEC_BOK_ZSU23"];
	_MotPool=	["MEC_HAM_Offroad_01_armed","MEC_BOK_Offroad_01s_F","MEC_BOK_Offroad_01_armed_F","MEC_BOK_Offroad_01s_armed_F","MEC_HEZ_Offroad_01","MEC_HAM_Offroad_01_armed","MEC_HEZ_Offroad_01_armed"];
	_ACHPool=	["O_Heli_Attack_02_black_F","O_Heli_Attack_02_F","MEC_SAA_Hind"];
	_CHPool=	["O_Heli_Light_02_F","O_Heli_Light_02_unarmed_F","O_Heli_Transport_04_covered_F","MEC_SAA_Hind"];
	_uavPool=	[];
	_stPool=	["MEC_HEZ_ZU23","MEC_HEZ_DSHKM","MEC_HEZ_AGS","MEC_HEZ_DSHkM_Mini_TriPod","MEC_HEZ_KORD","MEC_HEZ_KORD_high","MEC_HEZ_Metis","MEC_HEZ_SPG9","MEC_HEZ_Igla_AA_pod","MEC_HEZ_2b14_82mm","MEC_HEZ_D30","MEC_HEZ_D30_AT"];
	_shipPool=	["O_Boat_Armed_01_hmg_F","O_Boat_Transport_01_F"];
	_diverPool=	["MEC_HEZ_Engineer"];
	_crewPool=	["MEC_HEZ_Crewman"];
	_heliCrew=	["MEC_HEZ_Rifleman","MEC_HEZ_MachineGunner","MEC_HEZ_RPG7Soldier","MEC_HEZ_Grenadier","MEC_HEZ_AASoldier"];
};
	case 12 : {// Sud Russians
	_InfPool=	["SUD_USSR_Soldier_TL","SUD_USSR_Soldier_AR","SUD_USSR_Soldier_GL","SUD_USSR_Soldier_AT","SUD_USSR_Soldier_HAT","SUD_USSR_Soldier","SUD_USSR_Soldier_Medic","SUD_USSR_Soldier_Crew","SUD_USSR_Soldier_Specop","SUD_USSR_Soldier_AA","SUD_USSR_Soldier_Repair","SUD_USSR_Soldier_Sapper"];
	_ArmPool=	["SUD_BMP2","SUD_T72B","SUD_ZSU"];
	_MotPool=	["SUD_UAZ","SUD_BRDM2","SUD_URAL","SUD_BTR60"];
	_ACHPool=	["O_Heli_Attack_02_black_F","O_Heli_Attack_02_F"];
	_CHPool=	["O_Heli_Light_02_F","O_Heli_Light_02_unarmed_F","O_Heli_Transport_04_covered_F"];
	_uavPool=	[];
	_stPool=	["RDS_ZU23_SAA","RDS_DSHKM_SAA","RDS_DSHkM_Mini_TriPod_SAA","RDS_KORD_SAA","RDS_KORD_high_SAA","RDS_AGS_SAA","RDS_Metis_SAA","RDS_SPG9_SAA","RDS_Igla_AA_pod_SAA","RDS_2b14_82mm_SAA","RDS_D30_SAA","RDS_D30_AT_SAA"];
	_shipPool=	["O_Boat_Armed_01_hmg_F","O_Boat_Transport_01_F"];
	_diverPool=	["SUD_USSR_Soldier_Crew"];
	_crewPool=	["SUD_USSR_Soldier_Crew"];
	_heliCrew=	["SUD_USSR_Soldier_Pilot","SUD_USSR_Soldier_Specop","SUD_USSR_Soldier_GL","SUD_USSR_Soldier_AT"];
};
	case 13 : {// CAF Aggressors Middle Eastern
	_InfPool=	["CAF_AG_ME_T_AK47","CAF_AG_ME_T_AK74","CAF_AG_ME_T_GL","CAF_AG_ME_T_PKM","CAF_AG_ME_T_RPG","CAF_AG_ME_T_RPK74","CAF_AG_ME_T_SVD"];	
	_ArmPool=	["O_APC_Tracked_02_AA_F","O_APC_Tracked_02_cannon_F","O_APC_Wheeled_02_rcws_F","O_MBT_02_arty_F","O_MBT_02_cannon_F"];
	_MotPool=	["CAF_AG_ME_T_van_01","CAF_AG_ME_T_Offroad","CAF_AG_ME_T_Offroad_armed_01"];
	_ACHPool=	["O_Heli_Attack_02_black_F","O_Heli_Attack_02_F"];
	_CHPool=	["O_Heli_Light_02_F","O_Heli_Light_02_unarmed_F","O_Heli_Transport_04_covered_F"];
	_uavPool=	[];
	_stPool=	["O_Mortar_01_F","O_HMG_01_high_F","O_static_AT_F","O_static_AA_F"];
	_shipPool=	["O_Boat_Armed_01_hmg_F","O_Boat_Transport_01_F"];
	_diverPool=	["CAF_AG_ME_T_AK47"];
	_crewPool=	["CAF_AG_ME_T_AK47"];
	_heliCrew=	["CAF_AG_ME_T_RPG","CAF_AG_ME_T_GL"];
};
	case 14 : {// CAF Aggressors African pirates
	_InfPool=	["CAF_AG_AFR_P_AK47","CAF_AG_AFR_P_AK47","CAF_AG_AFR_P_SVD","CAF_AG_AFR_P_AK47","CAF_AG_AFR_P_AK74","CAF_AG_AFR_P_GL","CAF_AG_AFR_P_PK","CAF_AG_AFR_P_RPK","CAF_AG_AFR_P_RPG"];	
	_ArmPool=	["O_APC_Tracked_02_AA_F","O_APC_Tracked_02_cannon_F","O_APC_Wheeled_02_rcws_F","O_MBT_02_arty_F","O_MBT_02_cannon_F"];
	_MotPool=	["CAF_AG_afr_p_Offroad","CAF_AG_afr_p_Offroad_armed_01","CAF_AG_afr_p_van_01"];
	_ACHPool=	["O_Heli_Attack_02_black_F","O_Heli_Attack_02_F"];
	_CHPool=	["O_Heli_Light_02_F","O_Heli_Light_02_unarmed_F","O_Heli_Transport_04_covered_F"];
	_uavPool=	[];
	_stPool=	["O_Mortar_01_F","O_HMG_01_high_F","O_static_AT_F","O_static_AA_F"];
	_shipPool=	["O_Boat_Armed_01_hmg_F","O_Boat_Transport_01_F"];
	_diverPool=	["O_diver_exp_F","O_diver_F","O_diver_TL_F"];
	_crewPool=	["CAF_AG_AFR_P_AK47"];
	_heliCrew=	["CAF_AG_AFR_P_RPG","CAF_AG_AFR_P_GL"];
};
	case 15 : {// CAF Aggressors European Rebels
	_InfPool=	["CAF_AG_EEUR_R_AK47","CAF_AG_EEUR_R_AK74","CAF_AG_EEUR_R_GL","CAF_AG_EEUR_R_PKM","CAF_AG_EEUR_R_RPG","CAF_AG_EEUR_R_RPK74","CAF_AG_EEUR_R_SVD"];
	_ArmPool=	["O_APC_Tracked_02_AA_F","O_APC_Tracked_02_cannon_F","O_APC_Wheeled_02_rcws_F","O_MBT_02_arty_F","O_MBT_02_cannon_F"];
	_MotPool=	["CAF_AG_eeur_r_Offroad","CAF_AG_eeur_r_Offroad_armed_01","O_G_Offroad_01_armed_F","CAF_AG_eeur_r_van_01"];
	_ACHPool=	["O_Heli_Attack_02_black_F","O_Heli_Attack_02_F"];
	_CHPool=	["MEC_SAA_Hind","O_Heli_Light_02_F","O_Heli_Light_02_unarmed_F","O_Heli_Transport_04_covered_F"];
	_uavPool=	[];
	_stPool=	["O_Mortar_01_F","O_HMG_01_high_F","O_static_AT_F","O_static_AA_F"];
	_shipPool=	["O_Boat_Armed_01_hmg_F","O_Boat_Transport_01_F"];
	_diverPool=	["O_diver_exp_F","O_diver_F","O_diver_TL_F"];
	_crewPool=	["CAF_AG_EEUR_R_AK47"];
	_heliCrew=	["CAF_AG_EEUR_R_RPG","CAF_AG_EEUR_R_GL"];
};
	case 16 : {// RHS - Armed Forces of the Russian Federation MSV
	_InfPool=	["rhs_msv_crew","rhs_msv_crew_commander","rhs_msv_armoredcrew","rhs_msv_combatcrew","rhs_msv_rifleman","rhs_msv_efreitor","rhs_msv_grenadier","rhs_msv_machinegunner","rhs_msv_machinegunner_assistant","rhs_msv_at","rhs_msv_strelok_rpg_assist","rhs_msv_marksman","rhs_msv_officer_armored","rhs_msv_officer","rhs_msv_junior_sergeant","rhs_msv_sergeant","rhs_msv_engineer","rhs_msv_driver_armored","rhs_msv_driver","rhs_msv_aa","rhs_msv_medic","rhs_msv_LAT"];
	_ArmPool=	["rhs_sprut_vdv","rhs_bmp1p_msv","rhs_brm1k_msv","rhs_bmp2_msv","rhs_bmp2e_msv","rhs_bmp2d_msv","rhs_bmp2k_msv","rhs_prp3_msv","rhs_bmp3mera_msv","rhs_bmd4_vdv","rhs_bmd4ma_vdv","rhs_t80u","rhs_t80bv","rhs_t80a","rhs_t72bc_tv","rhs_t72bb_tv","rhs_zsu234_aa","rhs_t90a_tv"];
	_MotPool=	["RHS_Ural_MSV_01","RHS_Ural_Fuel_MSV_01","RHS_Ural_VDV_01","rhs_typhoon_vdv","rhs_gaz66_repair_vdv","RHS_Ural_Open_MSV_01"];
	_ACHPool=	["RHS_Mi24P_vvsc","RHS_Mi24V_vvsc"];
	_CHPool=	["Cha_Mi24_P","Cha_Mi24_V","O_Heli_Light_02_F","O_Heli_Light_02_unarmed_F"];
	_uavPool=	["O_UAV_01_F","O_UAV_02_CAS_F","O_UGV_01_rcws_F"];
	_stPool=	["O_Mortar_01_F","O_Mortar_01_F","O_static_AT_F","O_static_AA_F","O_GMG_01_high_F","O_HMG_01_high_F"];
	_shipPool=	["O_Boat_Armed_01_hmg_F","O_Boat_Transport_01_F"];
	_diverPool=	["O_diver_exp_F","O_diver_F","O_diver_TL_F"];
	_crewPool=	["rhs_msv_crew"];
	_heliCrew=	["rhs_msv_grenadier","rhs_msv_machinegunner","rhs_msv_at"];
};
	case 17 : {// Iraqi-Syrian Conflict - Syrian Arab Army (Opfor)
	_InfPool=	["isc_saa_officer_o","isc_saa_grenadier_o","isc_saa_rifleman_o","isc_saa_machinegunner_o","isc_saa_sniper_o","isc_saa_at_o","isc_saa_medic_o","isc_saa_sapper_o","isc_saa_crewman_o"];
	_ArmPool=	["isc_saa_BTR60_o","isc_saa_BMP1_o","isc_saa_BMP1P_o","isc_saa_BMP2_o","isc_saa_T55_o","isc_saa_T72_o","isc_saa_T72M_o","isc_saa_ZSU_o"];
	_MotPool=	["isc_is_offroad_o","isc_is_offroad_M2_o","isc_is_hilux_MG_o","isc_is_hilux_M2_o","isc_is_hilux_AGS30_o","isc_is_hilux_SPG9_o","isc_is_hilux_Unarmed_o","isc_is_LR_M2_o","isc_is_LR_Mk19_o","isc_is_LR_TOW_o","isc_is_LR_SPG9_o","isc_is_UAZ_MG_o","isc_is_UAZ_M2_o","isc_is_UAZ_AGS30_o","isc_is_UAZ_SPG9_o"];
	_ACHPool=	["O_mas_MI8MTV","O_mas_MI24V"];
	_CHPool=	["O_mas_MI8","O_Heli_Light_02_F","O_Heli_Light_02_unarmed_F"];
	_uavPool=	["O_UAV_01_F","O_UAV_02_CAS_F","O_UGV_01_rcws_F"];
	_stPool=	["isc_is_ZU23_o","isc_is_DSHKM_o","isc_is_KORD_high_o","isc_is_KORD_o","isc_is_AGS_o","isc_is_GMG_o","isc_is_M2Static_o","isc_is_MK19_TriPod_o","isc_is_Metis_o","isc_is_SPG9_o","isc_is_Igla_o","isc_is_Stinger_o","isc_is_TOW_o","isc_is_2b14_82mm_o","isc_is_M252_o","isc_is_D30_o","isc_is_D30_AT_o","isc_is_M119_o","isc_is_M119_AT_o"];
	_shipPool=	["O_Boat_Armed_01_hmg_F","O_Boat_Transport_01_F"];
	_diverPool=	["O_diver_exp_F","O_diver_F","O_diver_TL_F"];
	_crewPool=	["isc_saa_crewman_o"];
	_heliCrew=	["isc_saa_grenadier_o","isc_saa_machinegunner_o","isc_saa_at_o"];
};
	case 18 : {// Iraqi-Syrian Conflict - Islamic State (Opfor)
	_InfPool=	["isc_is_team_leader_o","isc_is_squad_leader_o","isc_is_grenadier_o","isc_is_rifleman_o","isc_is_militaman_o","isc_is_irregular_o","isc_is_autorifleman_o","isc_is_machinegunner_o","isc_is_sniper_o","isc_is_at_o","isc_is_medic_o","isc_is_sapper_o","isc_is_crewman_o"];
	_ArmPool=	["isc_is_BMP1_o","isc_is_BMP1P_o","isc_is_BMP2_o","isc_is_T34_o","isc_is_T55_o","isc_is_T72e_o","isc_is_T72_o","isc_is_T72B_o","isc_is_T72BM_o","isc_is_ZSU_o"];
	_MotPool=	["isc_is_offroad_o","isc_is_offroad_M2_o","isc_is_hilux_MG_o","isc_is_hilux_M2_o","isc_is_hilux_AGS30_o","isc_is_hilux_SPG9_o","isc_is_hilux_Unarmed_o","isc_is_LR_M2_o","isc_is_LR_Mk19_o","isc_is_LR_TOW_o","isc_is_LR_SPG9_o","isc_is_UAZ_MG_o","isc_is_UAZ_M2_o","isc_is_UAZ_AGS30_o","isc_is_UAZ_SPG9_o"];
	_ACHPool=	["O_mas_MI8MTV","O_mas_MI24V"];
	_CHPool=	["O_mas_MI8","O_Heli_Light_02_F","O_Heli_Light_02_unarmed_F"];
	_uavPool=	["O_UAV_01_F","O_UAV_02_CAS_F","O_UGV_01_rcws_F"];
	_stPool=	["isc_is_ZU23_o","isc_is_DSHKM_o","isc_is_KORD_high_o","isc_is_AGS_o","isc_is_GMG_o","isc_is_M2Static_o","isc_is_MK19_TriPod_o","isc_is_Metis_o","isc_is_SPG9_o","isc_is_Igla_o","isc_is_Stinger_o","isc_is_TOW_o","isc_is_2b14_82mm_o","isc_is_M252_o","isc_is_D30_o","isc_is_D30_AT_o","isc_is_M119_o","isc_is_M119_AT_o"];
	_shipPool=	["O_Boat_Armed_01_hmg_F","O_Boat_Transport_01_F"];
	_diverPool=	["O_diver_exp_F","O_diver_F","O_diver_TL_F"];
	_crewPool=	["isc_is_crewman_o"];
	_heliCrew=	["isc_is_grenadier_o","isc_is_machinegunner_o","isc_is_at_o"];};
};

////////////////////////////////////////////////////////////////////////////////////////
if (_type isEqualTo 0) then {
	for "_i" from 0 to 5 do{
	_unit=_InfPool select (floor(random(count _InfPool)));
	_tempArray set [count _tempArray,_unit];};
};

if (_type isEqualTo 1) then {_tempArray=_diverPool};

// CREATE ARMOUR & CREW
if (_type isEqualTo 2) then {
	_tempUnit=_ArmPool select (floor(random(count _ArmPool)));
	_temparray set [count _temparray,_tempUnit];
	_crew=_crewPool select (floor(random(count _crewPool)));
	_temparray set [count _temparray,_crew];
};

// CREATE ATTACK CHOPPER & CREW	
if (_type isEqualTo 3) then {
	_tempUnit=_ACHPool select (floor(random(count _ACHPool)));
	_temparray set [count _temparray,_tempUnit];
	_crew=_heliCrew select (floor(random(count _heliCrew)));
	_temparray set [count _temparray,_crew];
};

// CREATE TRANSPORT CHOPPER & CREW
if (_type isEqualTo 4) then {
	_tempUnit=_CHPool select (floor(random(count _CHPool)));
	_temparray set [count _temparray,_tempUnit];
	_crew=_heliCrew select (floor(random(count _heliCrew)));
	_temparray set [count _temparray,_crew];
};

// CREATE STATIC & CREW
if (_type isEqualTo 5) then {
	_tempUnit=_stPool select (floor(random(count _stPool)));
	_temparray set [count _temparray,_tempUnit];
	_crew=_crewPool select (floor(random(count _crewPool)));
	_temparray set [count _temparray,_crew];
};
if (_type isEqualTo 6) then {_tempArray=_uavPool select (floor(random(count _uavPool)));};

// CREATE TRANSPORT & CREW
if (_type isEqualTo 7) then {
	_tempUnit=_MotPool select (floor(random(count _MotPool)));
	_temparray set [count _temparray,_tempUnit];
	_crew=_crewPool select (floor(random(count _crewPool)));
	_temparray set [count _temparray,_crew];
};

// CREATE BOAT & DIVER CREW
if (_type isEqualTo 8) then {
	_tempUnit=_shipPool select (floor(random(count _shipPool)));
	_temparray set [count _temparray,_tempUnit];
	_crew=_diverPool select (floor(random(count _diverPool)));
	_temparray set [count _temparray,_crew];
};

// CREATE CARGO
if (_type isEqualTo 9) then {
	for "_i" from 0 to 5 do{
		_unit=_InfPool select (floor(random(count _InfPool)));
		_temparray set [count _temparray,_unit];
	};
};

// CREATE DIVER CARGO
if (_type isEqualTo 10) then {
	for "_i" from 0 to 5 do{
		_unit=_diverPool select (floor(random(count _diverPool)));
		_temparray set [count _temparray,_unit];
	};
};

//hint format ["%1",_tempArray];
_tempArray