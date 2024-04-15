/// @description Float
switch (travel) {
	case 0:
		spd = (1 - abs(y - ystart) / floatDistance) * spdMax;
		spd = clamp(spd, spdMin, spdMax);
		y = Approach(y, floatY[0], spd);
		if (y == floatY[0] && alarm[0] == -1) alarm[0] = switchCd;
	break;
	
	case 1:
		spd = (1 - abs(y - ystart) / floatDistance) * spdMax;
		spd = clamp(spd, spdMin, spdMax);
		y = Approach(y, floatY[1], spd);
		if (y == floatY[1] && alarm[0] == -1) alarm[0] = switchCd;
	break;
}