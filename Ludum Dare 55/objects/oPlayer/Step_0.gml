/// @description Main Gameplay
input();

//Check if grounded
if (place_meeting(x, y + 1, oCollision)) grounded = true;
else grounded = false;

//Horizontal movement
var _hsp;
_hsp = right - left;
movement.hspd = Approach(movement.hspd, _hsp * movement.movSpd, movement.momentum);

//Jump / Vertical movement
if (grounded && space) movement.vspd = movement.jumpSpd;
else if (!grounded) movement.vspd = Approach(movement.vspd, movement.jumpSpd * -1, movement.grav);


//Move Player
movement.hspd = collisionsX(movement.hspd);
movement.vspd = collisionsY(movement.vspd);