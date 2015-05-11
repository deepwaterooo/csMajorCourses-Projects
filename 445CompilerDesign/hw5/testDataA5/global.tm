* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  global.c-
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
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 31:    LDC  3,666(6) 	Load constant 
 32:     ST  3,0(0) 	Store variable x
* EXPRESSION STMT
 33:    LDC  3,1(6) 	Load constant 
 34:     ST  3,-1(0) 	Store variable b
* EXPRESSION STMT
 35:     ST  1,-2(1) 	Store old fp in ghost frame 
 36:     LD  3,0(0) 	Load variable x
 37:     ST  3,-4(1) 	Store parameter 
 38:    LDA  1,-2(1) 	Load address of new frame 
 39:    LDA  3,1(7) 	Return address in ac 
 40:    LDA  7,-35(7) 	CALL output
 41:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 42:     ST  1,-2(1) 	Store old fp in ghost frame 
 43:     LD  3,-1(0) 	Load variable b
 44:     ST  3,-4(1) 	Store parameter 
 45:    LDA  1,-2(1) 	Load address of new frame 
 46:    LDA  3,1(7) 	Return address in ac 
 47:    LDA  7,-30(7) 	CALL outputb
 48:    LDA  3,0(2) 	Save the result in ac 
* RETURN
 49:    LDA  2,0(3) 	Copy result to rt register 
 50:     LD  3,-1(1) 	Load return address 
 51:     LD  1,0(1) 	Adjust fp 
 52:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 53:    LDC  2,0(6) 	Set return value to 0 
 54:     LD  3,-1(1) 	Load return address 
 55:     LD  1,0(1) 	Adjust fp 
 56:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,56(7) 	Jump to init 
* BEGIN Init
 57:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
 58:    LDA  1,-2(0) 	set first frame at end of globals 
 59:     ST  1,0(1) 	store old fp (point to self) 
 60:    LDA  3,1(7) 	Return address in ac 
 61:    LDA  7,-32(7) 	Jump to main 
 62:   HALT  0,0,0 	DONE! 
* END Init
