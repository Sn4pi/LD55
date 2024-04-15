/// @description Init
spd = 0;
spdMax = 12;
spdMin = 2;

travelLen = 64;
horizontalBorder = [xstart - travelLen, xstart + travelLen];
verticalBorder = [ystart - travelLen, ystart + travelLen];

enum sawDirection {
	horizontal = 0,
	vertical = 1
};
dir = sawDirection.horizontal;
travel = -1;
switchCd = FPS * 1.0;