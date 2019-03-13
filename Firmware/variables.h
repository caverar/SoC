#ifndef VARIABLE_H
#define VARIABLE_H

unsigned int state;
unsigned int getState();
void putState(unsigned int value);
void wait_ms(unsigned int time);
void wait_ns(unsigned int time);
void putTile(unsigned int position, unsigned int tile);
void playSoundTrack ();
void stopSoundTrack ();
void playSoundEffect (unsigned int Track);


#endif