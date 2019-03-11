#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <irq.h>
#include <uart.h>
#include <console.h>
#include <generated/csr.h>
#include "variables.h"


//Arreglo Tablero
unsigned int Tablero[10][14];

unsigned int puntaje;

unsigned int ficha;

//Imprimir tablero
void PrintTablero(){
	for(unsigned int i = 0; i < 10; i++){
		for(unsigned int j = 0; j < 14; j++){
			putTile((i+(j*20))+21,Tablero[i][j]); 
		}
	}
}

void PrintPuntaje(){
    putTile(96,(puntaje & (1<<0))+ 25 );
    putTile(97,(puntaje & (1<<1))+ 25);
    putTile(98,(puntaje & (1<<2))+ 25);
	
}

unsigned int getFicha(){
    if(ficha<4){
        ficha=ficha+1;
    }else{
        ficha=0,
    }
    return ficha;
}

int main(void)
{	
    unsigned int fichaActual;
	irq_setmask(1<<7);
	irq_setie(1);		
	Buttons_WB_ev_enable_write((1<<3)+(1<<2)+(1<<1)+1);
	//in tablero
	for(int i = 0; i < 10; i++)	{
		for(int j = 0; j < 14; j++){
			Tablero[i][j] = 3; 
		}
	}
	// Pendiente in pantalla
	puntaje=0;
    ficha=0;
    
	
	while(1) {
        PrintPuntaje();
        PrintTablero();
	    fichaActual=getFicha;
        //wait_ms(1000);	
	}
	
	return 0;
}
