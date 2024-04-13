//General stuff usable for all instances
//Collisions
function collisions(_hspd, _vspd) {
	var _collisions = move_and_collide(_hspd * delta, _vspd * delta, oCollision, 10);
	if (array_length(_collisions) > 0) {
		_hspd = 0;
		_vspd = 0;
		return true;
	}
	return false;
}

function collisionsX(_hspd) {
	var _collisions = move_and_collide(_hspd * delta, 0, oCollision, 8);
	if (array_length(_collisions) > 0) _hspd = 0;
	return _hspd;
}

function collisionsY(_vspd) {
	var _collisions = move_and_collide(0, _vspd * delta, oCollision, 8);
	if (array_length(_collisions) > 0) _vspd = 0;
	return _vspd;
}

//Ground below?
function checkGrounded() {
	if (place_meeting(x, y + 1, oCollision)) {
		grounded = true;
		if (object_index == oPlayer) movement.falling = false;
	}
	else grounded = false;
}