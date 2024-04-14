/// @description Move, be there for teleportation
if (collision) exit;
if (oPlayer.sprite_index == oPlayer.animation.spr[pSprites.teleport] && oPlayer.image_index >= 2) {
	movement.spd = 0;
	slowMo = 0;
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
		movement.spd = Approach(movement.spd, movement.movSpd, movement.grav);
	}
}

/*	- Charged Shot -
	Hit the next wall instantly
*/
else {
	var i = 1000;
	while (i > 0 && collision_line(x, y, x + lengthdir_x(i, direction), y + lengthdir_y(i, direction), oCollision, 1, 1)) {
		i--;
	}
	
	x = x + lengthdir_x(i, direction);
	y = y + lengthdir_y(i, direction);
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