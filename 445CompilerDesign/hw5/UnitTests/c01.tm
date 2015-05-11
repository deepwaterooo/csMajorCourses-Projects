* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  c01.tm
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
 31:    LDC  3,73(6) 	Load constant 
 32:     ST  3,0(1) 	Store variable x
* EXPRESSION STMT
 33:    LDC  3,211(6) 	Load constant 
 34:     ST  3,-2(1) 	Store variable y
* EXPRESSION STMT
 35:     ST  1,-3(1) 	Store old frame in ghost frame 
 36:     LD  3,0(1) 	Load variable x
 37:     ST  3,-5(1) 	Save left side 
 38:     LD  3,-2(1) 	Load variable y
 39:     LD  4,-5(1) 	Load left into ac1 
 40:    ADD  3,4,3 	Op + 
 41:     ST  3,-5(1) 	Store parameter 
 42:    LDA  1,-3(1) 	Load address of new frame 
 43:    LDA  3,1(7) 	Return address in ac 
 44:    LDA  7,-39(7) 	CALL output
 45:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 46:     ST  1,-3(1) 	Store old frame in ghost frame 
 47:    LDA  1,-3(1) 	Load address of new frame 
 48:    LDA  3,1(7) 	Return address in ac 
 49:    LDA  7,-25(7) 	CALL outnl
 50:    LDA  3,0(2) 	Save the result in ac 
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
 59:    LDA  7,-30(7) 	Jump to main 
 60:   HALT  0,0,0 	DONE! 
* END Init
