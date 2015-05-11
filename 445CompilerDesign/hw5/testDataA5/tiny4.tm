* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  tiny4.c-
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
* BEGIN function wolf
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
 31:    LDC  3,2(6) 	load size of array w
 32:     ST  3,-3(1) 	save size of array w
* RETURN
 33:    LDC  3,1(6) 	Load constant 
 34:     LD  4,-2(1) 	Load address of base of array garion
 35:    SUB  3,4,3 	Compute offset of value 
 36:     LD  3,0(3) 	Load the value 
 37:    LDA  2,0(3) 	Copy result to rt register 
 38:     LD  3,-1(1) 	Load return address 
 39:     LD  1,0(1) 	Adjust fp 
 40:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 41:    LDC  2,0(6) 	Set return value to 0 
 42:     LD  3,-1(1) 	Load return address 
 43:     LD  1,0(1) 	Adjust fp 
 44:    LDA  7,0(3) 	Return 
* END of function wolf
* BEGIN function main
 45:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
 46:    LDC  3,3(6) 	load size of array y
 47:     ST  3,-2(1) 	save size of array y
* EXPRESSION STMT
 48:    LDC  3,1(6) 	Load constant 
 49:     ST  3,-6(1) 	Save index 
 50:    LDC  3,666(6) 	Load constant 
 51:     LD  4,-6(1) 	Restore index 
 52:    LDA  5,-3(1) 	Load address of base of array y
 53:    SUB  5,5,4 	Compute offset of value 
 54:     ST  3,0(5) 	Store variable y
* EXPRESSION STMT
 55:     ST  1,-6(1) 	Store old fp in ghost frame 
 56:    LDA  3,-3(1) 	Load address of base of array y
 57:     ST  3,-8(1) 	Store parameter 
 58:    LDA  1,-6(1) 	Load address of new frame 
 59:    LDA  3,1(7) 	Return address in ac 
 60:    LDA  7,-31(7) 	CALL wolf
 61:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 62:    LDC  2,0(6) 	Set return value to 0 
 63:     LD  3,-1(1) 	Load return address 
 64:     LD  1,0(1) 	Adjust fp 
 65:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,65(7) 	Jump to init 
* BEGIN Init
 66:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
 67:    LDA  1,0(0) 	set first frame at end of globals 
 68:     ST  1,0(1) 	store old fp (point to self) 
 69:    LDA  3,1(7) 	Return address in ac 
 70:    LDA  7,-26(7) 	Jump to main 
 71:   HALT  0,0,0 	DONE! 
* END Init