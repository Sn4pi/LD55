/// @description Fade In
if (visible && image_alpha != 1) image_alpha = Approach(image_alpha, 1, 1 / (FPS * 0.2));