* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  funcaa.tm
* Nov 29, 2007
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
 30:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
 31:     LD  3,-2(1) 	Load variable z
 32:    MUL  3,4,3 	Op * 
 33:    LDC  3,7(6) 	Load constant 
 34:     ST  3,-3(1) 	Save index 
* END compound statement
* Add standard closing in case there is no return statement
 35:    LDC  2,0(6) 	Set return value to 0 
 36:     LD  3,-1(1) 	Load return address 
 37:     LD  1,0(1) 	Adjust fp 
 38:    LDA  7,0(3) 	Return 
* END function cat
* BEGIN function dog
 39:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
 40:    LDC  3,0(6) 	load size of array y
 41:     ST  3,1(1) 	save size of array y
 42:     LD  3,-2(1) 	Load variable x
 43:    MUL  3,4,3 	Op * 
 44:     LD  3,0(1) 	Load variable y
 45:    MUL  3,4,3 	Op * 
* EXPRESSION STMT
 46:    LDC  3,7(6) 	Load constant 
 47:     ST  3,-3(1) 	Save index 
 48:    LDC  3,666(6) 	Load constant 
 49:     ST  3,0(1) 	Store variable y
* EXPRESSION STMT
 50:     ST  1,-4(1) 	Store old frame in ghost frame 
 51:     LD  3,-2(1) 	Load variable x
 52:     ST  3,-6(1) 	Store parameter 
 53:    LDA  1,-4(1) 	Load address of new frame 
 54:    LDA  3,1(7) 	Return address in ac 
 55:    LDA  7,-26(7) 	CALL cat
 56:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 57:     ST  1,-4(1) 	Store old frame in ghost frame 
 58:     LD  3,0(1) 	Load variable y
 59:     ST  3,-6(1) 	Store parameter 
 60:    LDA  1,-4(1) 	Load address of new frame 
 61:    LDA  3,1(7) 	Return address in ac 
 62:    LDA  7,-33(7) 	CALL cat
 63:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 64:    LDC  2,0(6) 	Set return value to 0 
 65:     LD  3,-1(1) 	Load return address 
 66:     LD  1,0(1) 	Adjust fp 
 67:    LDA  7,0(3) 	Return 
* END function dog
* BEGIN function main
 68:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
 69:    LDC  3,0(6) 	load size of array a
 70:     ST  3,0(1) 	save size of array a
* EXPRESSION STMT
 71:    LDC  3,7(6) 	Load constant 
 72:     ST  3,-2(1) 	Save index 
 73:    LDC  3,444(6) 	Load constant 
 74:     ST  3,-1(1) 	Store variable a
* EXPRESSION STMT
 75:     ST  1,-3(1) 	Store old frame in ghost frame 
 76:     LD  3,-1(1) 	Load variable a
 77:     ST  3,-5(1) 	Store parameter 
 78:    LDA  1,-3(1) 	Load address of new frame 
 79:    LDA  3,1(7) 	Return address in ac 
 80:    LDA  7,-42(7) 	CALL dog
 81:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 82:    LDC  2,0(6) 	Set return value to 0 
 83:     LD  3,-1(1) 	Load return address 
 84:     LD  1,0(1) 	Adjust fp 
 85:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,85(7) 	Jump to init 
* BEGIN Init
 86:     LD  0,0(0) 	Set the global pointer 
 87:    LDA  1,0(0) 	set first frame at end of globals 
 88:     ST  1,0(1) 	store old fp (point to self) 
 89:    LDA  3,1(7) 	Return address in ac 
 90:    LDA  7,-23(7) 	Jump to main 
 91:   HALT  0,0,0 	DONE! 
* END Init
