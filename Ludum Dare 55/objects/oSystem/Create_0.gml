/// @description Init
globalvar slowMo;
slowMo = 1.0;

#macro FPS 60
#macro delta (delta_time / 1000000) * FPS * slowMo

//Camera
cam = camera_create();
zoom = 0.75;
gameWidth = 640 / zoom;
gameHeight = 360 / zoom;

var vm = matrix_build_lookat(x, y, -10, x, y, 0, 0, 1, 0);
var pm = matrix_build_projection_ortho(gameWidth, gameHeight, 1, 10000);
camera_set_view_mat(cam, vm);
camera_set_proj_mat(cam, pm);

xTo = x;
yTo = y;
dx = 0;
dy = 0;
smooth = 18;

//Pixel perfect
view_wport[0] = 640;
view_hport[0] = 360;
application_surface_enable(false);
camera_set_view_size(cam, gameWidth + 1, gameHeight + 1);
display_set_gui_size(gameWidth, gameHeight);

viewSurf = -1;

//Fade Away
fadeIn = true;
fadeOut = false;
fadeAlpha = 1;
fadeInc = 1 / (FPS * 2);