/// @description Draw screen-sized portion of surface
display_set_gui_size(gameWidth * scale, gameHeight * scale);

if (surface_exists(viewSurf)) {
	draw_surface_part_ext(viewSurf, frac(x), frac(y), gameWidth, gameHeight,
	0, 0,
	scale, scale, c_white, 1);
}