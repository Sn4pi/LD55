/// @description Count up timer, change slowMo
if (timerGo) {
	timer += (delta_time / 10000);		//Count Up the miliseconds
	
	tMilis = floor(timer mod 100);
	tSec = (timer div 100) mod 60;
	tMin = ((timer div 100) div 60) mod 60;
}

if (slowMo < 1) {
	var _slowMoFade = 1 / (oPlayer.chargeCd * 1.8 * FPS);		//uninteressant / (chargeCd * DAUER * SEKUNDE);
	slowMo = Approach(slowMo, 1.0, _slowMoFade);
}