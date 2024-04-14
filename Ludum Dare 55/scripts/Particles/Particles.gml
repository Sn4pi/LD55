function partTeleport(_duration, _dir, _scl, _img) {
	part_type_direction(pTeleport, _dir, _dir, 0, 0);
	part_type_orientation(pTeleport, _dir, _dir, 0, 0, 0);
	part_type_alpha2(pTeleport, 1, 0);
	part_type_scale(pTeleport, _scl, 1);
	part_type_life(pTeleport, _duration, _duration);
	part_type_sprite(pTeleport, sTeleport, 0, 0, 0);
	part_type_subimage(pTeleport, _img);
}