#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <irq.h>
#include <uart.h>
#include <console.h>
#include <generated/csr.h>
#include "variables.h"



unsigned int readSD(){
	while(SD_WB_EnableDataReadRegisterCSR_read()==0){
	}
	return SD_WB_InputDataRegisterCSR_read();
} 

void writeSD(unsigned int value){

	SD_WB_OuputDataRegister_write(value & 255 );
	while(SD_WB_BussyDataWriteRegisterCSR_read()==1){
	}
	SD_WB_EnableDataWriteRegister_write(1);
	SD_WB_EnableDataWriteRegister_write(0);
	wait_ns(1);


}
void enableSD(){
	SD_WB_SPI_EnableRegister_write(1);
}


int main(void){	
    
	playSoundTrack();
	irq_setmask(1<<7);
	irq_setie(1);		
	Buttons_WB_ev_enable_write((1<<3)+(1<<2)+(1<<1)+1);
	enableSD();
	for(unsigned int i=0;i<256;i++){
		writeSD(i);	
	}
	
	return 0;
}
