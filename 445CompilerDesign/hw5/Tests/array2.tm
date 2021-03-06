* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  array2.tm
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
* EXPRESSION STMT
 31:    LDC  3,3(6) 	Load constant 
 32:     ST  3,-3(1) 	Save index 
 33:     ST  3,0(1) 	Store variable y
* EXPRESSION STMT
 34:     ST  1,-4(1) 	Store old frame in ghost frame 
 35:     LD  3,0(1) 	Load variable y
 36:     ST  3,-6(1) 	Store parameter 
 37:    LDA  1,-4(1) 	Load address of new frame 
 38:    LDA  3,1(7) 	Return address in ac 
 39:    LDA  7,-34(7) 	CALL output
 40:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 41:    LDC  3,3(6) 	Load constant 
 42:     ST  3,-4(1) 	Save index 
 43:    LDC  3,777(6) 	Load constant 
 44:     ST  3,-2(1) 	Store variable x
* END compound statement
* Add standard closing in case there is no return statement
 45:    LDC  2,0(6) 	Set return value to 0 
 46:     LD  3,-1(1) 	Load return address 
 47:     LD  1,0(1) 	Adjust fp 
 48:    LDA  7,0(3) 	Return 
* END function ford
* BEGIN function main
 49:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
 50:    LDC  3,0(6) 	load size of array y
 51:     ST  3,-1(1) 	save size of array y
* EXPRESSION STMT
 52:    LDC  3,3(6) 	Load constant 
 53:     ST  3,-2(1) 	Save index 
 54:    LDC  3,666(6) 	Load constant 
 55:     ST  3,-2(1) 	Store variable y
* EXPRESSION STMT
 56:     ST  1,-3(1) 	Store old frame in ghost frame 
 57:     LD  3,-2(1) 	Load variable y
 58:     ST  3,-5(1) 	Store parameter 
 59:    LDA  1,-3(1) 	Load address of new frame 
 60:    LDA  3,1(7) 	Return address in ac 
 61:    LDA  7,-32(7) 	CALL ford
 62:    LDA  3,0(2) 	Save the result in ac 
 63:    LDC  3,3(6) 	Load constant 
 64:     ST  3,-3(1) 	Save index 
* EXPRESSION STMT
 65:     ST  1,-4(1) 	Store old frame in ghost frame 
 66:    LDC  3,3(6) 	Load constant 
 67:     ST  3,-6(1) 	Save index 
 68:     ST  3,-7(1) 	Store parameter 
 69:    LDA  1,-4(1) 	Load address of new frame 
 70:    LDA  3,1(7) 	Return address in ac 
 71:    LDA  7,-66(7) 	CALL output
 72:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 73:    LDC  2,0(6) 	Set return value to 0 
 74:     LD  3,-1(1) 	Load return address 
 75:     LD  1,0(1) 	Adjust fp 
 76:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,76(7) 	Jump to init 
* BEGIN Init
 77:     LD  0,0(0) 	Set the global pointer 
 78:    LDA  1,0(0) 	set first frame at end of globals 
 79:     ST  1,0(1) 	store old fp (point to self) 
 80:    LDA  3,1(7) 	Return address in ac 
 81:    LDA  7,-33(7) 	Jump to main 
 82:   HALT  0,0,0 	DONE! 
* END Init
