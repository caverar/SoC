#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <irq.h>
#include <uart.h>
#include <console.h>
#include <generated/csr.h>
#include "variables.h"



//Variables del juego
unsigned int Tablero[10][14];
unsigned int puntaje1;
unsigned int puntaje2;
unsigned int puntaje3;
unsigned int ficha;

//Imprimir tablero
void printTablero(){
	for(unsigned int i = 0; i < 10; i++){
		for(unsigned int j = 0; j < 14; j++){
			putTile((i+(j*20))+21,Tablero[i][j]); 
		}
	}
}

void printPuntaje(){
    
    putTile(98,(puntaje1 + 16));
	putTile(97,(puntaje2 + 16));
    putTile(96,(puntaje3 + 16));
	
}
void sumarPuntaje(unsigned int value){  //menor a 10
	
	if(puntaje1+value>9){
		puntaje2=puntaje2+1;
		puntaje1=puntaje1+value-10;
	}else {
		puntaje1=puntaje1+1;
	}
	if(puntaje2>9){
		puntaje3=puntaje3+1;
		puntaje2=0;
	} 
	if(puntaje3>9){
		puntaje1=0;
		puntaje2=0;
		puntaje3=0;
	}
}

unsigned int getFicha(){
    if(ficha<4){
        ficha=ficha+1;
    }else{
        ficha=0;
    }
    return ficha;
}

int main(void){	
    unsigned int fichaActual=0;
	playSoundTrack();
	irq_setmask(1<<7);
	irq_setie(1);		
	Buttons_WB_ev_enable_write((1<<3)+(1<<2)+(1<<1)+1);
	//inicializacion del tablero
	for(int i = 0; i < 10; i++)	{
		for(int j = 0; j < 14; j++){
			Tablero[i][j] = 3; 
		}
	}
	// incializacion de pantalla
	//...
	//inicializacion Variables de juego
	puntaje1=0;
	puntaje2=0;
	puntaje3=0;
    ficha=0;
    printTablero();
	
	while(1) {
        
        
	    fichaActual=getFicha();

		sumarPuntaje(1);
		printPuntaje();
		wait_ms(100);
	
	}
	
	return 0;
}
