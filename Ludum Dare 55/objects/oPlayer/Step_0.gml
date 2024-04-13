/// @description Main Gameplay
input();
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
}
//DED
else if (hp <= 0) {
	movement.hspd = Approach(movement.hspd, 0, movement.momentum * delta);
	movement.vspd = Approach(movement.vspd, movement.jumpSpd * -1, movement.grav * delta);
	
	if (restart) room_restart();
}

//Move Player
movement.hspd = collisionsX(movement.hspd);
movement.vspd = collisionsY(movement.vspd);

//Animation
pAnimation();