/// @description Camera
camera_set_view_pos(cam, x - gameWidth * 0.5, y - gameHeight * 0.6);
if (!surface_exists(viewSurf)) {
    viewSurf = surface_create(gameWidth + 1, gameHeight + 1);
}

view_surface_id[0] = viewSurf;