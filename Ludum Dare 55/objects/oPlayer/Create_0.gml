/// @description Init Player
//Animation
image_speed = 0;
image_xscale = 0.5;
image_yscale = 0.5;

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
	throwSpd : 20 / FPS,
	throwImg : [3, 6],
	throwChSpd : 20 / FPS,
	throwChImg : [3, 8],
	teleSpd : 15 / FPS,
	teleImg: [9, 12],
	deathSpd : 11 / FPS
}


//Movement
var _movSpd = 3;
var _jumpSpd = 5;
var _jumpDistance = 32 * 4;
movement = {
	vspd : 0,
	jumpSpd : _jumpSpd * -1,
	grav : _jumpDistance / (sqr(FPS * 0.275)),		//a = s/t²
	falling : false,
	longJump : time_source_create(time_source_game, 0.2, time_source_units_seconds, startFall),
	jumpDuration : [0.05, 0.5],
	jumpCharge : false,
	jumpInc : (0.5 - 0.05) / (FPS * 2.0)
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
chargeCd = 2.5;
chargeTimer = time_source_create(time_source_game, chargeCd, time_source_units_seconds, setCharge);

//States
hp = 1;
hurt = time_source_create(time_source_game, 0.4, time_source_units_seconds, doNothing);