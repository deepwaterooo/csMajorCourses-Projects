#include<avr/io.h>

int main()
{
  // high nibble for output(columns) low for input(rows)' port D
  //  DDRB = 0XF0;
  DDRD = 0x74;
  
  // enable internal pullups for PB0-PB3
  // PORTB = 0X0F;
  PORTD = 0X8B;

  // PROTD for indication only
  //ddrd = 0xff;
  DDRB = 0XFF;

  while(1) // loop key check forever
    {
      // first column
      //      PORTB = 0b01111111;
      PORTD = 0b11111011;

      // check for rows and send key number to portD
      // instead sending key number to portd you can use
      // any function that serves pressed button
      if (bit_is_set(PIND,7)) PORTB =1;
      if (bit_is_set(PIND,0)) PORTB =4;
      if (bit_is_set(PIND,1)) PORTB =7;
      if (bit_is_set(PIND,3)) PORTB =11;

      // second column
      //      PORTB = 0b10111111;
      PORTD = 0b11101111;
      if (bit_is_set(PIND,7)) PORTB =2;
      if (bit_is_set(PIND,0)) PORTB =5;
      if (bit_is_set(PIND,1)) PORTB =8;
      if (bit_is_set(PIND,3)) PORTB =0;

      // third column
      //PORTB = 0b11011111;
      PORTD = 0b11011111;
      if (bit_is_set(PIND,7)) PORTB =3;
      if (bit_is_set(PIND,0)) PORTB =6;
      if (bit_is_set(PIND,1)) PORTB =9;
      if (bit_is_set(PIND,3)) PORTB =12;

      // four column
      //      PORTB = 0b11101111;
      PORTD = 0b01111111;
      if (bit_is_set(PIND,7)) PORTB =13;
      if (bit_is_set(PIND,0)) PORTB =14;
      if (bit_is_set(PIND,1)) PORTB =15;
      if (bit_is_set(PIND,3)) PORTB =16;
    }
  return 0;
}

// each i/o port in AVR has three related registers PORTx, DDRx and PINx. 
// For example port A has: 

// PORTA Port Driver - when any bit is set to 1 it appears as HIGH i.e. 5v . 
//      But this is the case only if that bit is OUTPUT. 
//      If it is input, setting any bit to 1 enables the internal pullup on that bit.

// DDRA Data Direction Register - Make any pin on than port as IN or OUT.
//      When bit is 1 it represents Output. When bit is 0 it represents Input. 
//      Input state is also called tristate or high Z state.

// PINA - Read it to get the level(HIGH or LOW) at the actual i/o pin. 
//      It is read when the pin is made input. 

// So now you know
//    How to make any i/o line Input(high Z) or Output.
//    How to enable internal pullup register on input lines.
//    How to read value that is present on input lines.

// Port D's related registers

// DDRD: 
// This is the Data Direction Register of PORTD. 
// The bits in this register set the data direction of individual pins. 
// The direction for each pin can be input or output. 
// Port pins are made input when you want to read data from them ex a light sensor. 
// They are made output when you want to use them to output data ex blink led or control a motor. 
// To set any pin as output set its bit to ‘1’ and to make it input make it ‘0’.
// example: make portD-0 as output:  DDRD=0b00000001;
// In this example portd’s 0th bit is made output while rest pins are input.By default all IO port pins are input i.e. ‘0’ 

// PORTD: 
// After you have set the pins to output now you can control them with the register 
// The values you write here will be visible on the related pins of the MCU. 
// Make portd-0 high: PORTD=0b00000001;
// Wait one sec:      Wait(1);
// Make it low:       PORTD=0b00000000;

// PIND - Port Input: 
// When you set any port pin as input you have to read its status using this register. 
// Suppose you have connected a switch as shown below


