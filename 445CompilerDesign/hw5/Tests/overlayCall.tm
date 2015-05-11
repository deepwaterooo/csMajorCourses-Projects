* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  overlayCall.tm
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
* BEGIN function dog
 30:     ST  3,-1(1) 	Store return address 
* Add standard closing in case there is no return statement
 31:    LDC  2,0(6) 	Set return value to 0 
 32:     LD  3,-1(1) 	Load return address 
 33:     LD  1,0(1) 	Adjust fp 
 34:    LDA  7,0(3) 	Return 
* END function dog
* BEGIN function main
 35:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* BEGIN compound statement
 36:    LDC  3,0(6) 	load size of array x
 37:     ST  3,1(1) 	save size of array x
* EXPRESSION STMT
 38:     ST  1,-2(1) 	Store old frame in ghost frame 
 39:    LDA  1,-2(1) 	Load address of new frame 
 40:    LDA  3,1(7) 	Return address in ac 
 41:    LDA  7,-12(7) 	CALL dog
 42:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* EXPRESSION STMT
 43:     ST  1,-2(1) 	Store old frame in ghost frame 
 44:    LDA  1,-2(1) 	Load address of new frame 
 45:    LDA  3,1(7) 	Return address in ac 
 46:    LDA  7,-17(7) 	CALL dog
 47:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 48:    LDC  2,0(6) 	Set return value to 0 
 49:     LD  3,-1(1) 	Load return address 
 50:     LD  1,0(1) 	Adjust fp 
 51:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,51(7) 	Jump to init 
* BEGIN Init
 52:     LD  0,0(0) 	Set the global pointer 
 53:    LDA  1,0(0) 	set first frame at end of globals 
 54:     ST  1,0(1) 	store old fp (point to self) 
 55:    LDA  3,1(7) 	Return address in ac 
 56:    LDA  7,-22(7) 	Jump to main 
 57:   HALT  0,0,0 	DONE! 
* END Init
