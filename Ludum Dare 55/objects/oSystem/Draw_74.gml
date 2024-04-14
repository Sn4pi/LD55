/// @description Draw screen-sized portion of surface
if (surface_exists(viewSurf)) {
    var _scale = 1;

	draw_surface_part_ext(viewSurf, frac(x), frac(y), gameWidth, gameHeight,
	0 - (gameWidth * _scale - gameWidth) / 2, 0 - (gameHeight * _scale - gameHeight) / 2,
	_scale, _scale, c_white, 1);
}