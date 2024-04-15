/// @description Play Music, sort SFX
if (musicPlaying != -1 && musicPlaying != music[trackNum]) {
	audio_sound_gain(musicPlaying, 0, 1000);
	if (audio_sound_get_gain(musicPlaying)) {
		audio_stop_sound(musicPlaying);
		musicPlaying = -1;
	}
}

else if (musicPlaying == -1) {
	musicPlaying = music[trackNum];
	audio_play_sound(musicPlaying, 100, true);
	audio_sound_gain(musicPlaying, 0, 0);
	audio_sound_gain(musicPlaying, volMusic, 1000);
}


if (instance_exists(oPlayer)) {
	with (oPlayer) {
		//JUMP BAR
		if (movement.jumpCharge) {
			//PLAY SFX
			if (!audio_is_playing(oMusic.sfx[sound.charging])) audio_play_sound(oMusic.sfx[sound.charging], 1, 0, volSfx -0.5, 0, 0.6 * audio_sound_length(oMusic.sfx[sound.charging]) / 0.75);
		}
		//THROW BAR
		else if (time_source_get_state(chargeTimer) == time_source_state_active) {
			//PLAY SFX
			if (!audio_is_playing(oMusic.sfx[sound.charging])) audio_play_sound(oMusic.sfx[sound.charging], 1, 0, volSfx, 0, 0.5 * audio_sound_length(oMusic.sfx[sound.charging]) / time_source_get_period(chargeTimer));
		}
		else if (time_source_get_state(chargeTimer) != time_source_state_active && audio_is_playing(oMusic.sfx[sound.charging])) audio_stop_sound(oMusic.sfx[sound.charging]);
	}
}