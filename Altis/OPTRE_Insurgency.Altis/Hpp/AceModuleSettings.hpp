//http://ace3mod.com/wiki/framework/settings-framework.html
class ACE_Settings {
    // Add exported settings here
	class ace_common_forceAllSettings {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_common_checkPBOsAction {
		value = 0;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_common_checkPBOsCheckAll {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_common_checkPBOsWhitelist {
		value = "[]";
		typeName = "STRING";
		force = 1;
	};
	class ace_common_settingFeedbackIcons {
		value = 1;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_common_SettingProgressBarLocation {
		value = 0;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_common_displayTextColor {
		value[] = {0, 0, 0, 0.1};
		typeName = "COLOR";
		force = 1;
	};
	class ace_common_displayTextFontColor {
		value[] = {0.0572223, 0.793029, 0.793029, 1};
		typeName = "COLOR";
		force = 1;
	};
	class ace_finger_enabled {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_finger_maxRange {
		value = 4;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_finger_indicatorForSelf {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_finger_indicatorColor {
		value[] = {0.83, 0.68, 0.21, 0.75};
		typeName = "COLOR";
		force = 1;
	};
	class ace_frag_Enabled {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_frag_SpallEnabled {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_frag_maxTrack {
		value = 500;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_frag_MaxTrackPerFrame {
		value = 50;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_frag_EnableDebugTrace {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_goggles_showInThirdPerson {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_hitreactions_minDamageToTrigger {
		value = 0.1;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_interact_menu_AlwaysUseCursorSelfInteraction {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_interact_menu_cursorKeepCentered {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_interact_menu_AlwaysUseCursorInteraction {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_interact_menu_UseListMenu {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_interact_menu_colorTextMax {
		value[] = {1, 0.454558, 0, 1};
		typeName = "COLOR";
		force = 1;
	};
	class ace_interact_menu_colorTextMin {
		value[] = {1, 1, 0.194573, 0.508517};
		typeName = "COLOR";
		force = 1;
	};
	class ace_interact_menu_colorShadowMax {
		value[] = {0, 0, 0, 1};
		typeName = "COLOR";
		force = 1;
	};
	class ace_interact_menu_colorShadowMin {
		value[] = {0, 0, 0, 0.25};
		typeName = "COLOR";
		force = 1;
	};
	class ace_interact_menu_textSize {
		value = 2;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_interact_menu_shadowSetting {
		value = 2;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_interact_menu_actionOnKeyRelease {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_interact_menu_menuBackground {
		value = 0;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_interact_menu_addBuildingActions {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_interaction_EnableTeamManagement {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_inventory_inventoryDisplaySize {
		value = 0;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_laserpointer_enabled {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_magazinerepack_TimePerAmmo {
		value = 1.5;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_magazinerepack_TimePerMagazine {
		value = 2;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_magazinerepack_TimePerBeltLink {
		value = 8;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_map_BFT_Interval {
		value = 1;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_map_BFT_Enabled {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_map_BFT_HideAiGroups {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_map_mapIllumination {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_map_mapGlow {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_map_mapShake {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_map_mapLimitZoom {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_map_mapShowCursorCoordinates {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_maptools_EveryoneCanDrawOnBriefing {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_medical_level {
		value = 1;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_medical_medicSetting {
		value = 1;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_medical_enableFor {
		value = 0;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_medical_enableOverdosing {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_medical_bleedingCoefficient {
		value = 1;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_medical_painCoefficient {
		value = 1;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_medical_enableAirway {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_medical_enableFractures {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_medical_enableAdvancedWounds {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_medical_enableVehicleCrashes {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_medical_enableScreams {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_medical_playerDamageThreshold {
		value = 1;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_medical_AIDamageThreshold {
		value = 1;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_medical_enableUnconsciousnessAI {
		value = 1;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_medical_remoteControlledAI {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_medical_preventInstaDeath {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_medical_enableRevive {
		value = 0;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_medical_maxReviveTime {
		value = 120;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_medical_amountOfReviveLives {
		value = -1;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_medical_allowDeadBodyMovement {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_medical_allowLitterCreation {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_medical_litterSimulationDetail {
		value = 3;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_medical_litterCleanUpDelay {
		value = 0;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_medical_medicSetting_PAK {
		value = 1;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_medical_medicSetting_SurgicalKit {
		value = 1;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_medical_consumeItem_PAK {
		value = 0;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_medical_consumeItem_SurgicalKit {
		value = 0;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_medical_useLocation_PAK {
		value = 3;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_medical_useLocation_SurgicalKit {
		value = 2;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_medical_useCondition_PAK {
		value = 0;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_medical_useCondition_SurgicalKit {
		value = 0;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_medical_keepLocalSettingsSynced {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_medical_healHitPointAfterAdvBandage {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_medical_painIsOnlySuppressed {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_medical_painEffectType {
		value = 0;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_medical_allowUnconsciousAnimationOnTreatment {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_medical_moveUnitsFromGroupOnUnconscious {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_medical_menuTypeStyle {
		value = 0;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_medical_menu_allow {
		value = 1;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_medical_menu_useMenu {
		value = 0;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_medical_menu_openAfterTreatment {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_microdagr_MapDataAvailable {
		value = 2;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_missileguidance_enabled {
		value = 2;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_mk6mortar_airResistanceEnabled {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_mk6mortar_allowComputerRangefinder {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_mk6mortar_allowCompass {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_movement_useImperial {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_nametags_defaultNametagColor {
		value[] = {0.77, 0.51, 0.08, 1};
		typeName = "COLOR";
		force = 1;
	};
	class ace_nametags_showPlayerNames {
		value = 1;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_nametags_showPlayerRanks {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_nametags_showVehicleCrewInfo {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_nametags_showNamesForAI {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_nametags_showCursorTagForVehicles {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_nametags_showSoundWaves {
		value = 1;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_nametags_playerNamesViewDistance {
		value = 5;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_nametags_playerNamesMaxAlpha {
		value = 0.8;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_nametags_tagSize {
		value = 2;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_optionsmenu_optionMenuDisplaySize {
		value = 0;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_optionsmenu_showNewsOnMainMenu {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_overheating_DisplayTextOnJam {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_reload_DisplayText {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_repair_DisplayTextOnRepair {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_repair_engineerSetting_Repair {
		value = 1;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_repair_engineerSetting_Wheel {
		value = 0;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_repair_repairDamageThreshold {
		value = 0.6;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_repair_repairDamageThreshold_Engineer {
		value = 0.4;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_repair_consumeItem_ToolKit {
		value = 1;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_repair_fullRepairLocation {
		value = 2;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_repair_engineerSetting_fullRepair {
		value = 2;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_repair_addSpareParts {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_repair_wheelRepairRequiredItems {
		value = 0;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_respawn_SavePreDeathGear {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_respawn_RemoveDeadBodiesDisconnected {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_respawn_BodyRemoveTimer {
		value = 0;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_sitting_enable {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_spectator_filterUnits {
		value = 2;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_spectator_filterSides {
		value = 0;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_spectator_restrictModes {
		value = 0;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_spectator_restrictVisions {
		value = 0;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_switchunits_EnableSwitchUnits {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_switchunits_SwitchToWest {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_switchunits_SwitchToEast {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_switchunits_SwitchToIndependent {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_switchunits_SwitchToCivilian {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_switchunits_EnableSafeZone {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_switchunits_SafeZoneRadius {
		value = 100;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_vehiclelock_DefaultLockpickStrength {
		value = 10;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_vehiclelock_LockVehicleInventory {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_vehiclelock_VehicleStartingLockState {
		value = -1;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_viewdistance_enabled {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_viewdistance_viewDistanceOnFoot {
		value = 0;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_viewdistance_viewDistanceLandVehicle {
		value = 0;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_viewdistance_viewDistanceAirVehicle {
		value = 0;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_viewdistance_limitViewDistance {
		value = 10000;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_viewdistance_objectViewDistanceCoeff {
		value = 0;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_weaponselect_DisplayText {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_weather_enableServerController {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_weather_useACEWeather {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_weather_syncRain {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_weather_syncWind {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_weather_syncMisc {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_weather_serverUpdateInterval {
		value = 60;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_winddeflection_enabled {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_winddeflection_vehicleEnabled {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_winddeflection_simulationInterval {
		value = 0.05;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_winddeflection_simulationRadius {
		value = 3000;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_zeus_zeusAscension {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_zeus_zeusBird {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_zeus_remoteWind {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_zeus_radioOrdnance {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_zeus_revealMines {
		value = 0;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_zeus_autoAddObjects {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_captives_allowHandcuffOwnSide {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_captives_requireSurrender {
		value = 1;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_captives_allowSurrender {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_cargo_enable {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_explosives_RequireSpecialist {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_explosives_PunishNonSpecialists {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_explosives_ExplodeOnDefuse {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_hearing_EnableCombatDeafness {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_hearing_EarplugsVolume {
		value = 0.5;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_hearing_UnconsciousnessVolume {
		value = 0.4;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_hearing_DisableEarRinging {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_hearing_enabledForZeusUnits {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_advanced_ballistics_enabled {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_advanced_ballistics_simulateForSnipers {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_advanced_ballistics_simulateForGroupMembers {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_advanced_ballistics_simulateForEveryone {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_advanced_ballistics_disabledInFullAutoMode {
		value = 0;
		typeName = "BOOL";
		force = 1;
	};
	class ace_advanced_ballistics_ammoTemperatureEnabled {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_advanced_ballistics_barrelLengthInfluenceEnabled {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_advanced_ballistics_bulletTraceEnabled {
		value = 1;
		typeName = "BOOL";
		force = 1;
	};
	class ace_advanced_ballistics_simulationInterval {
		value = 0;
		typeName = "SCALAR";
		force = 1;
	};
	class ace_advanced_ballistics_simulationRadius {
		value = 3000;
		typeName = "SCALAR";
		force = 1;
	};
};