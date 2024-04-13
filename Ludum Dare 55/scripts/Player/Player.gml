function startFall() {
	with (oPlayer) movement.falling = true;
}

function pMovement() {
	//Horizontal movement
	var _hsp;
	_hsp = right - left;
	movement.hspd = Approach(movement.hspd, _hsp * movement.movSpd, movement.momentum * delta);


	//Jump / Vertical movement
	if (grounded && space) {
		movement.vspd = movement.jumpSpd;
		time_source_start(movement.longJump);
	}
	else if (!grounded) {
		//Still committing to a long jump
		if (!movement.falling) {
			if (slowMo == 0.1) time_source_pause(movement.longJump);
			else if (time_source_get_state(movement.longJump) == time_source_state_paused) time_source_resume(movement.longJump);
			
			//First half of the uptime he moves up faster
			if ((1 - time_source_get_time_remaining(movement.longJump) / 0.45) < 0.5) movement.vspd = Approach(movement.vspd, movement.jumpSpd * -1, movement.grav * 0.72 * delta);
			//then there should be a state of "float"
			else movement.vspd = Approach(movement.vspd, movement.jumpSpd * -1, movement.grav * 0.2 * delta);
			//Do a short jump instead
			if (spaceRelease) {
				movement.falling = true;
				time_source_stop(movement.longJump)
			}
		}
		//Fall Faster
		else {
			movement.vspd = Approach(movement.vspd, movement.jumpSpd * -1, movement.grav * delta);
		}
	}
}

function pTalisman() {
	switch (abilityState) {
		//Activate aim mode
		case talisman.inPocket:
			if (rmb) {
				abilityState = talisman.aim;
				slowMo = 0.1;
				time_source_start(chargeTimer);
			}
		break;
		
		//Aim and throw
		case talisman.aim:
			if (rmbReleased) {
				abilityState = talisman.thrown;
				slowMo = 1.0;
				
				var _talisman = instance_create_depth(x, y, depth - 1, oTalisman);
				var _dir = point_direction(x, y, mouse_x, mouse_y);
				_talisman.image_angle = _dir;
				_talisman.direction = _dir;
				
				//Normal Shot
				if (!charged) {
					var _len = _talisman.movement.movSpd;
					time_source_stop(chargeTimer);
					_talisman.movement.spd = _len;
				}
				//Charged Shot
				else {
					_talisman.charged = true;
				}
				charged = false;
			}
		break;
		
		//Teleport yourself
		case talisman.thrown:
			if !(instance_exists(oTalisman)) abilityState = talisman.inPocket;
			else if (rmb) {
				var _dir = (oTalisman.direction + 180) mod 360;
				var _newX = oTalisman.x;
				var _newY = oTalisman.y;
				while (place_meeting(_newX, _newY, oCollision)) {
					_newX = _newX + lengthdir_x(1, _dir);
					_newY = _newY + lengthdir_y(1, _dir);
				}
				x = _newX;
				y = _newY;
				movement.vspd = movement.jumpSpd;
				movement.falling = true;
				
				with (oTalisman) instance_destroy();
				abilityState = talisman.inPocket;
			}
		break;
		
		default: break;
	}
}

function pAnimation() {
	if (movement.hspd != 0) image_xscale = sign(movement.hspd);
}

function pDamage() {
	if (time_source_get_state(hurt) != time_source_state_active) {
		time_source_start(hurt);
	
		hp = Approach(hp, 0, 1);
		movement.vspd = movement.jumpSpd;
		movement.falling = true;
	}
}