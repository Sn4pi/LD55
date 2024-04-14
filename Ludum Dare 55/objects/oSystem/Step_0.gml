/// @description Main
x += (xTo - x) / smooth;
y += (yTo - y) / smooth;
x = round(clamp(x, gameWidth * 0.5, (room_width - gameWidth * 0.5)));
y = round(clamp(y, gameHeight * 0.6, (room_height - gameHeight * 0.4)));

//Enable view if not enabled
if (!view_enabled || !view_visible[0]) {
	view_enabled = true;
	view_visible[0] = true;
	view_camera[0] = cam;
	view_wport[0] = gameWidth;
	view_hport[0] = gameHeight;
}

if (instance_exists(oPlayer)) {
	xTo = oPlayer.x;
	yTo = oPlayer.y;
	
	dx = oPlayer.x - x;
	dy = oPlayer.y - y;
}

//Reposition camera view!
var vm = matrix_build_lookat(x, y, -10, x, y, 0, 0, 1, 0);
camera_set_view_mat(cam, vm);

//Resize camera view if needed!
var pm = matrix_build_projection_ortho(gameWidth, gameHeight, 1, 10000);
if (camera_get_proj_mat(cam) != pm) {
	camera_set_proj_mat(cam, pm);
}