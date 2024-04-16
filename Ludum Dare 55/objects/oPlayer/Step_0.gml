/// @description Main Gameplay
input();

//SUICIDE
if (keyboard_check_pressed(ord("R"))) hp = 0;

//Animation
pAnimation();
//Check if grounded
checkGrounded();

//Goto next level
if (place_meeting(x, y, oDoor) && grounded && lmb) {
	var _doorDx = oDoor.x - oSystem.x;
	var _doorDy = oDoor.y - oSystem.y;
	var _doorXtoGui = (oSystem.gameWidth * 0.5 + _doorDx) / oSystem.zoom;
	var _doorYtoGui = (oSystem.gameHeight * 0.6 + _doorDy) / oSystem.zoom;
	if (mx == clamp(mx, _doorXtoGui * oSystem.zoom, (_doorXtoGui + 59 * 2) * oSystem.zoom) &&
		my == clamp(my,_doorYtoGui * oSystem.zoom, (_doorYtoGui + 64 * 2) * oSystem.zoom)) {
		//PLAY SFX
		if (!audio_is_playing(oMusic.sfx[sound.roomexitt])) audio_play_sound(oMusic.sfx[sound.roomexitt], 1, 0, volSfx);
		oSystem.fadeOut = true;
		exit;
	}
}

//ALIVE
if (hp > 0) {
	//Movement
	pMovement();
	//Talisman Action
	pTalisman();

	//Get damage by spikes
	if (place_meeting(x, y, oSpikes) || place_meeting(x, y, oBuzzsaw)) pDamage();

}

//Die
else if (hp <= 0) {
	movement.hspd = 0;
	movement.vspd = 0;
	visible = false;
	
	//NOW HE'S REALLY FUCKING DEAD
	if (!instance_exists(oPlayerPart)) {
		//PLAY SFX
		audio_play_sound(oMusic.sfx[sound.slash], 1, 0, volSfx);
		
		//Reset any cooldowns and states
		time_source_stop(movement.longJump);
		time_source_stop(chargeTimer);
		time_source_stop(talisReady);
		abilityState = talisman.inPocket;
		with (oTalisman) instance_destroy();
		slowMo = 1.0;
		
		//Spawn Player Parts
		for (var i = 0; i < sprite_get_number(sPlayerParts); i++) {
			var _part = instance_create_depth(x, y - 20, depth, oPlayerPart);
			_part.image_index = i;
			var _dir = irandom_range(15, 180 - 15);
			var _len = 14;
			_part.hspd = lengthdir_x(_len, _dir);
			_part.vspd = lengthdir_y(_len, _dir);
			_part.rotationSpd = irandom_range(5, 20);
		}
	}
	
	//Retry
	else if (restart && instance_exists(oPlayerPart) && !oPlayerPart.flyBack) {
		with (oPlayerPart) {
			hspd = 0;
			vspd = 0;
			flyBack = true;
		}
	}
}

//Move Player
movement.vspd = collisionsY(movement.vspd);