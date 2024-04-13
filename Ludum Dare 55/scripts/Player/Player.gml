function startFall() {
	with (oPlayer) movement.falling = true;
}

function pMovement() {
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
				charged = false;
				slowMo = 0.1;
				time_source_start(chargeTimer);
			}
		break;
		
		//Aim and throw
		case talisman.aim:
			var _slowMoFade = 0.9 / (chargeCd * 1.5 * FPS);
			slowMo = Approach(slowMo, 1.0, _slowMoFade);
			if (rmbReleased && !instance_exists(oTalisman)) {
				slowMo = 1.0;
				
				var _talisman = instance_create_depth(x, y - sprite_get_height(sprite_index) / 2, depth - 1, oTalisman);
				var _dir = point_direction(x, y - sprite_get_height(sprite_index) / 2, mouse_x, mouse_y);
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
			}
		break;
		
		//Teleport yourself
		case talisman.thrown:
			if (rmb && sprite_index != animation.spr[pSprites.teleport]) sprite_index = animation.spr[pSprites.teleport];
		break;
		
		default: break;
	}
}

function pAnimation() {
	//Death
	if (hp <= 0) {
		if (sprite_index != animation.spr[pSprites.death]) sprite_index = animation.spr[pSprites.death];
		image_index = Approach(image_index, sprite_get_number(sprite_index) - 1, animation.deathSpd);
	}
	else {
		//Turn around
		if (mouse_x != x) image_xscale = sign(mouse_x - x) / 2;
		
		//Talisman animation states
		switch (abilityState) {
			case talisman.inPocket:
				
			break;
			
			case talisman.aim:
				if (sprite_index != animation.spr[pSprites.throwNormal] && !charged) sprite_index = animation.spr[pSprites.throwNormal];
				else if (sprite_index != animation.spr[pSprites.throwCharged] && charged) {sprite_index = animation.spr[pSprites.throwCharged]; image_index = animation.throwChImg[0];}
				
				//Aim
				if (!instance_exists(oTalisman)) {
					image_index = Approach(image_index, animation.throwImg[0], animation.throwSpd);
				}
				//Throw
				else {
					//Normal
					if (!charged) {
						image_index = Approach(image_index, animation.throwImg[1], animation.throwSpd);
						if (image_index == animation.throwImg[1]) abilityState = talisman.thrown;
					}
					else {
						image_index = Approach(image_index, animation.throwChImg[1], animation.throwChSpd);
						if (image_index == animation.throwChImg[1]) abilityState = talisman.thrown;
					}
				}
				
			break;
			
			case talisman.thrown:
				//Teleport
				if (sprite_index == animation.spr[pSprites.teleport]) {
					image_index = Approach(image_index, animation.teleImg[0], animation.teleSpd);
					if (image_index >= animation.teleImg[0]) {
						if (instance_exists(oTalisman)) {
							var _dir = (oTalisman.direction + 180) mod 360;
							var _newX = oTalisman.x;
							var _newY = oTalisman.y;
							while (place_meeting(_newX, _newY, oCollision)) {
								_newX = _newX + lengthdir_x(1, _dir);
								_newY = _newY + lengthdir_y(1, _dir);
							}
							x = _newX;
							y = _newY;
							with (oTalisman) instance_destroy();
						
							movement.vspd = movement.jumpSpd * 0.75;
							movement.falling = true;
						}
						//End animation after teleport success
						else {
							image_index = Approach(image_index, animation.teleImg[1], animation.teleSpd);
							if (image_index == animation.teleImg[1]) abilityState = talisman.inPocket;
						}
					}
				}
			break;
		}
	}
}

function pDamage() {
	if (time_source_get_state(hurt) != time_source_state_active) {
		time_source_start(hurt);
	
		hp = Approach(hp, 0, 1);
		movement.vspd = movement.jumpSpd;
		movement.falling = true;
	}
}