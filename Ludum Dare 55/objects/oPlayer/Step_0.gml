/// @description Main Gameplay
input();

//Check if grounded
if (place_meeting(x, y + 1, oCollision)) {
	grounded = true;
	movement.falling = false;
}
else grounded = false;

//Movement
pMovement();
//Animation
pAnimation();