#include <generated/csr.h>
#include "variables.h"
#include <stdio.h>

void putState(unsigned int value){
	state=value;
}
unsigned int getState(){
	return state;
} 

void wait_ms(unsigned int time){
	timer0_en_write(0);
	timer0_reload_write(0);
	timer0_load_write(time*(SYSTEM_CLOCK_FREQUENCY/1000));
	timer0_en_write(1);
	timer0_update_value_write(1);
	while(timer0_value_read()) timer0_update_value_write(1);
}

void putTile(unsigned int position, unsigned int tile){
	
	unsigned int value = (position<<5) + tile;  
	Video_WB_TilesControlRegisterCSR_write(value);
}
void playSoundTrack(){
	unsigned int CurrentValue=((1)+(1<<1)+(1<<2)) & Audio_WB_AudioControlRegisterCSR_read();
 	Audio_WB_AudioControlRegisterCSR_write(CurrentValue+(1<<3));
}
void stopSoundTrack(){
	unsigned int CurrentValue=((1)+(1<<1)+(1<<2)) & Audio_WB_AudioControlRegisterCSR_read();
 	Audio_WB_AudioControlRegisterCSR_write(CurrentValue);
}

void playSoundEffect(unsigned int Track){
	unsigned int CurrentValue=(0+(1<<3)) & Audio_WB_AudioControlRegisterCSR_read();
	//printf("Value %u",CurrentValue+Track+(1<<2));	 	
 	Audio_WB_AudioControlRegisterCSR_write(CurrentValue);
	Audio_WB_AudioControlRegisterCSR_write(CurrentValue+Track+(1<<2));
}

