/*
@filename: enemyInd.hpp
Author:

	Quiksilver
	
Description:
	INDEPENDENT
	Units, vehicles and groups, for use elsewhere in the mission.
	Doing this alleviates the need to dig through configFile, which eats more server CPU.
	Also allows greater control over what is being spawned, and where, yet allows for random composition groups.
	
	Sentry = 2-man
	Team = 4-man
	Squad = 8-man
__________________________________________________*/

class ind {
	units[] = {
		"OPTRE_Ins_ER_Terrorist",
		"OPTRE_Ins_ER_Farmer",
		"OPTRE_Ins_ER_Deserter_GL",
		"OPTRE_Ins_ER_Insurgent_BR",
		"OPTRE_Ins_ER_Warlord",
		"OPTRE_Ins_ER_MAdvisor",
		"OPTRE_Ins_ER_Militia_MG",
		"OPTRE_Ins_ER_Rebel_AT",
		"OPTRE_Ins_ER_Guerilla_AR"
	};
};
