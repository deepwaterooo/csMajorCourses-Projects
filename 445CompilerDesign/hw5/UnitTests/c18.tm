* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  c18.tm
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
* BEGIN function main
 30:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
 31:    LDC  3,0(6) 	load size of array x
 32:     ST  3,1(1) 	save size of array x
 33:    LDC  3,0(6) 	load size of array y
 34:     ST  3,-2(1) 	save size of array y
* EXPRESSION STMT
 35:    LDC  3,5(6) 	Load constant 
 36:     ST  3,-3(1) 	Save index 
 37:    LDC  3,333(6) 	Load constant 
 38:     ST  3,0(1) 	Store variable x
* EXPRESSION STMT
 39:    LDC  3,7(6) 	Load constant 
 40:     ST  3,-4(1) 	Save index 
 41:    LDC  3,444(6) 	Load constant 
 42:     ST  3,-3(1) 	Store variable y
* EXPRESSION STMT
 43:    LDC  3,5(6) 	Load constant 
 44:     ST  3,-5(1) 	Save index 
 45:    LDC  3,7(6) 	Load constant 
 46:    LDA  4,-3(1) 	Load address of base of array y
 47:    SUB  3,4,3 	Compute offset of value 
 48:     LD  3,0(3) 	Load the value 
 49:     LD  4,-5(1) 	Restore index 
 50:    LDA  5,0(0) 	Load address of base of array x
 51:    SUB  5,5,4 	Compute offset of value 
 52:     ST  3,0(5) 	Store variable x
* EXPRESSION STMT
 53:     ST  1,-5(1) 	Store old frame in ghost frame 
 54:    LDC  3,5(6) 	Load constant 
 55:     ST  3,-7(1) 	Save index 
 56:     ST  3,-8(1) 	Store parameter 
 57:    LDA  1,-5(1) 	Load address of new frame 
 58:    LDA  3,1(7) 	Return address in ac 
 59:    LDA  7,-54(7) 	CALL output
 60:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 61:    LDC  3,7(6) 	Load constant 
 62:     ST  3,-5(1) 	Save index 
 63:    LDC  3,5(6) 	Load constant 
 64:    LDA  4,0(0) 	Load address of base of array x
 65:    SUB  3,4,3 	Compute offset of value 
 66:     LD  3,0(3) 	Load the value 
 67:     LD  4,-5(1) 	Restore index 
 68:    LDA  5,-3(1) 	Load address of base of array y
 69:    SUB  5,5,4 	Compute offset of value 
 70:     ST  3,0(5) 	Store variable y
* EXPRESSION STMT
 71:     ST  1,-5(1) 	Store old frame in ghost frame 
 72:    LDC  3,7(6) 	Load constant 
 73:     ST  3,-7(1) 	Save index 
 74:     ST  3,-8(1) 	Store parameter 
 75:    LDA  1,-5(1) 	Load address of new frame 
 76:    LDA  3,1(7) 	Return address in ac 
 77:    LDA  7,-72(7) 	CALL output
 78:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 79:     ST  1,-5(1) 	Store old frame in ghost frame 
 80:    LDA  1,-5(1) 	Load address of new frame 
 81:    LDA  3,1(7) 	Return address in ac 
 82:    LDA  7,-58(7) 	CALL outnl
 83:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 84:    LDC  2,0(6) 	Set return value to 0 
 85:     LD  3,-1(1) 	Load return address 
 86:     LD  1,0(1) 	Adjust fp 
 87:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,87(7) 	Jump to init 
* BEGIN Init
 88:     LD  0,0(0) 	Set the global pointer 
 89:    LDA  1,0(0) 	set first frame at end of globals 
 90:     ST  1,0(1) 	store old fp (point to self) 
 91:    LDA  3,1(7) 	Return address in ac 
 92:    LDA  7,-63(7) 	Jump to main 
 93:   HALT  0,0,0 	DONE! 
* END Init
