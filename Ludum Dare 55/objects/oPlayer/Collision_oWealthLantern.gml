/// @description Get Wealthy
if (!visible) exit;

wealth++;
wealthX = other.x;
wealthY = other.y;
//PLAY SFX
audio_play_sound(oMusic.sfx[sound.chime], 1, 0, volSfx);

with (other) instance_destroy();