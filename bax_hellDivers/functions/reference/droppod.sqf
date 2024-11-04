
bax_pzeus_droppod_fnc_drop = {
	if !(canSuspend) exitWith {
		_this spawn bax_pzeus_droppod_fnc_drop;
	};

	// TODO: Add a last parameter for 'findSafePos' to enable that as optional. Allows for fixed landing pads in comps.
	params ["_dropObject","_lz",["_craterless",false],["_craterOffset",[0,0,1]]];
	// private ["_projectile","_posLZ","_posDrop"];

	if (_lz isEqualType []) then {
		_lz = createVehicle ["Land_HelipadEmpty_F", _lz, [], 0, "CAN_COLLIDE"];
	};

	_posLz = getPos _lz;
	_posLz set [2, 0];
	_posDrop = getPos _lz;
	_posDrop set [2, 1900];
	
	_projectile = createVehicle ["B_93x64_Ball", _posDrop];
	_projectile setPosATL _posDrop;
	_dropObject attachTo [_projectile, [0, 0, 30]];
	_velocity = (_posLZ vectorFromTo _posDrop) vectorMultiply -200;
	_projectile setVelocity _velocity;

	waitUntil {
		_projectile setVelocity _velocity;
		// !(((getPos _projectile) distance _posLZ < 65) or {alive _projectile});
		!(alive _projectile);
	};

	if (_craterless) then {
		_posLZ = [_posLZ, 0, 15] call BIS_fnc_findSafePos;
		_posLZ set [2, 0];
		detach _dropObject;
		_dropObject setVelocity [0, 0, 0];
		_dropObject setPosATL _posLZ;
	} else {
		_crater = createVehicle ["Land_ShellCrater_02_small_F", _posLZ, [], 0, "CAN_COLLIDE"];
		_dropObject attachTo [_crater, _craterOffset];
	};
	
	if ((typeOf _dropObject) == "Land_Pod_Heli_Transport_04_covered_F") then {
		([_dropObject, 'Door_4_move_1', 'Door_4_move_2', 'Door_4_handle_rot'] call BIS_fnc_DoorOpen);
		([_dropObject, 'Door_5_move_1', 'Door_5_move_2', 'Door_5_handle_rot'] call BIS_fnc_DoorOpen);
		_dropObject animateDoor ["Door_6_source", 1];
	};

	// TODO: Figure out another effect that doesnt have a delayed repeat.
	createVehicle ["MissileCore", _posLZ];
	playSound3d ["A3\Sounds_F\weapons\Rockets\explosion_missile_04.wss", objNull, false, _posLZ];
};

_pod = _this;
_vel = velocity _pod;
_dir = direction _pod;
_speed = 0;
_pod setVariable ["DOS_P_Pod_Launched", true];

openMap true;
hint "Click on map to launch Drop Pod.";
onMapSingleClick {
	_pos set [2, 2500]; // m altitude
	vehicle player setPos _pos;
	onMapSingleClick "";
	true;
	openMap false;
};

waitUntil { getPos _pod select 2 > 2000 };
waitUntil { getPos _pod select 2 < 2000 };

playSound3D ["A3\Sounds_F\environment\ambient\battlefield\battlefield_explosions5.wss", _pod, false, getPosASL _pod, 4, 4, 0];
if ((driver _pod isEqualTo player) OR (player in (crew _pod))) then {addCamShake [2,1000,5];};
_fireball = createVehicle ["test_EmptyObjectForFireBig", [0, 0, 0], [], 0, "CAN_COLLIDE"];
_fireball attachTo [_pod, [0,0,0]];

waitUntil { getPos _pod select 2 < 1000 };

_impact = "Hellpod_ImpactAmmo" createVehicle [0,0,10000];
_impact attachTo [_pod, [0,0,0], "attach_point"];
_impact setVectorDirAndUp [[0,0,-1], [-1,0,-1]];
_impact disableCollisionWith _pod;

waitUntil { (!alive _impact) || getPosATL _pod select 2 < 1 || isTouchingGround _pod };

playSound3D ["A3\Sounds_F\sfx\missions\vehicle_collision.wss", _pod];
_pod setVelocity [0,0,0];
_pod setVectorUp surfaceNormal position _pod;
removeAllActions _pod;
deleteVehicle _fireball;
_pod setVectorDirAndUp [[0,1,0],[0,0,0]];
resetCamShake;
sleep 0.1;
if (getPosATL _pod select 2 < 0) then { _pod setPosATL [(getPosATL _pod select 0), (getPosATL _pod select 1), 0.2]; };

waitUntil {((count (fullCrew [_pod, "cargo"])) + (count (fullCrew [_pod, "driver"]))) < 1;};

_crashpod = createVehicle ["H_Drop_Pod_Wreck", [(position _pod select 0), (position _pod select 1), (position _pod select 2)], [], 0, "CAN_COLLIDE"];
_crashpod setVectorDirAndUp [vectorDir _pod, vectorUp _pod];
deleteVehicle _pod;
sleep 600;
deleteVehicle _crashpod;
