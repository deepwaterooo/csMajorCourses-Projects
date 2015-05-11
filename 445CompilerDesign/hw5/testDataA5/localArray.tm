* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  localArray.c-
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
 31:    LDC  3,3(6) 	load size of array x
 32:     ST  3,-2(1) 	save size of array x
 33:    LDC  3,4(6) 	load size of array b
 34:     ST  3,-6(1) 	save size of array b
* EXPRESSION STMT
 35:    LDC  3,2(6) 	Load constant 
 36:     ST  3,-11(1) 	Save index 
 37:    LDC  3,666(6) 	Load constant 
 38:     LD  4,-11(1) 	Restore index 
 39:    LDA  5,-3(1) 	Load address of base of array x
 40:    SUB  5,5,4 	Compute offset of value 
 41:     ST  3,0(5) 	Store variable x
* EXPRESSION STMT
 42:    LDC  3,3(6) 	Load constant 
 43:     ST  3,-11(1) 	Save index 
 44:    LDC  3,1(6) 	Load constant 
 45:     LD  4,-11(1) 	Restore index 
 46:    LDA  5,-7(1) 	Load address of base of array b
 47:    SUB  5,5,4 	Compute offset of value 
 48:     ST  3,0(5) 	Store variable b
* EXPRESSION STMT
 49:     ST  1,-11(1) 	Store old fp in ghost frame 
 50:    LDC  3,2(6) 	Load constant 
 51:    LDA  4,-3(1) 	Load address of base of array x
 52:    SUB  3,4,3 	Compute offset of value 
 53:     LD  3,0(3) 	Load the value 
 54:     ST  3,-13(1) 	Store parameter 
 55:    LDA  1,-11(1) 	Load address of new frame 
 56:    LDA  3,1(7) 	Return address in ac 
 57:    LDA  7,-52(7) 	CALL output
 58:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 59:     ST  1,-11(1) 	Store old fp in ghost frame 
 60:    LDC  3,3(6) 	Load constant 
 61:    LDA  4,-7(1) 	Load address of base of array b
 62:    SUB  3,4,3 	Compute offset of value 
 63:     LD  3,0(3) 	Load the value 
 64:     ST  3,-13(1) 	Store parameter 
 65:    LDA  1,-11(1) 	Load address of new frame 
 66:    LDA  3,1(7) 	Return address in ac 
 67:    LDA  7,-50(7) 	CALL outputb
 68:    LDA  3,0(2) 	Save the result in ac 
* RETURN
 69:    LDA  2,0(3) 	Copy result to rt register 
 70:     LD  3,-1(1) 	Load return address 
 71:     LD  1,0(1) 	Adjust fp 
 72:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 73:    LDC  2,0(6) 	Set return value to 0 
 74:     LD  3,-1(1) 	Load return address 
 75:     LD  1,0(1) 	Adjust fp 
 76:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,76(7) 	Jump to init 
* BEGIN Init
 77:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
 78:    LDA  1,0(0) 	set first frame at end of globals 
 79:     ST  1,0(1) 	store old fp (point to self) 
 80:    LDA  3,1(7) 	Return address in ac 
 81:    LDA  7,-52(7) 	Jump to main 
 82:   HALT  0,0,0 	DONE! 
* END Init
