* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  arraysizeold.c-
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
 31:    LDC  3,13(6) 	load size of array y
 32:     ST  3,-4(1) 	save size of array y
* EXPRESSION STMT
 33:    LDC  3,0(6) 	Load constant 
 34:     ST  3,-18(1) 	Save index 
 35:    LDC  3,666(6) 	Load constant 
 36:     LD  4,-18(1) 	Restore index 
 37:    LDA  5,-5(1) 	Load address of base of array y
 38:    SUB  5,5,4 	Compute offset of value 
 39:     ST  3,0(5) 	Store variable y
* EXPRESSION STMT
 40:    LDC  3,0(6) 	Load constant 
 41:     ST  3,-18(1) 	Save index 
 42:    LDC  3,888(6) 	Load constant 
 43:     LD  4,-18(1) 	Restore index 
 44:    LDA  5,-1(0) 	Load address of base of array g
 45:    SUB  5,5,4 	Compute offset of value 
 46:     ST  3,0(5) 	Store variable g
* END compound statement
* Add standard closing in case there is no return statement
 47:    LDC  2,0(6) 	Set return value to 0 
 48:     LD  3,-1(1) 	Load return address 
 49:     LD  1,0(1) 	Adjust fp 
 50:    LDA  7,0(3) 	Return 
* END of function ford
* BEGIN function main
 51:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
 52:    LDC  3,11(6) 	load size of array m
 53:     ST  3,-2(1) 	save size of array m
* EXPRESSION STMT
 54:    LDC  3,0(6) 	Load constant 
 55:     ST  3,-14(1) 	Save index 
 56:    LDC  3,777(6) 	Load constant 
 57:     LD  4,-14(1) 	Restore index 
 58:    LDA  5,-3(1) 	Load address of base of array m
 59:    SUB  5,5,4 	Compute offset of value 
 60:     ST  3,0(5) 	Store variable m
* EXPRESSION STMT
 61:     ST  1,-14(1) 	Store old fp in ghost frame 
 62:    LDA  3,-3(1) 	Load address of base of array m
 63:     ST  3,-16(1) 	Store parameter 
 64:    LDA  1,-14(1) 	Load address of new frame 
 65:    LDA  3,1(7) 	Return address in ac 
 66:    LDA  7,-37(7) 	CALL ford
 67:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 68:     ST  1,-14(1) 	Store old fp in ghost frame 
 69:    LDA  3,-1(0) 	Load address of base of array g
 70:     ST  3,-16(1) 	Store parameter 
 71:    LDA  1,-14(1) 	Load address of new frame 
 72:    LDA  3,1(7) 	Return address in ac 
 73:    LDA  7,-44(7) 	CALL ford
 74:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 75:    LDC  2,0(6) 	Set return value to 0 
 76:     LD  3,-1(1) 	Load return address 
 77:     LD  1,0(1) 	Adjust fp 
 78:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,78(7) 	Jump to init 
* BEGIN Init
 79:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
 80:    LDC  3,12(6) 	load size of array g
 81:     ST  3,0(0) 	save size of array g
* END init of global array sizes
 82:    LDA  1,-13(0) 	set first frame at end of globals 
 83:     ST  1,0(1) 	store old fp (point to self) 
 84:    LDA  3,1(7) 	Return address in ac 
 85:    LDA  7,-35(7) 	Jump to main 
 86:   HALT  0,0,0 	DONE! 
* END Init
