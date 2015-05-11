* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  funcaa.c-
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
* BEGIN function cat
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 31:     LD  3,-2(1) 	Load address of base of array z
 32:     LD  3,1(3) 	Load array size 
* EXPRESSION STMT
 33:    LDC  3,7(6) 	Load constant 
 34:     LD  4,-2(1) 	Load address of base of array z
 35:    SUB  3,4,3 	Compute offset of value 
 36:     LD  3,0(3) 	Load the value 
* END compound statement
* Add standard closing in case there is no return statement
 37:    LDC  2,0(6) 	Set return value to 0 
 38:     LD  3,-1(1) 	Load return address 
 39:     LD  1,0(1) 	Adjust fp 
 40:    LDA  7,0(3) 	Return 
* END of function cat
* BEGIN function dog
 41:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
 42:    LDC  3,23(6) 	load size of array y
 43:     ST  3,-3(1) 	save size of array y
* EXPRESSION STMT
 44:     LD  3,-2(1) 	Load address of base of array x
 45:     LD  3,1(3) 	Load array size 
* EXPRESSION STMT
 46:    LDA  3,-4(1) 	Load address of base of array y
 47:     LD  3,1(3) 	Load array size 
* EXPRESSION STMT
 48:    LDC  3,7(6) 	Load constant 
 49:     ST  3,-27(1) 	Save index 
 50:    LDC  3,666(6) 	Load constant 
 51:     LD  4,-27(1) 	Restore index 
 52:    LDA  5,-4(1) 	Load address of base of array y
 53:    SUB  5,5,4 	Compute offset of value 
 54:     ST  3,0(5) 	Store variable y
* EXPRESSION STMT
 55:     ST  1,-27(1) 	Store old fp in ghost frame 
 56:     LD  3,-2(1) 	Load address of base of array x
 57:     ST  3,-29(1) 	Store parameter 
 58:    LDA  1,-27(1) 	Load address of new frame 
 59:    LDA  3,1(7) 	Return address in ac 
 60:    LDA  7,-31(7) 	CALL cat
 61:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 62:     ST  1,-27(1) 	Store old fp in ghost frame 
 63:    LDA  3,-4(1) 	Load address of base of array y
 64:     ST  3,-29(1) 	Store parameter 
 65:    LDA  1,-27(1) 	Load address of new frame 
 66:    LDA  3,1(7) 	Return address in ac 
 67:    LDA  7,-38(7) 	CALL cat
 68:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 69:    LDC  2,0(6) 	Set return value to 0 
 70:     LD  3,-1(1) 	Load return address 
 71:     LD  1,0(1) 	Adjust fp 
 72:    LDA  7,0(3) 	Return 
* END of function dog
* BEGIN function main
 73:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
 74:    LDC  3,17(6) 	load size of array a
 75:     ST  3,-2(1) 	save size of array a
* EXPRESSION STMT
 76:    LDC  3,7(6) 	Load constant 
 77:     ST  3,-20(1) 	Save index 
 78:    LDC  3,444(6) 	Load constant 
 79:     LD  4,-20(1) 	Restore index 
 80:    LDA  5,-3(1) 	Load address of base of array a
 81:    SUB  5,5,4 	Compute offset of value 
 82:     ST  3,0(5) 	Store variable a
* EXPRESSION STMT
 83:     ST  1,-20(1) 	Store old fp in ghost frame 
 84:    LDA  3,-3(1) 	Load address of base of array a
 85:     ST  3,-22(1) 	Store parameter 
 86:    LDA  1,-20(1) 	Load address of new frame 
 87:    LDA  3,1(7) 	Return address in ac 
 88:    LDA  7,-48(7) 	CALL dog
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
 98:    LDA  7,-26(7) 	Jump to main 
 99:   HALT  0,0,0 	DONE! 
* END Init
