// CS552 Assignment 3
// Heyan Huang      Feb 14, 2013

#include<avr/io.h>

uint8_t i;
void delay(unsigned int dly)
{
  for(i = dly; i != 0; i--);
}

int main()
{
  uint8_t row, col;
  // PortB for keypad input, PortD for LED lights
  DDRB = 0X8b;
  PORTB = 0X74;
  col = PINB; 

  if(PINB != 0x74 )
    {
      DDRB = 0X74;
      PORTB = 0X8B;
      row = PINB;
    }

  switch (col)
    {
    case 0x34:
      4;
      break;
    case 0x54:
      3;
      break;
    case 0x64: 
      2;
      break;
    case 0x70:
      1;
      break;
    }

  switch (row)
    {
    case 0x0b:
      1;
      break;
    case 0x83:
      4;
      break;
    case 0x89: 
      3;
      break;
    case 0x8a:
      2;
      break;
    }

  uint8_t key = 0;
  if ( row == 1 && col == 1) key = 1;       //1
  else if ( row == 1 && col == 2 )  key = 2; //2
  else if ( row == 1 && col == 3 )  key = 3; //3
  else if ( row == 1 && col == 4 )  key = 13;//A
  else if ( row == 2 && col == 1 )  key = 4; //4 
  else if ( row == 2 && col == 2 )  key = 5; //5
  else if ( row == 2 && col == 3 )  key = 6; //6
  else if ( row == 2 && col == 4 )  key = 14;//B
  else if ( row == 3 && col == 1 )  key = 7; //7
  else if ( row == 3 && col == 2 )  key = 8; //8
  else if ( row == 3 && col == 3 )  key = 9; //9 
  else if ( row == 3 && col == 4 )  key = 15;//C
  else if ( row == 4 && col == 1 )  key = 11;//*
  else if ( row == 4 && col == 2 )  key = 10;//0
  else if ( row == 4 && col == 3 )  key = 12;//#
  else if ( row == 4 && col == 4 )  key = 16;//D
  else{;}

  // PortD for LED lights, key values will be shown in upper four bits
  // input key nubers will be indicated by LED lights in lower four bits
  // When the entered key is KeyLock key, the lower four bits will be on in turn and then all on

  DDRD = 0XFF;

  uint8_t j = 1, cnt;  // indication of number of keys typed

  uint8_t KeyLock[4] = [0x02, 0x00, 0x01, 0x04];
  int check = 0;

  while (key != 0)
    {
      cnt = 2^j - 1;
      j++;
      // PORTD = ~(key<<4 | cnt);  final version
      PORTD = ~key<<4;   // check for key connections
      delay(65000U);
      if (j > 4 )
	j = 1;

      uint8_t x; 
      for(x = 0; x < 4; x++)
	{
	  if (key == KeyLock[j-1])
	    check++;
	  
    }

  

  return 0;
}
