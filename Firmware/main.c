#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#include <irq.h>
#include <uart.h>
#include <console.h>
#include <generated/csr.h>
#include "variables.h"
#include "game.h"
#include "SD.h"



int main(void){

	//inicializacion de Perifericos
		
	irq_setmask((1<<7)+(1<<8)+(1<<2));
	irq_setie(1);
	Buttons_WB_ev_enable_write((1<<3)+(1<<2)+(1<<1)+1);		
	initSD();
	loadSoundTrackDataFromSD();
	stopSD();	
	putTile( 0,15);

	//Juegos		
	//	inicializacion del tablero
	for(int i = 0; i < 10; i++)	{
		for(int j = 0; j < 18; j++){
			Tablero[i][j] = 3; 
		}
	}
	printTablero();

	playSoundTrack();
	
	//inicializacion Variables de juego
	puntaje1=0;
	puntaje2=0;
	puntaje3=0;
    ficha=0;	
	PosX=3;
	PosY=-4;

	//Juego
	
	while(1){

		getFicha();
		
		cambiarFormaFicha();
		wait_ms(500);

		while(moveDownFicha()==1){			
			putFicha();
			printTablero();
			removeFicha();	
			wait_ms(500);
			
		}
		putFicha();
		printTablero();
		PosY=-4;
		printf("Hola");	
		
	}

	//rotarFicha();		
	//putFicha();
	//printTablero();
	sumarPuntaje(1);
	printPuntaje();
	
	wait_ms(100);
	
	
	
	return 0;
}
