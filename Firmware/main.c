#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <irq.h>
#include <uart.h>
#include <console.h>
#include <generated/csr.h>
#include "variables.h"


unsigned int swSD(unsigned int outValue){
	while(getSD_alreadySend()==0);
	setSD_OutputData(outValue);
	setSD_alreadySend(0);
	return getSD_InputData() & 255;
	
}

void initSD(){
	unsigned int InputData;
	wait_ms(1);
	enableSD();	
		
	SD_WB_ev_enable_write(1);
	for(unsigned int i=0;i<11;i++){
		InputData=swSD(255);
	}
	enableSD_CS();
	//CMD0-Reset
	InputData=swSD(64);		//CMD   : 01000000
	InputData=swSD(0);		//DATA0 : 00000000
	InputData=swSD(0);		//DATA1 : 00000000
	InputData=swSD(0);		//DATA2 : 00000000
	InputData=swSD(0);		//DATA3 : 00000000
	InputData=swSD(149);	//CRC   : 10010101	
	while(swSD(255)!=1);	//Response

	//CMD58-ACMD
	InputData=swSD(119);	//CMD   : 01110111
	InputData=swSD(0);		//DATA0 : 00000000
	InputData=swSD(0);		//DATA1 : 00000000
	InputData=swSD(0);		//DATA2 : 00000000
	InputData=swSD(0);		//DATA3 : 00000000
	InputData=swSD(255);	//CRC   : 11111111	
	while(swSD(255)!=1);	//Response
	//ACMD41-Init
	InputData=swSD(105);	//CMD   : 01101001
	InputData=swSD(0);		//DATA0 : 00000000
	InputData=swSD(0);		//DATA1 : 00000000
	InputData=swSD(0);		//DATA2 : 00000000
	InputData=swSD(0);		//DATA3 : 00000000
	InputData=swSD(255);	//CRC   : 11111111	
	while(swSD(255)!=1);	//Response

	wait_ms(300);

	//CMD58-ACMD
	InputData=swSD(119);	//CMD   : 01110111
	InputData=swSD(0);		//DATA0 : 00000000
	InputData=swSD(0);		//DATA1 : 00000000
	InputData=swSD(0);		//DATA2 : 00000000
	InputData=swSD(0);		//DATA3 : 00000000
	InputData=swSD(255);	//CRC   : 11111111	
	while(swSD(255)!=1);	//Response
	//ACMD41-Init
	InputData=swSD(105);	//CMD   : 01101001
	InputData=swSD(0);		//DATA0 : 00000000
	InputData=swSD(0);		//DATA1 : 00000000
	InputData=swSD(0);		//DATA2 : 00000000
	InputData=swSD(0);		//DATA3 : 00000000
	InputData=swSD(255);	//CRC   : 11111111	
	while(swSD(255)!=0);	//Response
	
}

void loadSoundTrackDataFromSD(){
	//CMD17
	InputData=swSD(81);		//CMD   : 01010001
	InputData=swSD(0);		//DATA0 : 00000000
	InputData=swSD(0);		//DATA1 : 00000000
	InputData=swSD(10);		//DATA2 : 00001010 -0A
	InputData=swSD(0);		//DATA3 : 00000000
	InputData=swSD(1);		//CRC   : 00000001	
	while(swSD(255)!=0);	//Response

}

void stopSD(){
	disableSD();
	disableSD_CS();
}




int main(void){

		
	irq_setmask((1<<7)+(1<<8)+(1<<2));
	irq_setie(1);
	Buttons_WB_ev_enable_write((1<<3)+(1<<2)+(1<<1)+1);
	
	
	playSoundTrack();
	initSD();
	loadSoundTrackDataFromSD();
	stopSD();	
	
	
	
	
	
	return 0;
}
