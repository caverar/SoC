#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <irq.h>
#include <uart.h>
#include <console.h>
#include <generated/csr.h>

//Espera en ms
volatile unsigned int state;
static void wait_ms(unsigned int time)
{
	timer0_en_write(0);
	timer0_reload_write(0);
	timer0_load_write(time*(SYSTEM_CLOCK_FREQUENCY/1000));
	timer0_en_write(1);
	timer0_update_value_write(1);
	while(timer0_value_read()) timer0_update_value_write(1);
}

static void putTile(unsigned int position, unsigned int tile)
{
	
	unsigned int value = (position<<5) + tile;  
	Video_WB_TilesControlRegisterCSR_write(value);
}
static void playTrack ( unsigned int EnablePlay, unsigned int EnableLoop, unsigned int Track){
	Audio_WB_Track1ControlRegisterCSR_write(0);
	Audio_WB_Track1ControlRegisterCSR_write((EnablePlay<<4)+(EnableLoop<<3)+Track);
}


int main(void)
{	
	
	while(1) {
		irq_setmask(1<<7);
		irq_setie(1);
		playTrack(1,1,3);
		Buttons_WB_ev_enable_write((1<<3)+(1<<2)+(1<<1)+1);
		state=0;
		if(state==0){		
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
		}else if(state==1){
			for(int i=0;i<320;i++){
				putTile(i,5);
			}
			wait_ms(200);	
		}else if(state==2){
			for(int i=0;i<320;i++){
				putTile(i,6);
			}
			wait_ms(200);	
		}else if(state==3){
			for(int i=0;i<320;i++){
				putTile(i,7);
			}
			wait_ms(200);	
		}

	}

	return 0;
}
