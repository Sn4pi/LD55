/// @description END SCREEN INFOS
if (room != rmEND) exit;
timerGo = false;

var _lanternX = 1377;
var _lanternX2 = 1442;
var _lanternY = 2391;
var _timeX = 1382;
var _timeY = 2404;

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_set_color(c_white);
draw_set_font(ft1);
draw_text(_lanternX, _lanternY, $"{wealth}");
draw_text(_lanternX2, _lanternY, "20");
draw_text(_timeX, _timeY, $"{tMin}min {tSec}s {tMilis}ms");

draw_set_halign(fa_left);
draw_set_valign(fa_top);