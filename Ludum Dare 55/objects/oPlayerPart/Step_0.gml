/// @description Move
if (flyBack) {
	var _xx = oPlayer.xstart;
	var _yy = oPlayer.ystart;
	var _dir = point_direction(x, y, _xx, _yy);
	spd++;
	hspd = lengthdir_x(spd, _dir);
	vspd = lengthdir_y(spd, _dir);
	x = Approach(x, _xx, abs(hspd));
	y = Approach(y, _yy, abs(vspd));
	
	if (x == _xx && y == _yy) {
		if (instance_number(oPlayerPart) == 1) {
			with (oPlayer) {
				x = _xx;
				y = _yy;
				visible = true;
				hp = 1;
				
				if (wealthX != -1 && wealthY != -1) {
					var _lantern = instance_create_depth(wealthX, wealthY, depth, oWealthLantern);
					wealth--;
					wealthX = -1;
					wealthY = -1;
				}
			}
			instance_destroy();
		}
		else {
			instance_destroy();
		}
	}
	
	exit;
}


image_angle -= rotationSpd * sign(hspd);
rotationSpd *= 0.97;

hspd *= momentum;
vspd += grav;

collisionsX(hspd);
collisionsY(vspd);