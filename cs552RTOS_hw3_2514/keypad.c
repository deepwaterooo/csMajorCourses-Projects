/*
--------------------------------------------------------------------------------------------
Title:  Hello World - 4x4 Keypad
Author:  Jeff Murry
Created: Jan 15, 2008
Purpose:  A simple Hello World example of how to read keys on a 4x4 keypad
Interface: Press keys on keypad. A LED will blink the number of times corresponding to key pressed (1-16)
Power consumption: .5mA when nothing pressed or lit up. 20-45mA when LEDs lit up

Components Used:
- MCU = Atmel ATtiny2313
- 4x4 keypad
- Did not use: 4 10k resistors (to connect between 4 column ports of key pad -- some web sites say not needed)

Wiring connections:
- Keypad "columns" 1-4 (pins 1-4)  to PB0-3 (pins 12-15)
- Keypad "rows" 1-4 (pins 5-8) to PB4-7 (pins 16-19)
- LED with resistor on PD5 (to "+")

Web References:
- Great explanation of options to do this = http://www.avr-asm-tutorial.net/avr_en/keypad/keyboard.html
- Example with c-code of scanning option = http://www.8051projects.net/keypad-interfacing/introduction.php

http://winavr.scienceprog.com/example-avr-projects/4x4-keypad-example-using-avr-gcc-c-language.html

 
--------------------------------------------------------------------------------------------
*/

#define F_CPU 1000000UL 
#include <avr/io.h>
#include <util/delay.h> // used for _delay_ms()

/************ Constant definitions *****************************************/
#define BUILD_VERSION 4   // Update version in comments + display on LCD startup for a few seconds if using

// Keypad constants
#define keyport PORTB           //Keypad Port
#define keyportddr DDRB         //Data Direction Register
#define keyportpin PINB         //Keypad Port Pins

#define col1 PB0                //Column1 PortB.0
#define col2 PB1                //Column2 PortB.1
#define col3 PB2                //Column3 PortB.2
#define col4 PB3                //Column4 PortB.3

#define TRUE 1
#define FALSE 0

// Function to turn power to Port B4 on / off
//#define LEDOFF          PORTD |= (1<<5)
/#define LEDON           PORTD &= ~(1<<5)
#define BLINK_SPEED 250

unsigned char keyval;   //A variable

/************ Function definitions *****************************************/
/*
+---------------------------------------+
| Prototype: void key_init(void);       |
| Return Type: void                     |
| Arguments: None                       |
| Description: Initialize ports and     |
|              Keypad.                  |
+---------------------------------------+
*/
void key_init(void){
        keyportddr = 0xF0;   // 1111 0000
        keyport = 0x0F;      // 0000 1111
}

/*
+-----------------------------------------------+
| Prototype: unsigned char get_key(void);       |
| Return Type: unsigned char (1-16)    |
| Arguments: None                               |
| Description: To read key from the keypad      |
+-----------------------------------------------+
*/
unsigned char get_key(void){
  unsigned char key=0;
  
  // Make rows low one by one (check for press, wait for release, return key)
  // First Row
  PORTB = 0b01111111;
  if (!bit_is_set(PINB, 0)) {while(!bit_is_set(PINB, 0)); key = 1;}
  if (!bit_is_set(PINB, 1)) {while(!bit_is_set(PINB, 0)); key = 2;}
  if (!bit_is_set(PINB, 2)) {while(!bit_is_set(PINB, 0)); key = 3;}
  if (!bit_is_set(PINB, 3)) {while(!bit_is_set(PINB, 0)); key = 4;}
  
  // Second Row
  PORTB = 0b10111111;
  if (!bit_is_set(PINB, 0)) {while(!bit_is_set(PINB, 0)); key = 5;}
  if (!bit_is_set(PINB, 1)) {while(!bit_is_set(PINB, 0)); key = 6;}
  if (!bit_is_set(PINB, 2)) {while(!bit_is_set(PINB, 0)); key = 7;}
  if (!bit_is_set(PINB, 3)) {while(!bit_is_set(PINB, 0)); key = 8;}
  
  // Third Row
  PORTB = 0b11011111;
  if (!bit_is_set(PINB, 0)) {while(!bit_is_set(PINB, 0)); key = 9;}
  if (!bit_is_set(PINB, 1)) {while(!bit_is_set(PINB, 0)); key = 10;}
  if (!bit_is_set(PINB, 2)) {while(!bit_is_set(PINB, 0)); key = 11;}
  if (!bit_is_set(PINB, 3)) {while(!bit_is_set(PINB, 0)); key = 12;}
  
  // Forth Row
  PORTB = 0b11101111;
  if (!bit_is_set(PINB, 0)) {while(!bit_is_set(PINB, 0)); key = 13;} // Column 1
  if (!bit_is_set(PINB, 1)) {while(!bit_is_set(PINB, 0)); key = 14;} // Column 2
  if (!bit_is_set(PINB, 2)) {while(!bit_is_set(PINB, 0)); key = 15;} // Column 3
  if (!bit_is_set(PINB, 3)) {while(!bit_is_set(PINB, 0)); key = 16;} // Column 4
 
  // Reset key ports
  key_init();
          return key;   //return false if no key pressed
}

int main (void)
{
 // Init keys
 keyval = 0;  // Start with key value = 0 (ie.. not pressed)
 key_init();
 
 // Init light
 DDRD |= 1<<DDD5 | 1<<DDD4 | 1<<DDD3 | 1<<DDD2 | 1<<DDD1 | 1<<DDD0;// Set D0-D5 as output
 PORTD &= ~(31); // OFF .. 31=0b11111 // 15 = 0b1111 ie.. binary 1111  //PORTD |= 31; // ON .. 15 = 0b1111 ie.. binary 1111
 //LEDOFF;
 
 // Blink current build #
 for (unsigned char i = 0; i < BUILD_VERSION; i++)
  {
   //LEDON;
   //_delay_ms(BLINK_SPEED);
   //LEDOFF;
   //_delay_ms(BLINK_SPEED);
   
   // Blink test of the 4 binary status lights
   PORTD |= 31; // ON .. 31=0b11111,  15 = 0b1111 ie.. binary 1111
   _delay_ms(BLINK_SPEED);
   PORTD &= ~(31); // OFF
   _delay_ms(BLINK_SPEED);
  }
 
 
 while (1==1)   // Loop forever
 {
  // Check for a key press
  keyval = get_key();
  
  // Turn on 4 binary status lights to match keypress. Reduce keyval by 1 so it is 0-15 to keep to 4 status lights.
  // Only change if status keyval is 0 (ie.. no new keypress)
  if (keyval != 0)
  {
   PORTD &= ~(31); // OFF ALL 4 status lights .. 31=0b11111. 15 = 0b1111 ie.. binary 1111
   PORTD |= keyval; // ON for binary version of key pressed
  }
  
  // Blink lights equal to # of key presses

  
  // Reset keyval before checking again
  keyval = 0;  
 }
      
} 

/*
Web References:
    Good Tutorial with c example - www.8051projects.net/keypad-interfacing/ 
    Good overview of different option -- Connecting keypad to AVR - www.avr-asm-tutorial.net/avr_en/keypad/keyboard.html 
    Explains expected values - http://www.embeddedrelated.com/groups/avrclub/show/2185.php  
    LCD + Keypad schematic example - www.circuitdb.com/circuits/id/56
    Good example with c codehttp://winavr.scienceprog.com/example-avr-projects/4x4-keypad-example-using-avr-gcc-c-language.html
    Atmel 3x3 matrix contest winner - http://www.circuitcellar.com/AVR2004/DA3448.html
    PC keyboard with c example - http://www.scienceprog.com/interfacing-pc-keyboard-to-avr-microcontroller/
    Another example with c - http://www.blitzlogic.com/kbd_C.htm
*/
