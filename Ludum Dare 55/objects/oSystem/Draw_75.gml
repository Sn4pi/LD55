/// @description Cursor, FADE In and Out
//Draw Cursor
draw_sprite_ext(sCursor, 0, device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), 1, 1, 0, c_white, 1);

//Draw Timer
tMilis = floor(timer mod 100);
tSec = (timer div 100) mod 60;
tMin = ((timer div 100) div 60) mod 60;
draw_text(4, 4, $"{tMin}:{tSec}:{tMilis}");

//EXIT ROOM #############################################################################
//Draw Fade
if (fadeOut) {
	if (fadeAlpha < 1) fadeAlpha = Approach(fadeAlpha, 1, fadeInc);
	//Room Transition
	else {
		room_goto_next();
		fadeIn = true;
		fadeOut = false;
	}
}
else if (fadeIn) {
	if (fadeAlpha > 0) fadeAlpha = Approach(fadeAlpha, 0, fadeInc);
	//Fade FINISHED
	else {
		fadeIn = false;
	}
}

draw_set_alpha(fadeAlpha);
draw_set_color(c_black);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), 0);
draw_set_alpha(1);