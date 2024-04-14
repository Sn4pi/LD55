/// @description Main Gameplay
input();
//Animation
pAnimation();
//Check if grounded
checkGrounded();
//ALIVE
if (hp > 0) {
	//Movement
	pMovement();
	//Talisman Action
	pTalisman();

	//Get damage by spikes
	if (place_meeting(x, y, oSpikes)) {
		pDamage();
		
		
	}
	//Skip Level
		if (nextlevel) room_goto_next();
}
//DED
else if (hp <= 0) {
	movement.vspd = Approach(movement.vspd, movement.jumpSpd * -1, movement.grav * delta);
	
	if (restart) room_restart();
}

//Move Player
movement.vspd = collisionsY(movement.vspd);