/// @description Reset
//Reset any cooldowns and states
with (oPlayer) {
	time_source_stop(movement.longJump);
	time_source_stop(chargeTimer);
	time_source_stop(talisReady);
	slowMo = 1.0;
}