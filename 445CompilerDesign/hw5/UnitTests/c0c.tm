* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  c0c.tm
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
* EXPRESSION STMT
 31:    LDC  3,753(6) 	Load constant 
 32:     ST  3,0(1) 	Store variable x
* EXPRESSION STMT
 33:    LDC  3,444(6) 	Load constant 
 34:     ST  3,-2(1) 	Store variable y
* EXPRESSION STMT
 35:     ST  1,-4(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
* EXPRESSION STMT
 36:     LD  3,-2(1) 	Load variable y
 37:     ST  3,0(1) 	Store variable x
 38:     ST  3,-3(1) 	Store variable z
 39:     ST  3,-6(1) 	Store parameter 
 40:    LDA  1,-4(1) 	Load address of new frame 
 41:    LDA  3,1(7) 	Return address in ac 
 42:    LDA  7,-37(7) 	CALL output
 43:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 44:     ST  1,-4(1) 	Store old frame in ghost frame 
 45:    LDA  1,-4(1) 	Load address of new frame 
 46:    LDA  3,1(7) 	Return address in ac 
 47:    LDA  7,-23(7) 	CALL outnl
 48:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 49:    LDC  2,0(6) 	Set return value to 0 
 50:     LD  3,-1(1) 	Load return address 
 51:     LD  1,0(1) 	Adjust fp 
 52:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,52(7) 	Jump to init 
* BEGIN Init
 53:     LD  0,0(0) 	Set the global pointer 
 54:    LDA  1,0(0) 	set first frame at end of globals 
 55:     ST  1,0(1) 	store old fp (point to self) 
 56:    LDA  3,1(7) 	Return address in ac 
 57:    LDA  7,-28(7) 	Jump to main 
 58:   HALT  0,0,0 	DONE! 
* END Init
