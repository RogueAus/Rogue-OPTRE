// Original pilotcheck by Kamaradski [AW]. 
// Since then been tweaked by many hands!
// Notable contributors: chucky [allFPS], Quiksilver.

_pilots = ["OPTRE_UNSC_Airforce_Soldier_Airman"];
_aircraft_nocopilot = ["OPTRE_Pelican_armed_green","OPTRE_Pelican_armed_tan","OPTRE_Pelican_armed_black","OPTRE_Pelican_armed_Marine","OPTRE_Pelican_unarmed_green","OPTRE_Pelican_unarmed_tan","OPTRE_Pelican_unarmed_black","OPTRE_Pelican_unarmed_Marine"];

waitUntil {player == player};

_iampilot = ({typeOf player == _x} count _pilots) > 0;

//Remove comments and insert UIDs into the whitelist to exempt individuals from this script
_uid = getPlayerUID player;
_whitelist = ["76561198059693747"/*Rogue*/,"76561198160246849"/*Machine*/,"76561198111830735"/*ItsLiam*/,""/*Matt.k (Waiting his PID*/];

if (_uid in _whitelist) exitWith {};


while { true } do {
	_oldvehicle = vehicle player;
	waitUntil {vehicle player != _oldvehicle};

	if(vehicle player != player) then {
		_veh = vehicle player;

		//------------------------------ pilot can be pilot seat only
		
		if((_veh isKindOf "Helicopter" || _veh isKindOf "Plane") && !(_veh isKindOf "ParachuteBase")) then {
			if(({typeOf _veh == _x} count _aircraft_nocopilot) > 0) then {
				_forbidden = [_veh turretUnit [0]];
				if(player in _forbidden) then {
					if (!_iampilot) then {
						systemChat "Co-pilot is disabled on this vehicle";
						player action ["getOut",_veh];
					};
				};
			};
			if(!_iampilot) then {
				_forbidden = [driver _veh];
				if (player in _forbidden) then {
					systemChat "You must be a pilot to fly this aircraft";
					player action ["getOut", _veh];
				};
			};
		};
	};
};

