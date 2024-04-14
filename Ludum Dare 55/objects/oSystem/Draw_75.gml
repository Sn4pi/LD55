/// @description FADE In and Out
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