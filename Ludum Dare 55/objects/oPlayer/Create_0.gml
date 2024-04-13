/// @description Init Player
image_speed = 0;

//Movement
var _movSpd = 3;
var _jumpSpd = 5;
var _jumpDistance = 32 * 4;
movement = {
	hspd : 0,
	vspd : 0,
	movSpd : _movSpd,
	jumpSpd : _jumpSpd * -1,
	momentum : _movSpd / (FPS * 0.15),
	grav : _jumpDistance / (sqr(FPS * 0.275)),		//a = s/t²
	falling : false,
	longJump : time_source_create(time_source_game, 0.45, time_source_units_seconds, startFall)
}

//State check
grounded = true;