#include <generated/csr.h>
#include <irq.h>
#include <uart.h>
#include "variables.h"
#include <stdio.h>


extern void periodic_isr(void);

unsigned int localState=0;

void isr(void);
void isr(void)
{
		
	unsigned int irqs;
	unsigned int ButtonInterrupt;	
	ButtonInterrupt = Buttons_WB_ev_pending_read();
	irqs = irq_pending() & irq_getmask();


	if(irqs & (1 << SD_WB_INTERRUPT)){		
		SD_isr();
	}
	if(irqs & (1 << UART_INTERRUPT)){
		uart_isr();
	}else if(irqs & (1 << BUTTONS_WB_INTERRUPT)){
		
		if((ButtonInterrupt & 1)==1){
			putState(0);
			if(localState==0){
				playSoundTrack();
				localState=1;
			}else{
				stopSoundTrack();
				localState=0;
			}
						
		}else if((ButtonInterrupt & (1<<1))==1<<1){
			putState(1);
			playSoundEffect(1);
			
						
		}else if((ButtonInterrupt & (1<<2))==1<<2){
			putState(2);
			playSoundEffect(2);			
			
		}else if((ButtonInterrupt & (1<<3))==1<<3){
			putState(3);
			playSoundEffect(3);			
		}
		Buttons_WB_ev_pending_write((1<<3)+(1<<2)+(1<<1)+1);
		
	}

}

