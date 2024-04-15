/// @description Play Music
//Select the first room of THIS track and the last room playing this TRACK
var _trackNum = 0;
if (room == rm1Corridor || room == rm2Shaft) _trackNum = 0;
else if (room == rm3DropAndRise || room == rm4Stairs) _trackNum = 1;
else if (room == rm5Refills || room == rm6Bouncyfun) _trackNum = 2;

if (musicPlaying != -1 && musicPlaying != music[_trackNum]) {
	audio_sound_gain(musicPlaying, 0, 1000);
	if (audio_sound_get_gain(musicPlaying)) {
		audio_stop_sound(musicPlaying);
		musicPlaying = -1;
	}
}

else if (musicPlaying == -1) {
	musicPlaying = music[_trackNum];
	audio_play_sound(musicPlaying, 100, true);
	audio_sound_gain(musicPlaying, 0, 0);
	audio_sound_gain(musicPlaying, volMusic, 1000);
}