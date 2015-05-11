* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  array2.c-
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
* BEGIN function ford
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 31:    LDC  3,3(6) 	Load constant 
 32:     LD  4,-2(1) 	Load address of base of array x
 33:    SUB  3,4,3 	Compute offset of value 
 34:     LD  3,0(3) 	Load the value 
 35:     ST  3,-3(1) 	Store variable y
* EXPRESSION STMT
 36:     ST  1,-4(1) 	Store old fp in ghost frame 
 37:     LD  3,-3(1) 	Load variable y
 38:     ST  3,-6(1) 	Store parameter 
 39:    LDA  1,-4(1) 	Load address of new frame 
 40:    LDA  3,1(7) 	Return address in ac 
 41:    LDA  7,-36(7) 	CALL output
 42:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 43:    LDC  3,3(6) 	Load constant 
 44:     ST  3,-4(1) 	Save index 
 45:    LDC  3,777(6) 	Load constant 
 46:     LD  4,-4(1) 	Restore index 
 47:     LD  5,-2(1) 	Load address of base of array x
 48:    SUB  5,5,4 	Compute offset of value 
 49:     ST  3,0(5) 	Store variable x
* END compound statement
* Add standard closing in case there is no return statement
 50:    LDC  2,0(6) 	Set return value to 0 
 51:     LD  3,-1(1) 	Load return address 
 52:     LD  1,0(1) 	Adjust fp 
 53:    LDA  7,0(3) 	Return 
* END of function ford
* BEGIN function main
 54:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
 55:    LDC  3,5(6) 	load size of array y
 56:     ST  3,-2(1) 	save size of array y
* EXPRESSION STMT
 57:    LDC  3,3(6) 	Load constant 
 58:     ST  3,-8(1) 	Save index 
 59:    LDC  3,666(6) 	Load constant 
 60:     LD  4,-8(1) 	Restore index 
 61:    LDA  5,-3(1) 	Load address of base of array y
 62:    SUB  5,5,4 	Compute offset of value 
 63:     ST  3,0(5) 	Store variable y
* EXPRESSION STMT
 64:     ST  1,-8(1) 	Store old fp in ghost frame 
 65:    LDA  3,-3(1) 	Load address of base of array y
 66:     ST  3,-10(1) 	Store parameter 
 67:    LDA  1,-8(1) 	Load address of new frame 
 68:    LDA  3,1(7) 	Return address in ac 
 69:    LDA  7,-40(7) 	CALL ford
 70:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 71:    LDC  3,3(6) 	Load constant 
 72:    LDA  4,-3(1) 	Load address of base of array y
 73:    SUB  3,4,3 	Compute offset of value 
 74:     LD  3,0(3) 	Load the value 
* EXPRESSION STMT
 75:     ST  1,-8(1) 	Store old fp in ghost frame 
 76:    LDC  3,3(6) 	Load constant 
 77:    LDA  4,-3(1) 	Load address of base of array y
 78:    SUB  3,4,3 	Compute offset of value 
 79:     LD  3,0(3) 	Load the value 
 80:     ST  3,-10(1) 	Store parameter 
 81:    LDA  1,-8(1) 	Load address of new frame 
 82:    LDA  3,1(7) 	Return address in ac 
 83:    LDA  7,-78(7) 	CALL output
 84:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 85:    LDC  2,0(6) 	Set return value to 0 
 86:     LD  3,-1(1) 	Load return address 
 87:     LD  1,0(1) 	Adjust fp 
 88:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,88(7) 	Jump to init 
* BEGIN Init
 89:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
 90:    LDA  1,0(0) 	set first frame at end of globals 
 91:     ST  1,0(1) 	store old fp (point to self) 
 92:    LDA  3,1(7) 	Return address in ac 
 93:    LDA  7,-40(7) 	Jump to main 
 94:   HALT  0,0,0 	DONE! 
* END Init
