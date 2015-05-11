* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  c0g.c-
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
* BEGIN compound statement
* EXPRESSION STMT
 31:    LDC  3,3(6) 	Load constant 
 32:     ST  3,-2(1) 	Save index 
 33:    LDC  3,1023(6) 	Load constant 
 34:     LD  4,-2(1) 	Restore index 
 35:    LDA  5,-1(0) 	Load address of base of array x
 36:    SUB  5,5,4 	Compute offset of value 
 37:     ST  3,0(5) 	Store variable x
* EXPRESSION STMT
 38:     ST  1,-2(1) 	Store old fp in ghost frame 
 39:    LDC  3,3(6) 	Load constant 
 40:    LDA  5,-1(0) 	Load address of base of array x
 41:    SUB  5,5,3 	Compute offset of value 
 42:     LD  3,0(5) 	load lhs variable x
 43:    LDA  3,1(3) 	increment value of x
 44:     ST  3,0(5) 	Store variable x
 45:     ST  3,-4(1) 	Store parameter 
 46:    LDA  1,-2(1) 	Load address of new frame 
 47:    LDA  3,1(7) 	Return address in ac 
 48:    LDA  7,-43(7) 	CALL output
 49:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 50:     ST  1,-2(1) 	Store old fp in ghost frame 
 51:    LDA  1,-2(1) 	Load address of new frame 
 52:    LDA  3,1(7) 	Return address in ac 
 53:    LDA  7,-29(7) 	CALL outnl
 54:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 55:     ST  1,-2(1) 	Store old fp in ghost frame 
 56:    LDC  3,3(6) 	Load constant 
 57:    LDA  4,-1(0) 	Load address of base of array x
 58:    SUB  3,4,3 	Compute offset of value 
 59:     LD  3,0(3) 	Load the value 
 60:     ST  3,-4(1) 	Store parameter 
 61:    LDA  1,-2(1) 	Load address of new frame 
 62:    LDA  3,1(7) 	Return address in ac 
 63:    LDA  7,-58(7) 	CALL output
 64:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 65:     ST  1,-2(1) 	Store old fp in ghost frame 
 66:    LDA  1,-2(1) 	Load address of new frame 
 67:    LDA  3,1(7) 	Return address in ac 
 68:    LDA  7,-44(7) 	CALL outnl
 69:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 70:    LDC  2,0(6) 	Set return value to 0 
 71:     LD  3,-1(1) 	Load return address 
 72:     LD  1,0(1) 	Adjust fp 
 73:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,73(7) 	Jump to init 
* BEGIN Init
 74:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
 75:    LDC  3,7(6) 	load size of array x
 76:     ST  3,0(0) 	save size of array x
* END init of global array sizes
 77:    LDA  1,-8(0) 	set first frame at end of globals 
 78:     ST  1,0(1) 	store old fp (point to self) 
 79:    LDA  3,1(7) 	Return address in ac 
 80:    LDA  7,-51(7) 	Jump to main 
 81:   HALT  0,0,0 	DONE! 
* END Init
