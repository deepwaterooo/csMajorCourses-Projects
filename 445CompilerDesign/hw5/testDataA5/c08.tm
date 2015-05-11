* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  c08.c-
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
 31:    LDC  3,2(6) 	Load constant 
 32:     ST  3,-2(1) 	Save index 
 33:    LDC  3,1(6) 	Load constant 
 34:     LD  4,-2(1) 	Restore index 
 35:    LDA  5,-1(0) 	Load address of base of array x
 36:    SUB  5,5,4 	Compute offset of value 
 37:     ST  3,0(5) 	Store variable x
* EXPRESSION STMT
 38:    LDC  3,1(6) 	Load constant 
 39:     ST  3,-2(1) 	Save index 
 40:    LDC  3,0(6) 	Load constant 
 41:     LD  4,-2(1) 	Restore index 
 42:    LDA  5,-5(0) 	Load address of base of array y
 43:    SUB  5,5,4 	Compute offset of value 
 44:     ST  3,0(5) 	Store variable y
* EXPRESSION STMT
 45:     ST  1,-2(1) 	Store old fp in ghost frame 
 46:    LDC  3,2(6) 	Load constant 
 47:    LDA  4,-1(0) 	Load address of base of array x
 48:    SUB  3,4,3 	Compute offset of value 
 49:     LD  3,0(3) 	Load the value 
 50:     ST  3,-4(1) 	Save left side 
 51:    LDC  3,1(6) 	Load constant 
 52:    LDA  4,-5(0) 	Load address of base of array y
 53:    SUB  3,4,3 	Compute offset of value 
 54:     LD  3,0(3) 	Load the value 
 55:     LD  4,-4(1) 	Load left into ac1 
 56:    JGT  3,1(7) 	Op OR 
 57:    LDA  3,0(4) 	 
 58:     ST  3,-4(1) 	Store parameter 
 59:    LDA  1,-2(1) 	Load address of new frame 
 60:    LDA  3,1(7) 	Return address in ac 
 61:    LDA  7,-44(7) 	CALL outputb
 62:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 63:     ST  1,-2(1) 	Store old fp in ghost frame 
 64:    LDA  1,-2(1) 	Load address of new frame 
 65:    LDA  3,1(7) 	Return address in ac 
 66:    LDA  7,-42(7) 	CALL outnl
 67:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 68:    LDC  2,0(6) 	Set return value to 0 
 69:     LD  3,-1(1) 	Load return address 
 70:     LD  1,0(1) 	Adjust fp 
 71:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,71(7) 	Jump to init 
* BEGIN Init
 72:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
 73:    LDC  3,3(6) 	load size of array x
 74:     ST  3,0(0) 	save size of array x
 75:    LDC  3,4(6) 	load size of array y
 76:     ST  3,-4(0) 	save size of array y
* END init of global array sizes
 77:    LDA  1,-9(0) 	set first frame at end of globals 
 78:     ST  1,0(1) 	store old fp (point to self) 
 79:    LDA  3,1(7) 	Return address in ac 
 80:    LDA  7,-51(7) 	Jump to main 
 81:   HALT  0,0,0 	DONE! 
* END Init
