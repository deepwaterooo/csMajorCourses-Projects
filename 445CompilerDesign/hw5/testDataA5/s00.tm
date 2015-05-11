* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  s00.c-
* BEGIN function input
  1:     ST  3,-1(1) 	Store return address 
  2:     IN  2,2,2 	Grab int input 
  3:     LD  3,-1(1) 	Load return address 
  4:     LD  1,0(1) 	Adjust fp 
  5:    LDA  7,0(3) 	Return 
* END of function input
* BEGIN function output
  6:     ST  3,-1(1) 	Store return address 
  7:     LD  3,-2(1) 	Load parameter 
  8:    OUT  3,3,3 	Output integer 
  9:    LDC  2,0(6) 	Set return to 0 
 10:     LD  3,-1(1) 	Load return address 
 11:     LD  1,0(1) 	Adjust fp 
 12:    LDA  7,0(3) 	Return 
* END of function output
* BEGIN function inputb
 13:     ST  3,-1(1) 	Store return address 
 14:    INB  2,2,2 	Grab bool input 
 15:     LD  3,-1(1) 	Load return address 
 16:     LD  1,0(1) 	Adjust fp 
 17:    LDA  7,0(3) 	Return 
* END of function inputb
* BEGIN function outputb
 18:     ST  3,-1(1) 	Store return address 
 19:     LD  3,-2(1) 	Load parameter 
 20:   OUTB  3,3,3 	Output bool 
 21:    LDC  2,0(6) 	Set return to 0 
 22:     LD  3,-1(1) 	Load return address 
 23:     LD  1,0(1) 	Adjust fp 
 24:    LDA  7,0(3) 	Return 
* END of function outputb
* BEGIN function outnl
 25:     ST  3,-1(1) 	Store return address 
 26:  OUTNL  3,3,3 	Output a newline 
 27:     LD  3,-1(1) 	Load return address 
 28:     LD  1,0(1) 	Adjust fp 
 29:    LDA  7,0(3) 	Return 
* END of function outnl
* BEGIN function main
 30:     ST  3,-1(1) 	Store return address. 
* Add standard closing in case there is no return statement
 31:    LDC  2,0(6) 	Set return value to 0 
 32:     LD  3,-1(1) 	Load return address 
 33:     LD  1,0(1) 	Adjust fp 
 34:    LDA  7,0(3) 	Return 
* END of function main
* BEGIN function dogs
 35:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
 36:    LDC  3,10(6) 	load size of array ccc
 37:     ST  3,-8(1) 	save size of array ccc
 38:    LDC  3,10(6) 	load size of array ddd
 39:     ST  3,-19(1) 	save size of array ddd
 40:    LDC  3,10(6) 	load size of array sccc
 41:     ST  3,-26(0) 	save size of array sccc
 42:    LDC  3,10(6) 	load size of array sddd
 43:     ST  3,-37(0) 	save size of array sddd
* RETURN
 44:     LD  3,-6(1) 	Load variable aaa
 45:    LDA  2,0(3) 	Copy result to rt register 
 46:     LD  3,-1(1) 	Load return address 
 47:     LD  1,0(1) 	Adjust fp 
 48:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 49:    LDC  2,0(6) 	Set return value to 0 
 50:     LD  3,-1(1) 	Load return address 
 51:     LD  1,0(1) 	Adjust fp 
 52:    LDA  7,0(3) 	Return 
* END of function dogs
  0:    LDA  7,52(7) 	Jump to init 
* BEGIN Init
 53:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
 54:    LDC  3,10(6) 	load size of array ccc
 55:     ST  3,-2(0) 	save size of array ccc
 56:    LDC  3,10(6) 	load size of array ddd
 57:     ST  3,-13(0) 	save size of array ddd
* END init of global array sizes
 58:    LDA  1,-48(0) 	set first frame at end of globals 
 59:     ST  1,0(1) 	store old fp (point to self) 
 60:    LDA  3,1(7) 	Return address in ac 
 61:    LDA  7,-32(7) 	Jump to main 
 62:   HALT  0,0,0 	DONE! 
* END Init
