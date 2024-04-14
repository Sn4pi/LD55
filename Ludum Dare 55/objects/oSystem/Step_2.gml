/// @description Camera
camera_set_view_pos(view_camera[0], floor(x), floor(y));
if (!surface_exists(viewSurf)) {
    viewSurf = surface_create(gameWidth + 1, gameHeight + 1);
}
view_surface_id[0] = viewSurf;