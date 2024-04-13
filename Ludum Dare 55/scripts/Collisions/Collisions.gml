//General stuff usable for all instances
//Collisions
function collisionsX(_hspd) {
	var _collisions = move_and_collide(_hspd * delta, 0, oCollision, 8);
	if (array_length(_collisions) > 0) _hspd = 0;
	return _hspd;
	
	/*var bbox_side;
	
	//Horizontal
	//Set bbox
	if (_hspd > 0) bbox_side = bbox_right; else bbox_side = bbox_left;
	
	if (tilemap_get_at_pixel(tilemap, bbox_side + ceil(_hspd), bbox_top) != 0 ||
		tilemap_get_at_pixel(tilemap, bbox_side + ceil(_hspd), bbox_bottom) != 0) {
		if (_hspd > 0) x = x - (x mod 10) + 9 - (bbox_right - x);
		else x = x - (x mod 10) - (bbox_left - x);
		_hspd = 0;
	}
	x += _hspd;
	return _hspd;*/
}

function collisionsY(_vspd) {
	var _collisions = move_and_collide(0, _vspd * delta, oCollision, 8);
	if (array_length(_collisions) > 0) _vspd = 0;
	return _vspd;
	
	/*var bbox_side;

	//Vertical
	//Set bbox
	if (_vspd > 0) bbox_side = bbox_bottom; else bbox_side = bbox_top;
	
	if (tilemap_get_at_pixel(tilemap, bbox_right, bbox_side + ceil(_vspd)) != 0 ||
		tilemap_get_at_pixel(tilemap, bbox_left, bbox_side + ceil(_vspd)) != 0) {
		if (_vspd > 0) y = y - (y mod 10) + 9 - (bbox_bottom - y);
		else y = y - (y mod 10) - (bbox_top - y);
		_vspd = 0;
	}
	y += _vspd;
	return _vspd;*/
}
