* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  tiny5.c-
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
* BEGIN function wolf
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
 31:    LDC  3,2(6) 	load size of array w
 32:     ST  3,-3(1) 	save size of array w
* RETURN
 33:    LDC  3,77(6) 	Load constant 
 34:     ST  3,-6(1) 	Save left side 
 35:    LDC  3,1(6) 	Load constant 
 36:     LD  4,-2(1) 	Load address of base of array garion
 37:    SUB  3,4,3 	Compute offset of value 
 38:     LD  3,0(3) 	Load the value 
 39:     LD  4,-6(1) 	Load left into ac1 
 40:    ADD  3,4,3 	Op + 
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
* END of function wolf
* BEGIN function main
 49:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
 50:    LDC  3,3(6) 	load size of array y
 51:     ST  3,-2(1) 	save size of array y
* EXPRESSION STMT
 52:    LDC  3,1(6) 	Load constant 
 53:     ST  3,-6(1) 	Save index 
 54:    LDC  3,666(6) 	Load constant 
 55:     LD  4,-6(1) 	Restore index 
 56:    LDA  5,-3(1) 	Load address of base of array y
 57:    SUB  5,5,4 	Compute offset of value 
 58:     ST  3,0(5) 	Store variable y
* EXPRESSION STMT
 59:     ST  1,-6(1) 	Store old fp in ghost frame 
 60:    LDA  3,-3(1) 	Load address of base of array y
 61:     ST  3,-8(1) 	Store parameter 
 62:    LDA  1,-6(1) 	Load address of new frame 
 63:    LDA  3,1(7) 	Return address in ac 
 64:    LDA  7,-35(7) 	CALL wolf
 65:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 66:    LDC  2,0(6) 	Set return value to 0 
 67:     LD  3,-1(1) 	Load return address 
 68:     LD  1,0(1) 	Adjust fp 
 69:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,69(7) 	Jump to init 
* BEGIN Init
 70:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
 71:    LDC  3,3(6) 	load size of array g
 72:     ST  3,0(0) 	save size of array g
* END init of global array sizes
 73:    LDA  1,-4(0) 	set first frame at end of globals 
 74:     ST  1,0(1) 	store old fp (point to self) 
 75:    LDA  3,1(7) 	Return address in ac 
 76:    LDA  7,-28(7) 	Jump to main 
 77:   HALT  0,0,0 	DONE! 
* END Init
