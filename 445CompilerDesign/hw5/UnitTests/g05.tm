* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  g05.tm
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
 31:     LD  3,-2(1) 	Load variable z
 32:     ST  3,-4(1) 	Save left side 
 33:     LD  3,-3(1) 	Load variable x
 34:     LD  4,-4(1) 	Load left into ac1 
 35:    MUL  3,4,3 	Op * 
 36:     ST  3,-4(1) 	Save left side 
 37:     LD  3,-3(1) 	Load variable x
 38:     LD  4,-4(1) 	Load left into ac1 
 39:    SUB  3,4,3 	Op - 
 40:    LDA  2,0(3) 	Copy result to rt register 
 41:     LD  3,-1(1) 	Load return address 
 42:     LD  1,0(1) 	Adjust fp 
 43:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 44:    LDC  2,0(6) 	Set return value to 0 
 45:     LD  3,-1(1) 	Load return address 
 46:     LD  1,0(1) 	Adjust fp 
 47:    LDA  7,0(3) 	Return 
* END function cat
* BEGIN function main
 48:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
 49:    LDC  3,0(6) 	load size of array z
 50:     ST  3,1(1) 	save size of array z
* EXPRESSION STMT
 51:    LDC  3,3(6) 	Load constant 
 52:     ST  3,-2(1) 	Save index 
 53:    LDC  3,445(6) 	Load constant 
 54:     ST  3,0(1) 	Store variable z
* EXPRESSION STMT
 55:     ST  1,-3(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
 56:     ST  1,-5(1) 	Store old frame in ghost frame 
 57:    LDC  3,3(6) 	Load constant 
 58:     ST  3,-7(1) 	Save index 
 59:     ST  3,-8(1) 	Store parameter 
 60:    LDC  3,911(6) 	Load constant 
 61:     ST  3,-9(1) 	Store parameter 
 62:    LDA  1,-5(1) 	Load address of new frame 
 63:    LDA  3,1(7) 	Return address in ac 
 64:    LDA  7,-35(7) 	CALL cat
 65:    LDA  3,0(2) 	Save the result in ac 
 66:     ST  3,-5(1) 	Store parameter 
 67:    LDA  1,-3(1) 	Load address of new frame 
 68:    LDA  3,1(7) 	Return address in ac 
 69:    LDA  7,-64(7) 	CALL output
 70:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 71:    LDC  2,0(6) 	Set return value to 0 
 72:     LD  3,-1(1) 	Load return address 
 73:     LD  1,0(1) 	Adjust fp 
 74:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,74(7) 	Jump to init 
* BEGIN Init
 75:     LD  0,0(0) 	Set the global pointer 
 76:    LDA  1,0(0) 	set first frame at end of globals 
 77:     ST  1,0(1) 	store old fp (point to self) 
 78:    LDA  3,1(7) 	Return address in ac 
 79:    LDA  7,-32(7) 	Jump to main 
 80:   HALT  0,0,0 	DONE! 
* END Init
