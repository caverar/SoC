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
	color=0;	
	PosX=3;
	PosY=-4;

	//Juego
	
	while(1){

		getFicha();
		getColor();
		
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
		printPuntaje();
		//Revision Perder
		bool perder =0;
		for(int i=0;i<10;i++){
			if(Tablero[i][0]!=3){
				perder=1;
			}
		}
		if(perder){
			stopSoundTrack();
			playSoundEffect(2);
			wait_ms(1000);
			playSoundTrack();
			for(int i = 0; i < 10; i++)	{
				for(int j = 0; j < 18; j++){
					Tablero[i][j] = 3; 
				}
			}
			puntaje1=0;
			puntaje2=0;
			puntaje3=0;
		}
		int puntosNuevos=0;
		
		//Revision Punto
		

		for(int j = 0; j < 14; j++)	{
			bool filaCompletada=1;
			for(int i = 0; i < 10; i++){
				if(Tablero[i][j] == 3 ){
					filaCompletada=0;
				}					
			}
			if(filaCompletada){
				removeFila(j);
				puntosNuevos=puntosNuevos+1;
			}
		}
		
		if(puntosNuevos!=0){
			sumarPuntaje(puntosNuevos);
			playSoundEffect(1);
		}

		
		printTablero();
		printPuntaje();
		PosY=-4;
		PosX=3;
		
	}
	
	
	
	return 0;
}
