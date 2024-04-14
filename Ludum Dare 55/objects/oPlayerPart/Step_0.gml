/// @description Move
image_angle -= rotationSpd * sign(hspd);
rotationSpd *= 0.97;

hspd *= momentum;
vspd += grav;

collisionsX(hspd);
collisionsY(vspd);