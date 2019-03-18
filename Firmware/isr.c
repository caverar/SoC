#include <generated/csr.h>
#include <irq.h>
#include "game.h"
#include <uart.h>
#include "variables.h"
#include <stdio.h>
#include <stdbool.h>


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
		
		if((ButtonInterrupt & 1)==1){ //derecha
			Buttons_WB_ev_enable_write(0);	
			wait_ms(200);
			playSoundEffect(3);
			moveRightFicha();
			putFicha();
			printTablero();
			removeFicha();
			Buttons_WB_ev_pending_write((1<<3)+(1<<2)+(1<<1)+1);
			Buttons_WB_ev_enable_write((1<<3)+(1<<2)+(1<<1)+1);
			
						
		}else if((ButtonInterrupt & (1<<1))==1<<1){ //Rotar
			Buttons_WB_ev_enable_write(0);
			wait_ms(200);
			
			playSoundEffect(3);
			rotarFicha();		
			putFicha();
			printTablero();
			removeFicha();
			Buttons_WB_ev_pending_write((1<<3)+(1<<2)+(1<<1)+1);
			Buttons_WB_ev_enable_write((1<<3)+(1<<2)+(1<<1)+1);
			
						
		}else if((ButtonInterrupt & (1<<2))==1<<2){ //izquierda
			Buttons_WB_ev_enable_write(0);
			wait_ms(200);
			playSoundEffect(3);
			moveLeftFicha();
			putFicha();
			printTablero();
			removeFicha();
			Buttons_WB_ev_pending_write((1<<3)+(1<<2)+(1<<1)+1);
			Buttons_WB_ev_enable_write((1<<3)+(1<<2)+(1<<1)+1);
						
			
		}else if((ButtonInterrupt & (1<<3))==1<<3){ //Aceleron
			Buttons_WB_ev_enable_write(0);
			wait_ms(200);
			while(moveDownFicha()==1);			
				
			playSoundEffect(3);
			Buttons_WB_ev_pending_write((1<<3)+(1<<2)+(1<<1)+1);
			Buttons_WB_ev_enable_write((1<<3)+(1<<2)+(1<<1)+1);	
				
		}
			
		
		
	}

}

