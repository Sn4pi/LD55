/// @description Init
spd = 0;
spdMax = 9;
spdMin = 1;

travelLen = 96;
horizontalBorder = [xstart - travelLen, xstart + travelLen];
verticalBorder = [ystart - travelLen, ystart + travelLen];

enum sawDirection {
	horizontal = 0,
	vertical = 1
};
dir = sawDirection.horizontal;
travel = -1;
switchCd = FPS * 1.0;