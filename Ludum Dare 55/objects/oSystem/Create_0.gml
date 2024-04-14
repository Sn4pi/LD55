/// @description Init
globalvar slowMo;
slowMo = 1.0;

#macro FPS 60
#macro delta (delta_time / 1000000) * FPS * slowMo


//View
application_surface_enable(false);
// game_width, game_height are your base resolution (ideally constants)
gameWidth = 640;
gameHeight = 360;
camera_set_view_size(view_camera[0], gameWidth + 1, gameHeight + 1);
display_set_gui_size(gameWidth, gameHeight);
viewSurf = -1;

xTo = x;
yTo = y;
dx = 0;
dy = 0;
smooth = 18;