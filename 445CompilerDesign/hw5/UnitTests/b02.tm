* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  b02.tm
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
 31:     ST  1,-2(1) 	Store old frame in ghost frame 
 32:    LDC  3,50(6) 	Load constant 
 33:     ST  3,-4(1) 	Save left side 
 34:    LDC  3,13(6) 	Load constant 
 35:     LD  4,-4(1) 	Load left into ac1 
 36:    ADD  3,4,3 	Op + 
 37:     ST  3,-4(1) 	Store parameter 
 38:    LDA  1,-2(1) 	Load address of new frame 
 39:    LDA  3,1(7) 	Return address in ac 
 40:    LDA  7,-35(7) 	CALL output
 41:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 42:     ST  1,-2(1) 	Store old frame in ghost frame 
 43:    LDA  1,-2(1) 	Load address of new frame 
 44:    LDA  3,1(7) 	Return address in ac 
 45:    LDA  7,-21(7) 	CALL outnl
 46:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 47:    LDC  2,0(6) 	Set return value to 0 
 48:     LD  3,-1(1) 	Load return address 
 49:     LD  1,0(1) 	Adjust fp 
 50:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,50(7) 	Jump to init 
* BEGIN Init
 51:     LD  0,0(0) 	Set the global pointer 
 52:    LDA  1,0(0) 	set first frame at end of globals 
 53:     ST  1,0(1) 	store old fp (point to self) 
 54:    LDA  3,1(7) 	Return address in ac 
 55:    LDA  7,-26(7) 	Jump to main 
 56:   HALT  0,0,0 	DONE! 
* END Init
