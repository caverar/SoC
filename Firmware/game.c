#include <generated/csr.h>
#include "variables.h"
#include "game.h"
#include <stdio.h>
#include <stdbool.h>




//inicializa la MatrizTab

void inicial_matriz(void){

	for(int i = 0; i < 10; i++)
	{
		for(int j = 0; j < 14; j++)
		{
			MatrizTab[i][j] = 0;
		}
		
	}
	
}
//Colores y forma de fichas

void cambiarFormaFicha(void){
	for(int i = 0; i < 4; i++){
		for(int j = 0; j < 4; j++){
			formaFicha[i][j]=0;
		}
	}
	switch (ficha){
		case 0: //cuadro
			for(int i = 2; i < 4; i++){
				for(int j = 2; j < 4; j++){
					formaFicha[i][j]=color;
				}				
			}			
			break;		
		
		case 1:	//Linea |
			for(int i = 0; i < 4; i++){
				formaFicha[i][0]=color;
			}
			break;
		case 2:	//L
			for(int i = 0; i < 3; i++){
				formaFicha[i][0] = color;
			}
			formaFicha[2][1] = color;
			break;
		case 3:	//L inversa
			for(int i = 0; i < 3; i++){
				formaFicha[i][1] = color;
			}
			formaFicha[2][0] = color;
			break;
		case 4:	//Z
			for(int i = 0; i < 2; i++){
				formaFicha[i][0] = color;
			}
			for(int j = 1; j < 3; j++){
				formaFicha[j][1] = color;
			}
			break;
		case 5:	//Z inversa
			for(int i = 0; i < 2; i++){
				formaFicha[i][1] = color;
			}
			for(int j = 1; j < 3; j++){
				formaFicha[j][0] = color;
			}
			break;
		case 6:	//T
			for(int i = 0; i < 3; i++){
				formaFicha[i][0] = color;
			}
			formaFicha[1][1]=color;
			break;		
	}
}

void rotarFicha(void){
	unsigned int formaFichaAuxiliar[4][4];

	for(int i = 0; i < 4; i++){
		for(int j = 0; j < 4; j++){
			formaFichaAuxiliar[i][j] = formaFicha[i][j];
		}	
	}
	if(ficha==0){
        //ficha que no rota
	}else if(ficha==1){
		for(int i = 0; i < 4; i++){
			for(int j = 0; j < 4; j++){
				formaFicha[j][i] = formaFichaAuxiliar[i][j];
			}
	
		}
	}else if(ficha==2 || ficha==3 || ficha==6){
		for(int i = 0; i < 3; i++){
			for(int j = 0; j < 3; j++){
				formaFicha[j][2-i] = formaFichaAuxiliar[i][j];
			}
	
		}
	}else if(ficha==4 || ficha==5){
		for(int i = 0; i < 3; i++){
			for(int j = 0; j < 3; j++){
				formaFicha[j][i] = formaFichaAuxiliar[i][j];
			}
	
		}
	}
	bool estaFuera=0;

	//restriccion de bordes
	
	for(int i = 0; i < 4; i++){
		for(int j = 0; j < 4; j++){
			if((i+PosX)>9||(j+PosY)>13 ){
				if(formaFicha[i][j]!=0){
					estaFuera=1;
				}
			}
		}
	
	}

	

    //Restriccion vertical

    //Hallar las posiciones mas bajas
    int lowerPositions[4];
    lowerPositions[0]=80;   //80 significa que no la columna esta vacia
    lowerPositions[1]=80;
    lowerPositions[2]=80;
    lowerPositions[3]=80;

    for(int i=0;i<4;i++){
        for(int j=0;j<4;j++){
            if(formaFicha[i][j]!=0){
                lowerPositions[i]=j;
            }
        }
    }

    //Revisar los cuadros bajo la pieza y revisar si no se llego al piso
    for(int i=0;i<4;i++){
        if(lowerPositions[i]!=80 ){
            if((PosY+lowerPositions[i]+1)>=14){
                estaFuera=0;
            }else if(Tablero[PosX+i][PosY+(lowerPositions[i])+1] != 3){
                estaFuera=0;
            }
        }
    }

    if(estaFuera){
		for(int i = 0; i < 4; i++){
			for(int j = 0; j < 4; j++){
				formaFicha[i][j]=formaFichaAuxiliar[i][j];
			}	
		}	
	}

}

void corrimiento(void){


}


//Imprimir tablero

void printTablero(void){
	for(unsigned int i = 0; i < 10; i++){
		for(unsigned int j = 0; j < 14; j++){
			putTile((i+(j*20))+21,Tablero[i][j]); 
		}
	}
}

void printPuntaje(void){
    
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

void getFicha(void){
    if(ficha<6){
        ficha=ficha+1;
    }else{
        ficha=0;
    }    
}
void getColor(void){
    if(color<6){
        color=color+1;
    }else{
        color=1;
    }    
}
void putFicha(void){
	for(int i = 0; i < 4; i++)	{
		for(int j = 0; j < 4; j++){
			Tablero[i+PosX][j+PosY] =Tablero[i+PosX][j+PosY]+formaFicha[i][j]; 
		}
	}
}

void removeFicha(void){
	for(int i = 0; i < 4; i++)	{
		for(int j = 0; j < 4; j++){
			Tablero[i+PosX][j+PosY] =Tablero[i+PosX][j+PosY]-formaFicha[i][j]; 
		}
	}
}
void moveLeftFicha(void){
    
    _Bool moverFicha=1; // Define si se continua con esa ficha o se pasa a la siguiente
    
    //Hallar las posiciones mas a la izquierda
    int lowerPositions[4];
    lowerPositions[0]=80;   //80 significa que no la columna esta vacia
    lowerPositions[1]=80;
    lowerPositions[2]=80;
    lowerPositions[3]=80;

    for(int j=0;j<4;j++){
        for(int i=3;i>=0;i--){
            if(formaFicha[i][j]!=0){
                lowerPositions[j]=i;
            }
        }
    }

    //Revisar los cuadros a la izquierda de la pieza y revisar si no se llego al limite
    for(int i=0;i<4;i++){
        if(lowerPositions[i]!=80 ){
            if((PosX+lowerPositions[i]-1)<0){
                moverFicha=0;
            }else if(Tablero[PosX+lowerPositions[i]-1][PosY+i] != 3){
                moverFicha=0;
            }
        }
    }

    if(moverFicha){
        PosX=PosX-1;
    } 
}

void moveRightFicha(void){
    
    _Bool moverFicha=1; // Define si se continua con esa ficha o se pasa a la siguiente
    
    //Hallar las posiciones mas a la izquierda
    int lowerPositions[4];
    lowerPositions[0]=80;   //80 significa que no la columna esta vacia
    lowerPositions[1]=80;
    lowerPositions[2]=80;
    lowerPositions[3]=80;

    for(int j=0;j<4;j++){
        for(int i=0;i<4;i++){
            if(formaFicha[i][j]!=0){
                lowerPositions[j]=i;
            }
        }
    }

    //Revisar los cuadros a la izquierda de la pieza y revisar si no se llego al limite
    for(int i=0;i<4;i++){
        if(lowerPositions[i]!=80 ){
            if((PosX+lowerPositions[i]+1)>9){
                moverFicha=0;
            }else if(Tablero[PosX+lowerPositions[i]+1][PosY+i] != 3){
                moverFicha=0;
            }
        }
    }

    if(moverFicha){
        PosX=PosX+1;
    } 
}

_Bool moveDownFicha(void){
    _Bool moverFicha=1; // Define si se continua con esa ficha o se pasa a la siguiente
    
    //Hallar las posiciones mas bajas
    int lowerPositions[4];
    lowerPositions[0]=80;   //80 significa que no la columna esta vacia
    lowerPositions[1]=80;
    lowerPositions[2]=80;
    lowerPositions[3]=80;

    for(int i=0;i<4;i++){
        for(int j=0;j<4;j++){
            if(formaFicha[i][j]!=0){
                lowerPositions[i]=j;
            }
        }
    }

    //Revisar los cuadros bajo la pieza y revisar si no se llego al piso
    for(int i=0;i<4;i++){
        if(lowerPositions[i]!=80 ){
            if((PosY+lowerPositions[i]+1)>=14){
                moverFicha=0;
            }else if(Tablero[PosX+i][PosY+(lowerPositions[i])+1] != 3){
                moverFicha=0;
            }
        }
    }

    if(moverFicha){
        PosY=PosY+1;
    }
    return moverFicha;
    
}

void removeFila(int fila){
    int copiaTablero[10][18];
    for(int i = 0; i < 10; i++)	{
		for(int j = 0; j < 18; j++){
			copiaTablero[i][j]=Tablero[i][j]; 
		}
	}

    for(int j = fila; j >= 1; j--){
        for(int i = 0; i < 10; i++){
			Tablero[i][j]=Tablero[i][j-1]; 
		}
    }
}
