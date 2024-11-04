
if !(isServer) exitWith {};

comment "Component: hellbomb.sqf";

if (isNil "bax_pzeus_hellbomb_fnc_detonateHellbomb") then {
	bax_pzeus_hellbomb_fnc_detonateHellbomb = {
		if !(canSuspend) exitWith {
			_this spawn bax_pzeus_hellbomb_fnc_detonateHellbomb;
		};
	
		params ["_device", "_terminal", "_rings", "_delay"];
		
		_pos = getPos _device;
		_strTime = str time;
		_markerInnerName = "HellbombInner" + _strTime;
		_markerOuterName = "HellbombOuter" + _strTime;
		createMarkerLocal [_markerInnerName, _pos];
		_markerInnerName setMarkerShapeLocal "ELLIPSE";
		_markerInnerName setMarkerSizeLocal [120, 120];
		_markerInnerName setMarkerColorLocal "ColorRed";
		_markerInnerName setMarkerAlphaLocal 0.6;
		_markerInnerName setMarkerBrush "SolidBorder";
		createMarkerLocal [_markerOuterName, _pos];
		_markerOuterName setMarkerShapeLocal "ELLIPSE";
		_markerOuterName setMarkerSizeLocal [200, 200];
		_markerOuterName setMarkerColorLocal "ColorYellow";
		_markerOuterName setMarkerBrush "Border";
	
		sleep 2;
		_startTime = time;
		_devicePos = getPos _device;
		waitUntil {
			sleep 0.9;
			_players = allPlayers select { (getPos _x) distance2D _devicePos < 1000 };
			_text = format ["Hellbomb detonation in T-%1", (str ceil (_startTime + _delay - time))];
			_text = format ["<t align='center' size='1.2' color='%1'>%2</t>", "#ff1100", _text];
			[_text, 0, -0.3, 1.2, 0, 0, "bax_pzeus_displayText_title"] remoteExec ["bis_fnc_dynamicText", _players];
			time > _startTime + _delay
		};
		sleep 2;
	
		deleteVehicle _device;
		deleteVehicle _terminal;
	
		_posCoords = [[0,0,0]];

		if (_rings >= 1) then {
			_innerFactor = 40;
			_innerHexCoords = [0, 60, 120, 180, 240, 300] apply {
				[_innerFactor*sin(_x), _innerFactor*cos(_x), 0]
			};
			_posCoords append _innerHexCoords;
		};
		if (_rings >= 2) then {
			_outerFactor = 75;
			_outerHexCoords = [0, 30, 60, 90, 120, 150, 180, 210, 240, 270, 300, 330] apply {
				[_outerFactor*cos(_x), _outerFactor*sin(_x), 0]
			};
			_posCoords append _outerHexCoords;
		};
	
		_posCoords apply {
			_veh = "Bo_GBU12_LGB" createVehicle (_x vectorAdd _devicePos);
			sleep 0.2;
		};

		_veget = nearestTerrainObjects [_devicePos, ["TREE", "SMALL TREE", "BUSH"],95];
		_build = nearestObjects [_devicePos, ["building"], 95];
		_misce = nearestObjects [_devicePos, ["man", "car", "tank", "plane", "helicopter"],95];
		{
			if !(_x isKindOf "Land_HelipadEmpty_F") then {
				_x setVelocity [0, 0, 30 + random 30];
				_x setDamage 1;
				sleep 0.05;
			};
		} forEach _misce;
		{
			if !(_x isKindOf "Land_HelipadEmpty_F") then {
				_x setDamage [1, false];
				sleep 0.05;
			}
		} foreach _build;
		{
			_x setDamage 1;
			sleep 0.05;
		} foreach _veget;
	
		_markerInnerName setMarkerColor "ColorGrey";
		_markerOuterName setMarkerColor "ColorGrey";
	};
	publicVariable "bax_pzeus_hellbomb_fnc_detonateHellbomb";
};

if (isNil "bax_pzeus_hellbomb_fnc_initializeHellbomb") then {
	bax_pzeus_hellbomb_fnc_initializeHellbomb = {
		params ["_spawnPos", "_rings", "_delay"];
	
		_device = createVehicle ["Land_Device_assembled_F", _spawnPos];
		_terminal = "Land_DataTerminal_01_F" createVehicle _spawnPos;
		_terminal allowDamage false;
		_terminal attachTo [_device, [-1.22, 0.3, -0.35]];
		_terminal setDir 90;
		_device setVariable ["bax_pzeus_hellbomb_terminal", _terminal, true];
		_terminal setVariable ["bax_pzeus_hellbomb_device", _device, true];

		[
			_terminal,
			12,
			{
				params ["_terminal", "_args"];
				_args params ["_rings", "_delay"];
	
				_device = _terminal getVariable ["bax_pzeus_hellbomb_device", objNull];
				[_device, _terminal, _rings, _delay] call bax_pzeus_hellbomb_fnc_detonateHellbomb;
			},
			[_rings, _delay]
		] call bax_pzeus_terminals_fnc_initializeTerminal;

		_device;
	};
	publicVariable "bax_pzeus_hellbomb_fnc_initializeHellbomb";
};

comment "Component: terminals.sqf";

if (isNil "bax_pzeus_terminals_fnc_inputTerminalAction") then {
	bax_pzeus_terminals_fnc_inputTerminalAction = {
		params ["_terminal", "_referenceTerminalCodeIndex", "_inputValue"];
		
		_terminalCode = _terminal getVariable ["bax_pzeus_terminals_terminalCode", [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]];
		_terminalCodeIndex = _terminal getVariable ["bax_pzeus_terminals_terminalCodeIndex",0];
		
		if (_terminalCodeIndex == -1) exitWith {};

		if (_terminalCodeIndex != _referenceTerminalCodeIndex) exitWith {};
		
		if (_inputValue == (_terminalCode select _terminalCodeIndex)) then {
			_terminalCodeIndex = _terminalCodeIndex + 1;
		} else {
			_terminalCodeIndex = -1;
		};

		if (_terminalCodeIndex >= 12) exitWith {
			_terminal setObjectTextureGlobal [0, ""];
			[[_terminal], {
				params ["_terminal"];
				removeAllActions _terminal;
				[_terminal, 0] call BIS_fnc_dataTerminalAnimate;
			}] remoteExec ["spawn", 0, _terminal];
			_onCompleteFunction = _terminal getVariable ["bax_pzeus_terminals_onCompleteFunction", { hint "No on complete function?" }];
			_args = _terminal getVariable ["bax_pzeus_terminals_functionArgs", []];
			[_terminal, _args] call _onCompleteFunction;
		};
	
		if (_terminalCodeIndex == -1) exitWith {
			_terminal setVariable ["bax_pzeus_terminals_terminalCodeIndex", -1, true];
			_terminal setObjectTextureGlobal [0,"#(rgb,1,1,1)color(1,0.3,0,1)"];
			[_terminal,_terminalCode] spawn {
				params ["_terminal","_terminalCode"];
	
				sleep 2;
	
				_terminal setVariable ["bax_pzeus_terminals_terminalCodeIndex",0,true];
				_image = switch (_terminalCode select 0) do {
					case 0: {"a3\ui_f\data\gui\rsccommon\rschtml\arrow_left_ca.paa"};
					case 1: {"a3\ui_f\data\igui\cfg\actions\arrow_up_gs.paa"};
					case 2: {"a3\ui_f\data\gui\rsccommon\rschtml\arrow_right_ca.paa"};
					case 3: {"a3\ui_f\data\igui\cfg\actions\arrow_down_gs.paa"};
				};
				_terminal setObjectTextureGlobal [0,_image];
			};
		};
		
		_terminal setVariable ["bax_pzeus_terminals_terminalCodeIndex",_terminalCodeIndex,true];
		_image = switch (_terminalCode select _terminalCodeIndex) do {
			case 0: {"a3\ui_f\data\gui\rsccommon\rschtml\arrow_left_ca.paa"};
			case 1: {"a3\ui_f\data\igui\cfg\actions\arrow_up_gs.paa"};
			case 2: {"a3\ui_f\data\gui\rsccommon\rschtml\arrow_right_ca.paa"};
			case 3: {"a3\ui_f\data\igui\cfg\actions\arrow_down_gs.paa"};
		};
		_terminal setObjectTextureGlobal [0,_image];
	};
	publicVariable "bax_pzeus_terminals_fnc_inputTerminalAction";
};

if (isNil "bax_pzeus_terminals_fnc_initializeTerminal") then {
	bax_pzeus_terminals_fnc_initializeTerminal = {
		params ["_terminal", "_size", "_onCompleteFunction", ["_args", []]];
	
		[[_terminal], {
			params ["_terminal"];

			if (isNil "_terminal" or { !(alive _terminal) }) exitWith {};

			[_terminal, "red", "orange", "red"] call BIS_fnc_dataTerminalColor;
	
			_actionId = _terminal addAction [
				"Hit Ctrl x2 to lower weapon and use Ctrl [WASD] to quickly input key code",
				{},
				[],
				1.5,
				true,
				false,
				""
			];
			_displayText = [
				"<br/><br/><t size='2'>",
				"Ctrl x2 to lower weapon.",
				"Ctrl + W",
				"<img image='a3\ui_f\data\igui\cfg\actions\arrow_up_gs.paa' />",
				"Ctrl + A " +
				"<img image='a3\ui_f\data\gui\rsccommon\rschtml\arrow_left_ca.paa' />" +
				"      " +
				"<img image='a3\ui_f\data\gui\rsccommon\rschtml\arrow_right_ca.paa' />" +
				" Ctrl + D",
				"<img image='a3\ui_f\data\igui\cfg\actions\arrow_down_gs.paa' />",
				"Ctrl + S</t>"
			] joinString "<br/>";
			_terminal setUserActionText [
				_actionId,
				"Hit Ctrl x2 to lower weapon and use Ctrl [WASD] to quickly input key code",
				"",
				_displayText
			];
	
			_terminal addAction [
				"<img image='a3\ui_f\data\gui\rsccommon\rschtml\arrow_left_ca.paa' /> Left  (Ctrl+A)",
				{
					params ["_target", "_caller", "_actionId", "_args"];
					_terminalCodeIndex = _target getVariable ["bax_pzeus_terminals_terminalCodeIndex", 0];
					playSound "Beep_Target";
					[_target, _terminalCodeIndex, 0] remoteExecCall ["bax_pzeus_terminals_fnc_inputTerminalAction", 2];
				},
				[],
				1.5,
				true,
				false,
				"AdjustLeft"
			];
	
			_terminal addAction [
				"<img image='a3\ui_f\data\igui\cfg\actions\arrow_up_gs.paa' /> Up    (Ctrl+W)",
				{
					params ["_target", "_caller", "_actionId", "_args"];
					_terminalCodeIndex = _target getVariable ["bax_pzeus_terminals_terminalCodeIndex", 0];
					playSound "Beep_Target";
					[_target, _terminalCodeIndex, 1] remoteExecCall ["bax_pzeus_terminals_fnc_inputTerminalAction", 2];
				},
				[],
				1.5,
				true,
				false,
				"AdjustUp"
			];
	
			_terminal addAction [
				"<img image='a3\ui_f\data\gui\rsccommon\rschtml\arrow_right_ca.paa' /> Right (Ctrl+D)",
				{
					params ["_target", "_caller", "_actionId", "_args"];
					_terminalCodeIndex = _target getVariable ["bax_pzeus_terminals_terminalCodeIndex", 0];
					playSound "Beep_Target";
					[_target, _terminalCodeIndex, 2] remoteExecCall ["bax_pzeus_terminals_fnc_inputTerminalAction", 2];
				},
				[],
				1.5,
				true,
				false,
				"AdjustRight"
			];
	
			_terminal addAction [
				"<img image='a3\ui_f\data\igui\cfg\actions\arrow_down_gs.paa' /> Down  (Ctrl+S)",
				{
					params ["_target", "_caller", "_actionId", "_args"];
					_terminalCodeIndex = _target getVariable ["bax_pzeus_terminals_terminalCodeIndex", 0];
					playSound "Beep_Target";
					[_target, _terminalCodeIndex, 3] remoteExecCall ["bax_pzeus_terminals_fnc_inputTerminalAction", 2];
				},
				[],
				1.5,
				true,
				false,
				"AdjustDown"
			];

			[_terminal, 2] call BIS_fnc_dataTerminalAnimate;
		}] remoteExec ["spawn", 0, _terminal];

		_terminalCode = [];
		_previousValue = -1;
		for "_i" from 1 to _size do {
			_nextValue = floor random 3.9;

			if (_nextValue == _previousValue) then {
				_nextValue = (_nextValue + (floor random 2.9) + 1) % 4;
			};
			_previousValue = _nextValue;
			_terminalCode pushBack _nextValue;
		};
		_terminal setVariable ["bax_pzeus_terminals_terminalCode", _terminalCode, true];
		_terminal setVariable ["bax_pzeus_terminals_terminalCodeIndex", 0, true];
		_terminal setVariable ["bax_pzeus_terminals_onCompleteFunction", _onCompleteFunction, true];
		_terminal setVariable ["bax_pzeus_terminals_functionArgs", _args, true];
		_image = switch (_terminalCode select 0) do {
			case 0: {"a3\ui_f\data\gui\rsccommon\rschtml\arrow_left_ca.paa"};
			case 1: {"a3\ui_f\data\igui\cfg\actions\arrow_up_gs.paa"};
			case 2: {"a3\ui_f\data\gui\rsccommon\rschtml\arrow_right_ca.paa"};
			case 3: {"a3\ui_f\data\igui\cfg\actions\arrow_down_gs.paa"};
		};
		_terminal setObjectTextureGlobal [0, _image];
	};
	publicVariable "bax_pzeus_terminals_fnc_initializeTerminal";
};

[getPos this, 2, 90] call bax_pzeus_hellbomb_fnc_initializeHellbomb;
deleteVehicle this;
