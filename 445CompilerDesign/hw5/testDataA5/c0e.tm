* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  c0e.c-
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
 31:    LDC  3,1023(6) 	Load constant 
 32:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
 33:     ST  1,-3(1) 	Store old fp in ghost frame 
 34:     LD  3,-2(1) 	load lhs variable x
 35:    LDA  3,1(3) 	increment value of x
 36:     ST  3,-2(1) 	Store variable x
 37:     ST  3,-5(1) 	Store parameter 
 38:    LDA  1,-3(1) 	Load address of new frame 
 39:    LDA  3,1(7) 	Return address in ac 
 40:    LDA  7,-35(7) 	CALL output
 41:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 42:     ST  1,-3(1) 	Store old fp in ghost frame 
 43:    LDA  1,-3(1) 	Load address of new frame 
 44:    LDA  3,1(7) 	Return address in ac 
 45:    LDA  7,-21(7) 	CALL outnl
 46:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 47:     ST  1,-3(1) 	Store old fp in ghost frame 
 48:     LD  3,-2(1) 	Load variable x
 49:     ST  3,-5(1) 	Store parameter 
 50:    LDA  1,-3(1) 	Load address of new frame 
 51:    LDA  3,1(7) 	Return address in ac 
 52:    LDA  7,-47(7) 	CALL output
 53:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 54:     ST  1,-3(1) 	Store old fp in ghost frame 
 55:    LDA  1,-3(1) 	Load address of new frame 
 56:    LDA  3,1(7) 	Return address in ac 
 57:    LDA  7,-33(7) 	CALL outnl
 58:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 59:    LDC  2,0(6) 	Set return value to 0 
 60:     LD  3,-1(1) 	Load return address 
 61:     LD  1,0(1) 	Adjust fp 
 62:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,62(7) 	Jump to init 
* BEGIN Init
 63:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
 64:    LDA  1,0(0) 	set first frame at end of globals 
 65:     ST  1,0(1) 	store old fp (point to self) 
 66:    LDA  3,1(7) 	Return address in ac 
 67:    LDA  7,-38(7) 	Jump to main 
 68:   HALT  0,0,0 	DONE! 
* END Init
