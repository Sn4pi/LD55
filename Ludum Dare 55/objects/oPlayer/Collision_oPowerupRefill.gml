/// @description Refill Talisman instantly!
if (!other.visible) exit;

if (time_source_get_state(talisReady) == time_source_state_active) {
	time_source_stop(talisReady);
}

with (other) {
	visible = false;
	image_alpha = 0;
	alarm[0] = FPS * 3;
}