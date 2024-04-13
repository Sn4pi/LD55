/// @description Init
globalvar slowMo;
slowMo = 1.0;

#macro FPS 60
#macro delta (delta_time / 1000000) * FPS * slowMo