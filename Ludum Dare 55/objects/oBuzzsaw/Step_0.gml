/// @description Move
switch (travel) {
	case -1: exit;
	
	case 0:
		if (dir == 0) {
			spd = (1 - abs(x - xstart) / travelLen) * spdMax;
			spd = clamp(spd, spdMin, spdMax);
			x = Approach(x, horizontalBorder[0], spd);
			if (x == horizontalBorder[0] && alarm[0] == -1) alarm[0] = switchCd;
		}
		else {
			spd = (1 - abs(y - ystart) / travelLen) * spdMax;
			spd = clamp(spd, spdMin, spdMax);
			y = Approach(y, verticalBorder[0], spd);
			if (y == verticalBorder[0] && alarm[0] == -1) alarm[0] = switchCd;
		}
	break;
	
	case 1:
		if (dir == 0) {
			spd = (1 - abs(x - xstart) / travelLen) * spdMax;
			spd = clamp(spd, spdMin, spdMax);
			x = Approach(x, horizontalBorder[1], spd);
			if (x == horizontalBorder[1] && alarm[0] == -1) alarm[0] = switchCd;
		}
		else {
			spd = (1 - abs(y - ystart) / travelLen) * spdMax;
			spd = clamp(spd, spdMin, spdMax);
			y = Approach(y, verticalBorder[1], spd);
			if (y == verticalBorder[1] && alarm[0] == -1) alarm[0] = switchCd;
		}
	break;
}