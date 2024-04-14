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
	
	if (array_length(_collisions) > 0) {
		if (_collisions[0].object_index == oBouncyWall) {
			_hspd *= -1.0;
		}
		else _hspd = 0;
	}
	
	return _hspd;
}

function collisionsY(_vspd) {
	var _collisions = move_and_collide(0, _vspd * delta, oCollision, 8);
	if (array_length(_collisions) > 0) {
		if (_collisions[0].object_index == oBouncyWall) {
			_vspd *= -1.5;
		}
		else _vspd = 0;
	}
	
	return _vspd;
}

//Ground below?
function checkGrounded() {
	if (place_meeting(x, y + 1, oCollision) || (place_meeting(x, floor(y + max(movement.vspd, 1)), oSemiWall) && !place_meeting(x, y - 1, oSemiWall) && movement.vspd >= 0)) {
		grounded = true;
		if (object_index == oPlayer) {
			if (!place_meeting(x, y + 1, oBouncyWall)) movement.vspd = 0;
		}
	}
	else grounded = false;
}