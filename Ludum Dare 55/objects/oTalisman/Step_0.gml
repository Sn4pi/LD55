/// @description Move, be there for teleportation
if (collision) exit;

/*	- Normal Shot -
	start with increased speed
	slow down a bit
	then add exponnential but small acceleration to the Talisman
*/
if (!charged) {
	if (!accelerate) {
		movement.spd = Approach(movement.spd, movement.movSpd, movement.slowDown);
		if (movement.spd == movement.movSpd) accelerate = true;
	}
	else {
		movement.spd *= movement.acc;
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
	while (i > 0 && collision_line(x, y, x + lengthdir_x(i, direction), y + lengthdir_y(i, direction), oCollision, 1, 1)) {
		i--;
	}
	x = x + lengthdir_x(i, direction) * delta;
	y = y + lengthdir_y(i, direction) * delta;
	movement.spd = 0;
	collision = true;
}