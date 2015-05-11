* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  c0f.c-
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
 31:    LDC  3,7(6) 	load size of array x
 32:     ST  3,-2(1) 	save size of array x
* EXPRESSION STMT
 33:    LDC  3,3(6) 	Load constant 
 34:     ST  3,-10(1) 	Save index 
 35:    LDC  3,1023(6) 	Load constant 
 36:     LD  4,-10(1) 	Restore index 
 37:    LDA  5,-3(1) 	Load address of base of array x
 38:    SUB  5,5,4 	Compute offset of value 
 39:     ST  3,0(5) 	Store variable x
* EXPRESSION STMT
 40:     ST  1,-10(1) 	Store old fp in ghost frame 
 41:    LDC  3,3(6) 	Load constant 
 42:    LDA  5,-3(1) 	Load address of base of array x
 43:    SUB  5,5,3 	Compute offset of value 
 44:     LD  3,0(5) 	load lhs variable x
 45:    LDA  3,1(3) 	increment value of x
 46:     ST  3,0(5) 	Store variable x
 47:     ST  3,-12(1) 	Store parameter 
 48:    LDA  1,-10(1) 	Load address of new frame 
 49:    LDA  3,1(7) 	Return address in ac 
 50:    LDA  7,-45(7) 	CALL output
 51:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 52:     ST  1,-10(1) 	Store old fp in ghost frame 
 53:    LDA  1,-10(1) 	Load address of new frame 
 54:    LDA  3,1(7) 	Return address in ac 
 55:    LDA  7,-31(7) 	CALL outnl
 56:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 57:     ST  1,-10(1) 	Store old fp in ghost frame 
 58:    LDC  3,3(6) 	Load constant 
 59:    LDA  4,-3(1) 	Load address of base of array x
 60:    SUB  3,4,3 	Compute offset of value 
 61:     LD  3,0(3) 	Load the value 
 62:     ST  3,-12(1) 	Store parameter 
 63:    LDA  1,-10(1) 	Load address of new frame 
 64:    LDA  3,1(7) 	Return address in ac 
 65:    LDA  7,-60(7) 	CALL output
 66:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 67:     ST  1,-10(1) 	Store old fp in ghost frame 
 68:    LDA  1,-10(1) 	Load address of new frame 
 69:    LDA  3,1(7) 	Return address in ac 
 70:    LDA  7,-46(7) 	CALL outnl
 71:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 72:    LDC  2,0(6) 	Set return value to 0 
 73:     LD  3,-1(1) 	Load return address 
 74:     LD  1,0(1) 	Adjust fp 
 75:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,75(7) 	Jump to init 
* BEGIN Init
 76:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
 77:    LDA  1,0(0) 	set first frame at end of globals 
 78:     ST  1,0(1) 	store old fp (point to self) 
 79:    LDA  3,1(7) 	Return address in ac 
 80:    LDA  7,-51(7) 	Jump to main 
 81:   HALT  0,0,0 	DONE! 
* END Init
