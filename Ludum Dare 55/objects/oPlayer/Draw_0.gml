/// @description Draw self and aim line
draw_self();

//Aim Line
if (abilityState == talisman.aim) {
	var _lenMax = 56;
	var _lenNow = _lenMax * (1 - time_source_get_time_remaining(chargeTimer) / chargeCd);
	var _dir = point_direction(x, y, mx, my);
	draw_set_alpha(0.2);
	draw_line_width_color(x, y, x + lengthdir_x(_lenMax, _dir), y + lengthdir_y(_lenMax, _dir), 3, c_white, c_white);
	draw_set_alpha(1.0);
	draw_line_width_color(x, y, x + lengthdir_x(_lenNow, _dir), y + lengthdir_y(_lenNow, _dir), 3, c_green, c_green);
}