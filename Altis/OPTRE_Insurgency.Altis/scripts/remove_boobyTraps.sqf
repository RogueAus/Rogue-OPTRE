//remove_boobyTraps.sqf by Jigsor

if (!isServer) exitwith {};
waitUntil {time > 62};

private ["_totalItems","_cleanup_mkrs","_nearestMines","_nearestMinebase"];

_totalItems = [];
_cleanup_mkrs = Blu4_mkrs + ["Airfield"];

for [{_loop=0}, {_loop<1}, {_loop=_loop}] do
{
	_totalItems = _totalItems - _totalItems;
	{
		_nearestMines = getmarkerPos _x nearObjects ["TimeBombCore",50];
		{
			if (mineActive _x) then
			{
				_totalItems set [count _totalItems,_x]
			};
		} foreach _nearestMines;

		_nearestMinebase = getmarkerPos _x nearObjects ["minebase",50];
		{
			_totalItems set [count _totalItems,_x]
		} foreach _nearestMinebase;

		{deleteVehicle _x; sleep 0.1;} foreach _totalItems;
	} foreach _cleanup_mkrs;
	sleep 120;
};