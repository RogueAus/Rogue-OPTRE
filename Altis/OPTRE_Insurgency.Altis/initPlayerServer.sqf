private["_player","_didJIP","_update","_intel","_text","_hcEntities"];

_player = _this select 0;
_didJIP =  _this select 1;
_update = false;
_hcEntities = entities "HeadlessClient_F";
_text = format["%1 joined the game!",name _player];

//[[_text],"JIG_MPsideChatWest_fnc"] call BIS_fnc_MP;
//[[_text],"JIG_MPsideChatEast_fnc"] call BIS_fnc_MP;

if !(_player in _hcEntities) then {

	waitUntil {!isNil "INS_play_op4"};
	if (INS_play_op4 isEqualTo 0) then {
		waitUntil {!isNil "Playable_Op4_disabled"};
		if (side _player == east) exitWith {
			[[],"Playable_Op4_disabled",_player] call BIS_fnc_MP;
		};
	};

	waitUntil {!isNil "Kick_For_Duration"};
	if ((count Kick_For_Duration) > 0) then {
		private ["_uid","_pname"];
		_uid = getPlayerUID _player;
		waitUntil {!isNil "Kicked_for_TKing"};
		if (_uid in Kick_For_Duration) exitWith {
			_pname = name _player;
			[[],"Kicked_for_TKing",_player] call BIS_fnc_MP;
			diag_log format ["Forced mission ending applied to PlayerName: %1 SteamID: %2 Player tried to rejoin after exceeding team kill warning limit set by BTC_tk_last_warning.", _pname, _uid];
		};
	};

	waitUntil {!isNil "JIPmkr_updateClient_fnc"};
	call JIPmkr_updateClient_fnc;

	waitUntil {!isNil "intel_Build_objs"};
	if ((count intel_Build_objs) > 0) then {
		//{if (format["%1",_x] == "<NULL-object>") then {intel_Build_objs = intel_Build_objs - [_x];};} forEach intel_Build_objs;
		if (ObjNull in intel_Build_objs) then {
			{intel_Build_objs = intel_Build_objs - [objNull]} forEach intel_Build_objs;
			_update = true;
		};
	};
	{_intel = _x; [[_intel,current_cache_pos],"fnc_jip_mp_intel",_player] spawn BIS_fnc_MP;} forEach intel_Build_objs;
	if (_update) then {publicVariableServer "intel_Build_objs";};
/*
} else {
	if (_didJIP) then {
		waitUntil {!isNil {server getVariable "EOSmkrStates"}};
		waitUntil {!isNil "disableEOSmkrs_fnc"};
		[[],"disableEOSmkrs_fnc",_player] call BIS_fnc_MP;
	};
*/
};