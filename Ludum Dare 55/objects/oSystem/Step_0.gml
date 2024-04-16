/// @description Main
if (room == rmTitle) {
	if (mouse_check_button_pressed(mb_left)) {
		if (titleImg == sprite_get_number(sTitle) - 1) fadeOut = true;
		else {
			if (titleFade == -1) titleFade = 0;
			else {
				titleFade = 0;
				titleImg++;
			}
		}
	}
}

if (shake) 
{ 
   shakeTime -= 1; 
   var _xval = choose(-shakeMagnitude, shakeMagnitude); 
   var _yval = choose(-shakeMagnitude, shakeMagnitude); 
   camera_set_view_pos(cam, _xval, _yval); 

   if (shakeTime <= 0) 
   { 
      shakeMagnitude -= shakeFade; 

      if (shakeMagnitude <= 0) 
      { 
         camera_set_view_pos(cam, 0, 0); 
         shake = false; 
      } 
   } 
}

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

//Background
var _backId = [
	layer_get_id("B0"),
	layer_get_id("B1"),
	layer_get_id("B2"),
	layer_get_id("B3"),
	layer_get_id("B4"),
	layer_get_id("B5"),
	layer_get_id("B6"),
	layer_get_id("B7"),
	layer_get_id("B8"),
];

var _backX = [
	0,			//Bg 1
	0.05,		//Cloud 1
	0.2,		//Cloud 2
	0.3,		//Cloud 3
	0,			//Moon
	0,			//Bg 2
	0.05,		//Forest 1
	0.3,		//Forest 2
	0.4,		//Forest 3
];
var _backY = [
	0,			//Bg 1
	15,			//Cloud 1
	10,			//Cloud 2
	0,			//Cloud 3
	120,		//Moon
	320,	//Bg 2
	310,	//Forest 1
	315,	//Forest 2
	320	//Forest 3
];

for (var i = 0; i < 9; i++) {
	layer_x(_backId[i], x * _backX[i]);
	layer_y(_backId[i], y - gameHeight * 0.6 + _backY[i]);
}