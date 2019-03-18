#ifndef GAME_H
#define GAME_H

//Variables del juego
int Tablero[10][18];
unsigned int puntaje1;
unsigned int puntaje2;
unsigned int puntaje3;
int ficha;
int color;
unsigned int MatrizTab[10][14];
unsigned int formaFicha[4][4];
int PosX;
int PosY;
_Bool pausa;

//inicializa la MatrizTab

void inicial_matriz(void);
//Colores y forma de fichas

void cambiarFormaFicha(void);

void rotarFicha(void);
void corrimiento(void);


//Imprimir tablero

void printTablero(void);

void printPuntaje(void);
void sumarPuntaje(unsigned int value);  //menor a 10
	
void getFicha(void);
void getColor(void);

void putFicha(void);

void removeFicha(void);
void moveLeftFicha(void);
void moveRightFicha(void);
_Bool moveDownFicha(void);

void removeFila(int fila);
#endif