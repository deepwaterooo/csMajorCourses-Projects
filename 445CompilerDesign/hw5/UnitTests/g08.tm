* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  g08.tm
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
 31:    LDC  3,77(6) 	Load constant 
 32:     ST  3,-4(1) 	Save left side 
 33:     LD  3,-3(1) 	Load variable x
 34:     ST  3,-5(1) 	Save index 
 35:     ST  3,-6(1) 	Save left side 
 36:     LD  3,-3(1) 	Load variable x
 37:     ST  3,-7(1) 	Save index 
 38:     LD  4,-7(1) 	Load left into ac1 
 39:    MUL  3,4,3 	Op * 
 40:     LD  4,-6(1) 	Load left into ac1 
 41:    ADD  3,4,3 	Op + 
 42:    LDA  2,0(3) 	Copy result to rt register 
 43:     LD  3,-1(1) 	Load return address 
 44:     LD  1,0(1) 	Adjust fp 
 45:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 46:    LDC  2,0(6) 	Set return value to 0 
 47:     LD  3,-1(1) 	Load return address 
 48:     LD  1,0(1) 	Adjust fp 
 49:    LDA  7,0(3) 	Return 
* END function cat
* BEGIN function main
 50:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
 51:    LDC  3,0(6) 	load size of array z
 52:     ST  3,1(1) 	save size of array z
* EXPRESSION STMT
 53:    LDC  3,3(6) 	Load constant 
 54:     ST  3,-2(1) 	Save index 
 55:    LDC  3,445(6) 	Load constant 
 56:     ST  3,0(1) 	Store variable z
* EXPRESSION STMT
 57:     ST  1,-3(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
 58:     ST  1,-5(1) 	Store old frame in ghost frame 
 59:     LD  3,0(1) 	Load variable z
 60:     ST  3,-7(1) 	Store parameter 
 61:    LDC  3,3(6) 	Load constant 
 62:     ST  3,-8(1) 	Store parameter 
 63:    LDA  1,-5(1) 	Load address of new frame 
 64:    LDA  3,1(7) 	Return address in ac 
 65:    LDA  7,-36(7) 	CALL cat
 66:    LDA  3,0(2) 	Save the result in ac 
 67:     ST  3,-5(1) 	Store parameter 
 68:    LDA  1,-3(1) 	Load address of new frame 
 69:    LDA  3,1(7) 	Return address in ac 
 70:    LDA  7,-65(7) 	CALL output
 71:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 72:    LDC  2,0(6) 	Set return value to 0 
 73:     LD  3,-1(1) 	Load return address 
 74:     LD  1,0(1) 	Adjust fp 
 75:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,75(7) 	Jump to init 
* BEGIN Init
 76:     LD  0,0(0) 	Set the global pointer 
 77:    LDA  1,0(0) 	set first frame at end of globals 
 78:     ST  1,0(1) 	store old fp (point to self) 
 79:    LDA  3,1(7) 	Return address in ac 
 80:    LDA  7,-31(7) 	Jump to main 
 81:   HALT  0,0,0 	DONE! 
* END Init
