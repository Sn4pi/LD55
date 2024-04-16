/// @description Count up timer
if (timerGo) {
	timer += (delta_time / 10000);		//Count Up the miliseconds
	
	tMilis = floor(timer mod 100);
	tSec = (timer div 100) mod 60;
	tMin = ((timer div 100) div 60) mod 60;
}
