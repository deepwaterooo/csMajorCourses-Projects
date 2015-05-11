* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  array1.tm
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
* BEGIN function ford
 30:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
 31:    LDC  3,0(6) 	load size of array z
 32:     ST  3,1(1) 	save size of array z
 33:     LD  3,-2(1) 	Load variable x
 34:    MUL  3,4,3 	Op * 
* EXPRESSION STMT
 35:    LDC  3,11(6) 	Load constant 
 36:     ST  3,-4(1) 	Save index 
 37:    LDC  3,3(6) 	Load constant 
 38:    LDA  4,-2(1) 	Load address of base of array x
 39:    SUB  3,4,3 	Compute offset of value 
 40:     LD  3,0(3) 	Load the value 
 41:     LD  4,-4(1) 	Restore index 
 42:    LDA  5,0(0) 	Load address of base of array z
 43:    SUB  5,5,4 	Compute offset of value 
 44:     ST  3,0(5) 	Store variable z
* EXPRESSION STMT
 45:    LDC  3,3(6) 	Load constant 
 46:     ST  3,-4(1) 	Save index 
 47:    LDC  3,777(6) 	Load constant 
 48:     ST  3,-2(1) 	Store variable x
* END compound statement
* Add standard closing in case there is no return statement
 49:    LDC  2,0(6) 	Set return value to 0 
 50:     LD  3,-1(1) 	Load return address 
 51:     LD  1,0(1) 	Adjust fp 
 52:    LDA  7,0(3) 	Return 
* END function ford
* BEGIN function main
 53:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
 54:    LDC  3,0(6) 	load size of array y
 55:     ST  3,0(1) 	save size of array y
* EXPRESSION STMT
 56:    LDC  3,3(6) 	Load constant 
 57:     ST  3,-2(1) 	Save index 
 58:    LDC  3,666(6) 	Load constant 
 59:     ST  3,-1(1) 	Store variable y
* EXPRESSION STMT
 60:     ST  1,-3(1) 	Store old frame in ghost frame 
 61:     LD  3,-1(1) 	Load variable y
 62:     ST  3,-5(1) 	Store parameter 
 63:     LD  3,-1(1) 	Load variable y
 64:     ST  3,-6(1) 	Store parameter 
 65:    LDA  1,-3(1) 	Load address of new frame 
 66:    LDA  3,1(7) 	Return address in ac 
 67:    LDA  7,-38(7) 	CALL ford
 68:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 69:     ST  1,-3(1) 	Store old frame in ghost frame 
 70:    LDC  3,3(6) 	Load constant 
 71:     ST  3,-5(1) 	Save index 
 72:     ST  3,-6(1) 	Store parameter 
 73:    LDA  1,-3(1) 	Load address of new frame 
 74:    LDA  3,1(7) 	Return address in ac 
 75:    LDA  7,-70(7) 	CALL output
 76:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 77:     ST  1,-3(1) 	Store old frame in ghost frame 
 78:    LDA  1,-3(1) 	Load address of new frame 
 79:    LDA  3,1(7) 	Return address in ac 
 80:    LDA  7,-56(7) 	CALL outnl
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
 90:    LDA  7,-38(7) 	Jump to main 
 91:   HALT  0,0,0 	DONE! 
* END Init
