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
	var _dir = 0;
	var _len = 0;
	
	_dir = point_direction(oPlayer.xToGUI * zoom, (oPlayer.yToGUI) * zoom, device_mouse_x_to_gui(0), device_mouse_y_to_gui(0));
	_len = point_distance(oPlayer.xToGUI * zoom, (oPlayer.yToGUI) * zoom, device_mouse_x_to_gui(0), device_mouse_y_to_gui(0));
	_len = clamp(_len, 0, 32 * 10);
	if (_len <= 32 * 6) _len = 0;
	
	xTo = oPlayer.x + 0.5 * lengthdir_x(_len, _dir);
	yTo = oPlayer.y + 0.5 * lengthdir_y(_len, _dir);
	
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