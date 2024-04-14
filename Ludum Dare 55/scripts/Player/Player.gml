function startFall() {
	with (oPlayer) movement.falling = true;
}

function pMovement() {
	//Jump / Vertical movement
	if (grounded) {
		if (space && abilityState != talisman.aim && !movement.jumpCharge) {
			movement.jumpCharge = true;
			time_source_reconfigure(movement.longJump, movement.jumpDuration[0], time_source_units_seconds, startFall);
		}
		else if (movement.jumpCharge) {
			time_source_reconfigure(movement.longJump, Approach(time_source_get_period(movement.longJump), movement.jumpDuration[1], movement.jumpInc), time_source_units_seconds, startFall);
			
			if (spaceRelease) {
				movement.jumpCharge = false;
				movement.vspd = movement.jumpSpd * (1 + (time_source_get_period(movement.longJump) / movement.jumpDuration[1]) / 4);
				time_source_start(movement.longJump);
			}
		}
		
		
	}
	else if (!grounded) {
		//Still committing to a long jump
		if (!movement.falling) {
			if (slowMo == 0.1) time_source_pause(movement.longJump);
			else if (time_source_get_state(movement.longJump) == time_source_state_paused) time_source_resume(movement.longJump);
			
			//First half of the uptime he moves up faster
			if ((1 - time_source_get_time_remaining(movement.longJump) / time_source_get_period(movement.longJump)) < 0.5) movement.vspd = Approach(movement.vspd, movement.jumpSpd * -1, movement.grav * 0.72 * delta);
			//then there should be a state of "float"
			else movement.vspd = Approach(movement.vspd, movement.jumpSpd * -1, movement.grav * 0.2 * delta);
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
			if (rmb && !instance_exists(oTalisman)) {
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
			if (rmb && sprite_index != animation.spr[pSprites.teleport]) {
				image_index = 0;
				sprite_index = animation.spr[pSprites.teleport];
			}
		break;
		
		default: break;
	}
}

function pAnimation() {
	//Death
	if (hp <= 0) {
		if (sprite_index != animation.spr[pSprites.death]) {sprite_index = animation.spr[pSprites.death]; image_index = 0;}
		image_index = Approach(image_index, sprite_get_number(sprite_index) - 1, animation.deathSpd);
	}
	else {
		//Turn around
		if (mouse_x != x) image_xscale = sign(mouse_x - x) / 2;
		
		//Talisman animation states
		var _noTalisman = false;
		
		switch (abilityState) {
			case talisman.aim:
				if (sprite_index != animation.spr[pSprites.throwNormal] && !charged) {sprite_index = animation.spr[pSprites.throwNormal]; image_index = 0;}
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
					if (image_index < animation.teleImg[0]) image_index = Approach(image_index, animation.teleImg[0], animation.teleSpd);
					else if (image_index == animation.teleImg[0] && instance_exists(oTalisman)) {
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
					else if (image_index >= animation.teleImg[0] && !instance_exists(oTalisman)) {
						image_index = Approach(image_index, animation.teleImg[1], animation.teleSpd);
						if (image_index == animation.teleImg[1]) {
							image_index = animation.teleImg[1];
							abilityState = talisman.inPocket;
						}
					}
					break;
				}
				else if (instance_exists(oTalisman)) _noTalisman = true;
				
				
			default:
			case talisman.inPocket:
				switch (_noTalisman) {
					case false:
					#region Player HAS the Talisman
						//Jump - Landing Motion
						if (grounded && movement.falling) {
							if (sprite_index != animation.spr[pSprites.jump]) {
								sprite_index = animation.spr[pSprites.jump];
								image_index = animation.jumpImg[2];
							}
							image_index = Approach(image_index, animation.jumpImg[3], animation.jumpSpd);
							if (image_index == animation.jumpImg[3]) movement.falling = false;
						}
						//Idle
						else if (grounded && !movement.jumpCharge) {
							if (sprite_index != animation.spr[pSprites.idle]) {sprite_index = animation.spr[pSprites.idle]; image_index = 0;}
							image_index = Approach(image_index, sprite_get_number(sprite_index), animation.idleSpd);
						}
						//Jump Charge
						else if (movement.jumpCharge) {
							if (sprite_index != animation.spr[pSprites.jump]) {sprite_index = animation.spr[pSprites.jump]; image_index = 0;}
							if (animation.jumpBlink == 0) image_index = Approach(image_index, animation.jumpImg[0], animation.jumpSpd);
							if (image_index == animation.jumpImg[0] || animation.jumpBlink > 0) {
								animation.jumpBlink = Approach(animation.jumpBlink, 2, 0.1);
								if (animation.jumpBlink == 1) {
									image_index = animation.jumpImg[0] - 1;
								}
								else if (animation.jumpBlink == 2) {
									image_index = animation.jumpImg[0];
									animation.jumpBlink = 0.1;
								}
							}
						}
						//Jump - Up Motion
						else if (movement.vspd <= -0.2) {
							animation.jumpBlink = 0;
							if (sprite_index != animation.spr[pSprites.jump]) {
								sprite_index = animation.spr[pSprites.jump];
								image_index = animation.jumpImg[0];
							}
							image_index = Approach(image_index, animation.jumpImg[1], animation.jumpSpd);
						}
						// Jump - Down Motion
						else if (movement.vspd > -0.2) {
							if (sprite_index != animation.spr[pSprites.jump]) {
								sprite_index = animation.spr[pSprites.jump];
								image_index = animation.jumpImg[1];
							}
							image_index = Approach(image_index, animation.jumpImg[2], animation.jumpSpd);
						}
					#endregion
					break;
					
					case true:
					#region Player has NO Talisman
						//Jump - Landing Motion
						if (grounded && movement.falling) {
							if (sprite_index != animation.spr[pSprites.jump2]) {
								sprite_index = animation.spr[pSprites.jump2];
								image_index = animation.jumpImg[2];
							}
							image_index = Approach(image_index, animation.jumpImg[3], animation.jumpSpd);
							if (image_index == animation.jumpImg[3]) movement.falling = false;
						}
						//Idle
						else if (grounded && !movement.jumpCharge) {
							if (sprite_index != animation.spr[pSprites.idle2]) {sprite_index = animation.spr[pSprites.idle2]; image_index = 0;}
							image_index = Approach(image_index, sprite_get_number(sprite_index), animation.idleSpd);
						}
						//Jump Charge
						else if (movement.jumpCharge) {
							if (sprite_index != animation.spr[pSprites.jump2]) {sprite_index = animation.spr[pSprites.jump2]; image_index = 0;}
							if (animation.jumpBlink == 0) image_index = Approach(image_index, animation.jumpImg[0], animation.jumpSpd);
							if (image_index == animation.jumpImg[0] || animation.jumpBlink > 0) {
								animation.jumpBlink = Approach(animation.jumpBlink, 2, 0.1);
								if (animation.jumpBlink == 1) {
									image_index = animation.jumpImg[0] - 1;
								}
								else if (animation.jumpBlink == 2) {
									image_index = animation.jumpImg[0];
									animation.jumpBlink = 0.1;
								}
							}
						}
						//Jump - Up Motion
						else if (movement.vspd <= 0) {
							animation.jumpBlink = 0;
							if (sprite_index != animation.spr[pSprites.jump2]) {
								sprite_index = animation.spr[pSprites.jump2];
								image_index = animation.jumpImg[0];
							}
							image_index = Approach(image_index, animation.jumpImg[1], animation.jumpSpd);
						}
						// Jump - Down Motion
						else if (movement.vspd > 0) {
							if (sprite_index != animation.spr[pSprites.jump2]) {
								sprite_index = animation.spr[pSprites.jump2];
								image_index = animation.jumpImg[1];
							}
							image_index = Approach(image_index, animation.jumpImg[2], animation.jumpSpd);
						}
					#endregion
					break;
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