* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  globalArray.c-
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
 33:    LDC  3,666(6) 	Load constant 
 34:     LD  4,-2(1) 	Restore index 
 35:    LDA  5,-1(0) 	Load address of base of array x
 36:    SUB  5,5,4 	Compute offset of value 
 37:     ST  3,0(5) 	Store variable x
* EXPRESSION STMT
 38:    LDC  3,3(6) 	Load constant 
 39:     ST  3,-2(1) 	Save index 
 40:    LDC  3,1(6) 	Load constant 
 41:     LD  4,-2(1) 	Restore index 
 42:    LDA  5,-5(0) 	Load address of base of array b
 43:    SUB  5,5,4 	Compute offset of value 
 44:     ST  3,0(5) 	Store variable b
* EXPRESSION STMT
 45:     ST  1,-2(1) 	Store old fp in ghost frame 
 46:    LDC  3,2(6) 	Load constant 
 47:    LDA  4,-1(0) 	Load address of base of array x
 48:    SUB  3,4,3 	Compute offset of value 
 49:     LD  3,0(3) 	Load the value 
 50:     ST  3,-4(1) 	Store parameter 
 51:    LDA  1,-2(1) 	Load address of new frame 
 52:    LDA  3,1(7) 	Return address in ac 
 53:    LDA  7,-48(7) 	CALL output
 54:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 55:     ST  1,-2(1) 	Store old fp in ghost frame 
 56:    LDC  3,3(6) 	Load constant 
 57:    LDA  4,-5(0) 	Load address of base of array b
 58:    SUB  3,4,3 	Compute offset of value 
 59:     LD  3,0(3) 	Load the value 
 60:     ST  3,-4(1) 	Store parameter 
 61:    LDA  1,-2(1) 	Load address of new frame 
 62:    LDA  3,1(7) 	Return address in ac 
 63:    LDA  7,-46(7) 	CALL outputb
 64:    LDA  3,0(2) 	Save the result in ac 
* RETURN
 65:    LDA  2,0(3) 	Copy result to rt register 
 66:     LD  3,-1(1) 	Load return address 
 67:     LD  1,0(1) 	Adjust fp 
 68:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 69:    LDC  2,0(6) 	Set return value to 0 
 70:     LD  3,-1(1) 	Load return address 
 71:     LD  1,0(1) 	Adjust fp 
 72:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,72(7) 	Jump to init 
* BEGIN Init
 73:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
 74:    LDC  3,3(6) 	load size of array x
 75:     ST  3,0(0) 	save size of array x
 76:    LDC  3,4(6) 	load size of array b
 77:     ST  3,-4(0) 	save size of array b
* END init of global array sizes
 78:    LDA  1,-9(0) 	set first frame at end of globals 
 79:     ST  1,0(1) 	store old fp (point to self) 
 80:    LDA  3,1(7) 	Return address in ac 
 81:    LDA  7,-52(7) 	Jump to main 
 82:   HALT  0,0,0 	DONE! 
* END Init
