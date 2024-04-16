function input() {
	//Mouse
	mx = device_mouse_x_to_gui(0);
	my = device_mouse_y_to_gui(0);
	xToGUI = (oSystem.gameWidth * 0.5 + oSystem.dx) / oSystem.zoom;
	yToGUI = (oSystem.gameHeight * 0.6 + oSystem.dy) / oSystem.zoom;
	
	lmb = mouse_check_button_pressed(mb_left);
	lmbReleased = mouse_check_button_released(mb_left);
	rmb = mouse_check_button_pressed(mb_right);
	rmbReleased = mouse_check_button_released(mb_right);
	wheelUp = mouse_wheel_up();
	wheelDown = mouse_wheel_down();
	
	//Keyboard
	left = keyboard_check(ord("A")) || keyboard_check(vk_left);
	down = keyboard_check(ord("S")) || keyboard_check(vk_down);
	right = keyboard_check(ord("D")) || keyboard_check(vk_right);
	
	interact = keyboard_check_pressed(ord("E"));
	space = keyboard_check_pressed(vk_space) || rmb;
	spaceRelease = keyboard_check_released(vk_space) || rmbReleased;
	esc = keyboard_check_pressed(vk_escape);
	restart = mouse_check_button_pressed(mb_left);
	nextlevel = keyboard_check_pressed(vk_tab);
}

function menuInput() {
	up = keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"));
	left = keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A"));
	down = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"));
	right = keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D"));
	
	interact = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space);
	interactHold = keyboard_check(vk_enter) || keyboard_check(vk_space);
	esc = keyboard_check_pressed(vk_escape);
}

function Approach(a, b, amount) {
 
	if (a < b) {
	    a += amount;
	    if (a > b) return b;
	}
	else {
	    a -= amount;
	    if (a < b) return b;
	}
	
	return a;
}
	
function Wave(from, to, duration, offset) {
 
	var a = (to - from) * 0.5;
	return from + a + sin((((current_time * 0.001) + duration * offset) / duration) * (pi * 2)) * a;
}

function Wrap(value, min, max) {
	// Returns the value wrapped, values over or under will be wrapped around
	if (value mod 1 == 0) {
	    while (value > max || value < min) {
	        if (value > max)
	            value += min - max - 1;
	        else if (value < min)
	            value += max - min + 1;
	    }
	    return value;
	}
	
	else {
	    var vOld = value + 1;
	    while (value != vOld) {
	        vOld = value;
	        if (value < min)
	            value = max - (min - value);
	        else if (value > max)
	            value = min + (value - max);
	    }
	    return value;
	}
}

function Chance(percent) {
	// Returns true or false depending on RNG
	// ex: 
	//      Chance(0.7);    -> Returns true 70% of the time
 
	return percent > random(1);
}

function doNothing() {
	
}

function draw_text_outline(_x, _y, _str, _outwidth = 1, _outcol = c_black, _outfidelity = 4, _separation = -1, _width = display_get_gui_width()) {
	//Created by Andrew McCluskey http://nalgames.com/
	//x,y: Coordinates to draw
	//str: String to draw
	//outwidth: Width of outline in pixels
	//outcol: Colour of outline (main text draws with regular set colour)
	//outfidelity: Fidelity of outline (recommended: 4 for small, 8 for medium, 16 for larger. Watch your performance!)
	//separation, for the draw_text_EXT command.
	//width for the draw_text_EXT command.
	
	
	//2,c_dkgray,4,20,500 <Personal favorite preset. (For fnt_3)
	var dto_dcol = draw_get_color();
	
	draw_set_color(_outcol);
	
	for(var dto_i = 45; dto_i < 405; dto_i += 360 / _outfidelity)
	{
	  //draw_text_ext(_x+lengthdir_x(_outwidth,dto_i),argument1+lengthdir_y(argument3,dto_i),_str,_separation,_width);
	  draw_text_ext(_x + round(lengthdir_x(_outwidth, dto_i)), _y + round(lengthdir_y(_outwidth, dto_i)), _str, _separation, _width);
	}
	
	draw_set_color(dto_dcol);
	
	draw_text_ext(_x, _y, _str, _separation, _width);

	/* Original code, in case I mess something up.
	var dto_dcol=draw_get_color();

	draw_set_color(_outcol);

	for(var dto_i=45; dto_i<405; dto_i+=360/argument5)
	{
	    draw_text(argument0+lengthdir_x(argument3,dto_i),argument1+lengthdir_y(argument3,dto_i),argument2);
	}

	draw_set_color(dto_dcol);

	draw_text(argument0,argument1,argument2);*/
}