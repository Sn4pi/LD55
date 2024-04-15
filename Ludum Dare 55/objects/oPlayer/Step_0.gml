/// @description Main Gameplay
input();

//SUICIDE
if (keyboard_check_pressed(ord("R"))) hp = 0;

//Animation
pAnimation();
//Check if grounded
checkGrounded();

//Goto next level
if (place_meeting(x, y, oDoor) && grounded) {
	oSystem.fadeOut = true;
	exit;
}

//ALIVE
if (hp > 0) {
	//Movement
	pMovement();
	//Talisman Action
	pTalisman();

	//Get damage by spikes
	if (place_meeting(x, y, oSpikes) || place_meeting(x, y, oBuzzsaw)) pDamage();
	//Skip Level
		if (nextlevel) room_goto_next();

}

//DED
else if (hp <= 0) {
	movement.hspd = 0;
	movement.vspd = 0;
	visible = false;
	
	//Get taken apart
	if (!instance_exists(oPlayerPart)) {
		//PLAY SFX
		audio_play_sound(oMusic.sfx[sound.slash], 1, 0, volSfx);
		
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
	if (restart && instance_exists(oPlayerPart) && !oPlayerPart.flyBack) {
		with (oPlayerPart) {
			hspd = 0;
			vspd = 0;
			flyBack = true;
		}
	}
}

//Move Player
movement.vspd = collisionsY(movement.vspd);