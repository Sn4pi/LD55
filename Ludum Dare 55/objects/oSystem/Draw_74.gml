/// @description DRAW
if (surface_exists(viewSurf)) {
    draw_surface_part(viewSurf, frac(x), frac(y), gameWidth, gameHeight, 0, 0);
}

if (room == rmTitle) {
	var _xscl = gameWidth / sprite_get_width(sTitle);
	var _yscl = gameHeight / sprite_get_height(sTitle);
	draw_sprite_ext(sTitle, titleImg, 0, 0, _xscl, _yscl, 0, c_white, 1);
	if (titleFade != -1 && titleImg < sprite_get_number(sTitle) - 1) {
		titleFade = Approach(titleFade, 1, 1 / FPS);
		draw_sprite_ext(sTitle, titleImg + 1, 0, 0, _xscl, _yscl, 0, c_white, titleFade);
		
		if (titleFade == 1) {
			titleImg++;
			titleFade = -1;
		}
	}
}