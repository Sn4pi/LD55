/// @description Draw self and aim line
draw_self();

//Aim Line
if (abilityState == talisman.aim && image_index == clamp(image_index, 2, animation.throwImg[0])) {
	var _dir = point_direction(xToGUI * oSystem.zoom, yToGUI * oSystem.zoom, mx, my);
	
	/*var _lenMax = 56;
	var _lenNow = _lenMax * (1 - time_source_get_time_remaining(chargeTimer) / chargeCd);
	draw_set_alpha(0.2);
	draw_line_width_color(x, y - sprite_get_height(sprite_index) / 2, x + lengthdir_x(_lenMax, _dir), y - sprite_get_height(sprite_index) / 2 + lengthdir_y(_lenMax, _dir), 3, c_white, c_white);
	draw_set_alpha(1.0);
	draw_line_width_color(x, y - sprite_get_height(sprite_index) / 2, x + lengthdir_x(_lenNow, _dir), y - sprite_get_height(sprite_index) / 2 + lengthdir_y(_lenNow, _dir), 3, c_green, c_green);*/
	
	//Arm
	var _armX = x - 11 * sign(image_xscale);
	var _armY = y + 7;
	var _armAngle = _dir mod 360;
	var _yscl = 1;
	if (_armAngle == clamp(_armAngle, 90, 270)) _yscl = -1;
	if (_yscl == 1) {
		if (_armAngle <= 90) _armAngle = clamp(_armAngle, 0, 45);
		else _armAngle = clamp(_armAngle, 315, 359);
	}
	else {
		_armAngle = clamp(_armAngle, 135, 225);
	}
	
	draw_sprite_ext(sPlayerArm, 0, _armX, _armY, 1, _yscl, _armAngle, c_white, 1);
}