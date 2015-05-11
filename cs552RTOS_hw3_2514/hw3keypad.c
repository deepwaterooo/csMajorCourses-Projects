// CS552 Assignment 3
// Heyan Huang   Feb 14, 2013

// Size of code: 000616
// quote: the original codes are adapted from blog.jeffmurry.com
// blog.jeffmurry.com/2008/11/01/how-to-interface-with-4x4-keypad.aspx
// But I have modified them to cater to our keppad design


#define F_CPU 1000000UL 
#include <avr/io.h>
#include <util/delay.h> // used for _delay_ms()
//#include <math.h>

#define BUILD_VERSION 4   // Update version in comments + display on LCD startup for a few seconds if using

// Keypad constants
#define keyport PORTB           //Keypad Port
#define keyportddr DDRB         //Data Direction Register
#define keyportpin PINB         //Keypad Port Pins
#define col1 PB2                //Column1 PortB.2
#define col2 PB4                //Column2 PortB.4
#define col3 PB5                //Column3 PortB.5
#define col4 PB6                //Column4 PortB.6

//#define LEDON PORTD &= ~(1<<5)
#define BLINK_SPEED 250;
unsigned int KeyLock[4] = {0xde, 0xac, 0xe8, 0xb0}; // 2514

uint8_t i;
void delay(unsigned int dly)
{
  for(i = dly; i != 0; i--);
}

void key_init(void){
        keyportddr = 0x8b;   // 0111 0100
        keyport = 0x74;      // 1000 1011
}

unsigned int get_key(void){
  unsigned int key= 0;
  // Make rows low one by one (check for press, wait for release, return key)
  // First Row
  PORTB = 0b01111111;
  if (!bit_is_set(PINB, 2)) {while(!bit_is_set(PINB, 2)); key = 1;}
  if (!bit_is_set(PINB, 4)) {while(!bit_is_set(PINB, 4)); key = 2;}
  if (!bit_is_set(PINB, 5)) {while(!bit_is_set(PINB, 5)); key = 3;}
  if (!bit_is_set(PINB, 6)) {while(!bit_is_set(PINB, 6)); key = 10;} //A
  // Second Row
  PORTB = 0b11111110;
  if (!bit_is_set(PINB, 2)) {while(!bit_is_set(PINB, 2)); key = 4;}
  if (!bit_is_set(PINB, 4)) {while(!bit_is_set(PINB, 4)); key = 5;}
  if (!bit_is_set(PINB, 5)) {while(!bit_is_set(PINB, 5)); key = 6;}
  if (!bit_is_set(PINB, 6)) {while(!bit_is_set(PINB, 6)); key = 11;} //B
  // Third Row
  PORTB = 0b11111101;
  if (!bit_is_set(PINB, 2)) {while(!bit_is_set(PINB, 2)); key = 7;}
  if (!bit_is_set(PINB, 4)) {while(!bit_is_set(PINB, 4)); key = 8;}
  if (!bit_is_set(PINB, 5)) {while(!bit_is_set(PINB, 5)); key = 9;}
  if (!bit_is_set(PINB, 6)) {while(!bit_is_set(PINB, 6)); key = 12;} //C
  // Forth Row
  PORTB = 0b11110111;
  if (!bit_is_set(PINB, 2)) {while(!bit_is_set(PINB, 2)); key = 14;} // Column 1  *
  if (!bit_is_set(PINB, 4)) {while(!bit_is_set(PINB, 4)); key = 16;} // Column 2  0
  if (!bit_is_set(PINB, 5)) {while(!bit_is_set(PINB, 5)); key = 15;} // Column 3  #
  if (!bit_is_set(PINB, 6)) {while(!bit_is_set(PINB, 6)); key = 13;} // Column 4  D
  // Reset key ports
  key_init();
  return key;
}

int compareKey( unsigned int value[])
{
  int y = 0; 
  for(; y<4; y++)
    {
      if (KeyLock[y] != value[y])
	return 0;
    }
  return 1;
}

int main (void)
{
  DDRD = 0XFF;
  PORTD = 0X00;
  unsigned int keyval;
  key_init();
  keyval = 0;  // Start with key value = 0 (ie.. not pressed)

  unsigned int cnt; // indication of number of keys typed
  unsigned int count[4] = {0xfe,0xfc,0xf8,0xf0};
  unsigned int Type[4] = {0};
  int checkflag = 0;
  uint8_t x = 0;

  while(1)
    {
      keyval = get_key();
      if (keyval != 0)
	{
	  PORTD = ~(keyval<<4|(~count[x]));
	  //PORTD = (~keyval<<4)& count[x];
	  //PORTD = count[x];
	  //Type[x] = (~keyval<<4)& count[x];
	  Type[x] = ~( keyval<<4 | (~count[x]) );
	  x++;
	  delay(65000U);

	  if( x == 4)
	    {
	      x = 0;
	      delay(65000U);
	      if ( compareKey(Type) == 1)
		{
		  delay(65000U);
		  PORTD = 0Xfc; // right two LED will be on for correct keys
		}
	      else
		PORTD = 0xf7; // wrong one LED
	    }
	}
    }

  return 0;    
} 
