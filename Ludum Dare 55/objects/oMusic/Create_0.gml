/// @description Init
globalvar volMusic, volSfx;
volMusic = 1.0;
volSfx = 1.0;

enum sound {
	charging,		//Ist Klar				X
	chime,			//Laterne				X
	clap,			//Teleport Animation	X
	fall,			//Jump					X
	slash,			//DEATH					X
	step,			//Landing				X
	teleport,		//Teleport				X
	throwing,		//Throw					X
	chargethrow,
	roomexitt,
};
sfx = [Charging, Chime2, SFX_Clap1, SFX_Fall1, SFX_Slash, SFX_Step2, SFX_Teleport3, SFX_Throw,SFX_Chargethrow,roomexit];

music = [TRACK1, TRACK2, TRACK3, TRACKTITLE];
//Loop Points
audio_sound_loop_start(music[0], 30.19);
audio_sound_loop_start(music[2], 8.09);
musicPlaying = -1;