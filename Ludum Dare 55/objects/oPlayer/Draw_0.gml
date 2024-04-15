/// @description Draw self and aim line
draw_self();

//Aim Line
if (abilityState == talisman.aim && image_index == clamp(image_index, 2, animation.throwImg[0])) {
	var _dir = point_direction(xToGUI * oSystem.zoom, yToGUI * oSystem.zoom, mx, my);
	
	#region CHARGE Bar
	var _barX = x + 8 * image_xscale;
	var _barY = bbox_bottom + 24;
	var _chargeMax = 20;
	var _img = 0;
	_img = floor((1.05 - time_source_get_time_remaining(chargeTimer) / time_source_get_period(chargeTimer)) * _chargeMax);
	if (_img == _chargeMax) {
		if (throwBarFull <= 4) throwBarFull = Approach(throwBarFull, 4, 1 / (FPS * 0.1));
		_img = _chargeMax + throwBarFull;
	}
	else {
		throwBarFull = 0;
	}
	draw_self();
	draw_sprite_ext(sHudThrow, _img, _barX, _barY, image_xscale, 1, 0, c_white, 1);
	#endregion
	
	
	#region Arm
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
	#endregion
}

//TALISMAN Bar
else if (time_source_get_state(talisReady) == time_source_state_active) {
	var _barX = bbox_left;
	if (image_xscale == -1) _barX = bbox_right;
	var _barY = y + 4;
	var _chargeMax = 15;
	var _img = 0;
	_img = floor((1.1 - time_source_get_time_remaining(talisReady) / time_source_get_period(talisReady)) * _chargeMax);
	if (_img == _chargeMax) {
		if (talisBarFull <= 3) talisBarFull = Approach(talisBarFull, 3, 1 / (FPS * 0.1));
		_img = _chargeMax + talisBarFull;
	}
	else {
		talisBarFull = 0;
	}
	
	draw_sprite_ext(sHudTalisman, _img, _barX, _barY, image_xscale, 1, 0, c_white, 1);
	draw_self();
}

//JUMP Bar
if (movement.jumpCharge) {
	var _barX = bbox_left - 7;
		if (image_xscale == -1) _barX = bbox_right + 7;
	var _barY = y + 46;
	var _chargeMax = 14;
	var _diffMax = movement.jumpDuration[1] - movement.jumpDuration[0];
	var _diff = movement.jumpDuration[1] - time_source_get_period(movement.longJump);
	var _img = 0;
	if (_diff > 0) {
		jumpBarFull = 0;
		_img = floor((1 - _diff / _diffMax) * _chargeMax);
	}
	else {
		if (jumpBarFull <= 4) jumpBarFull = Approach(jumpBarFull, 4, 1 / (FPS * 0.1));
		_img = _chargeMax + jumpBarFull;
	}
	
	draw_sprite_ext(sHudJump, _img, _barX, _barY, image_xscale, 1, 0, c_white, 1);
	draw_self();
}