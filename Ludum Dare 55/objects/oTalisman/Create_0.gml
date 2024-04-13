/// @description Init
image_speed = 0;

//Movement
var _movSpd = 5;
movement = {
	spd : 0,
	throwSpd : 15,
	slowDown : 10 / (FPS * 1.0),
	movSpd : _movSpd,
	acc : 1.01,
}
accelerate = false;
charged = false;
collision = false;

//Die after specific time
die = function() {
	instance_destroy();
}
deathTimer = time_source_create(time_source_game, 5, time_source_units_seconds, die);
time_source_start(deathTimer);