/// @description DRAW
if (surface_exists(viewSurf)) {
    draw_surface_part(viewSurf, frac(x), frac(y), gameWidth, gameHeight, 0, 0);
}