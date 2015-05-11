* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  g02.tm
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
* EXPRESSION STMT
 31:     ST  1,-3(1) 	Store old frame in ghost frame 
 32:     LD  3,-2(1) 	Load variable z
 33:     ST  3,-5(1) 	Store parameter 
 34:    LDA  1,-3(1) 	Load address of new frame 
 35:    LDA  3,1(7) 	Return address in ac 
 36:    LDA  7,-31(7) 	CALL output
 37:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 38:    LDC  3,122(6) 	Load constant 
 39:     ST  3,-2(1) 	Store variable z
* EXPRESSION STMT
 40:     ST  1,-3(1) 	Store old frame in ghost frame 
 41:     LD  3,-2(1) 	Load variable z
 42:     ST  3,-5(1) 	Store parameter 
 43:    LDA  1,-3(1) 	Load address of new frame 
 44:    LDA  3,1(7) 	Return address in ac 
 45:    LDA  7,-40(7) 	CALL output
 46:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 47:    LDC  2,0(6) 	Set return value to 0 
 48:     LD  3,-1(1) 	Load return address 
 49:     LD  1,0(1) 	Adjust fp 
 50:    LDA  7,0(3) 	Return 
* END function cat
* BEGIN function main
 51:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* EXPRESSION STMT
 52:    LDC  3,637(6) 	Load constant 
 53:     ST  3,-2(1) 	Store variable z
* EXPRESSION STMT
 54:     ST  1,-2(1) 	Store old frame in ghost frame 
 55:     LD  3,-2(1) 	Load variable z
 56:     ST  3,-4(1) 	Store parameter 
 57:    LDA  1,-2(1) 	Load address of new frame 
 58:    LDA  3,1(7) 	Return address in ac 
 59:    LDA  7,-30(7) 	CALL cat
 60:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 61:     ST  1,-2(1) 	Store old frame in ghost frame 
 62:     LD  3,-2(1) 	Load variable z
 63:     ST  3,-4(1) 	Store parameter 
 64:    LDA  1,-2(1) 	Load address of new frame 
 65:    LDA  3,1(7) 	Return address in ac 
 66:    LDA  7,-61(7) 	CALL output
 67:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 68:    LDC  2,0(6) 	Set return value to 0 
 69:     LD  3,-1(1) 	Load return address 
 70:     LD  1,0(1) 	Adjust fp 
 71:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,71(7) 	Jump to init 
* BEGIN Init
 72:     LD  0,0(0) 	Set the global pointer 
 73:    LDA  1,-1(0) 	set first frame at end of globals 
 74:     ST  1,0(1) 	store old fp (point to self) 
 75:    LDA  3,1(7) 	Return address in ac 
 76:    LDA  7,-26(7) 	Jump to main 
 77:   HALT  0,0,0 	DONE! 
* END Init
