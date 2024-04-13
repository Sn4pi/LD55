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
	grav : _jumpDistance / (sqr(FPS * 0.35))			//a = s/t²
}

//State check
grounded = true;