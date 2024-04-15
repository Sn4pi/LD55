/// @description Init Player
hp = 1;

//Animation
image_speed = 0;

enum pSprites {
	idle = 0,
	idle2 = 1,
	jump = 2,
	jump2 = 3,
	throwNormal = 4,
	throwCharged = 5,
	teleport = 6,
	death = 7
};

animation = {
	spr : [
		sPlayerIdle,
		sPlayerIdle2,
		sPlayerJump,
		sPlayerJump2,
		sPlayerThrow,
		sPlayerThrowCharged,
		sPlayerTeleport,
		sPlayerDeath
	],
	idleSpd : 6 / FPS,
	jumpSpd : 20 / FPS,
	jumpImg : [5, 9, 11, 13],
	jumpBlink : 0,
	throwSpd : 8 / FPS,
	throwImg : [3, 6],
	throwBlink : 0,
	throwChSpd : 8 / FPS,
	throwChImg : [3, 8],
	teleSpd : 15 / FPS,
	teleImg: [9, 12],
	deathSpd : 11 / FPS
}


//Movement
var _movSpd = 3;
var _jumpSpd = 7;
var _jumpDistance = 32 * 5;
movement = {
	vspd : 0,
	jumpSpd : _jumpSpd * -1,
	grav : _jumpDistance / (sqr(FPS * 0.275)),		//a = s/t²
	falling : true,
	longJump : time_source_create(time_source_game, 0.2, time_source_units_seconds, startFalling),
	jumpDuration : [0.05, 1.00],
	floatDuration : 0.7,
	jumpCharge : false,
	jumpInc : (1.0 - 0.05) / (FPS * 0.75)
}
grounded = true;

//Talisman
enum talisman {
	inPocket,
	aim,
	thrown
};
abilityState = talisman.inPocket;
charged = false;
setCharge = function() {
	with (oPlayer) charged = true;
}
chargeCd = 0.8;
chargeTimer = time_source_create(time_source_game, chargeCd, time_source_units_seconds, setCharge);
talisReadyCd = 0.9;
talisReady = time_source_create(time_source_game, talisReadyCd, time_source_units_seconds, doNothing);

throwX = x;
throwY = y;

//States
hurt = time_source_create(time_source_game, 0.2, time_source_units_seconds, doNothing);

//Particles
pTeleport = part_type_create();

//HUD
jumpBarFull = 0;
throwBarFull = 0;
talisBarFull = 0;