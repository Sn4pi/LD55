/// @description Camera
x += (xTo - x) / smooth;
y += (yTo - y) / smooth;
x = round(clamp(x, gameWidth * 0.5, (room_width - gameWidth * 0.5)));
y = round(clamp(y, gameHeight * 0.6, (room_height - gameHeight * 0.4)));

if (instance_exists(oPlayer)) {
	xTo = oPlayer.x;
	yTo = oPlayer.y;
	
	dx = oPlayer.x - x;
	dy = oPlayer.y - y;
}

camera_set_view_pos(view_camera[0], floor(x - gameWidth * 0.5), floor(y - gameHeight * 0.6));


if (!surface_exists(viewSurf)) {
    viewSurf = surface_create(gameWidth + 1, gameHeight + 1);
}

view_surface_id[0] = viewSurf;