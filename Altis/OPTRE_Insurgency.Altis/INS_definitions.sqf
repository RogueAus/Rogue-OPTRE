// INS_definitions.sqf by Jigsor //

// Params //////////////////////////////////////////////////////////
INS_p_time      =		(paramsArray select 1);
JIPweather		=		(paramsArray select 2);
ambRadioChatter =		(paramsArray select 3);
ambCombSound	=		(paramsArray select 4);
Remove_grass_opt=		(paramsArray select 5);
INS_environment	=		(paramsArray select 6);
INS_p_rev       =		(paramsArray select 8);
INS_p_rev_time  =		(paramsArray select 9);
INS_op_faction	=		(paramsArray select 11);
InfPb			=		(paramsArray select 13);
MecArmPb		=		(paramsArray select 14);
AI_SpawnDis		=		(paramsArray select 15);
Max_Act_Gzones	=		(paramsArray select 16);
DeAct_Gzone_delay	=	(paramsArray select 17);
EnableEnemyAir	=		(paramsArray select 18);
AirRespawnDelay =		(paramsArray select 19);
PatroleWPmode	=		(paramsArray select 20);
BTC_p_skill     =		(paramsArray select 22);
BTC_AI_skill    =		(paramsArray select 23)/10;
CiviMobiles		=		(paramsArray select 25);
CiviFoot		=		(paramsArray select 26);
CivProbability	= 		(paramsArray select 27);
SuicideBombers	=		(paramsArray select 28);
INS_play_op4	=		(paramsArray select 30);
INS_logistics	=		(paramsArray select 31);
Fatigue_ability =		(paramsArray select 32);
EOS_DAMAGE_MULTIPLIER =	(paramsArray select 33);
JigHeliExtraction =		(paramsArray select 34);
INS_GasGrenadeMod	=	(paramsArray select 35);
limitPOV		=		(paramsArray select 36);
max_ai_recruits	=		(paramsArray select 37);
AI_radio_volume	=		(paramsArray select 38);
EnemyAmmoCache	=		(paramsArray select 40);
Intel_Loc_Alpha =		(paramsArray select 41);
Intel_Count		=		(paramsArray select 42);
DebugEnabled	=		paramsArray select 44;if (!isMultiplayer) then {DebugEnabled = 1;};
tky_perfmon		=		(paramsArray select 45);

// Weather //
if ((JIPweather isEqualTo 0) || {(JIPweather >3)}) then {
	[] spawn {
		waitUntil {time > 1};
		skipTime (((INS_p_time - (daytime) +24) % 24) -24);
		86400 setOvercast (JIPweather/100);
		UIsleep 1;
		0 setFog 0;
		skipTime 24;
		sleep 1;
		//setWind [1,1,false];
		simulWeatherSync;
	};
}else{
	if (JIPweather isEqualTo 2) then {
		[] execVM "scripts\real_weather.sqf"; skipTime ((INS_p_time - (daytime) +24) % 24);
	}else{
		if (JIPweather !=1) then {
			[] execVM "scripts\randomWeather2.sqf"; skipTime (INS_p_time -0.84);
		};
	};
};

// Global Variables /////////////////////////////////////////////////
//number
WestScore = 0;
EastScore = 0;
LT_distance = 20;
jig_tvt_globalsleep = 0.1;// Global sleep used after spawning a unit.
if (isNil "lck_markercnt") then {lck_markercnt=0;};// bardosy's HuntIR
BTC_tk_last_warning = 3;// Max TK punishment warnings given before user input controls disabled.

//boolean
IamHC = false;
INS_MHQ_enabled = false;
INS_mod_missing = false;
if (isNil "timesup") then {timesup = false;};
if (INS_p_rev isEqualTo 5 or {INS_p_rev isEqualTo 7}) then {INS_MHQ_enabled = true;};
INS_ACE_para = if (isClass(configFile >> "cfgPatches" >> "ace_parachute")) then {TRUE}else{FALSE};

//array
StackedEHkeysWhiteList = ["CBA_PFH"];
ghst_Build_objs = [];// all ammo cache objects array
Op4_mkrs = ["Respawn_East"];
Blu4_mkrs = ["Respawn_West","Helicopters","Mechanized","VehicleMaintenance","HelicopterRepair","HelicopterRepair2","AircraftMaintenance","Halo","Dock"];
INS_Op4_wepCrates = [INS_weps_Cbox,INS_ammo_Cbox,INS_nade_Cbox,INS_launchers_Cbox,INS_demo_Cbox,INS_sup_Cbox,INS_E_tent];
INS_Blu4_wepCrates = [INS_weps_Nbox,INS_ammo_Nbox,INS_nade_Nbox,INS_launchers_Nbox,INS_sup_Nbox];

if (INS_GasGrenadeMod isEqualTo 1) then {
	Choke_Sounds = [
		"A3\Sounds_f\characters\human-sfx\Person0\P0_choke_02.wss",
		"A3\Sounds_f\characters\human-sfx\Person0\P0_choke_03.wss",
		"A3\Sounds_f\characters\human-sfx\Person0\P0_choke_04.wss",
		"A3\Sounds_f\characters\human-sfx\Person1\P1_choke_04.wss",
		"A3\Sounds_f\characters\human-sfx\Person2\P2_choke_04.wss",
		"A3\Sounds_f\characters\human-sfx\Person2\P2_choke_05.wss",
		"A3\Sounds_f\characters\human-sfx\Person3\P3_choke_02.wss",
		"A3\Sounds_f\characters\human-sfx\P06\Soundbreathinjured_Max_2.wss",
		"A3\Sounds_f\characters\human-sfx\P05\Soundbreathinjured_Max_5.wss"
	];
};
INS_ending_videos = [
	"\A3\Missions_F_EPA\video\A_in_quotation.ogv",
	"\A3\Missions_F_EPA\video\A_hub_quotation.ogv",
	"\A3\Missions_F_EPA\video\A_in2_quotation.ogv",
	"\A3\Missions_F_EPA\video\A_m01_quotation.ogv",
	"\A3\Missions_F_EPA\video\A_m02_quotation.ogv",
	"\A3\Missions_F_EPA\video\A_m03_quotation.ogv",
	"\A3\Missions_F_EPA\video\A_m04_quotation.ogv",
	"\A3\Missions_F_EPA\video\A_m05_quotation.ogv",
	"\A3\Missions_F_EPA\video\A_out_quotation.ogv",
	"\A3\Missions_F_EPA\video\A_out_to_be_continued.ogv"
];

// Headless Client Variables ///////////////////////////////////////
if  (!isServer && !hasInterface) then {
	IamHC = true;
	Any_HC_present = true; publicVariable "Any_HC_present";
	if (name player == "HC_1") then {HC_1Present = true; publicVariable "HC_1Present";};
	if (name player == "HC_2") then {HC_2Present = true; publicVariable "HC_2Present";};
};

// Client Variables /////////////////////////////////////////////////
if (!isServer) then {
	if (isNil "PVEH_netSay3D") then {PVEH_NetSay3D = [objNull,0];};
	if (isNil "INS_MHQ_killed") then {INS_MHQ_killed = "";};
	ebox = ObjNull;
	epad = ObjNull;
};

// Server Variables /////////////////////////////////////////////////
if (isServer) then {
	//server getVariable "eosMarkers";
	//server getVariable "eosMarkersCiv";
	switch (true) do {
		case (toLower (worldName) isEqualTo "altis"):
		{
			Airfield_opt = true;publicVariable "Airfield_opt";
			Rand_AirCntr_OFstMax = 3500;publicVariable "Rand_AirCntr_OfstMax";
			Del_box_Pos = [20933,7265.92,0.00153351];publicVariable "Del_box_Pos";
			all_eos_mkrs = ["m1","m2","m3","m4","m5","m6","m7","m8","m9","m10","m11","m12","m13","m14","m15","m16","m17","m18","m19","m20","m21","m22","m23","m24","m25","m26","m27","m28","m29","m30","m31","m32","m33","m34","m35","m36","m37","m38","m39","m40","m41","m42","m43","m44","m45","m46","m47","m48","m49","m50","m51","m52","m53","m54","m55","m56","m57","m58","m59","m60","m61","m62","m63","m64","m65","m66","m67","m68","m69","m70","m71","m72","m73","m74","m75","m76","m77","m78","m79","m80","m81","m82","m83","m84","m85","m86","m87","m88","m89","m90","m91","m92","m93","m94","m95","m96","m97","m98","m99","m100","m101","m102","m103","m104","m105","m106","m107","m108","m109","m110","m111","m112","m113","m114","m115","m116","m117","m118","m119","m120","m121","m122","m123","m124","m125","m126","m127","m128","m129","m130","m131","m132","m133","m134","m135","m136","m137","m138","m139","m140","m141","m142","m143","m144","m145","m146","m147","m148","m149","m150","m151","m152","m153","m154","m155","m156","m157","m158","m159","m160","m161","m162","m163","m164","m165","m166","m167","m168","m169","m170","m171","m172","m173","m174","m175","m176","m177","m178","m179","m180","m181","m182","m183","m184","m185","m186","m187","m188","m189","m190","m191","m192","m193","m194","m195","m196","m197","m198","m199","m200","m201","m202","m203","m204","m205","m206","m207","m208","m209","m210","m211","m212","m213","m214","m215","m216","m217","m218","m219","m220","m221","m222","m223","m224","m225","m226","m227","m228","m229","m230","m231","m232","m233","m234","m235","m236","m237","m238","m239","m240","m241","m242","m243","m244","m245","m246","m247","m248","m249","m250","m251","m252","m253","m254","m255","m256","m257","m258","m259","m260","m261","m262","m263","m264","m265","m266","m267","m268","m269","m270","m271","m272","m273","m274","m275","m276","m277","m278","m279","m280","m281","m282","m283","m284","m285","m286","m287","m288","m289","m290","m291","m292","m293","m294","m295","m296","m297","m298","m299","m300","m301","m302","m303","m304","m305","m306","m307","m308","m309","m310","m311","m312","m313","m314","m315","m316","m317","m318","m319","m320","m321","m322","m323","m324","m325","m326","m327","m328","m329","m330","m331","m332","m333","m334","m335","m336","m337","m338","m339","m340","m341","m342","m343","m344","m345","m346","m347","m348","m349","m350","m351","m352","m353","m354","m355","m356","m357","m358","m359","m360","m361","m362","m363","m364","m365","m366","m367","m368","m369","m370","m371","m372","m373","m374","m375","m376","m377","m378","m379","m380","m381","m382","m383","m384","m385","m386","m387","m388","m389","m390","m391","m392","m393","m394","m395","m396","m397","m398","m399","m400","m401","m402","m403","m404","m405","m406","m407","m408","m409","m410","m411","m412","m413","m414","m415","m416","m417","m418","m419","m420","m421","m422","m423","m424","m425","m426","m427","m428","m429","m430","m431","m432","m433","m434","m435","m436","m437","m438","m439","m440","m441","m442","m443","m444","m445","m446","m447","m448","m449","m450","m451","m452","m453","m454","m455","m456","m457","m458","m459","m460","m461","m462","m463","m464","m465","m466","m467","m468","m469","m470","m471","m472","m473","m474","m475","m476","m477","m478","m479","m480","m481","m482","m483","m484","m485","m486","m487","m488","m489","m490","m491","m492","m493","m494","m495","m496","m497","m498","m499","m500","m501","m502","m503","m504","m505","m506","m507","m508","m509","m510","m511","m512","m513","m514","m515","m516","m517","m518","m519","m520","m521","m522","m523","m524","m525","m526","m527","m528","m529","m530","m531","m532","m533","m534","m535","m536","m537","m538","m539","m540","m541","m542","m543","m544","m545","m546","m547","m548","m549","m550","m551","m552","m553","m554","m555","m556","m557","m558","m559","m560","m561","m562","m563","m564","m565","m566","m567","m568","m569","m570","m571","m572","m573","m574","m575","m576","m577","m578","m579","m580","m581","m582","m583","m584","m585","m586","m587","m588","m589","m590","m591","m592","m593","m594","m595","m596","m597","m598","m599","m600","m601","m602","m603","m604","m605","m606","m607","m608","m609","m610","m611","m612","m613","m614","m615","m616","m617","m618","m619","m620","m621","m622","m623","m624","m625","m626","m627","m628","m629","m630","m631","m632","m633","m634","m635","m636","m637","m638","m639","m640","m641","m642","m643","m644","m645","m646","m647","m648","m649","m650","m651","m652","m653","m654","m655","m656","m657","m658","m659","m660","m661","m662","m663","m664","m665","m666","m667","m668","m669","m670","m671","m672","m673","m674","m675","m676","m677","m678","m679","m680","m681","m682","m683","m684","m685","m686","m687","m688","m689","m690","m691","m692","m693","m694","m695","m696","m697","m698","m699","m700","m701","m702","m703","m704","m705","m706","m707","m708","m709","m710","m711","m712","m713","m714","m715","m716","m717","m718","m719","m720","m721","m722","m723","m724","m725","m726","m727","m728","m729","m730","m731","m732","m733","m734","m735","m736","m737","m738","m739","m740","m741","m742","m743","m744","m745","m746","m747","m748","m749","m750","m751","m752","m753","m754","m755","m756","m757","m758","m759","m760","m761","m762","m763","m764","m765","m766","m767","m768","m769","m770","m771","m772","m773","m774","m775","m776","m777","m778","m779","m780","m781","m782","m783","m784","m785","m786","m787","m788","m789","m790","m791","m792","m793","m794","m795","m796","m797","m798","m799","m800","m801","m802","m803","m804","m805","m806","m807","m808","m809","m810","m811","m812","m813","m814","m815","m816","m817","m818","m819","m820","m821","m822","m823","m824","m825","m826","m827","m828","m829","m830","m831","m832","m833","m834","m835","m836","m837","m838","m839","m840","m841","m842","m843","m844","m845","m846","m847","m848","m849","m850","m851","m852","m853","m854","m869","m870"];publicVariable "all_eos_mkrs";//invisible eos markers excluded
			//all_civ_eos_mkrs = ["civmkr1","civmkr2","civmkr3","civmkr4","civmkr5","civmkr6","civmkr7","civmkr8","civmkr9","civmkr10","civmkr11","civmkr12","civmkr13","civmkr14","civmkr15","civmkr16","civmkr17"];
		};
		case (toLower (worldName) isEqualTo "zargabad"):
		{
			Airfield_opt = false;publicVariable "Airfield_opt";
			Rand_AirCntr_OFstMax = 1800;publicVariable "Rand_AirCntr_OfstMax";
			Del_box_Pos = [4867.45,6245.6,0.00129318];publicVariable "Del_box_Pos";
			all_eos_mkrs = ["mrkr1","mrkr2","mrkr3","mrkr4","mrkr5","mrkr6","mrkr7","mrkr8","mrkr9","mrkr10","mrkr11","mrkr12","mrkr15","mrkr14","mrkr16","mrkr17","mrkr18","mrkr19","mrkr20","mrkr21","mrkr22","mrkr23","mrkr24","mrkr25","mrkr26","mrkr27","mrkr28","mrkr31","mrkr30","mrkr29","mrkr32","mrkr33","mrkr35","mrkr34","mrkr36","mrkr37","mrkr39","mrkr38","mrkr40","mrkr41","mrkr42","mrkr43","mrkr44","mrkr45","mrkr60","mrkr47","mrkr48","mrkr49","mrkr50","mrkr51","mrkr52","mrkr53","mrkr54","mrkr55","mrkr56","mrkr57","mrkr64","mrkr63","mrkr65","mrkr66","mrkr58","mrkr62","mrkr61","mrkr59","mrkr67","mrkr68","mrkr69","mrkr70","mrkr72","mrkr71","mrkr73","mrkr75","mrkr74","mrkr76","mrkr77","mrkr78","mrkr79","mrkr80","mrkr81","mrkr82","mrkr83","mrkr84","mrkr85","mrkr86","mrkr87","mrkr88","mrkr90","mrkr92","mrkr93","mrkr91","mrkr89","mrkr94","mrkr95","mrkr96","mrkr97","mrkr98","mrkr99","mrkr100","mrkr101","mrkr102","mrkr103","mrkr104","mrkr105","mrkr106","mrkr107","mrkr108","mrkr109","mrkr110","mrkr112","mrkr113","mrkr114","mrkr115","mrkr119","mrkr117","mrkr116","mrkr118","mrkr120","mrkr121","mrkr124","mrkr123","mrkr122","mrkr125","mrkr126","mrkr127","mrkr128","mrkr129","mrkr130","mrkr131","mrkr132","mrkr133","mrkr134","mrkr135","mrkr136","mrkr137","mrkr138","mrkr139","mrkr140","mrkr141","mrkr142","mrkr143","mrkr144","mrkr145","mrkr146","mrkr147","mrkr148","mrkr149","mrkr155","mrkr150","mrkr154","mrkr156","mrkr151","mrkr152","mrkr153","mrkr157","mrkr159","mrkr158","mrkr160","mrkr161","mrkr162","mrkr163","mrkr164","mrkr165","mrkr166","mrkr167","mrkr168","mrkr169","mrkr170","mrkr171","mrkr172","mrkr173","mrkr174","mrkr175","mrkr176","mrkr177","mrkr178","mrkr179","mrkr180","mrkr181","mrkr182","mrkr183","mrkr185","mrkr184","mrkr186","mrkr187","mrkr189","mrkr188","mrkr190","mrkr193","mrkr194","mrkr195","mrkr196","mrkr197","mrkr198","mrkr199"]; publicVariable "all_eos_mkrs";//excludes hidden markers ["mrkr13",]
			//all_civ_eos_mkrs = ["civmkr1","civmkr2","civmkr3","civmkr4","civmkr5","civmkr6","civmkr7","civmkr8","civmkr9","civmkr10","civmkr11","civmkr12","civmkr13","civmkr14","civmkr15","civmkr16"];
		};
		case (toLower (worldName) isEqualTo "pja305"):
		{
			Airfield_opt = true;publicVariable "Airfield_opt";
			Rand_AirCntr_OFstMax = 2500;publicVariable "Rand_AirCntr_OfstMax";
			Del_box_Pos = [1314.1,1131.89,0.00144672];publicVariable "Del_box_Pos";
			all_eos_mkrs = ["mrkr1","mrkr2","mrkr3","mrkr4","mrkr5","mrkr6","mrkr7","mrkr8","mrkr9","mrkr10","mrkr11","mrkr12","mrkr14","mrkr15","mrkr16","mrkr17","mrkr18","mrkr19","mrkr20","mrkr21","mrkr22","mrkr23","mrkr24","mrkr25","mrkr26","mrkr31","mrkr27","mrkr28","mrkr29","mrkr30","mrkr32","mrkr33","mrkr34","mrkr35","mrkr36","mrkr37","mrkr38","mrkr39","mrkr40","mrkr41","mrkr44","mrkr42","mrkr43","mrkr45","mrkr46","mrkr47","mrkr48","mrkr49","mrkr50","mrkr51","mrkr52","mrkr53","mrkr54","mrkr55","mrkr56","mrkr57","mrkr59","mrkr58","mrkr60","mrkr61","mrkr62","mrkr63","mrkr65","mrkr64","mrkr66","mrkr67","mrkr70","mrkr68","mrkr69","mrkr71","mrkr72","mrkr74","mrkr73","mrkr76","mrkr77","mrkr75","mrkr78","mrkr79","mrkr80","mrkr81","mrkr82","mrkr83","mrkr84","mrkr85","mrkr86","mrkr87","mrkr88","mrkr89","mrkr91","mrkr92","mrkr93","mrkr90","mrkr149","mrkr94","mrkr95","mrkr96","mrkr97","mrkr98","mrkr99","mrkr100","mrkr106","mrkr108","mrkr101","mrkr102","mrkr103","mrkr104","mrkr105","mrkr107","mrkr112","mrkr118","mrkr109","mrkr110","mrkr113","mrkr114","mrkr116","mrkr115","mrkr117","mrkr119","mrkr160","mrkr120","mrkr121","mrkr122","mrkr123","mrkr124","mrkr125","mrkr126","mrkr127","mrkr128","mrkr129","mrkr130","mrkr131","mrkr133","mrkr135","mrkr136","mrkr134","mrkr137","mrkr138","mrkr139","mrkr140","mrkr141","mrkr142","mrkr143","mrkr144","mrkr145","mrkr146","mrkr147","mrkr148","mrkr151","mrkr152","mrkr150","mrkr153","mrkr154","mrkr156","mrkr155","mrkr161","mrkr162","mrkr163","mrkr159","mrkr158","mrkr164","mrkr165","mrkr132","mrkr157","mrkr166","mrkr168","mrkr169","mrkr167","mrkr170","mrkr171","mrkr172","mrkr173","mrkr174","mrkr175","mrkr176","mrkr177","mrkr178","mrkr179","mrkr180","mrkr181","mrkr182","mrkr183","mrkr184","mrkr185","mrkr186","mrkr187","mrkr188","mrkr189","mrkr190","mrkr191","mrkr192","mrkr193","mrkr194","mrkr195","mrkr196","mrkr197","mrkr198","mrkr199","mrkr200","mrkr201","mrkr202","mrkr203","mrkr204","mrkr205","mrkr206","mrkr207","mrkr208","mrkr209","mrkr210","mrkr211","mrkr212","mrkr213","mrkr214","mrkr215","mrkr216","mrkr217","mrkr218","mrkr219","mrkr220","mrkr221","mrkr222","mrkr223","mrkr224","mrkr225","mrkr226","mrkr227","mrkr228","mrkr229","mrkr230","mrkr231","mrkr232","mrkr233","mrkr234","mrkr235","mrkr236","mrkr237","mrkr238","mrkr238","mrkr239","mrkr240","mrkr241","mrkr242","mrkr243","mrkr244","mrkr245","mrkr246","mrkr247","mrkr248","mrkr249","mrkr250","mrkr251","mrkr252","mrkr253","mrkr254","mrkr255","mrkr256","mrkr257","mrkr258","mrkr259","mrkr260","mrkr262","mrkr261","mrkr262","mrkr263","mrkr264","mrkr265","mrkr266","mrkr267","mrkr268","mrkr269","mrkr270","mrkr271","mrkr272","mrkr273","mrkr274","mrkr275","mrkr276","mrkr277","mrkr278","mrkr279","mrkr280","mrkr281","mrkr282","mrkr283","mrkr284","mrkr285","mrkr286","mrkr287","mrkr288","mrkr289","mrkr290","mrkr291","mrkr292","mrkr293","mrkr294","mrkr295","mrkr296","mrkr297","mrkr298","mrkr299","mrkr300","mrkr301","mrkr302","mrkr303","mrkr304","mrkr305","mrkr306","mrkr307","mrkr308","mrkr309","mrkr310","mrkr311","mrkr312","mrkr313","mrkr314","mrkr315","mrkr316","mrkr317","mrkr318","mrkr319","mrkr320","mrkr321","mrkr322","mrkr323","mrkr324","mrkr325","mrkr326","mrkr327","mrkr328"];publicVariable "all_eos_mkrs";// hidden markers ["mrkr13","m329","m330","m331","m332","m333","m334","m335"]			
			//all_civ_eos_mkrs = ["civmkr1","civmkr2","civmkr3","civmkr4","civmkr5","civmkr6","civmkr7","civmkr8","civmkr9","civmkr10","civmkr11","civmkr12","civmkr13","civmkr14","civmkr15","civmkr16","civmkr17","civmkr18","civmkr19","civmkr20"];
		};
		case (toLower (worldName) isEqualTo "takistan"):
		{
			Airfield_opt = true;publicVariable "Airfield_opt";
			Rand_AirCntr_OFstMax = 3200;publicVariable "Rand_AirCntr_OfstMax";
			Del_box_Pos = [8031.23,1967,0.00143433];publicVariable "Del_box_Pos";
			all_eos_mkrs = ["mrkr1","mrkr2","mrkr3","mrkr4","mrkr5","mrkr6","mrkr7","mrkr8","mrkr9","mrkr10","mrkr11","mrkr12","mrkr13","mrkr14","mrkr15","mrkr16","mrkr17","mrkr18","mrkr19","mrkr20","mrkr21","mrkr22","mrkr23","mrkr24","mrkr25","mrkr26","mrkr27","mrkr28","mrkr29","mrkr30","mrkr31","mrkr32","mrkr33","mrkr34","mrkr35","mrkr36","mrkr37","mrkr38","mrkr39","mrkr40","mrkr41","mrkr42","mrkr43","mrkr44","mrkr45","mrkr46","mrkr47","mrkr48","mrkr49","mrkr50","mrkr51","mrkr52","mrkr53","mrkr54","mrkr55","mrkr56","mrkr57","mrkr58","mrkr59","mrkr60","mrkr61","mrkr62","mrkr63","mrkr64","mrkr65","mrkr66","mrkr67","mrkr68","mrkr69","mrkr70","mrkr71","mrkr72","mrkr73","mrkr74","mrkr75","mrkr76","mrkr77","mrkr78","mrkr79","mrkr80","mrkr82","mrkr81","mrkr83","mrkr84","mrkr85","mrkr86","mrkr87","mrkr88","mrkr89","mrkr90","mrkr92","mrkr91","mrkr93","mrkr94","mrkr95","mrkr96","mrkr97","mrkr98","mrkr99","mrkr100","mrkr101","mrkr102","mrkr103","mrkr104","mrkr105","mrkr106","mrkr107","mrkr108","mrkr109","mrkr110","mrkr111","mrkr112","mrkr113","mrkr114","mrkr115","mrkr116","mrkr117","mrkr118","mrkr119","mrkr120","mrkr121","mrkr122","mrkr123","mrkr124","mrkr125","mrkr126","mrkr127","mrkr128","mrkr129","mrkr130","mrkr131","mrkr132","mrkr133","mrkr134","mrkr136","mrkr135","mrkr137","mrkr138","mrkr139","mrkr140","mrkr141","mrkr142","mrkr143","mrkr144","mrkr145","mrkr146","mrkr147","mrkr148","mrkr149","mrkr150","mrkr151","mrkr152","mrkr153","mrkr154","mrkr155","mrkr156","mrkr157","mrkr158","mrkr159","mrkr160","mrkr161","mrkr162","mrkr163","mrkr164","mrkr165","mrkr166","mrkr167","mrkr168","mrkr169","mrkr170","mrkr171","mrkr172","mrkr173","mrkr174","mrkr175","mrkr176","mrkr177","mrkr178","mrkr179","mrkr180","mrkr181","mrkr182","mrkr183","mrkr184","mrkr185","mrkr186","mrkr187","mrkr188","mrkr189","mrkr190","mrkr191","mrkr192","mrkr193","mrkr194","mrkr195","mrkr196","mrkr197","mrkr198","mrkr199","mrkr200","mrkr201","mrkr202","mrkr203","mrkr204","mrkr205","mrkr206","mrkr207","mrkr208","mrkr209","mrkr210","mrkr211","mrkr212","mrkr213","mrkr214","mrkr215","mrkr216","mrkr217","mrkr218","mrkr219","mrkr223","mrkr224","mrkr225","mrkr226","mrkr228","mrkr227","mrkr229","mrkr229","mrkr230","mrkr231","mrkr232","mrkr233","mrkr234","mrkr235","mrkr236","mrkr237","mrkr238","mrkr239","mrkr240","mrkr241","mrkr242","mrkr243","mrkr244","mrkr245","mrkr246","mrkr247","mrkr248","mrkr249","mrkr250","mrkr251","mrkr252","mrkr253","mrkr254","mrkr255","mrkr256","mrkr257","mrkr258","mrkr259","mrkr260","mrkr261","mrkr262","mrkr263","mrkr264","mrkr265","mrkr266","mrkr267","mrkr268","mrkr269","mrkr270","mrkr271","mrkr272","mrkr273","mrkr274","mrkr275","mrkr276","mrkr277","mrkr278","mrkr279","mrkr280","mrkr281","mrkr282","mrkr283","mrkr284","mrkr285","mrkr286","mrkr287","mrkr288","mrkr289","mrkr290","mrkr291","mrkr292","mrkr293","mrkr294","mrkr295","mrkr296","mrkr297","mrkr298","mrkr299","mrkr300","mrkr301","mrkr302","mrkr303","mrkr304","mrkr305","mrkr306","mrkr307","mrkr308"];publicVariable "all_eos_mkrs";//excludes hidden markers ["mrkr220","mrkr221","mrkr222"]
			//all_civ_eos_mkrs = ["civmkr1","civmkr2","civmkr3","civmkr4","civmkr5","civmkr6","civmkr7","civmkr8","civmkr9","civmkr10","civmkr11","civmkr12","civmkr13","civmkr14","civmkr15","civmkr16","civmkr17","civmkr18","civmkr19","civmkr20","civmkr21","civmkr22","civmkr23","civmkr24","civmkr25","civmkr26","civmkr27","civmkr28","civmkr29","civmkr30","civmkr31","civmkr32"];publicVariable "all_civ_eos_mkrs";
		};
		case (toLower (worldName) isEqualTo "fallujah"):
		{
			Airfield_opt = true;publicVariable "Airfield_opt";
			Rand_AirCntr_OFstMax = 2000;publicVariable "Rand_AirCntr_OfstMax";
			Del_box_Pos = [5705.8,9883.6,0.00143862];publicVariable "Del_box_Pos";
			all_eos_mkrs = ["mrkr66","mrkr1","mrkr2","mrkr3","mrkr4","mrkr5","mrkr6","mrkr7","mrkr8","mrkr9","mrkr10","mrkr11","mrkr12","mrkr13","mrkr14","mrkr15","mrkr16","mrkr17","mrkr18","mrkr19","mrkr20","mrkr21","mrkr22","mrkr23","mrkr24","mrkr25","mrkr26","mrkr27","mrkr28","mrkr29","mrkr30","mrkr31","mrkr32","mrkr33","mrkr34","mrkr35","mrkr36","mrkr37","mrkr38","mrkr39","mrkr40","mrkr41","mrkr42","mrkr43","mrkr44","mrkr45","mrkr46","mrkr47","mrkr48","mrkr49","mrkr50","mrkr51","mrkr52","mrkr53","mrkr54","mrkr55","mrkr56","mrkr57","mrkr58","mrkr59","mrkr60","mrkr61","mrkr62","mrkr63","mrkr64","mrkr65","mrkr67","mrkr68","mrkr71","mrkr72","mrkr73","mrkr74","mrkr75","mrkr76","mrkr77","mrkr78","mrkr79","mrkr80","mrkr81","mrkr82","mrkr83","mrkr84","mrkr85","mrkr88","mrkr89","mrkr90","mrkr91","mrkr92","mrkr93","mrkr94","mrkr95","mrkr96","mrkr97","mrkr98","mrkr99","mrkr198","mrkr199","mrkr200","mrkr201","mrkr202","mrkr203","mrkr204","mrkr205","mrkr100","mrkr101","mrkr102","mrkr103","mrkr106","mrkr107","mrkr108","mrkr109","mrkr110","mrkr111","mrkr112","mrkr113","mrkr114","mrkr115","mrkr116","mrkr117","mrkr118","mrkr119","mrkr86","mrkr87","mrkr120","mrkr121","mrkr122","mrkr123","mrkr124","mrkr125","mrkr126","mrkr127","mrkr128","mrkr129","mrkr130","mrkr131","mrkr132","mrkr133","mrkr134","mrkr135","mrkr136","mrkr137","mrkr138","mrkr139","mrkr140","mrkr141","mrkr142","mrkr143","mrkr144","mrkr145","mrkr146","mrkr147","mrkr148","mrkr149","mrkr150","mrkr151","mrkr152","mrkr153","mrkr154","mrkr155","mrkr156","mrkr157","mrkr158","mrkr159","mrkr160","mrkr161","mrkr162","mrkr163","mrkr164","mrkr165","mrkr166","mrkr167","mrkr168","mrkr169","mrkr170","mrkr171","mrkr172","mrkr173","mrkr174","mrkr175","mrkr176","mrkr177","mrkr178","mrkr179","mrkr180","mrkr181","mrkr182","mrkr183","mrkr184","mrkr185","mrkr186","mrkr187","mrkr188","mrkr189","mrkr190","mrkr191","mrkr192","mrkr193","mrkr194","mrkr195","mrkr196","mrkr70","mrkr104","mrkr105","mrkr226","mrkr69","mrkr254","mrkr255","mrkr256","mrkr197","mrkr206","mrkr207","mrkr208","mrkr209","mrkr210","mrkr211","mrkr212","mrkr213","mrkr214","mrkr215","mrkr216","mrkr217","mrkr218","mrkr219","mrkr220","mrkr221","mrkr222","mrkr223","mrkr224","mrkr225","mrkr228","mrkr227","mrkr229","mrkr229","mrkr230","mrkr231","mrkr232","mrkr233","mrkr234","mrkr235","mrkr236","mrkr237","mrkr238","mrkr239","mrkr240","mrkr241","mrkr242","mrkr244","mrkr246","mrkr243","mrkr245","mrkr247","mrkr248","mrkr249","mrkr250","mrkr251","mrkr252","mrkr253","mrkr257","mrkr258","mrkr259","mrkr260","mrkr261","mrkr262","mrkr263","mrkr264","mrkr265","mrkr266","mrkr267","mrkr268","mrkr269","mrkr270","mrkr271","mrkr272","mrkr273","mrkr274","mrkr275","mrkr276","mrkr277","mrkr278","mrkr279","mrkr280","mrkr281","mrkr282","mrkr283","mrkr284","mrkr285","mrkr286","mrkr287","mrkr288","mrkr289","mrkr290","mrkr291","mrkr292","mrkr293","mrkr294","mrkr295","mrkr296","mrkr297","mrkr298","mrkr299","mrkr300","mrkr301","mrkr302","mrkr303","mrkr304","mrkr398","mrkr399","mrkr400","mrkr401","mrkr402","mrkr403","mrkr404","mrkr405","mrkr406","mrkr407","mrkr408","mrkr409","mrkr410","mrkr411","mrkr412","mrkr413","mrkr414","mrkr415","mrkr416","mrkr417","mrkr418","mrkr419","mrkr333","mrkr334","mrkr335","mrkr305","mrkr306","mrkr307","mrkr308","mrkr309","mrkr310","mrkr311","mrkr312","mrkr313","mrkr314","mrkr315","mrkr316","mrkr317","mrkr318","mrkr319","mrkr320","mrkr321","mrkr322","mrkr323","mrkr324","mrkr325","mrkr326","mrkr327","mrkr328","mrkr329","mrkr330","mrkr331","mrkr332","mrkr336","mrkr337","mrkr338","mrkr339","mrkr340","mrkr341","mrkr342","mrkr344","mrkr343","mrkr345","mrkr346","mrkr347","mrkr348","mrkr349","mrkr350","mrkr351","mrkr352","mrkr353","mrkr354","mrkr355","mrkr356","mrkr357","mrkr358","mrkr359","mrkr360","mrkr361","mrkr362","mrkr363","mrkr364","mrkr365","mrkr366","mrkr367","mrkr368","mrkr369","mrkr370","mrkr371","mrkr372","mrkr373","mrkr374","mrkr375","mrkr378","mrkr379","mrkr380","mrkr376","mrkr377","mrkr381","mrkr382","mrkr383","mrkr384","mrkr385","mrkr386","mrkr387","mrkr388","mrkr389","mrkr390","mrkr391","mrkr392","mrkr393","mrkr394","mrkr395","mrkr396","mrkr397","mrkr420","mrkr421","mrkr422","mrkr423","mrkr424","mrkr425","mrkr426","mrkr427","mrkr428","mrkr429","mrkr430","mrkr431","mrkr432","mrkr433","mrkr434","mrkr435","mrkr436","mrkr437","mrkr438","mrkr439","mrkr440","mrkr441","mrkr442","mrkr443","mrkr444","mrkr445","mrkr446","mrkr447","mrkr448","mrkr449","mrkr450","mrkr451","mrkr452","mrkr453","mrkr454","mrkr455","mrkr456","mrkr457","mrkr458","mrkr459","mrkr460","mrkr461","mrkr462","mrkr463","mrkr464","mrkr465","mrkr466","mrkr466","mrkr467","mrkr468","mrkr469","mrkr470","mrkr471","mrkr472","mrkr473","mrkr474","mrkr475","mrkr476","mrkr477","mrkr478","mrkr479","mrkr480","mrkr481","mrkr482","mrkr483","mrkr484","mrkr485","mrkr486","mrkr487","mrkr488","mrkr489","mrkr490","mrkr491","mrkr492","mrkr493","mrkr494","mrkr495","mrkr496","mrkr497","mrkr498","mrkr499","mrkr500","mrkr501","mrkr502","mrkr503","mrkr504","mrkr505","mrkr506","mrkr507","mrkr508","mrkr509","mrkr510","mrkr511","mrkr512","mrkr513","mrkr514","mrkr515","mrkr516","mrkr517","mrkr518","mrkr519","mrkr520","mrkr521","mrkr522","mrkr523","mrkr524","mrkr525","mrkr526","mrkr527","mrkr528","mrkr529","mrkr530","mrkr531","mrkr531","mrkr532","mrkr533","mrkr534","mrkr535","mrkr536","mrkr537","mrkr538","mrkr539","mrkr540","mrkr541","mrkr542","mrkr543","mrkr544","mrkr545","mrkr546","mrkr547","mrkr548","mrkr549","mrkr550","mrkr551","mrkr552","mrkr553","mrkr554","mrkr555","mrkr556","mrkr557","mrkr558","mrkr559","mrkr560","mrkr561","mrkr562","mrkr563","mrkr564","mrkr565","mrkr566","mrkr567","mrkr568","mrkr569","mrkr570","mrkr571","mrkr572","mrkr573","mrkr574","mrkr575","mrkr576","mrkr577","mrkr578","mrkr579","mrkr580","mrkr581","mrkr582","mrkr583","mrkr584","mrkr585","mrkr586","mrkr587","mrkr588","mrkr589","mrkr590","mrkr591","mrkr592","mrkr593","mrkr594","mrkr595","mrkr596","mrkr597","mrkr598","mrkr599","mrkr600","mrkr601","mrkr602","mrkr603","mrkr604","mrkr605","mrkr606","mrkr607","mrkr608","mrkr609","mrkr610","mrkr611","mrkr612","mrkr613","mrkr614","mrkr615","mrkr616","mrkr617","mrkr618","mrkr619","mrkr620","mrkr621","mrkr622","mrkr623","mrkr624","mrkr625","mrkr626","mrkr627","mrkr628","mrkr629","mrkr630","mrkr631","mrkr632","mrkr633","mrkr634","mrkr635","mrkr636","mrkr637","mrkr638","mrkr639","mrkr640","mrkr641","mrkr642","mrkr643","mrkr644","mrkr645","mrkr646","mrkr647","mrkr648","mrkr649","mrkr650","mrkr651","mrkr652","mrkr653","mrkr654","mrkr655","mrkr655","mrkr656","mrkr657","mrkr658","mrkr659","mrkr660","mrkr661","mrkr662","mrkr663","mrkr664","mrkr665","mrkr666","mrkr667","mrkr668","mrkr669","mrkr670","mrkr671","mrkr672","mrkr673","mrkr674","mrkr675","mrkr675","mrkr676","mrkr677","mrkr678","mrkr679","mrkr680","mrkr681","mrkr682","mrkr683","mrkr684","mrkr685","mrkr686","mrkr687","mrkr688","mrkr689","mrkr690","mrkr691","mrkr692","mrkr693","mrkr694","mrkr695","mrkr696","mrkr697","mrkr698","mrkr699","mrkr700","mrkr701","mrkr702","mrkr703","mrkr704","mrkr705","mrkr706","mrkr707","mrkr708","mrkr709","mrkr710","mrkr711","mrkr712","mrkr713","mrkr714","mrkr715","mrkr716","mrkr717","mrkr718","mrkr719","mrkr720","mrkr721","mrkr722","mrkr723","mrkr724","mrkr725","mrkr726","mrkr727","mrkr728","mrkr729","mrkr730","mrkr731","mrkr732","mrkr733","mrkr734","mrkr735","mrkr736","mrkr737","mrkr738","mrkr739","mrkr740","mrkr741","mrkr742","mrkr743","mrkr744","mrkr745","mrkr746","mrkr747","mrkr748","mrkr749","mrkr750","mrkr751","mrkr752","mrkr753","mrkr754","mrkr755","mrkr756","mrkr757","mrkr758","mrkr759","mrkr760","mrkr761","mrkr762","mrkr763","mrkr764","mrkr765","mrkr766","mrkr767","mrkr768","mrkr769","mrkr770","mrkr771","mrkr772","mrkr773","mrkr774","mrkr775","mrkr776","mrkr777","mrkr778","mrkr779","mrkr780","mrkr781","mrkr782","mrkr783","mrkr784","mrkr785","mrkr786","mrkr787","mrkr788","mrkr789","mrkr790","mrkr791","mrkr792","mrkr793","mrkr794","mrkr795","mrkr796","mrkr797","mrkr798","mrkr799","mrkr800","mrkr801","mrkr802","mrkr803","mrkr804","mrkr805","mrkr806","mrkr807","mrkr808","mrkr809","mrkr810","mrkr811","mrkr812","mrkr813","mrkr814","mrkr815","mrkr816","mrkr817","mrkr818","mrkr819","mrkr820","mrkr821","mrkr822","mrkr823","mrkr824","mrkr825","mrkr826","mrkr827","mrkr828","mrkr829","mrkr830","mrkr831","mrkr832","mrkr833","mrkr834","mrkr835","mrkr836","mrkr837","mrkr838","mrkr839","mrkr840","mrkr841","mrkr842","mrkr843","mrkr844","mrkr845","mrkr846","mrkr847","mrkr848","mrkr849","mrkr850","mrkr851","mrkr852","mrkr853","mrkr854","mrkr855","mrkr856","mrkr857","mrkr858","mrkr859","mrkr860","mrkr862","mrkr863","mrkr864","mrkr865","mrkr866","mrkr867","mrkr868","mrkr869","mrkr870","mrkr871","mrkr872","mrkr873","mrkr874","mrkr875","mrkr876","mrkr877","mrkr878","mrkr879","mrkr880","mrkr881","mrkr882","mrkr883","mrkr884","mrkr885","mrkr886","mrkr887","mrkr888","mrkr889","mrkr890","mrkr891","mrkr892","mrkr893","mrkr894","mrkr895","mrkr896","mrkr897","mrkr898","mrkr899","mrkr900","mrkr901","mrkr902","mrkr903","mrkr904","mrkr905","mrkr906","mrkr907","mrkr908","mrkr909","mrkr910","mrkr911","mrkr912","mrkr913","mrkr914","mrkr915","mrkr916","mrkr917","mrkr918","mrkr919","mrkr920","mrkr921","mrkr922","mrkr923","mrkr924","mrkr925","mrkr926","mrkr927","mrkr928","mrkr929","mrkr930","mrkr931","mrkr932","mrkr933","mrkr934","mrkr935","mrkr936","mrkr937","mrkr938","mrkr939","mrkr940","mrkr941","mrkr942","mrkr943","mrkr944","mrkr945","mrkr946","mrkr947"];publicVariable "all_eos_mkrs";//invisible eos markers excluded			
			//all_civ_eos_mkrs = ["civmkr1","civmkr2","civmkr3","civmkr4","civmkr5","civmkr6","civmkr7","civmkr8","civmkr9","civmkr10","civmkr11","civmkr12","civmkr13","civmkr14","civmkr15","civmkr16"];			
		};
		case (toLower (worldName) isEqualTo "stratis"):
		{
			Airfield_opt = false;publicVariable "Airfield_opt";
			Rand_AirCntr_OFstMax = 3000;publicVariable "Rand_AirCntr_OfstMax";
			Del_box_Pos = [2649.7,664.077,0.00126648];publicVariable "Del_box_Pos";
			all_eos_mkrs = ["m1","m2","m3","m4","m5","m6","m7","m8","m9","m10","m11","m12","m13","m14","m15","m16","m17","m18","m19","m20","m21","m22","m23","m24","m25","m26","m27","m28","m29","m30","m31","m32","m33","m34","m35","m36","m37","m38","m39","m40","m41","m42","m43","m44","m45","m46","m47","m48","m49","m50","m51","m52","m53","m54","m55","m56","m57","m58","m59","m60","m61","m62","m63","m64","m65","m66","m67","m68","m69","m70","m71","m72","m73","m74","m75","m76","m77","m78","m79","m80","m81","m82","m83","m84","m85","m86","m87","m88","m89","m90","m91","m92","m93","m94","m95","m96","m97","m98","m99","m100","m102","m103"];publicVariable "all_eos_mkrs";//invisible eos markers excluded
			//all_civ_eos_mkrs = ["civmkr1","civmkr2","civmkr3","civmkr4","civmkr5","civmkr6","civmkr7","civmkr8","civmkr9","civmkr10","civmkr11","civmkr12","civmkr13","civmkr14","civmkr15","civmkr16","civmkr17"];		
		};
		case (toLower (worldName) isEqualTo "fata"):
		{
			Airfield_opt = false;publicVariable "Airfield_opt";
			Rand_AirCntr_OFstMax = 1800;publicVariable "Rand_AirCntr_OfstMax";
			Del_box_Pos = [2175.55,213.65,0.00143814];publicVariable "Del_box_Pos";
			all_eos_mkrs = ["m1","m2","m3","m4","m5","m6","m7","m7","m8","m9","m10","m11","m12","m13","m14","m15","m16","m17","m18","m19","m20","m21","m22","m23","m24","m25","m26","m27","m28","m29","m30","m31","m32","m33","m34","m35","m36","m37","m38","m39","m40","m41","m42","m43","m44","m45","m46","m47","m48","m49","m50","m51","m52","m54","m53","m55","m56","m57","m58","m59","m60","m61","m62","m63","m64","m65","m66","m67","m68","m69","m70","m71","m72","m73","m74","m75","m76","m77","m78","m79","m80","m81","m82","m83","m84","m85","m86","m87","m88","m89","m90","m91","m92","m93","m94","m95","m96","m97","m98","m99","m100","m101","m102","m103","m104","m105","m106","m107","m108","m109","m110","m111","m112","m113","m114","m115","m116","m117","m118","m119","m120","m121","m122","m123","m124","m125","m126","m127","m128","m129","m130","m131","m132","m133","m134","m135","m136","m137","m138","m139","m140","m141","m142","m143","m144","m145","m146","m147","m148","m149","m150","m151","m152","m153","m154","m155","m156","m157","m158","m159","m160","m161","m162","m163","m164","m165"];publicVariable "all_eos_mkrs";
			//all_civ_eos_mkrs = ["civmkr1","civmkr2","civmkr3","civmkr4","civmkr5","civmkr6","civmkr7","civmkr8","civmkr9","civmkr10","civmkr11","civmkr12","civmkr13","civmkr14","civmkr15","civmkr16"];
		};
		case (toLower (worldName) isEqualTo "sara"):
		{
			Airfield_opt = true;publicVariable "Airfield_opt";
			Rand_AirCntr_OFstMax = 3000;publicVariable "Rand_AirCntr_OfstMax";
			Del_box_Pos = [18244.6,18112.6,0.00143909];publicVariable "Del_box_Pos";
			all_eos_mkrs = ["m1","m2","m3","m4","m5","m6","m7","m8","m9","m10","m11","m12","m13","m14","m15","m16","m17","m18","m19","m20","m21","m22","m23","m24","m25","m26","m27","m28","m29","m30","m31","m32","m33","m34","m35","m36","m37","m38","m39","m40","m41","m42","m43","m44","m45","m46","m47","m48","m49","m50","m51","m52","m53","m54","m55","m56","m57","m58","m59","m60","m61","m62","m63","m64","m65","m66","m67","m68","m69","m70","m71","m72","m73","m74","m75","m76","m77","m78","m79","m80","m81","m82","m83","m84","m85","m86","m87","m88","m89","m90","m91","m92","m93","m94","m95","m96","m97","m98","m99","m100","m101","m102","m103","m104","m105","m106","m107","m108","m109","m110","m111","m112","m113","m114","m115","m116","m117","m118","m119","m120","m121","m122","m123","m124","m125","m126","m127","m128","m129","m130","m131","m132","m133","m134","m135","m136","m137","m138","m139","m140","m141","m142","m143","m144","m145","m146","m147","m148","m149","m150","m151","m152","m153","m154","m155","m156","m157","m158","m159","m160","m161","m162","m163","m164","m165","m166","m167","m168","m169","m170","m171","m172","m173","m174","m175","m176","m177","m178","m179","m180","m181","m182","m183","m184","m185","m186","m187","m188","m189","m190","m191","m192","m193","m194","m195","m196","m197","m198","m199","m200","m201","m202","m203","m204","m205","m206","m207","m208","m209","m210","m211","m212","m213","m214","m215","m216","m217","m218","m219","m220","m221","m222","m223","m224","m225","m226","m227","m228","m229","m230","m231","m232","m233","m234","m235","m236","m237","m238","m239","m240","m241","m242","m243","m244","m245","m246","m247","m248","m249","m250","m251","m252","m253","m254","m255","m256","m257","m258","m259","m260","m261","m262","m263","m264","m265","m266","m267","m268","m269","m270","m271","m272","m273","m274","m275","m276","m277","m278","m279","m280","m281","m282","m283","m284","m285","m286","m287","m288","m289","m290","m291","m292","m293","m294","m295","m296","m297","m298","m299","m300","m301","m302","m303","m304","m305","m306","m307","m308","m309","m310","m311","m312","m313","m314","m315","m316","m317","m318","m319","m320","m321","m322","m323","m324","m325","m326","m327","m328","m329","m330","m331","m332","m333","m334","m335","m336","m337","m338","m339","m340","m341","m342","m343","m344","m345","m346","m347","m348","m349","m350","m351","m352","m353","m354","m355","m356","m357","m358","m359","m360","m361","m362","m363","m364","m365","m366","m367","m368","m369","m370","m371","m372","m373","m374","m375","m376","m377","m378","m379","m380","m381","m382","m383","m384","m385","m386","m387","m388","m389","m390","m391","m392","m393","m394","m395","m396","m397","m398","m399","m400","m401","m402","m403","m404","m405","m406","m407","m408","m409","m410","m411","m412","m413","m414","m415","m416","m417","m418","m419","m420","m421","m422","m423","m424","m425","m426","m427","m428","m429","m430","m431","m432","m433","m434","m435","m436","m437","m438","m439","m440","m441","m442","m443","m444","m445","m446","m447","m448","m449","m450","m451","m452","m453","m454","m455","m456","m457","m458","m459","m460","m461","m462","m463","m464","m465","m466","m467","m468","m469","m470","m471","m472","m473","m474","m475","m476","m477","m478","m479","m480","m481","m482","m483","m484","m485","m486","m487","m488","m489","m490","m491","m492","m493","m494","m495","m496","m497","m498","m499","m500","m501","m502","m503","m504","m505","m506","m507","m508","m509","m510","m511","m512","m513","m514","m515","m516","m517","m518","m519","m520","m521","m522","m523","m524","m525","m526","m527","m528","m529","m530","m531","m532","m533","m534","m535","m536","m537","m538","m539","m540","m541","m542","m543","m544","m545","m546","m547","m548","m549","m550","m551","m552","m553","m554","m555","m556","m557","m558","m559","m560","m561","m562","m563","m564","m565","m566","m567","m568","m569","m570","m571","m572","m573","m574","m575","m576","m577","m578","m579","m580","m581","m582","m583","m584","m585","m586","m587","m588","m589","m590","m591","m592","m593","m594","m595","m596","m597","m598","m599","m600","m601","m602","m603","m604","m605","m606","m607","m608","m609","m610","m611","m612","m613","m614","m615","m616","m617","m618","m619","m620","m621","m622","m623","m624","m625","m626","m627","m628","m629","m630","m631","m632","m633","m634","m635","m636","m637","m638","m639","m640","m641","m642","m643","m644","m645","m646","m647","m648","m649","m650","m651","m652","m653","m654","m655","m657","m658","m659","m660","m661","m662","m663","m664","m665","m666","m667","m668","m669","m670","m671","m672","m673","m674","m675","m677","m678","m679","m680"];publicVariable "all_eos_mkrs";//invisible eos markers excluded
			//all_civ_eos_mkrs = ["civmkr1","civmkr2","civmkr3","civmkr4","civmkr5","civmkr6","civmkr7","civmkr8","civmkr9","civmkr10","civmkr11","civmkr12","civmkr13","civmkr14","civmkr15","civmkr16","civmkr17"];			
		};
		case (toLower (worldName) isEqualTo "kunduz"):
		{
			Airfield_opt = true;publicVariable "Airfield_opt";
			Rand_AirCntr_OFstMax = 1800;publicVariable "Rand_AirCntr_OfstMax";
			Del_box_Pos = [4961.47,1474.58,0.00144124];publicVariable "Del_box_Pos";
			all_eos_mkrs = ["m1","m4","m7","m10","m11","m16","m17","m22","m23","m24","m29","m32","m33","m40","m41","m42","m43","m46","m47","m48","m49","m50","m51","m52","m53","m54","m55","m56","m57","m58","m59","m60","m61","m62","m63","m64","m65","m66","m67","m68","m69","m70","m71","m72","m73","m74","m75","m76","m77","m78","m79","m80","m81","m82","m83","m84","m85","m86","m87","m88","m89","m90","m91","m92","m93","m94","m95","m96","m97","m98","m99","m100","m101","m102","m103","m104","m105","m106","m107","m108","m109","m110","m111","m112","m113","m114","m115","m116","m117","m118","m119","m120","m121","m122","m123","m124","m125","m126","m127","m128","m129","m130","m131","m132","m133","m134","m135","m136","m137","m138","m139","m140","m141","m142","m143","m144","m145","m146","m147","m148","m149","m150","m151","m152","m153","m154","m155","m156","m157","m158","m159","m160","m161","m162","m163","m164","m165","m166","m167","m168","m169","m170","m171","m172","m173","m174","m175","m176","m177","m178","m179","m180","m181","m182","m183","m184","m185","m186","m187","m188","m189","m190","m191","m192","m193","m194","m195","m196","m197","m198","m199","m200","m201","m202","m203","m204","m205","m206","m207","m208","m209","m210","m211","m212","m213","m214","m215","m216","m217","m218","m219","m220","m221","m222","m223","m224","m225","m226","m227","m228","m229","m230","m231","m232","m233","m234","m235","m236","m237","m238","m239","m240","m241","m242","m243","m244","m245","m246","m247","m248","m249","m250","m251","m252","m253","m254","m255","m256","m257","m258","m259","m260","m261","m2","m3","m5","m6","m8","m9","m12","m13","m14","m15","m18","m19","m20","m21","m25","m26","m27","m28","m30","m31","m34","m35","m36","m37","m38","m39","m44","m45","m262","m263","m264","m265","m266","m267","m268","m269","m270","m271","m272","m273","m274","m275","m276","m277","m278","m279","m280","m281","m282","m283","m284","m285","m286","m287","m288","m289","m290","m291","m292","m293","m294","m295","m296","m297","m298","m299","m300"];publicVariable "all_eos_mkrs";//invisible eos markers excluded
			//all_civ_eos_mkrs = ["civmkr1","civmkr2","civmkr3","civmkr4","civmkr5","civmkr6","civmkr7","civmkr8","civmkr9","civmkr10","civmkr11","civmkr12","civmkr13","civmkr14","civmkr15","civmkr16","civmkr17"];		
		};
		case (toLower (worldName) isEqualTo "pja310"):
		{
			Airfield_opt = true;publicVariable "Airfield_opt";
			Rand_AirCntr_OFstMax = 3000;publicVariable "Rand_AirCntr_OfstMax";
			Del_box_Pos = [1311.09,1133.01,0.00144672];publicVariable "Del_box_Pos";
			all_eos_mkrs = ["m16","m18","m19","m24","m27","m28","m37","m38","m39","m44","m49","m50","m51","m52","m53","m57","m58","m59","m60","m62","m64","m68","m72","m73","m77","m78","m81","m84","m91","m92","m95","m111","m116","m119","m120","m125","m134","m135","m138","m141","m142","m144","m145","m153","m154","m159","m160","m173","m175","m178","m181","m182","m183","m184","m185","m188","m189","m190","m191","m198","m199","m204","m205","m208","m211","m212","m213","m214","m215","m220","m223","m224","m227","m228","m231","m234","m235","m242","m245","m246","m249","m252","m253","m254","m255","m260","m261","m262","m263","m264","m267","m272","m273","m276","m277","m278","m283","m284","m285","m286","m287","m290","m291","m292","m293","m294","m297","m298","m311","m316","m317","m320","m323","m326","m327","m328","m335","m336","m337","m342","m351","m352","m355","m356","m357","m358","m359","m360","m363","m373","m374","m375","m378","m379","m380","m381","m382","m383","m384","m387","m392","m393","m395","m398","m399","m400","m401","m410","m411","m416","m419","m420","m421","m422","m423","m424","m425","m428","m429","m431","m434","m435","m438","m439","m440","m441","m442","m443","m444","m451","m454","m457","m460","m461","m470","m473","m474","m475","m476","m477","m478","m479","m480","m481","m484","m487","m490","m491","m492","m493","m495","m500","m501","m510","m515","m524","m525","m536","m539","m542","m543","m544","m545","m548","m549","m550","m551","m552","m553","m556","m557","m560","m565","m566","m571","m572","m577","m578","m583","m586","m591","m592","m595","m598","m606","m607","m608","m609","m614","m615","m619","m620","m621","m623","m624","m629","m632","m633","m634","m635","m638","m639","m640","m643","m644","m646","m649","m650","m651","m652","m655","m656","m657","m658","m659","m660","m661","m662","m663","m664","m665","m672","m673","m674","m677","m680","m681","m684","m687","m688","m693","m694","m695","m698","m699","m702","m703","m704","m707","m708","m713","m714","m719","m720","m723","m724","m725","m726","m729","m740","m741","m742","m760","m761","m764","m765","m766","m767","m768","m769","m770","m777","m780","m781","m782","m785","m786","m787","m794","m797","m798","m799","m802","m803","m808","m809","m810","m815","m816","m819","m820","m823","m824","m825","m826","m827","m830","m831","m832","m835","m836","m839","m840","m841","m842","m847","m852","m856","m861","m862","m867","m868","m871","m872","m875","m876","m877","m879","m880","m886","m889","m895","m896","m903","m915","m918","m921","m926","m927","m928","m929","m949","m960","m967","m974","m977","m978","m979","m980","m983","m990","m998","m1015","m1016","m1017","m1021","m1034","m1040","m1045","m1046","m1047","m1048","m1053","m1060","m1061","m1062","m1065","m1067","m1070","m1073","m1074","m1077","m1079","m1082","m1087","m1090","m1099","m1104","m1107","m1108","m1111","m1112","m1115","m1118","m1119","m1120","m1125","m1128","m1129","m1130","m1131","m1134","m1137","m1138","m1139","m1041","m1142","m1148","m1152","m1155","m1156","m1164","m10","m11","m12","m13","m14","m15","m20","m21","m22","m23","m25","m26","m29","m30","m31","m32","m33","m34","m40","m41","m42","m43","m47","m48","m55","m56","m65","m66","m70","m71","m75","m76","m79","m80","m82","m83","m85","m86","m87","m88","m89","m90","m93","m94","m96","m97","m98","m99","m100","m101","m102","m103","m104","m105","m106","m107","m108","m109","m112","m113","m114","m115","m117","m118","m121","m122","m123","m124","m126","m127","m128","m129","m130","m131","m132","m133","m136","m137","m139","m140","m147","m148","m149","m150","m151","m152","m155","m156","m157","m158","m161","m162","m163","m164","m165","m166","m167","m168","m169","m170","m171","m172","m176","m177","m179","m180","m186","m187","m192","m193","m194","m195","m196","m197","m200","m201","m202","m203","m206","m207","m209","m210","m216","m217","m218","m219","m221","m222","m225","m226","m229","m230","m232","m233","m236","m237","m238","m239","m240","m241","m243","m244","m247","m248","m250","m251","m256","m257","m258","m259","m265","m266","m268","m269","m270","m271","m274","m275","m279","m280","m281","m282","m288","m289","m290","m291","m295","m296","m299","m300","m301","m302","m303","m304","m305","m306","m307","m308","m309","m310","m312","m313","m314","m315","m318","m319","m321","m322","m324","m325","m329","m330","m331","m332","m333","m334","m338","m339","m340","m341","m343","m344","m345","m346","m347","m348","m349","m350","m353","m354","m361","m362","m365","m366","m367","m368","m371","m372","m376","m377","m385","m386","m388","m389","m390","m391","m396","m397","m402","m403","m404","m405","m406","m407","m408","m409","m412","m413","m414","m415","m417","m418","m426","m427","m432","m433","m436","m437","m445","m446","m447","m448","m449","m450","m452","m453","m455","m456","m458","m459","m462","m463","m464","m465","m466","m467","m468","m469","m471","m472","m482","m483","m485","m486","m488","m489","m496","m497","m498","m499","m502","m503","m504","m505","m506","m507","m508","m509","m511","m512","m513","m514","m516","m517","m518","m519","m520","m521","m522","m523","m526","m527","m528","m529","m530","m531","m532","m533","m534","m535","m537","m538","m540","m541","m546","m547","m554","m555","m558","m559","m561","m562","m563","m564","m567","m568","m569","m570","m573","m574","m575","m576","m579","m580","m581","m582","m584","m585","m587","m588","m589","m590","m593","m594","m596","m597","m600","m601","m602","m603","m604","m605","m611","m612","m613","m617","m618","m625","m626","m627","m628","m630","m631","m636","m637","m641","m642","m647","m648","m653","m654","m666","m667","m668","m669","m670","m671","m675","m676","m678","m679","m682","m683","m685","m686","m689","m690","m691","m692","m696","m697","m700","m701","m705","m706","m709","m710","m711","m712","m715","m716","m717","m718","m721","m722","m727","m728","m730","m731","m732","m733","m734","m735","m736","m737","m738","m739","m744","m745","m746","m747","m748","m749","m750","m751","m752","m753","m754","m755","m756","m757","m758","m759","m762","m763","m771","m772","m773","m774","m775","m776","m778","m779","m783","m784","m788","m789","m790","m791","m792","m793","m795","m796","m800","m801","m804","m805","m806","m807","m811","m812","m813","m814","m817","m818","m821","m822","m828","m829","m833","m834","m837","m838","m843","m844","m845","m846","m848","m849","m850","m851","m854","m855","m857","m858","m859","m860","m863","m864","m865","m866","m869","m870","m873","m874","m882","m883","m884","m885","m887","m888","m893","m894","m897","m898","m899","m900","m901","m902","m905","m906","m907","m908","m909","m910","m911","m912","m913","m914","m916","m917","m919","m920","m922","m923","m924","m925","m930","m931","m932","m933","m934","m935","m936","m937","m938","m939","m941","m942","m943","m944","m945","m946","m947","m948","m950","m951","m952","m953","m954","m955","m956","m957","m958","m959","m961","m962","m963","m964","m965","m966","m968","m969","m970","m971","m972","m973","m975","m976","m981","m982","m984","m985","m986","m987","m988","m989","m994","m995","m996","m997","m999","m1000","m1002","m1003","m1004","m1005","m1006","m1007","m1008","m1009","m1011","m1012","m1013","m1014","m1019","m1020","m1022","m1023","m1024","m1025","m1026","m1027","m1028","m1029","m1030","m1031","m1032","m1033","m1035","m1036","m1038","m1039","m1043","m1044","m1049","m1050","m1051","m1052","m1054","m1055","m1056","m1057","m1058","m1059","m1063","m1064","m1068","m1069","m1071","m1072","m1075","m1076","m1080","m1081","m1083","m1084","m1085","m1086","m1088","m1089","m1093","m1094","m1095","m1096","m1097","m1098","m1100","m1101","m1102","m1103","m1109","m1110","m1113","m1114","m1121","m1122","m1123","m1124","m1126","m1127","m1132","m1133","m1135","m1136","m1140","m1141","m1150","m1151","m1153","m1154","m1158","m1159","m1160","m1161","m1162","m1163","m1165","m1166","m1167","m1168","m1169","m1170","m1171","m1172","m1173","m1174","m1175","m1176","m1177","m1178","m1179","m1180","m1181","m1182","m1183","m1184","m1185","m1186","m1187","m1188","m1189","m1190","m1191","m1192","m1193","m1194","m1195","m1196","m1197","m1198","m1199","m1200","m1201","m1202","m1203","m1204","m1205","m1206","m1207","m1208","m1209","m1210","m1211","m1212","m1213","m1214","m1215","m1216","m1217","m1218","m1219","m1220","m1221","m1222","m1223","m1224","m1225","m1226","m1227","m1228","m1229","m1230","m1231","m1232","m1233","m1234"];publicVariable "all_eos_mkrs";//invisible eos markers excluded
			//all_civ_eos_mkrs = ["civmkr1","civmkr2","civmkr3","civmkr4","civmkr5","civmkr6","civmkr7","civmkr8","civmkr9","civmkr10","civmkr11","civmkr12","civmkr13","civmkr14","civmkr15","civmkr16","civmkr17","civmkr18"];
		};
		case (toLower (worldName) isEqualTo "bornholm"):
		{
			Airfield_opt = true;publicVariable "Airfield_opt";
			Rand_AirCntr_OFstMax = 3000;publicVariable "Rand_AirCntr_OfstMax";
			Del_box_Pos = [3276.91,5278.15,0.00141907];publicVariable "Del_box_Pos";
			all_eos_mkrs = ["m1","m2","m3","m4","m5","m6","m7","m8","m9","m10","m11","m12","m13","m14","m15","m16","m17","m18","m19","m20","m21","m22","m23","m24","m25","m26","m27","m28","m29","m30","m31","m32","m33","m34","m35","m36","m37","m38","m39","m40","m41","m42","m43","m44","m45","m46","m47","m48","m49","m50","m51","m52","m53","m54","m55","m56","m57","m58","m59","m60","m61","m62","m63","m64","m65","m66","m67","m68","m69","m70","m71","m72","m73","m74","m75","m76","m77","m78","m79","m80","m81","m82","m83","m84","m85","m86","m87","m88","m89","m90","m91","m92","m93","m94","m95","m96","m97","m98","m99","m100","m101","m102","m103","m104","m105","m106","m107","m108","m109","m110","m111","m112","m113","m114","m115","m116","m117","m118","m119","m120","m121","m122","m123","m124","m125","m126","m127","m128","m129","m130","m131","m132","m133","m134","m135","m136","m137","m138","m139","m140","m141","m142","m143","m144","m145","m146","m147","m148","m149","m150","m151","m152","m153","m154","m155","m156","m157","m158","m159","m160","m161","m162","m163","m164","m165","m166","m167","m168","m169","m170","m171","m172","m173","m174","m175","m176","m177","m178","m179","m180","m181","m182","m183","m184","m185","m186","m187","m188","m189","m190","m191","m192","m193","m194","m195","m196","m197","m198","m199","m200","m201","m202","m203","m204","m205","m206","m207","m208","m209","m210","m211","m212","m213","m214","m215","m216","m217","m218","m219","m220","m221","m222","m223","m224","m225","m226","m227","m228","m229","m230","m231","m232","m233","m234","m235","m236","m237","m238","m239","m240","m241","m242","m243","m244","m245","m246","m247","m248","m249","m250","m251","m252","m253","m254","m255","m256","m257","m258","m259","m260","m261","m262","m263","m264","m265","m266","m267","m268","m269","m270","m271","m272","m273","m274","m275","m276","m277","m278","m279","m280","m281","m282","m283","m284","m285","m286","m287","m288","m289","m290","m291","m292","m293","m294","m295","m296","m297","m298","m299","m300","m301","m302","m303","m304","m305","m306","m307","m308","m309","m310","m311","m312","m313","m314","m315","m316","m317","m318","m319","m320","m321","m322","m323","m324","m325","m326","m327","m328","m329","m330","m331","m332","m333","m334","m335","m336","m337","m338","m339","m340","m341","m342","m343","m344","m345","m346","m347","m348","m349","m350","m351","m352","m353","m354","m355","m356","m357","m358","m359","m360","m361","m362","m363","m364","m365","m366","m367","m368","m369","m370","m371","m372","m373","m374","m375","m376","m377","m378","m379","m380","m381","m382","m383","m384","m385","m386","m387","m388","m389","m390","m391","m392","m393","m394","m395","m396","m397","m398","m399","m400","m401","m402","m403","m404","m405","m406","m407","m408","m409","m410","m411","m412","m413","m414","m415","m416","m417","m418","m419","m420","m421","m422","m423","m424","m425","m426","m427","m428","m429","m430","m431","m432","m433","m434","m435","m436","m437","m438","m439","m440","m441","m442","m443","m444","m445","m446","m447","m448","m449","m450","m451","m452","m453","m454","m455","m456","m457","m458","m459","m460","m461","m462","m463","m464","m465","m466","m467","m468","m469","m470","m471","m472","m473","m474","m475","m476","m477","m478","m479","m480","m481","m482","m483","m484","m485","m486","m487","m488","m489","m490","m491","m492","m493","m494","m495","m496","m497","m498","m499","m500","m501","m502","m503","m504","m505","m506","m507","m508","m509","m510","m511","m512","m513","m514","m515","m516","m517","m518","m519","m520","m521","m522","m523","m524","m525","m526","m527","m528","m529","m530","m531","m532","m533","m534","m535","m536","m537","m538","m539","m540","m541","m542","m543","m544","m545","m546","m547","m548","m549","m550","m551","m552","m553","m554","m555","m556","m557","m558","m559","m560","m561","m562","m563","m564","m565","m566","m567","m568","m569","m570","m571","m572","m573","m574","m575","m576","m577","m578","m579","m580","m581","m582","m583","m584","m585","m586","m587","m588","m589","m590","m591","m592","m593","m594","m595","m596","m597","m598","m599","m600","m601","m602","m603","m604","m605","m606","m607","m608","m609","m610","m611","m612","m613","m614","m615","m616","m617","m618","m619","m620","m621","m622","m623","m624","m625","m626","m627","m628","m629","m630","m631","m632","m633","m634","m635","m636","m637","m638","m639","m640","m641","m642","m643","m644","m645","m646","m647","m648","m649","m650","m651","m652","m653","m654","m655","m656","m657","m658","m659","m660","m661","m662","m663","m664","m665","m666","m667","m668","m669","m670","m671","m672","m673","m674","m675","m676","m677","m678","m679","m680","m681","m682","m683","m684","m685","m686","m687","m688","m689","m690","m691","m692","m693","m694","m695","m696","m697","m698","m699","m700","m701","m702","m703","m704","m705","m706","m707","m708","m709","m710","m711","m712","m713","m714","m715","m716","m717","m718","m719","m720","m721","m722","m723","m724","m725","m726","m727","m728","m729","m730","m731","m732","m733","m734","m735","m736","m737","m738","m739","m740","m741","m742","m743","m744","m745","m746","m747","m748","m749","m750","m751","m752","m753","m754","m755","m756","m757","m758","m759","m760","m761","m762","m763","m764","m765","m766","m767","m768","m769","m770","m771","m772","m773","m774","m775","m776","m777","m778","m779","m780","m781","m782","m783","m784","m785","m786","m787","m788","m789","m790","m791","m792","m793","m794","m795","m796","m797","m798","m799","m800","m801","m802","m803","m804","m805","m806","m807","m808","m809","m810","m811","m812","m813","m814","m815","m816","m817","m818","m819","m820","m821","m822","m823","m824","m825","m826","m827","m828","m829","m830","m831","m832","m833","m834","m835","m836","m837","m838","m839","m840","m841","m842","m843","m844","m845","m846","m847","m848","m849","m850","m851","m852","m853","m854","m855","m856","m857","m858","m859","m860","m861","m862","m863","m864","m865","m866","m867","m868","m869","m870","m871","m872","m873","m874","m875","m876","m877","m878","m879","m880","m881","m882","m883","m884","m885","m886","m887","m888","m889","m890","m891","m892","m893","m894","m895","m896","m897","m898","m899","m900","m901","m902","m903","m904","m905","m906","m907","m908","m909","m910","m911","m912","m913","m914","m915","m916","m917","m918","m919","m920","m921","m922","m923","m924","m925","m926","m927","m928","m929","m930","m931","m932","m933","m934","m935","m936","m937","m938","m939","m940","m941","m942","m943","m944","m945","m946","m947","m948","m949","m950","m951","m952","m953","m954","m955","m956","m957","m958","m959","m960","m961","m962","m963","m964","m965","m966","m967","m968","m969","m970","m971","m972","m973","m974","m975","m976","m977","m978","m979","m980","m981","m982","m983","m984","m985","m986","m987","m988","m989","m990","m991","m992","m993","m994","m995","m996","m997","m998","m999","m1000","m1001","m1002","m1003","m1004","m1005","m1006","m1007","m1008","m1009","m1010","m1011","m1012","m1013","m1014","m1015","m1016","m1017","m1018","m1019","m1020","m1021","m1022","m1023","m1024","m1025","m1026","m1027","m1028","m1029","m1030","m1031","m1032","m1033","m1034","m1035","m1036","m1037","m1038","m1039","m1040","m1041","m1042","m1043","m1044","m1045","m1046","m1047","m1048","m1049","m1050","m1051","m1052","m1053","m1054","m1055","m1056","m1057","m1058","m1059","m1060","m1061","m1062","m1063","m1064","m1065","m1066"];publicVariable "all_eos_mkrs";//invisible eos markers excluded
			//all_civ_eos_mkrs = ["civmkr1","civmkr2","civmkr3","civmkr4","civmkr5","civmkr6","civmkr7","civmkr8","civmkr9","civmkr10","civmkr11","civmkr12","civmkr13","civmkr14","civmkr15","civmkr16","civmkr17","civmkr18"];
		};
		case (toLower (worldName) isEqualTo "mog"):
		{
			Airfield_opt = true;publicVariable "Airfield_opt";
			Rand_AirCntr_OFstMax = 1800;publicVariable "Rand_AirCntr_OfstMax";
			Del_box_Pos = [6659.01,9873.3,0.00148392];publicVariable "Del_box_Pos";
			all_eos_mkrs = ["m1","m2","m7","m8","m15","m22","m23","m24","m37","m38","m39","m52","m59","m79","m80","m95","m96","m99","m111","m118","m119","m126","m147","m148","m165","m166","m167","m180","m183","m200","m233","m239","m246","m255","m256","m3","m4","m5","m6","m9","m10","m11","m12","m13","m14","m16","m17","m18","m19","m20","m21","m25","m26","m27","m28","m29","m30","m31","m32","m33","m34","m35","m36","m40","m41","m42","m43","m44","m45","m46","m47","m48","m49","m50","m51","m53","m54","m55","m56","m57","m58","m61","m62","m63","m64","m65","m66","m67","m68","m69","m70","m71","m72","m73","m74","m75","m76","m77","m78","m81","m82","m83","m84","m85","m86","m87","m88","m89","m90","m91","m92","m93","m94","m97","m98","m101","m102","m103","m104","m105","m106","m107","m108","m109","m110","m112","m113","m114","m115","m116","m117","m120","m121","m122","m123","m124","m125","m127","m128","m129","m130","m131","m132","m133","m134","m135","m136","m137","m138","m139","m140","m141","m142","m143","m144","m145","m146","m149","m150","m151","m152","m153","m154","m155","m156","m157","m158","m159","m160","m161","m162","m163","m164","m168","m169","m170","m171","m172","m173","m174","m175","m176","m177","m178","m179","m181","m182","m184","m185","m186","m187","m188","m189","m190","m191","m192","m193","m194","m195","m196","m197","m198","m199","m201","m202","m203","m204","m205","m206","m207","m208","m209","m210","m211","m212","m213","m214","m215","m216","m217","m218","m219","m220","m221","m222","m223","m224","m225","m226","m227","m228","m229","m230","m231","m232","m60","m234","m235","m236","m238","m240","m241","m242","m243","m244","m245","m247","m248","m249","m250","m251","m252","m253","m254","m259","m260","m261","m262","m263","m264","m265","m266","m267"];publicVariable "all_eos_mkrs";//invisible eos markers excluded
			//all_civ_eos_mkrs = ["civmkr1","civmkr2","civmkr3","civmkr4","civmkr5","civmkr6","civmkr7","civmkr8","civmkr9","civmkr10","civmkr11","civmkr12","civmkr13","civmkr14","civmkr15","civmkr16","civmkr17"];
		};
		case (toLower (worldName) isEqualTo "clafghan"):
		{
			Airfield_opt = true;publicVariable "Airfield_opt";
			Rand_AirCntr_OFstMax = 1800;publicVariable "Rand_AirCntr_OfstMax";
			Del_box_Pos = [15263.9,1138.9,0.00143886];publicVariable "Del_box_Pos";
			all_eos_mkrs = ["m1","m2","m3","m4","m5","m6","m7","m8","m9","m10","m11","m12","m13","m14","m15","m16","m17","m18","m19","m20","m21","m22","m23","m24","m25","m26","m27","m28","m29","m30","m31","m32","m33","m34","m35","m36","m37","m38","m39","m40","m41","m42","m43","m44","m45","m46","m47","m48","m49","m50","m51","m52","m53","m54","m55","m56","m57","m58","m59","m60","m61","m62","m63","m64","m65","m66","m67","m68","m69","m70","m71","m72","m73","m74","m75","m76","m77","m78","m79","m80","m81","m82","m83","m84","m85","m86","m87","m88","m89","m90","m91","m92","m93","m94","m95","m96","m97","m98","m99","m100","m101","m102","m103","m104","m105","m106","m107","m108","m109","m110","m111","m112","m113","m114","m115","m116","m117","m118","m119","m120","m121","m122","m123","m124","m125","m126","m127","m128","m129","m130","m131","m132","m133","m134","m135","m136","m137","m138","m139","m140","m141","m142","m143","m144","m145","m146","m147","m148","m149","m150","m151","m152","m153","m154","m155","m156","m157","m158","m159","m160","m161","m162","m163","m164","m165","m166","m167","m168","m169","m170","m171","m172","m173","m174","m175","m176","m177","m178","m179","m180","m181","m182","m183","m184","m185","m186","m187","m188","m189","m190","m191","m192","m193","m194","m195","m196","m197","m198","m199","m200","m201","m202","m203","m204","m205","m206","m207","m208","m209","m210","m211","m212","m213","m214","m215","m216","m217","m218","m219","m220","m221","m222","m223","m224","m225","m226","m227","m228","m229","m230","m231","m232","m233","m234","m235","m236","m237","m238","m239","m240","m241","m242","m243","m244","m245","m246","m247","m248","m249","m250","m251","m252","m253","m254","m255","m256","m257","m258","m259","m260","m261","m262","m263","m264","m265","m266","m267","m268","m269","m270","m271","m272","m273","m274","m275","m276","m277","m278","m279","m280","m281","m282","m283","m284","m285","m286","m287","m288","m289","m290","m291","m292","m293","m294","m295","m296","m297","m298","m299","m300","m301","m302","m303","m304","m305","m306","m307","m308","m309","m310","m311","m312","m313","m314","m315","m316","m317","m318","m319","m320","m321","m322","m323","m324","m325","m326","m327","m328","m329","m330","m331","m332","m333","m334","m335","m336","m337","m338","m339","m340","m341","m342","m343","m344","m345","m346","m347","m348","m349","m350","m351","m352","m353","m354","m355","m356","m357"];publicVariable "all_eos_mkrs";//invisible eos markers excluded
			//all_civ_eos_mkrs = ["civmkr1","civmkr2","civmkr3","civmkr4","civmkr5","civmkr6","civmkr7","civmkr8","civmkr9","civmkr10","civmkr11","civmkr12","civmkr13","civmkr14","civmkr15","civmkr16","civmkr17"];
		};
	};
	CCServerAdminPasswordCC = "";
	ToxicGasLoc = [];publicVariable "ToxicGasLoc";
	all_intel_mkrs = [];publicVariable "all_intel_mkrs";
	intel_objArray = [];publicVariable "intel_objArray";
	PVEH_NetSay3D = [objNull,0];publicVariable "PVEH_NetSay3D";
	BTC_to_server = [];publicVariable "BTC_to_server";
	Kick_For_Duration = [];publicVariable "Kick_For_Duration";
	side_mission_mkrs = ["sidemiss1","sidemiss2","sidemiss3","sidemiss4","sidemiss5","sidemiss6","sidemiss7","sidemiss8","sidemiss9","sidemiss10","sidemiss11"];publicVariable "side_mission_mkrs";// all objective markers
	objective_objs = ["Land_TTowerBig_1_F","Land_BagBunker_Tower_F","Land_UWreck_MV22_F","Land_HighVoltageTower_F","APERSBoundingMine","O_APC_Tracked_02_AA_F","RoadCone_F","RoadCone_F","Land_Sign_WarningUnexplodedAmmo_F","Land_Cargo_HQ_V3_F","RoadCone_F"];publicVariable "objective_objs";// objective/mission objects (do not change array index order!)
	objective_list = ["comms_tower","kill_leader","rescue_pilot","cut_power","mine_field","deliver_supplies","destroy_convoy","destroy_armed_convoy","destroy_mortar_squad","c_n_h","destroy_roadblock"];publicVariable "objective_list";// all objectives (do not change array index order!)
	objective_ruins = ["Land_TTowerBig_1_ruins_F","Land_TTowerBig_2_ruins_F","Land_Cargo40_color_V3_ruins_F","Land_HighVoltageTower_dam_F","Land_Cargo_HQ_V3_ruins_F"];publicVariable "objective_ruins";// Objective/mission ruins models
	side_mission_mkrs_copy = + side_mission_mkrs;
	objective_list_copy = + objective_list;

	// Detect ASR_AI mod // (If not detected on server then recruit skills are set with function INS_Recruit_skill in INSfncs\client_fncs.sqf.)
	ASRrecSkill = if (isClass(configFile >> "cfgPatches" >> "asr_ai_main")) then {1}else{0};publicVariable "ASRrecSkill";

	BMR_Players = [];
	if (isNil "INS_MHQ_killed") then {INS_MHQ_killed = "";};
	suicide_bmbr_weps = ["ModuleExplosive_SatchelCharge_F"];
	suicide_bmbr_miniweps = ["MiniGrenade"];
	suicide_bmbr_deadman = ["mini_Grenade","GrenadeHand","APERSBoundingMine_Range_Ammo","IEDUrbanSmall_Remote_Ammo"];
	cache_types = ["Box_East_Ammo_F","Box_IND_Ammo_F","Box_FIA_Ammo_F","Land_Pallet_MilBoxes_F"];
	INS_log_blacklist = [INS_Wep_box,INS_flag,INS_Op4_flag,INS_nade_Nbox,INS_ammo_Nbox,INS_weps_Nbox,INS_launchers_Nbox,INS_sup_Nbox,INS_weps_Cbox,INS_ammo_Cbox,INS_nade_Cbox,INS_launchers_Cbox,INS_demo_Cbox,INS_sup_Cbox];//Logistics object names blacklist //Delivery_Box
};

// Global Class Arrays /////////////////////////////////////////////////////
// Csat
if (INS_op_faction isEqualTo 1) then {
	INS_Op4_side = EAST;
	INS_men_list = ["O_SoldierU_SL_F","O_soldierU_repair_F","O_soldierU_medic_F","O_sniper_F","O_Soldier_A_F","O_Soldier_AA_F","O_Soldier_AAA_F","O_Soldier_AAR_F","O_Soldier_AAT_F","O_Soldier_AR_F","O_Soldier_AT_F","O_soldier_exp_F","O_Soldier_F","O_engineer_F","O_engineer_U_F","O_medic_F","O_recon_exp_F","O_recon_F","O_recon_JTAC_F","O_recon_LAT_F","O_recon_M_F","O_recon_medic_F","O_recon_TL_F","O_Sharpshooter_F","O_HeavyGunner_F"];
	INS_Op4_medic = "O_soldierU_medic_F";
	INS_Op4_Eng = "O_soldierU_repair_F";
	INS_Op4_pilot = ["O_helipilot_F"];
	INS_Op4_Veh_Light = ["O_MRAP_02_hmg_F","O_MRAP_02_gmg_F","O_G_Offroad_01_armed_F","O_APC_Wheeled_02_rcws_F"];
	INS_Op4_Veh_Tracked = ["O_APC_Tracked_02_cannon_F","O_APC_Tracked_02_AA_F","O_MBT_02_cannon_F"];
	INS_Op4_Veh_Support = ["O_Truck_03_ammo_F","O_Truck_03_repair_F","O_Truck_02_Ammo_F","O_Truck_02_fuel_F","O_Truck_02_box_F","O_Truck_02_medical_F"];
	INS_Op4_Veh_AA = ["O_APC_Tracked_02_AA_F"];
	INS_Op4_stat_weps = ["O_GMG_01_high_F","O_HMG_01_high_F","O_static_AT_F","O_static_AA_F","O_HMG_01_A_F","O_GMG_01_F","O_G_Mortar_01_F"];//A3 East static weapons
	INS_civlist = ["C_man_p_beggar_F","C_man_1","C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F","C_man_polo_6_F","C_man_shorts_1_F","C_man_1_1_F","C_man_1_2_F","C_man_1_3_F","C_man_p_fugitive_F","C_man_p_shorts_1_F","C_man_hunter_1_F","C_man_shorts_2_F","C_man_shorts_3_F","C_man_shorts_4_F"];// A3 Civilians
	INS_civ_Veh_Car = ["C_Hatchback_01_F","C_Offroad_01_F","C_Quadbike_01_F","C_SUV_01_F"];
	INS_civ_Veh_Utl = ["C_Van_01_box_F","C_Van_01_transport_F","C_Van_01_fuel_F"];
	//INS_civClothes = ["U_Competitor","U_C_HunterBody_grn","U_C_Poloshirt_blue","U_C_Poloshirt_burgundy","U_C_Poloshirt_redwhite","U_C_Poloshirt_salmon","U_C_Poloshirt_stripped","U_C_Poloshirt_tricolour","U_C_Poor_1","U_C_Poor_2","U_IG_Guerilla2_2","U_IG_Guerilla2_3","U_IG_Guerilla3_1","U_IG_Guerilla3_2","U_NikosBody","U_Rangemaster"];// A3 Civilian Clothes
};

// AAF
if (INS_op_faction isEqualTo 2) then {
	INS_Op4_side = RESISTANCE;
	INS_men_list = ["I_soldier_F","I_Soldier_lite_F","I_soldier_AT_F","I_soldier_GL_F","I_soldier_LAT_F","I_soldier_exp_F","I_soldier_F","I_soldier_AR_F","I_soldier_repair_F","I_soldier_LAT_F","I_soldier_AR_F","I_soldier_M_F","I_soldier_AT_F","I_soldier_AA_F","I_soldier_F","I_soldier_TL_F","I_medic_F","I_soldier_GL_F","I_soldier_F"];
	INS_Op4_medic = "I_medic_F";
	INS_Op4_Eng = "I_soldier_repair_F";
	INS_Op4_pilot = ["I_pilot_F"];
	INS_Op4_Veh_Light = ["I_G_Offroad_01_armed_F","I_MRAP_03_gmg_F","I_MRAP_03_hmg_F","I_APC_Wheeled_03_cannon_F"];
	INS_Op4_Veh_Tracked = ["I_APC_tracked_03_cannon_F","I_MBT_03_cannon_F"];
	INS_Op4_Veh_Support = ["I_Truck_02_ammo_F","I_Truck_02_fuel_F","I_Truck_02_box_F","I_Truck_02_medical_F"];
	INS_Op4_Veh_AA = ["O_APC_Tracked_02_AA_F"];
	INS_Op4_stat_weps = ["O_GMG_01_high_F","O_HMG_01_high_F","O_static_AT_F","O_static_AA_F","O_HMG_01_A_F","O_GMG_01_F","O_G_Mortar_01_F"];//A3 East static weapons
	INS_civlist = ["C_man_p_beggar_F","C_man_1","C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F","C_man_polo_6_F","C_man_shorts_1_F","C_man_1_1_F","C_man_1_2_F","C_man_1_3_F","C_man_p_fugitive_F","C_man_p_shorts_1_F","C_man_hunter_1_F","C_man_shorts_2_F","C_man_shorts_3_F","C_man_shorts_4_F"];// A3 Civilians
	INS_civ_Veh_Car = ["C_Hatchback_01_F","C_Offroad_01_F","C_Quadbike_01_F","C_SUV_01_F"];
	INS_civ_Veh_Utl = ["C_Van_01_box_F","C_Van_01_transport_F","C_Van_01_fuel_F"];
};

// REBEL ARMY UNITS and RUSSIAN SPETSNAZ ADVISORS (masi EAST)
if (INS_op_faction isEqualTo 3) then {
	INS_Op4_side = EAST;
	INS_men_list = ["O_mas_afr_Soldier_F","O_mas_afr_Soldier_GL_F","O_mas_afr_soldier_AR_F","O_mas_afr_soldier_MG_F","O_mas_afr_Soldier_lite_F","O_mas_afr_Soldier_off_F","O_mas_afr_Soldier_SL_F","O_mas_afr_soldier_M_F","O_mas_afr_soldier_LAT_F","O_mas_afr_soldier_LAA_F","O_mas_afr_medic_F","O_mas_afr_soldier_repair_F","O_mas_afr_soldier_exp_F","O_mas_afr_rusadv1_F","O_mas_afr_rusadv2_F","O_mas_afr_rusadv3_F"];
	INS_Op4_medic = "O_mas_afr_medic_F";
	INS_Op4_Eng = "O_mas_afr_soldier_repair_F";
	INS_Op4_pilot = ["O_helipilot_F"];
	INS_Op4_Veh_Light = ["O_MRAP_02_hmg_F","O_MRAP_02_gmg_F","O_G_Offroad_01_armed_F","O_APC_Wheeled_02_rcws_F"];
	INS_Op4_Veh_Tracked = ["O_APC_Tracked_02_cannon_F","O_APC_Tracked_02_AA_F","O_MBT_02_cannon_F"];
	INS_Op4_Veh_AA = ["O_APC_Tracked_02_AA_F"];
	INS_Op4_Veh_Support = ["O_Truck_03_ammo_F","O_Truck_03_repair_F","O_Truck_02_Ammo_F","O_Truck_02_fuel_F","O_Truck_02_box_F","O_Truck_02_medical_F"];
	INS_Op4_stat_weps = ["O_GMG_01_high_F","O_HMG_01_high_F","O_static_AT_F","O_static_AA_F","O_HMG_01_A_F","O_GMG_01_F","O_G_Mortar_01_F"];//A3 East static weapons
	INS_civlist = ["C_mas_afr_1","C_mas_afr_2","C_mas_afr_3","C_mas_afr_4","C_mas_afr_5","C_mas_afr_6","C_mas_afr_7","C_mas_afr_8","C_mas_afr_9","C_mas_afr_10"];// Masi African Civilians
	INS_civ_Veh_Car = ["C_Hatchback_01_F","C_Offroad_01_F","C_Quadbike_01_F","C_SUV_01_F"];
	INS_civ_Veh_Utl = ["C_Van_01_box_F","C_Van_01_transport_F","C_Van_01_fuel_F"];
	//INS_civClothes = ["U_mas_afr_C_Civil1","U_mas_afr_C_Civil2","U_mas_afr_C_Civil3","U_mas_afr_C_Civil4","U_mas_afr_C_Civil5","U_mas_afr_C_Civil6","U_mas_afr_C_Civil7","U_mas_afr_C_Civil8","U_mas_afr_C_Civil9", "U_mas_afr_C_Civil10"];// Masi African Civilian Clothes
};

// CAF Aggressors Middle Eastern
if (INS_op_faction isEqualTo 4) then {
	INS_Op4_side = EAST;
	INS_men_list = ["CAF_AG_ME_T_AK47","CAF_AG_ME_T_AK74","CAF_AG_ME_T_GL","CAF_AG_ME_T_PKM","CAF_AG_ME_T_RPG","CAF_AG_ME_T_RPK74","CAF_AG_ME_T_SVD"];
	INS_Op4_medic = "CAF_AG_ME_T_AK47";//placeholder
	INS_Op4_Eng = "CAF_AG_ME_T_AK47";//placeholder
	INS_Op4_pilot = ["O_helipilot_F"];
	INS_Op4_Veh_Light = ["O_MRAP_02_hmg_F","O_MRAP_02_gmg_F","O_G_Offroad_01_armed_F","O_APC_Wheeled_02_rcws_F"];
	INS_Op4_Veh_Tracked = ["O_APC_Tracked_02_cannon_F","O_APC_Tracked_02_AA_F","O_MBT_02_cannon_F"];
	INS_Op4_Veh_Support = ["O_Truck_03_ammo_F","O_Truck_03_repair_F","O_Truck_02_Ammo_F","O_Truck_02_fuel_F","O_Truck_02_box_F","O_Truck_02_medical_F"];
	INS_Op4_Veh_AA = ["O_APC_Tracked_02_AA_F"];
	INS_Op4_stat_weps = ["O_GMG_01_high_F","O_HMG_01_high_F","O_static_AT_F","O_static_AA_F","O_HMG_01_A_F","O_GMG_01_F","O_G_Mortar_01_F"];//A3 East static weapons
	INS_civ_Veh_Car = ["C_Hatchback_01_F","C_Offroad_01_F","C_Quadbike_01_F","C_SUV_01_F"];
	INS_civ_Veh_Utl = ["C_Van_01_box_F","C_Van_01_transport_F","C_Van_01_fuel_F"];
	INS_civlist = ["CAF_AG_ME_CIV","CAF_AG_ME_CIV_02","CAF_AG_ME_CIV_03","CAF_AG_ME_CIV_04"];// CAF ME Civilians
	INS_civClothes = ["U_CAF_AG_ME_ROBES_01","U_CAF_AG_ME_ROBES_01a","U_CAF_AG_ME_ROBES_01b","U_CAF_AG_ME_ROBES_01c","U_CAF_AG_ME_ROBES_01d","U_CAF_AG_ME_ROBES_02","U_CAF_AG_ME_ROBES_02a","U_CAF_AG_ME_ROBES_02b","U_CAF_AG_ME_ROBES_02c","U_CAF_AG_ME_ROBES_02d","U_CAF_AG_ME_ROBES_03","U_CAF_AG_ME_ROBES_03a","U_CAF_AG_ME_ROBES_03b","U_CAF_AG_ME_ROBES_03c","U_CAF_AG_ME_ROBES_03d","U_CAF_AG_ME_ROBES_04","U_CAF_AG_ME_ROBES_04a","U_CAF_AG_ME_ROBES_04b","U_CAF_AG_ME_ROBES_04c","U_CAF_AG_ME_ROBES_04d","U_CAF_AG_ME_ROBES_mil_01","U_CAF_AG_ME_ROBES_mil_01a"];// CAF ME Civilian Clothes
	INS_civHeadgear = ["H_CAF_AG_TURBAN","H_CAF_AG_PAKTOL","H_CAF_AG_PAKTOL_01","H_CAF_AG_PAKTOL_02","H_CAF_AG_PAKTOL_03","H_CAF_AG_WRAP"];// CAF ME Civilian HeadGear
};

// Leight's Opfor Pack Islamic State of Takistan and Sahrani
if ((INS_op_faction isEqualTo 5) || (INS_op_faction isEqualTo 6)) then {
	INS_Op4_side = RESISTANCE;
	INS_men_list = ["LOP_ISTS_Infantry_TL","LOP_ISTS_Infantry_SL","LOP_ISTS_Infantry_Corpsman","LOP_ISTS_Infantry_AR","LOP_ISTS_Infantry_AT","LOP_ISTS_Infantry_Marksman","LOP_ISTS_Infantry_Engineer","LOP_ISTS_Infantry_GL"];
	INS_Op4_medic = "LOP_ISTS_Infantry_Corpsman";
	INS_Op4_Eng = "LOP_ISTS_Infantry_Engineer";
	INS_Op4_pilot = ["LOP_ISTS_Infantry_Engineer"];
	INS_Op4_Veh_Light = ["LOP_ISTS_Landrover_M2","LOP_ISTS_Offroad_M2","LOP_IA_M1025_W_Mk19","LOP_IA_M1025_W_M2"];
	INS_Op4_Veh_Tracked = ["LOP_ISTS_BMP1","LOP_ISTS_BMP2","LOP_ISTS_BTR60","LOP_ISTS_M113_W","LOP_ISTS_T72BA","LOP_ISTS_ZSU234"];
	INS_Op4_Veh_Support = ["LOP_ISTS_Truck","LOP_UA_Ural_fuel","O_Truck_02_Ammo_F","O_Truck_02_box_F","O_Truck_02_medical_F"];
	INS_Op4_Veh_AA = ["LOP_ISTS_ZSU234"];
	INS_Op4_stat_weps = ["LOP_ISTS_Static_Mk19_TriPod","LOP_ISTS_Static_M2","O_static_AT_F","LOP_ISTS_Static_M2_MiniTripod","O_static_AA_F","O_G_Mortar_01_F"];
	INS_civ_Veh_Car = ["LOP_TAK_Civ_Offroad","LOP_TAK_Civ_Hatchback","LOP_TAK_Civ_Landrover","C_Hatchback_01_F","C_Offroad_01_F","C_Quadbike_01_F","C_SUV_01_F"];
	INS_civ_Veh_Utl = ["LOP_TAK_Civ_Ural","LOP_TAK_Civ_Ural_open","LOP_TAK_Civ_UAZ","LOP_TAK_Civ_UAZ_Open","C_Van_01_box_F","C_Van_01_transport_F","C_Van_01_fuel_F"];
	INS_civlist = ["LOP_Tak_Civ_Man_01","LOP_Tak_Civ_Man_02","LOP_Tak_Civ_Man_04"];
};

// Middle Eastern Conflict - Taliban
if (INS_op_faction isEqualTo 7) then {
	INS_Op4_side = RESISTANCE;
	INS_men_list = ["MEC_TAL_AASoldier","MEC_TAL_ATSoldier","MEC_TAL_AutomaticRifleman","MEC_TAL_Crewman","MEC_TAL_Engineer","MEC_TAL_Explosives","MEC_TAL_Grenadier","MEC_TAL_MachineGunner","MEC_TAL_Marksman","MEC_TAL_Medic","MEC_TAL_Repair","MEC_TAL_Rifleman","MEC_TAL_RPG7Soldier","MEC_TAL_SquadLeader"];
	INS_Op4_medic = "MEC_TAL_Medic";
	INS_Op4_Eng = "MEC_TAL_Engineer";
	INS_Op4_pilot = ["MEC_SAA_Pilot"];
	INS_Op4_Veh_Light = ["MEC_TAL_Offroad_01_armed_F","MEC_TAL_Offroad_01_F","MEC_TAL_Offroad_01s_armed_F","MEC_TAL_Offroad_01s_F"];
	INS_Op4_Veh_Tracked = ["MEC_SAA_T72","MEC_SAA_BMP1","MEC_SAA_BMP2","MEC_SAA_T55"];
	INS_Op4_Veh_Support = ["O_Truck_03_ammo_F","O_Truck_03_repair_F","O_Truck_02_Ammo_F","O_Truck_02_fuel_F","O_Truck_02_box_F","O_Truck_02_medical_F"];
	INS_Op4_Veh_AA = ["MEC_SAA_ZSU23"];
	INS_Op4_stat_weps = ["MEC_SAA_ZU23","MEC_SAA_AGS","MEC_SAA_SPG9","MEC_SAA_DSHKM","MEC_SAA_DSHkM_Mini_TriPod","MEC_SAA_KORD","MEC_SAA_KORD_high","MEC_SAA_Metis","MEC_SAA_Igla_AA_pod","MEC_SAA_2b14_82mm","MEC_SAA_D30","MEC_SAA_D30_AT"];
	INS_civ_Veh_Car = ["C_Hatchback_01_F","C_Offroad_01_F","C_Quadbike_01_F","C_SUV_01_F"];
	INS_civ_Veh_Utl = ["C_Van_01_box_F","C_Van_01_transport_F","C_Van_01_fuel_F"];
	INS_civlist = ["MEC_CIV_Man"];
};

// Middle Eastern Conflict - Hamas
if (INS_op_faction isEqualTo 8) then {
	INS_Op4_side = EAST;
	INS_men_list = ["MEC_HAM_AASoldier","MEC_HAM_ATSoldier","MEC_HAM_AutomaticRifleman","MEC_HAM_Crewman","MEC_HAM_Engineer","MEC_HAM_Explosives","MEC_HAM_Grenadier","MEC_HAM_MachineGunner","MEC_HAM_Marksman","MEC_HAM_Medic","MEC_HAM_Repair","MEC_HAM_Rifleman","MEC_HAM_RPG7Soldier","MEC_HAM_SquadLeader"];//"MEC_HAM_RPG7Grenadier"
	INS_Op4_medic = "MEC_HAM_Medic";
	INS_Op4_Eng = "MEC_HAM_Engineer";
	INS_Op4_pilot = ["MEC_SAA_Pilot"];
	INS_Op4_Veh_Light = ["MEC_HAM_Offroad_01_armed","MEC_BOK_Offroad_01s_F","MEC_BOK_Offroad_01_armed_F","MEC_BOK_Offroad_01s_armed_F","MEC_HAM_Offroad_01","MEC_HAM_Offroad_01_armed","MEC_HEZ_Offroad_01_armed"];
	INS_Op4_Veh_Tracked = ["MEC_BOK_BMP1","MEC_BOK_BMP2","MEC_BOK_T55","MEC_BOK_T72","MEC_BOK_ZSU23"];
	INS_Op4_Veh_Support = ["O_Truck_03_ammo_F","O_Truck_03_repair_F","O_Truck_02_Ammo_F","O_Truck_02_fuel_F","O_Truck_02_box_F","O_Truck_02_medical_F"];
	INS_Op4_Veh_AA = ["MEC_BOK_ZSU23"];
	INS_Op4_stat_weps = ["MEC_HEZ_ZU23","MEC_HEZ_DSHKM","MEC_HEZ_AGS","MEC_HEZ_DSHkM_Mini_TriPod","MEC_HEZ_KORD","MEC_HEZ_KORD_high","MEC_HEZ_Metis","MEC_HEZ_SPG9","MEC_HEZ_Igla_AA_pod","MEC_HEZ_2b14_82mm","MEC_HEZ_D30","MEC_HEZ_D30_AT"];
	INS_civ_Veh_Car = ["C_Hatchback_01_F","C_Offroad_01_F","C_Quadbike_01_F","C_SUV_01_F"];
	INS_civ_Veh_Utl = ["C_Van_01_box_F","C_Van_01_transport_F","C_Van_01_fuel_F"];
	INS_civlist = ["MEC_CIV_Man"];
};

// East vs West mod - SUD Russians
if (INS_op_faction isEqualTo 9) then {
	INS_Op4_side = EAST;
	INS_men_list = ["SUD_USSR_Soldier_TL","SUD_USSR_Soldier_AR","SUD_USSR_Soldier_GL","SUD_USSR_Soldier_AT","SUD_USSR_Soldier_HAT","SUD_USSR_Soldier","SUD_USSR_Soldier_Medic","SUD_USSR_Soldier_Crew","SUD_USSR_Soldier_Specop","SUD_USSR_Soldier_AA","SUD_USSR_Soldier_Repair","SUD_USSR_Soldier_Sapper"];
	INS_Op4_medic = "SUD_USSR_Soldier_Medic";
	INS_Op4_Eng = "SUD_USSR_Soldier_Repair";
	INS_Op4_pilot = ["SUD_USSR_Soldier_Pilot"];
	INS_Op4_Veh_Light = ["SUD_UAZ","SUD_BRDM2","SUD_URAL","SUD_BTR60"];
	INS_Op4_Veh_Tracked = ["SUD_BMP2","SUD_T72B","SUD_ZSU"];
	INS_Op4_Veh_Support = ["O_Truck_03_ammo_F","O_Truck_03_repair_F","O_Truck_02_Ammo_F","O_Truck_02_fuel_F","O_Truck_02_box_F","O_Truck_02_medical_F"];
	INS_Op4_Veh_AA = ["SUD_ZSU"];
	INS_Op4_stat_weps = ["RDS_ZU23_CSAT","RDS_AGS_CSAT","RDS_SPG9_CSAT","RDS_DSHKM_CSAT","RDS_DSHkM_Mini_TriPod_CSAT","RDS_KORD_CSAT","RDS_KORD_high_CSAT","RDS_Metis_CSAT","RDS_Igla_AA_pod_CSAT","RDS_2b14_82mm_CSAT","RDS_D30_CSAT","RDS_D30_AT_CSAT"];
	INS_civ_Veh_Car = ["C_Hatchback_01_F","C_Offroad_01_F","C_Quadbike_01_F","C_SUV_01_F"];
	INS_civ_Veh_Utl = ["C_Van_01_box_F","C_Van_01_transport_F","C_Van_01_fuel_F"];
	INS_civlist = ["C_man_p_beggar_F","C_man_1","C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F","C_man_polo_6_F","C_man_shorts_1_F","C_man_1_1_F","C_man_1_2_F","C_man_1_3_F","C_man_p_fugitive_F","C_man_p_shorts_1_F","C_man_hunter_1_F","C_man_shorts_2_F","C_man_shorts_3_F","C_man_shorts_4_F"];// A3 Civilians
};

// RHS - Armed Forces of the Russian Federation MSV
if (INS_op_faction isEqualTo 10) then {
	INS_Op4_side = EAST;
	INS_men_list = ["rhs_msv_crew","rhs_msv_crew_commander","rhs_msv_armoredcrew","rhs_msv_combatcrew","rhs_msv_rifleman","rhs_msv_efreitor","rhs_msv_grenadier","rhs_msv_machinegunner","rhs_msv_machinegunner_assistant","rhs_msv_at","rhs_msv_strelok_rpg_assist","rhs_msv_marksman","rhs_msv_officer_armored","rhs_msv_officer","rhs_msv_junior_sergeant","rhs_msv_sergeant","rhs_msv_engineer","rhs_msv_driver_armored","rhs_msv_driver","rhs_msv_aa","rhs_msv_medic","rhs_msv_LAT"];
	INS_Op4_medic = "rhs_msv_medic";
	INS_Op4_Eng = "rhs_msv_engineer";
	INS_Op4_pilot = ["rhs_pilot"];
	INS_Op4_Veh_Light = ["rhs_btr60_msv","rhs_btr70_msv","rhs_btr80_msv","rhs_btr80a_msv"];
	INS_Op4_Veh_Tracked = ["rhs_sprut_vdv","rhs_bmp1p_msv","rhs_brm1k_msv","rhs_bmp2_msv","rhs_bmp2e_msv","rhs_bmp2d_msv","rhs_bmp2k_msv","rhs_prp3_msv","rhs_bmp3mera_msv","rhs_bmd4_vdv","rhs_bmd4ma_vdv","rhs_t80u","rhs_t80bv","rhs_t80a","rhs_t72bc_tv","rhs_t72bb_tv","rhs_zsu234_aa","rhs_t90a_tv"];
	INS_Op4_Veh_Support = ["RHS_Ural_MSV_01","RHS_Ural_Fuel_MSV_01","RHS_Ural_VDV_01","rhs_typhoon_vdv","rhs_gaz66_repair_vdv","RHS_Ural_Open_MSV_01"];
	INS_Op4_Veh_AA = ["rhs_zsu234_aa"];
	INS_Op4_stat_weps = ["O_GMG_01_high_F","O_HMG_01_high_F","O_static_AT_F","O_static_AA_F","O_HMG_01_A_F","O_GMG_01_F","O_G_Mortar_01_F","RHS_NSV_TriPod_MSV","RHS_NSV_TriPod_VDV"];//A3 East static weapons
	INS_civ_Veh_Car = ["C_Hatchback_01_F","C_Offroad_01_F","C_Quadbike_01_F","C_SUV_01_F"];
	INS_civ_Veh_Utl = ["RHS_Ural_Civ_02","RHS_Ural_Civ_03","RHS_Ural_Open_Civ_01","RHS_Civ_Truck_02_covered_F","RHS_Civ_Truck_02_transport_F","C_Van_01_box_F","C_Van_01_transport_F","C_Van_01_fuel_F"];//"RHS_Ural_Open_Civ_02","RHS_Ural_Open_Civ_03"
	INS_civlist = ["C_man_p_beggar_F","C_man_1","C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F","C_man_polo_6_F","C_man_shorts_1_F","C_man_1_1_F","C_man_1_2_F","C_man_1_3_F","C_man_p_fugitive_F","C_man_p_shorts_1_F","C_man_hunter_1_F","C_man_shorts_2_F","C_man_shorts_3_F","C_man_shorts_4_F"];// A3 Civilians
};

// Iraqi-Syrian Conflict - Syrian Arab Army
if (INS_op_faction isEqualTo 11) then {
	INS_Op4_side = EAST;
	INS_men_list = ["isc_saa_officer_o","isc_saa_grenadier_o","isc_saa_rifleman_o","isc_saa_machinegunner_o","isc_saa_sniper_o","isc_saa_at_o","isc_saa_medic_o","isc_saa_sapper_o","isc_saa_crewman_o"];
	INS_Op4_medic = "isc_saa_medic_o";
	INS_Op4_Eng = "isc_saa_sapper_o";
	INS_Op4_pilot = ["isc_saa_crewman_o"];
	INS_Op4_Veh_Light = ["isc_is_offroad_o","isc_is_offroad_M2_o","isc_is_hilux_MG_o","isc_is_hilux_M2_o","isc_is_hilux_AGS30_o","isc_is_hilux_SPG9_o","isc_is_hilux_RKTS_o","isc_is_LR_M2_o","isc_is_LR_Mk19_o","isc_is_LR_TOW_o","isc_is_LR_SPG9_o","isc_is_UAZ_MG_o","isc_is_UAZ_M2_o","isc_is_UAZ_AGS30_o","isc_is_UAZ_SPG9_o","isc_is_hilux_Unarmed_o","isc_saa_BTR60_o"];
	INS_Op4_Veh_Tracked = ["isc_saa_BMP1_o","isc_saa_BMP1P_o","isc_saa_BMP2_o","isc_saa_T55_o","isc_saa_T72_o","isc_saa_T72M_o","isc_saa_ZSU_o"];
	INS_Op4_Veh_Support = ["O_Truck_03_ammo_F","O_Truck_03_repair_F","O_Truck_02_Ammo_F","O_Truck_02_fuel_F","O_Truck_02_box_F","O_Truck_02_medical_F"];
	INS_Op4_Veh_AA = ["isc_saa_ZSU_o"];
	INS_Op4_stat_weps = ["isc_is_ZU23_o","isc_is_AGS_o","isc_is_SPG9_o","isc_is_DSHKM_o","isc_is_KORD_high_o","isc_is_GMG_o","isc_is_M2Static_o","isc_is_MK19_TriPod_o","isc_is_Metis_o","isc_is_Igla_o","isc_is_Stinger_o","isc_is_TOW_o","isc_is_2b14_82mm_o","isc_is_M252_o","isc_is_D30_o","isc_is_D30_AT_o","isc_is_M119_o","isc_is_M119_AT_o"];
	INS_civlist = ["C_man_p_beggar_F","C_man_1","C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F","C_man_polo_6_F","C_man_shorts_1_F","C_man_1_1_F","C_man_1_2_F","C_man_1_3_F","C_man_p_fugitive_F","C_man_p_shorts_1_F","C_man_hunter_1_F","C_man_shorts_2_F","C_man_shorts_3_F","C_man_shorts_4_F"];// A3 Civilians
	INS_civ_Veh_Car = ["C_Hatchback_01_F","C_Offroad_01_F","C_Quadbike_01_F","C_SUV_01_F"];
	INS_civ_Veh_Utl = ["C_Van_01_box_F","C_Van_01_transport_F","C_Van_01_fuel_F"];
};

// Air classes used by AirPatrolEast.sqf
INS_Op4_A3_fixedWing = ["I_Plane_Fighter_03_AA_F","I_Plane_Fighter_03_CAS_F","O_Plane_CAS_02_F"];
INS_Op4_A3_helis = ["O_Heli_Attack_02_black_F"];
INS_OP4_mod_fixedWing = ["RHS_Su25SM_vvsc","RHS_Su25SM_KH29_vvsc","RHS_Su25SM_KH29_vvs","RHS_Su25SM_vvs"];//"JS_JC_SU35","IVORY_MIG29K_1","RHS_Su25SM_vvsc"
INS_OP4_mod_helis = ["RHS_Mi24P_vvsc","RHS_Mi24V_vvsc"];

//Serviceable West UAVs
INS_W_Serv_UAVs = ["B_UAV_02_CAS_F","B_UAV_02_F","B_UAV_01_F"];
//Aircraft lacking chaff
INS_add_Chaff = ["B_Heli_Light_01_F","B_Heli_Light_01_armed_F","B_Heli_Light_01_stripped_F"];

INS_lights = ["Lamps_Base_F","PowerLines_base_F","Land_PowerPoleWooden_F","Land_LampHarbour_F","Land_LampShabby_F","Land_PowerPoleWooden_L_F","Land_PowerPoleWooden_small_F","Land_LampDecor_F","Land_LampHalogen_F","Land_LampSolar_F","Land_LampStreet_small_F","Land_LampStreet_F","Land_LampAirport_F","Land_PowerPoleWooden_L_F"];

// Blufor Side
INS_Blu_side = WEST;

// Player class types
INS_W_PlayerEng = ["B_engineer_F","B_soldier_repair_F","B_mas_mar_soldier_repair_F_v","B_mas_mar_soldier_repair_F_d"];// can build FARP
INS_W_PlayerJTAC = ["B_recon_TL_F","B_recon_JTAC_F","B_Soldier_SL_F","B_Soldier_TL_F","B_support_Mort_F","B_mas_mar_Soldier_JTAC_F_d","B_mas_mar_Soldier_JTAC_F_v","B_mas_mar_Soldier_TL_F_rec_d","B_mas_mar_Soldier_TL_F_rec_v","B_mas_mar_Soldier_F_rec_v"];// can call in CAS
INS_W_PlayerMedic = ["B_medic_F","B_recon_medic_F","B_mas_mar_medic_F_v","B_mas_mar_medic_F_d","B_mas_mar_medic_F_rec_d","B_mas_mar_medic_F_rec_v","B_mas_mar_medic_F_rec_vn"];// can build sandbag
INS_W_PlayerEOD = ["B_engineer_F","B_soldier_repair_F","B_soldier_exp_F","B_mas_mar_soldier_exp_F_rec_d","B_mas_mar_soldier_exp_F_rec_dn","B_mas_mar_soldier_exp_F_d","B_mas_mar_soldier_repair_F_d","B_mas_mar_soldier_exp_F_rec_v","B_mas_mar_soldier_exp_F_v"];//can deactivate mines/IEDs and use mine detector script
INS_W_PlayerUAVop = ["B_soldier_UAV_F","B_mas_mar_Soldier_UAV_F_v","B_mas_mar_Soldier_UAV_F_d"];// can call in UGV air drop and use huntIR
INS_W_PlayerSniper = ["B_recon_M_F","B_spotter_F","B_sniper_F","B_soldier_M_F","B_ghillie_ard_F","B_ghillie_lsh_F","B_ghillie_sard_F","B_Recon_Sharpshooter_F","B_mas_mar_soldier_Sg_F_v","B_mas_mar_soldier_Mhg_F_v","B_mas_mar_soldier_M_F_v","B_mas_mar_soldier_M_F_d","B_mas_mar_soldier_Mhg_F_d","B_mas_mar_soldier_Sg_F_d","B_mas_mar_soldier_M_F_rec_d","B_mas_mar_soldier_M_F_rec_v"];// can use bullet cam
INS_op4_players = "O_medic_F";// Opfor players "O_Soldier_F","O_medic_F","o_soldier_universal_f"
INS_all_medics = ["O_medic_F","B_medic_F","B_recon_medic_F","B_mas_mar_medic_F_v","B_mas_mar_medic_F_d","B_mas_mar_medic_F_rec_d","B_mas_mar_medic_F_rec_v","B_mas_mar_medic_F_rec_vn"];
INS_PlayerPilot = [];// Classes who can pilot aircraft. Empty array for no restrictions.

// Blufor Repair Support Vehicles
INS_W_repairTruck = ["B_Truck_01_Repair_F","B_APC_Tracked_01_CRV_F"];//"B_G_Offroad_01_repair_F"

// Liftable object
BTC_fob_materials = ["Land_Cargo20_military_green_F"];//"Box_NATO_AmmoVeh_F" "Land_CargoBox_V1_F"

if (INS_GasGrenadeMod isEqualTo 1) then {
	// All Headgear to use as Gasmask
	INS_gasMaskH = ["H_CrewHelmetHeli_B","H_CrewHelmetHeli_O","H_CrewHelmetHeli_I","H_PilotHelmetFighter_B","H_PilotHelmetFighter_O","H_PilotHelmetFighter_I"];
	// All Goggles to use as Gasmask
	INS_gasMaskG = ["Mask_M50","Mask_M40","Mask_M40_OD","G_mas_wpn_gasmask"];// Hidden Identity Pack v2 and NATO SF and Russian Spetsnaz Weapons v1.10
	// All Grenades to use as Poisonous Gas Grenades
	INS_Gas_Grenades = ["SmokeShellYellow","G_40mm_SmokeYellow"];// fired ammo
};