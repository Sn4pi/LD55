/// @description Draw self and aim line
draw_self();

//Aim Line
if (abilityState == talisman.aim) {
	var _lenMax = 56;
	var _lenNow = _lenMax * (1 - time_source_get_time_remaining(chargeTimer) / chargeCd);
	var _dir = point_direction(xToGUI * oSystem.scale, (yToGUI - sprite_get_height(sprite_index) / 2) * oSystem.scale, mx, my);
	draw_set_alpha(0.2);
	draw_line_width_color(x, y - sprite_get_height(sprite_index) / 2, x + lengthdir_x(_lenMax, _dir), y - sprite_get_height(sprite_index) / 2 + lengthdir_y(_lenMax, _dir), 3, c_white, c_white);
	draw_set_alpha(1.0);
	draw_line_width_color(x, y - sprite_get_height(sprite_index) / 2, x + lengthdir_x(_lenNow, _dir), y - sprite_get_height(sprite_index) / 2 + lengthdir_y(_lenNow, _dir), 3, c_green, c_green);
}

if (time_source_get_state(hurt) == time_source_state_active) {
	var _hurtAlpha = time_source_get_time_remaining(hurt) / 0.4;
	var _hurtCol = c_red;
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, _hurtCol, _hurtAlpha);
}