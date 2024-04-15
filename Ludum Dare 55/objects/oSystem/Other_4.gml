if (instance_exists(oPlayer)) {
	x = oPlayer.x;
	y = oPlayer.y;
}

view_enabled = true;
view_visible[0] = true;
view_camera[0] = cam;
view_wport[0] = gameWidth;
view_hport[0] = gameHeight;

//Background
layer_create(600, "B0");
layer_create(700, "B1");
layer_create(800, "B2");
layer_create(900, "B3");
layer_create(1000, "B4");
layer_create(1100, "B5");
layer_create(1200, "B6");
layer_create(1300, "B7");
layer_create(1400, "B8");

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

var _backY = [
	room_height - 320 * 2,		//Bg 1
	room_height - 320 * 2,		//Cloud 1
	room_height - 320 * 2,		//Cloud 2
	room_height - 320 * 2,		//Cloud 3
	room_height - 320 * 2,		//Moon
	room_height - 320 * 1,		//Bg 2
	room_height - 320 * 1,		//Forest 1
	room_height - 320 * 1,		//Forest 2
	room_height - 320 * 1,		//Forest 3
];

for (var i = 0; i < 9; i++) {
	var _bg = layer_background_create(_backId[i], sParallax);
	layer_background_htiled(_bg, true);
	layer_background_speed(_bg, 0);
	layer_background_index(_bg, i);
	layer_y(_backId[i], _backY[i]);
}