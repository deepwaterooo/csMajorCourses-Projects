* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  f0a.tm
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
* RETURN
 31:    LDC  3,93(6) 	Load constant 
 32:    LDA  2,0(3) 	Copy result to rt register 
 33:     LD  3,-1(1) 	Load return address 
 34:     LD  1,0(1) 	Adjust fp 
 35:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 36:    LDC  2,0(6) 	Set return value to 0 
 37:     LD  3,-1(1) 	Load return address 
 38:     LD  1,0(1) 	Adjust fp 
 39:    LDA  7,0(3) 	Return 
* END function cat
* BEGIN function main
 40:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* EXPRESSION STMT
 41:     ST  1,-2(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
 42:     ST  1,-4(1) 	Store old frame in ghost frame 
 43:    LDA  1,-4(1) 	Load address of new frame 
 44:    LDA  3,1(7) 	Return address in ac 
 45:    LDA  7,-16(7) 	CALL cat
 46:    LDA  3,0(2) 	Save the result in ac 
 47:     ST  3,-4(1) 	Save left side 
* EXPRESSION STMT
 48:     ST  1,-5(1) 	Store old frame in ghost frame 
 49:    LDA  1,-5(1) 	Load address of new frame 
 50:    LDA  3,1(7) 	Return address in ac 
 51:    LDA  7,-22(7) 	CALL cat
 52:    LDA  3,0(2) 	Save the result in ac 
 53:     LD  4,-4(1) 	Load left into ac1 
 54:    ADD  3,4,3 	Op + 
 55:     ST  3,-4(1) 	Save left side 
* EXPRESSION STMT
 56:     ST  1,-5(1) 	Store old frame in ghost frame 
 57:    LDA  1,-5(1) 	Load address of new frame 
 58:    LDA  3,1(7) 	Return address in ac 
 59:    LDA  7,-30(7) 	CALL cat
 60:    LDA  3,0(2) 	Save the result in ac 
 61:     LD  4,-4(1) 	Load left into ac1 
 62:    MUL  3,4,3 	Op * 
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
 73:    LDA  1,0(0) 	set first frame at end of globals 
 74:     ST  1,0(1) 	store old fp (point to self) 
 75:    LDA  3,1(7) 	Return address in ac 
 76:    LDA  7,-37(7) 	Jump to main 
 77:   HALT  0,0,0 	DONE! 
* END Init
