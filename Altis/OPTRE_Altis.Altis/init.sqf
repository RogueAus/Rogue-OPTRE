/*
@filename: init.sqf
Author:
	
Rogue

Last modified:

	4/06/16 ArmA 1.60 by Rogue
	
Description:

	Things that may run on both server and client.
______________________________________________________*/

keyspressed = compile preprocessFile "functions\pa_keyHandler.sqf";
_display = findDisplay 46;
_display displaySetEventHandler ["KeyDown","_this call keyspressed"];