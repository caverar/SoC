#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <irq.h>
#include <uart.h>
#include <console.h>
#include <generated/csr.h>
#include "variables.h"
//Espera en ms



int main(void)
{	
	putState(2);
	//playSoundTrack();
	while(1) {
		irq_setmask(1<<7);
		irq_setie(1);		
		Buttons_WB_ev_enable_write((1<<3)+(1<<2)+(1<<1)+1);

		
		if(getState()==0){		
			for(int j=0;j<28;j=j+4){

				for(int i=0;i<320;i++){
					if((i%2)>0){
						putTile(i,j);
					}else{
						putTile(i,j+1);
					}				
				}

				wait_ms(200);
				for(int i=0;i<320;i++){
					if((i%3)>0){
						putTile(i,j+2);
					}else{
						putTile(i,j+3);
					}				
				}

				wait_ms(200);	
			}
		}else if(getState()==1){
			for(int i=0;i<320;i++){
				putTile(i,5);
			}
			wait_ms(200);	
		}else if(getState()==2){
			for(int i=0;i<320;i++){
				putTile(i,6);
			}
			wait_ms(200);
			playSoundEffect(1);
			wait_ms(1000);
			playSoundEffect(2);
			wait_ms(1000);
			playSoundEffect(3);
			wait_ms(1000);	
		}else if(getState()==3){
			for(int i=0;i<320;i++){
				putTile(i,7);
			}
			wait_ms(200);	
		}

	}

	return 0;
}
