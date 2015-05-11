* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  mem.c-
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
* BEGIN function polgara
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 31:     LD  3,-2(1) 	Load variable a
 32:     ST  3,-4(1) 	Store variable x
* RETURN
 33:     LD  3,-4(1) 	Load variable x
 34:    LDA  2,0(3) 	Copy result to rt register 
 35:     LD  3,-1(1) 	Load return address 
 36:     LD  1,0(1) 	Adjust fp 
 37:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 38:    LDC  2,0(6) 	Set return value to 0 
 39:     LD  3,-1(1) 	Load return address 
 40:     LD  1,0(1) 	Adjust fp 
 41:    LDA  7,0(3) 	Return 
* END of function polgara
* BEGIN function main
 42:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
 43:    LDC  3,3(6) 	load size of array ai
 44:     ST  3,-4(1) 	save size of array ai
 45:    LDC  3,2(6) 	load size of array ab
 46:     ST  3,-8(1) 	save size of array ab
* EXPRESSION STMT
 47:     ST  1,-12(1) 	Store old fp in ghost frame 
 48:     LD  3,-2(1) 	Load variable i
 49:     ST  3,-14(1) 	Save left side 
 50:    LDC  3,43(6) 	Load constant 
 51:     LD  4,-14(1) 	Load left into ac1 
 52:    ADD  3,4,3 	Op + 
 53:     ST  3,-14(1) 	Store parameter 
 54:     LD  3,-3(1) 	Load variable b
 55:     ST  3,-15(1) 	Store parameter 
 56:    LDA  1,-12(1) 	Load address of new frame 
 57:    LDA  3,1(7) 	Return address in ac 
 58:    LDA  7,-29(7) 	CALL polgara
 59:    LDA  3,0(2) 	Save the result in ac 
 60:     ST  3,-11(1) 	Store variable z
* EXPRESSION STMT
 61:    LDC  3,666(6) 	Load constant 
 62:     ST  3,0(0) 	Store variable u
* EXPRESSION STMT
 63:    LDC  3,3(6) 	Load constant 
 64:     ST  3,-12(1) 	Save index 
 65:    LDC  3,1(6) 	Load constant 
 66:     LD  4,-12(1) 	Restore index 
 67:    LDA  5,-2(0) 	Load address of base of array v
 68:    SUB  5,5,4 	Compute offset of value 
 69:     ST  3,0(5) 	Store variable v
* END compound statement
* Add standard closing in case there is no return statement
 70:    LDC  2,0(6) 	Set return value to 0 
 71:     LD  3,-1(1) 	Load return address 
 72:     LD  1,0(1) 	Adjust fp 
 73:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,73(7) 	Jump to init 
* BEGIN Init
 74:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
 75:    LDC  3,4(6) 	load size of array v
 76:     ST  3,-1(0) 	save size of array v
* END init of global array sizes
 77:    LDA  1,-6(0) 	set first frame at end of globals 
 78:     ST  1,0(1) 	store old fp (point to self) 
 79:    LDA  3,1(7) 	Return address in ac 
 80:    LDA  7,-39(7) 	Jump to main 
 81:   HALT  0,0,0 	DONE! 
* END Init
