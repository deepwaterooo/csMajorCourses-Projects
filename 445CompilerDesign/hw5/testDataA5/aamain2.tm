* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  aamain2.c-
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
 31:     ST  1,-2(1) 	Store old fp in ghost frame 
 32:    LDC  3,666(6) 	Load constant 
 33:     ST  3,-4(1) 	Store parameter 
 34:    LDA  1,-2(1) 	Load address of new frame 
 35:    LDA  3,1(7) 	Return address in ac 
 36:    LDA  7,-31(7) 	CALL output
 37:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 38:     ST  1,-2(1) 	Store old fp in ghost frame 
 39:    LDC  3,1(6) 	Load constant 
 40:     ST  3,-4(1) 	Store parameter 
 41:    LDA  1,-2(1) 	Load address of new frame 
 42:    LDA  3,1(7) 	Return address in ac 
 43:    LDA  7,-26(7) 	CALL outputb
 44:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 45:     ST  1,-2(1) 	Store old fp in ghost frame 
 46:    LDA  1,-2(1) 	Load address of new frame 
 47:    LDA  3,1(7) 	Return address in ac 
 48:    LDA  7,-24(7) 	CALL outnl
 49:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 50:     ST  1,-2(1) 	Store old fp in ghost frame 
 51:    LDA  1,-2(1) 	Load address of new frame 
 52:    LDA  3,1(7) 	Return address in ac 
 53:    LDA  7,-53(7) 	CALL input
 54:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 55:     ST  1,-2(1) 	Store old fp in ghost frame 
 56:    LDA  1,-2(1) 	Load address of new frame 
 57:    LDA  3,1(7) 	Return address in ac 
 58:    LDA  7,-46(7) 	CALL inputb
 59:    LDA  3,0(2) 	Save the result in ac 
* RETURN
 60:    LDA  2,0(3) 	Copy result to rt register 
 61:     LD  3,-1(1) 	Load return address 
 62:     LD  1,0(1) 	Adjust fp 
 63:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 64:    LDC  2,0(6) 	Set return value to 0 
 65:     LD  3,-1(1) 	Load return address 
 66:     LD  1,0(1) 	Adjust fp 
 67:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,67(7) 	Jump to init 
* BEGIN Init
 68:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
 69:    LDA  1,0(0) 	set first frame at end of globals 
 70:     ST  1,0(1) 	store old fp (point to self) 
 71:    LDA  3,1(7) 	Return address in ac 
 72:    LDA  7,-43(7) 	Jump to main 
 73:   HALT  0,0,0 	DONE! 
* END Init
