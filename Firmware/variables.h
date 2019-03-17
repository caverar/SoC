#ifndef VARIABLE_H
#define VARIABLE_H


//SD
//  Manipulacion interna
unsigned int SD_OutputData;
unsigned int SD_InputData;
void setSD_OutputData(unsigned int value);
void setSD_InputData(unsigned int value);
unsigned int getSD_OutputData(void);
unsigned int getSD_InputData(void);

unsigned int SD_alreadySend;
void setSD_alreadySend(unsigned int value);
unsigned int getSD_alreadySend(void);

// Manipulacion externa
void SD_isr(void);
void enableSD(void);
void disableSD(void);
void enableSD_CS(void);
void disableSD_CS(void);

//Timer
void wait_ms(unsigned int time);
void wait_us(unsigned int time);

//Pantalla
void putTile(unsigned int position, unsigned int tile);

//Sonido
void playSoundTrack (void);
void stopSoundTrack (void);
void playSoundEffect (unsigned int Track);

//Aplicacion
unsigned int state;
unsigned int getState(void);
void putState(unsigned int value);

#endif