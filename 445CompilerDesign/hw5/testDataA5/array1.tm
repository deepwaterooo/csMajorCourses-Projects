* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  array1.c-
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
 31:    LDC  3,22(6) 	load size of array z
 32:     ST  3,-4(1) 	save size of array z
* EXPRESSION STMT
 33:     LD  3,-2(1) 	Load address of base of array x
 34:     LD  3,1(3) 	Load array size 
* EXPRESSION STMT
 35:    LDC  3,11(6) 	Load constant 
 36:     ST  3,-27(1) 	Save index 
 37:    LDC  3,3(6) 	Load constant 
 38:     LD  4,-2(1) 	Load address of base of array x
 39:    SUB  3,4,3 	Compute offset of value 
 40:     LD  3,0(3) 	Load the value 
 41:     LD  4,-27(1) 	Restore index 
 42:    LDA  5,-5(1) 	Load address of base of array z
 43:    SUB  5,5,4 	Compute offset of value 
 44:     ST  3,0(5) 	Store variable z
* EXPRESSION STMT
 45:    LDC  3,3(6) 	Load constant 
 46:     ST  3,-27(1) 	Save index 
 47:    LDC  3,777(6) 	Load constant 
 48:     LD  4,-27(1) 	Restore index 
 49:     LD  5,-2(1) 	Load address of base of array x
 50:    SUB  5,5,4 	Compute offset of value 
 51:     ST  3,0(5) 	Store variable x
* END compound statement
* Add standard closing in case there is no return statement
 52:    LDC  2,0(6) 	Set return value to 0 
 53:     LD  3,-1(1) 	Load return address 
 54:     LD  1,0(1) 	Adjust fp 
 55:    LDA  7,0(3) 	Return 
* END of function ford
* BEGIN function main
 56:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
 57:    LDC  3,33(6) 	load size of array y
 58:     ST  3,-2(1) 	save size of array y
* EXPRESSION STMT
 59:    LDC  3,3(6) 	Load constant 
 60:     ST  3,-36(1) 	Save index 
 61:    LDC  3,666(6) 	Load constant 
 62:     LD  4,-36(1) 	Restore index 
 63:    LDA  5,-3(1) 	Load address of base of array y
 64:    SUB  5,5,4 	Compute offset of value 
 65:     ST  3,0(5) 	Store variable y
* EXPRESSION STMT
 66:     ST  1,-36(1) 	Store old fp in ghost frame 
 67:    LDA  3,-3(1) 	Load address of base of array y
 68:     ST  3,-38(1) 	Store parameter 
 69:    LDA  3,-3(1) 	Load address of base of array y
 70:     ST  3,-39(1) 	Store parameter 
 71:    LDA  1,-36(1) 	Load address of new frame 
 72:    LDA  3,1(7) 	Return address in ac 
 73:    LDA  7,-44(7) 	CALL ford
 74:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 75:     ST  1,-36(1) 	Store old fp in ghost frame 
 76:    LDC  3,3(6) 	Load constant 
 77:    LDA  4,-3(1) 	Load address of base of array y
 78:    SUB  3,4,3 	Compute offset of value 
 79:     LD  3,0(3) 	Load the value 
 80:     ST  3,-38(1) 	Store parameter 
 81:    LDA  1,-36(1) 	Load address of new frame 
 82:    LDA  3,1(7) 	Return address in ac 
 83:    LDA  7,-78(7) 	CALL output
 84:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 85:     ST  1,-36(1) 	Store old fp in ghost frame 
 86:    LDA  1,-36(1) 	Load address of new frame 
 87:    LDA  3,1(7) 	Return address in ac 
 88:    LDA  7,-64(7) 	CALL outnl
 89:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 90:    LDC  2,0(6) 	Set return value to 0 
 91:     LD  3,-1(1) 	Load return address 
 92:     LD  1,0(1) 	Adjust fp 
 93:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,93(7) 	Jump to init 
* BEGIN Init
 94:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
 95:    LDA  1,0(0) 	set first frame at end of globals 
 96:     ST  1,0(1) 	store old fp (point to self) 
 97:    LDA  3,1(7) 	Return address in ac 
 98:    LDA  7,-43(7) 	Jump to main 
 99:   HALT  0,0,0 	DONE! 
* END Init
