function startFall() {
	with (oPlayer) movement.falling = true;
}

function pMovement() {
	//Horizontal movement
	var _hsp;
	_hsp = right - left;
	movement.hspd = Approach(movement.hspd, _hsp * movement.movSpd, movement.momentum);


	//Jump / Vertical movement
	if (grounded && space) {
		movement.vspd = movement.jumpSpd;
		time_source_start(movement.longJump);
	}
	else if (!grounded) {
		//Still committing to a long jump
		if (!movement.falling) {
			movement.vspd = Approach(movement.vspd, movement.jumpSpd * -1, movement.grav * 0.6);
			//Do a short jump instead
			if (spaceRelease) {
				movement.falling = true;
				time_source_stop(movement.longJump)
			}
		}
		//Fall Faster
		else {
			movement.vspd = Approach(movement.vspd, movement.jumpSpd * -1, movement.grav);
		}
	}


	//Move Player
	movement.hspd = collisionsX(movement.hspd);
	movement.vspd = collisionsY(movement.vspd);
}

function pAnimation() {
	if (movement.hspd != 0) image_xscale = sign(movement.hspd);
}