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

//Play SFX
audio_play_sound(oMusic.sfx[sound.sawblade], 0, 1, volSfx * random_range(0.8, 0.9), 0, random_range(0.95, 1.05));