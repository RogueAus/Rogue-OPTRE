class Params
{
	class INS_Dum_Param1//0
	{
	title = ":: Environment ::";
	values[]={0};
	texts[]={ ""};
	default = 0;
	};
	class INS_b_time//1
    {
	//title = $STR_BMR_start_time;
	title = "		Set the start time:";
	values[]={1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24};
	texts[]={"1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24"};
	default = 12;
	};
	class init_JIP_weather//2
	{
	title = "		Weather";
	values[]={0,25,50,75,1,2,3};
	texts[]={
	"Static Weather 0% Overcast",
	"Static Weather 25% Overcast",
	"Static Weather 50% Overcast",
	"Static Weather 75% Overcast",
	"Static Weather 100% Overcast (Weather Disabled)",
	"Dynamic Real Weather Enabled",
	"Dynamic Random Weather Enabled"};
	default = 25;
	};
	class radio_chatter//3
	{
	title = "		Enable Ambient Vehicle Radio Chatter?";
	values[]={0,1};
	texts[]={"No","Yes"};
	default = 1;
	};
	class combat_sounds//4
	{
	title = "		Enable Ambient Combat Sounds?";
	values[]={0,1};
	texts[]={"No","Yes"};
	default = 0;
	};
	class grass_tog//5
	{
	title = "		Grass Option None";
	values[]={0,1};
	texts[]={"Enabled","Disabled"};
	default = 0;
	};
	class enviroment_tog//6
	{
	title = "		Environment effects (ambient life + sound)";
	values[]={0,1};
	texts[]={"Disable","Enable"};
	default = 1;
	};
	class INS_Dum_Param2//7
	{
	title = ":: Revive ::";
	values[]={0};
	texts[]={ ""};
	default = 0;
	};
	class INS_revive_system//8
	{
	title="		Revive system";
	values[]={0,1,2,3,4,5,6,7};
	texts[]={
	"=BTC= Revive :: Anyone with FAK can revive. Mobile HQ Disabled.",
	"=BTC= Revive :: Anyone with FAK can revive. Mobile HQ Enabled.",
	"=BTC= Revive :: Only medics can revive. Mobile HQ Disabled.",
	"=BTC= Revive :: Only medics can revive. Mobile HQ Enabled.",
	"=BTC= Quick revive :: AI can revive. Mobile HQ Disabled.",
	"=BTC= Quick revive :: AI can revive. Mobile HQ Enabled.",
	"Revive System Disabled. Mobile HQ Disabled.",
	"Revive System Disabled. Mobile HQ Enabled."};
	default = 1;
	};
	class INS_revive_time//9
	{
	title="		Revive time";
	values[]={60,120,180,300,600,1800,3600};
	texts[]={"1 minutes","2 minutes","3 minutes","5 minutes","10 minutes","30 minutes","60 minutes"};
	default = 300;
	};
	class INS_Dum_Param3//10
	{
	title = ":: Compatibility and Factions ::";
	values[]={0};
	texts[]={ ""};
	default = 0;
	};
	class INS_enemy_army//11
	{
	title = "		Opposing Army/Mod Initialization";
	values[]={1,2,3,4,5,6,7,8,9,10,11};
	texts[]={
	"CSAT - Requirements :: None",
	"AAF - Requirements :: None",
	"Africian Rebel Army and Armed African Civilian Rebel supporters - Requirements :: @african_conflict;@nato_russian_sf_weapons",
	"CAF Aggressors - Requirements :: @caf_ag1.5",
	"Islamic State of Takistan/Sahrani and Afghan Militia - Requirements :: @rhs_afrf3;@rhs_usf3;@leights_opfor",
	"Syrian Arab Army and Al Qaida - Requirements :: @mec;@cup;@asdg_jr;@rds;@rds_tank;@cha_mi24",
	"Taliban and Islamic State - Requirements :: @mec;@cup;@asdg_jr;@rds;@rds_tank;@cha_mi24",
	"Hamas and Hezbollah - Requirements :: @mec;@cup;@asdg_jr;@rds;@rds_tank;@cha_mi24",
	"Sud Russians - Requirements :: @evw;@rds",
	"RHS Armed Forces of the Russian Federation - Requirements :: @rhs_afrf3",
	"Syrian Arab Army and Islamic State - Requirements :: @iraqi_syrian_conflict;@cup_weapons;@mas_nato_rus_sf_veh;@rhs_afrf3;@rhs_usf3"};
	default = 1;
	};
	class INS_Dum_Param4//12
	{
	title = ":: Opposing Forces Spawn Settings ::";
	values[]={0};
	texts[]={ ""};
	default = 0;
	};
	class infantry_chance//13
	{
	title = "		Enemy Infantry Probability";
	values[]={25,50,75,100};
	texts[]={"25 % chance","50 % chance","75 % chance","100 % chance"};
	default = 50;
	};
	class armor_chance//14
	{
	title = "		Enemy Armor Probability";
	values[]={1,25,50,75,100};
	texts[]={"0 % chance Heavy Armor + Rewards disabled","25 % chance","50 % chance","75 % chance","100 % chance"};
	default = 75;
	};
	class AI_spawn_Dis//15
	{
	title = "		Enemy AI Spawn Trigger Distance";
	values[]={200,250,300,350,400,450,500,550,600,650,700,750,800,850,900,950,1000,1050,1100,1150,1200,1250};
	texts[]={"200","250","300","350","400","450","500","550","600","650","700","750","800","850","900","950","1000","1050","1100","1150","1200","1250"};
	default = 350;
	};
	class Act_Zone_Limit//16
	{
	title = "		Maximum Simultaneous Activated Zone Limit";
	values[]={10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100,150,300,1000};
	texts[]={"10","15","20","25","30","35","40","45","50","55","60","65","70","75","80","85","90","95","100","150","300","1000"};
	default = 45;
	};
	class Deactivate_Zone_Delay//17
	{
	title = "		Delay Grid zone deactivation when no friendly players near";
	values[]={0,0.5,1,2,3,4,5,6,8,10,12,14,16,18,20,30};
	texts[]={"Disabled","30 seconds","1 minute","2 minutes","3 minutes","4 minutes","5 minutes","6 minutes","8 minutes","10 minutes","12 minutes","14 minutes","16 minutes","18 minutes","20 minutes","30 minutes"};
	default = 2;
	};
	class Enemy_Air//18
	{
	title = "		Enable JIG Enemy Air Patrols?";
	values[]={0,1,2,3};
	texts[]={"No","Helis Only","Fixed Wing Only","Helis and Fixed Wing"};
	default = 3;
	};
	class AiAirRespawn//19
	{
	title = "		Minimum Enemy Air Patrol Respawn Delay";
	values[]={45,300,600,1200,1800,2400,3000,3600};
	texts[]={"45 seconds","5 minutes","10 minutes","20 minutes","30 minutes","40 minutes","50 minutes","60 minutes"};
	default = 2400;
	};
	class patrolewpmod//20
	{
	title = "		Air Patrol way-point type";
	values[]={0,1};
	texts[]={"Seek N Destroy","Hunt Players"};
	default = 1;
	};
	class INS_Dum_Param5//21
	{
	title = ":: Skills ::";
	values[]={0};
	texts[]={ ""};
	default = 0;
	};
	class BTC_set_ai_skill//22
	{
	title = "		Set AI skill on non EOS units. (ASR AI detection will override this)";
	values[]={0,1}; 
	texts[]={"No","Yes"}; 
	default = 1;
	};
	class BTC_AI_accuracy//23
	{
	title = "		AI accuracy on non EOS units. (ASR AI detection will override this)";
	values[]={1,2,3,4,5,6,7,8,9,10};
	texts[]={"0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1"};
	default = 5; 
	};
	class INS_Dum_Param6//24
	{
	title = ":: Civilians ::";
	values[]={0};
	texts[]={ ""};
	default = 0;
	};
	class amb_mobile_civs//25
	{
	title = "		Ambient Mobile Civilians?";
	values[]={0,1};
	texts[]={"No","Yes"};
	default = 1;
	};
	class amb_foot_civs//26
	{
	title = "		Ambient Foot Civilians?";
	values[]={0,1};
	texts[]={"No","Yes"};
	default = 1;
	};
	class foot_civs_chance//27
	{
	title = "		Ambient Foot Civilians Probability";
	values[]={25,50,75,100};
	texts[]={"25 % chance","50 % chance","75 % chance","100 % chance"};
	default = 100;
	};
	class sst_bomber//28
	{
	title = "		Enable Civilian Suicide Bomber?";
	values[]={0,1};
	texts[]={"No","Yes"};
	default = 1;
	};
	class INS_Dum_Param7//29
	{
	title = ":: Mission Settings ::";
	values[]={0};
	texts[]={ ""};
	default = 0;
	};
	class INS_playable_opfor//30
	{
	title = "		Playable Opfor";
	values[]={0,1};
	texts[]={"Disabled","Enabled"};
	default = 1;
	};
	class INS_logistics//31
	{
	title = "		Logistics";
	values[]={0,1};
	texts[]={"Disabled","Enabled"};
	default = 1;
	};
	class can_fatigue//32
	{
	title = "		Fatigue and Stamina System";
	values[]={0,1,2};
	texts[]={"Arma 3 Player Fatigue and Stamina Disabled","Arma 3 Default Player Fatigue and Stamina Enabled","Modified Player Fatigue (Incomplete WIP)"};
	default = 0;
	};
	class damage_multiplier//33
	{
	title = "		Damage Multiplier (Effective hit on enemy)";
	values[]={0.5,1,2,3};
	texts[]={"Low","Default","High","Very High"};
	default = 3;
	};
	class init_JIG_EX//34
	{
	title = "		Enable CAS1 Group Heli Extraction?";
	values[]={0,1};
	texts[]={"No","Yes"};
	default = 1;
	};
	class gasnade_mod//35
	{
	title = "		Enable Gas Grenades and Masks";
	values[]={0,1};
	texts[]={
	"No",
	"Yes (Yellow Hand and GL smoke grenades. Heli Crew Helmets and or @hiddenidentitypack mod Gas Masks)"};
	default = 1;
	};
	class 3rd_person//36
	{
	title = "		Third person view in vehicles only?";
	values[]={0,1};
	texts[]={"No","Yes"};
	default = 0;
	};
	class INS_Recruitable_AI//37
	{
	title = "		Recruitable AI units maximum allowed";
	values[]={1,2,3,4,5,6,7,8,9,10};
	texts[]={"Recruitable AI disabled","1","2","3","4","5","6","7","8","9"};
	default = 10;
	};
	class Audible_AI_radio//38
	{
	title = "		Dissable Audible AI Radio?";
	values[]={0,1};
	texts[]={"No","Yes"};
	default = 0;
	};
	class INS_Dum_Param8//39
	{
	title = ":: Intel/AmmoCaches ::";
	values[]={0};
	texts[]={ ""};
	default = 0;
	};
	class init_ammo_caches//40
	{
	title = "		Enable Enemy Ammo Caches?";
	values[]={0,1};
	texts[]={"No","Yes"};
	default = 1;
	};
	class intel_locations//41
	{
	title = "		Show Intel Location Markers?";
	values[]={0,1};
	texts[]={"No","Yes"};
	default = 1;
	};
	class intel_ratio//42
	{
	title = "		Maximum possible intel per occupied grid zone ratio";
	values[]={2,3,4,5,6};
	texts[]={"1 intel : 2 zones","1 intel : 3 zones","1 intel : 4 zones","1 intel : 5 zones","1 intel : 6 zones"};
	default = 4;
	};
	class INS_Dum_Param9//43
	{
	title = ":: Debug ::";
	values[]={0};
	texts[]={ ""};
	default = 0;
	};
	class INS_editor_debug//44
	{
	title = "		Debug mode?";
	values[]={0,1};
	texts[]={"No","Yes"};
	default = 0;
	};
	class tky_perfmon//45
	{
	title = "		Run performance monitor? (Requires Debug mode Enabled.)";
	values[]={0,30,60,300};
	texts[]={"Off","Every 30 seconds","Once a minute","Once every 5 minutes"};
	default = 0;
	};
};