/*
@filename: initPlayerLocal.sqf
Author:
	
	Quiksilver - Thanks for the template and a few scripts

Last modified:

	04/06/2016 ArmA 1.60 by Rogue
	
Description:

	Client scripts and event handlers.
______________________________________________________*/

player enableFatigue FALSE;

//------------------- client executions

{_x addCuratorEditableObjects [[player],FALSE];} count allCurators;

_null = [] execvm "scripts\vehicle\crew\crew.sqf"; 								// vehicle HUD
//_null = [] execVM 'scripts\group_manager.sqf';									// group manager
//_null = [] execVM "scripts\restrictions.sqf"; 									// gear restrictions and safezone
//_null = [] execVM "scripts\pilotCheck.sqf"; 									// pilots only
_null = [] execVM "scripts\jump.sqf";// jump action
_null = [] execVM "scripts\holster.sqf";											//Holsteraction	
_null = [] execVM "scripts\icons.sqf";											// blufor map tracker Quiksilver
//_null = [] execVM "scripts\voice_control\voiceControl.sqf";						// Voice Control
//if (PARAMS_HeliRope != 0) then {call compile preprocessFileLineNumbers "scripts\vehicle\fastrope\zlt_fastrope.sqf";};	
//if (PARAMS_HeliSling != 0) then {call compile preprocessFileLineNumbers "scripts\vehicle\sling\sling_config.sqf";};				// Heli Sling.

// call QS_fnc_respawnPilot;



//Dynamic Groups

["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;
	
//--------------------- Squad Url Hint

_infoArray = squadParams player;    
_infoSquad = _infoArray select 0;
_squad = _infoSquad select 1;
_infoName = _infoArray select 1;
_name = _infoName select 1; 
_email = _infoSquad select 2;


// replace line below with your Squad xml's email
if (_email == "arma@ahoyworld.co.uk") then {

GlobalHint = format["<t align='center' size='2.2' color='#FF0000'>%1<br/></t><t size='1.4' color='#33CCFF'>%2</t><br/>has joined the server, To get involved in the Ahoy World community, register an account at www.AhoyWorld.co.uk and get stuck in!</t><br/>",_squad,_name];

hint parseText GlobalHint; publicVariable "GlobalHint";
} else {};