#include <generated/csr.h>
#include "variables.h"
#include <stdio.h>

//SD

//	Manipulacion interna

void setSD_OutputData(unsigned int value){
	SD_OutputData=value & 255;
}
void setSD_InputData(unsigned int value){
	SD_InputData =value & 255;	
}

unsigned int getSD_OutputData(void){
	return SD_OutputData;
}
unsigned int getSD_InputData(void){
	return SD_InputData;
}

void setSD_alreadySend(unsigned int value){
	SD_alreadySend=value;
}
unsigned int getSD_alreadySend(void){
	return SD_alreadySend;
}
//	Manipulacion externa

void SD_isr(void){
	SD_WB_OuputDataRegister_write(getSD_OutputData());
	setSD_InputData(SD_WB_InputDataRegisterCSR_read());
	setSD_alreadySend(1);
	SD_WB_ev_pending_write(1);
}

void enableSD(void){
	SD_WB_SPI_EnableRegister_write(1);
}

void disableSD(void){
	SD_WB_SPI_EnableRegister_write(0);
}

void enableSD_CS(void){
	SD_WB_SPI_EnableCSRegister_write(1);
}
void disableSD_CS(void){
	SD_WB_SPI_EnableCSRegister_write(0);
}



//Timer

void wait_ms(unsigned int time){
	timer0_en_write(0);
	timer0_reload_write(0);
	timer0_load_write(time*(SYSTEM_CLOCK_FREQUENCY/1000));
	timer0_en_write(1);
	timer0_update_value_write(1);
	while(timer0_value_read()) timer0_update_value_write(1);
}
void wait_us(unsigned int time){
	timer0_en_write(0);
	timer0_reload_write(0);
	timer0_load_write(time*(SYSTEM_CLOCK_FREQUENCY/1000000));
	timer0_en_write(1);
	timer0_update_value_write(1);
	while(timer0_value_read()) timer0_update_value_write(1);
}

//Pantalla

void putTile(unsigned int position, unsigned int tile){
	
	unsigned int value = (position<<5) + tile;  
	Video_WB_TilesControlRegisterCSR_write(value);
}


//Sonido
void playSoundTrack(void){
	unsigned int CurrentValue=((1)+(1<<1)+(1<<2)) & Audio_WB_AudioControlRegister_read();
 	Audio_WB_AudioControlRegister_write(CurrentValue+(1<<3));
}
void stopSoundTrack(void){
	unsigned int CurrentValue=((1)+(1<<1)+(1<<2)) & Audio_WB_AudioControlRegister_read();
 	Audio_WB_AudioControlRegister_write(CurrentValue);
}

void playSoundEffect(unsigned int Track){
	unsigned int CurrentValue=(1<<3) & Audio_WB_AudioControlRegister_read();	 	
 	Audio_WB_AudioControlRegister_write(CurrentValue);
	Audio_WB_AudioControlRegister_write(CurrentValue+Track+(1<<2));
}

//Aplicacion

void putState(unsigned int value){
	state=value;
}
unsigned int getState(void){
	return state;
} 



