/// @description Init
//Animation
image_speed = 0;
animation = {
	imgSpd : 7 / FPS,
	fastImg: 0,
	slowImg: [1, 3],
	chargedImg: [4, 7],
	stuckImg: [8, 10],
};

//Movement
var _movSpd = 5;
movement = {
	spd : 0,
	throwSpd : 15,
	slowDown : 10 / (FPS * 1.0),
	movSpd : _movSpd,
	acc : 1.01,
	grav : _movSpd / (sqr(FPS * 0.1))
}
accelerate = false;
chargeStages = 0;
charged = false;
collision = false;

//Die after specific time
die = function() {
	with (oPlayer) abilityState = talisman.inPocket;
	instance_destroy();
}
deathTimer = time_source_create(time_source_game, 5, time_source_units_seconds, die);
time_source_start(deathTimer);

//Fly then fall
flying = function() {
	movement.spd = 0;
	direction = 270;
	image_angle = 0;
}
flyTimer = time_source_create(time_source_game, 0, time_source_units_seconds, flying);

//Particles
pTeleport = part_type_create();