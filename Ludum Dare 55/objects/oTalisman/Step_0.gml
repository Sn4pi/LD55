/// @description Move, be there for teleportation
if (oPlayer.sprite_index == oPlayer.animation.spr[pSprites.teleport] && oPlayer.image_index >= 2) {
	movement.spd = 0;
	slowMo = 0;
	exit;
}

//Charged throw
if (charged) {
	if (image_index != clamp(image_index, animation.chargedImg[0], animation.chargedImg[1])) image_index = animation.chargedImg[0];
	image_index = Approach(image_index, animation.chargedImg[1], animation.imgSpd);
}

else if (!collision) {
	//Slow throw
	if (movement.spd <= movement.movSpd) {
		if (image_index != clamp(image_index, animation.slowImg[0], animation.slowImg[1] + 0.5)) image_index = animation.slowImg[0];
		image_index = Approach(image_index, animation.slowImg[1] + 1, animation.imgSpd);
	}
	//Fast throw
	else image_index = animation.fastImg;
}
//Stuck in Wall
else {
	time_source_stop(flyTimer);
	
	if (image_index != clamp(image_index, animation.stuckImg[0], animation.stuckImg[1] + 0.5)) image_index = animation.stuckImg[0];
	image_index = Approach(image_index, animation.stuckImg[1] + 1, animation.imgSpd);
	exit;
}

/*	- Normal Shot -
	start with increased speed
	slow down a bit
	then add exponnential but small acceleration to the Talisman
*/
if (!charged) {
	//Fly
	if (time_source_get_state(flyTimer) == time_source_state_active) {
		if (!accelerate) {
			movement.spd = Approach(movement.spd, movement.movSpd, movement.slowDown);
			if (movement.spd == movement.movSpd) accelerate = true;
		}
		else {
			movement.spd *= movement.acc;
		}
	}
	//Fall down
	else {
		image_angle = 0;
		movement.spd = Approach(movement.spd, movement.movSpd, movement.grav);
	}
}

/*	- Charged Shot -
	Hit the next wall instantly
*/
else {
	var _xx = oPlayer.x;
	var _yy = oPlayer.y - oPlayer.sprite_height / 2;
	var i = 1000;
	while (i > 0 && collision_line(x, y, x + lengthdir_x(i, direction), y + lengthdir_y(i, direction), oCollision, 1, 1)) {
		i--;
	}
	x = x + lengthdir_x(i, direction);
	y = y + lengthdir_y(i, direction);
	
	//PARTICLES
	if (!collision) {
		var _dir = point_direction(x, y, _xx, _yy);
		var _len = point_distance(_xx, _yy, x, y);
		partTeleport(FPS * 0.2, _dir, _len / sprite_get_width(sTeleport), 9);
		part_emitter_region(parsys, parem, x, x, y, y, ps_shape_line, ps_distr_linear);
		part_emitter_burst(parsys, parem, pTeleport, 1);
	}
	
	collision = true;
}

//No collision -> MOVE
if (!collision_line(x, y, x + lengthdir_x(movement.spd, direction), y + lengthdir_y(movement.spd, direction), oCollision, 1, 1)) {
	x = x + lengthdir_x(movement.spd, direction) * delta;
	y = y + lengthdir_y(movement.spd, direction) * delta;
}
//Collision -> Iterate and stop right at wall
else {
	var i = movement.spd;
	var _wall = collision_line(x, y, x + lengthdir_x(i, direction), y + lengthdir_y(i, direction), oCollision, 1, 1);
	
	while (i > 0 && collision_line(x, y, x + lengthdir_x(i, direction), y + lengthdir_y(i, direction), oCollision, 1, 1)) {
		i--;
	}
	x = x + lengthdir_x(i, direction) * delta;
	y = y + lengthdir_y(i, direction) * delta;
	
	//Check which kind of wall it is
	if (_wall.object_index == oBouncyWall) {
		movement.spd = movement.movSpd;
		if (place_meeting(x + 1, y, _wall) || place_meeting(x - 1, y, _wall)) direction = -direction + 180;
		else if (place_meeting(x, y + 1, _wall) || place_meeting(x, y - 1, _wall)) direction = -direction;
	}
	else {
		movement.spd = 0;
		collision = true;
	}
}