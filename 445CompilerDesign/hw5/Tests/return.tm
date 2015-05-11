* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  return.tm
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
* BEGIN function null
 30:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* END compound statement
* Add standard closing in case there is no return statement
 31:    LDC  2,0(6) 	Set return value to 0 
 32:     LD  3,-1(1) 	Load return address 
 33:     LD  1,0(1) 	Adjust fp 
 34:    LDA  7,0(3) 	Return 
* END function null
* BEGIN function cat
 35:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* RETURN
* EXPRESSION STMT
 36:     ST  1,-2(1) 	Store old frame in ghost frame 
 37:    LDA  1,-2(1) 	Load address of new frame 
 38:    LDA  3,1(7) 	Return address in ac 
 39:    LDA  7,-10(7) 	CALL null
 40:    LDA  3,0(2) 	Save the result in ac 
 41:    LDA  2,0(3) 	Copy result to rt register 
 42:     LD  3,-1(1) 	Load return address 
 43:     LD  1,0(1) 	Adjust fp 
 44:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 45:    LDC  2,0(6) 	Set return value to 0 
 46:     LD  3,-1(1) 	Load return address 
 47:     LD  1,0(1) 	Adjust fp 
 48:    LDA  7,0(3) 	Return 
* END function cat
* BEGIN function main
 49:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
 50:    LDC  3,899(6) 	Load constant 
* END compound statement
* Add standard closing in case there is no return statement
 51:    LDC  2,0(6) 	Set return value to 0 
 52:     LD  3,-1(1) 	Load return address 
 53:     LD  1,0(1) 	Adjust fp 
 54:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,54(7) 	Jump to init 
* BEGIN Init
 55:     LD  0,0(0) 	Set the global pointer 
 56:    LDA  1,0(0) 	set first frame at end of globals 
 57:     ST  1,0(1) 	store old fp (point to self) 
 58:    LDA  3,1(7) 	Return address in ac 
 59:    LDA  7,-11(7) 	Jump to main 
 60:   HALT  0,0,0 	DONE! 
* END Init
