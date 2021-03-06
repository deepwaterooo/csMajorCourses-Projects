* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  localArray.tm
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
* BEGIN function main
 30:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
 31:    LDC  3,0(6) 	load size of array x
 32:     ST  3,1(1) 	save size of array x
 33:    LDC  3,0(6) 	load size of array b
 34:     ST  3,-2(1) 	save size of array b
* EXPRESSION STMT
 35:    LDC  3,2(6) 	Load constant 
 36:     ST  3,-3(1) 	Save index 
 37:    LDC  3,666(6) 	Load constant 
 38:     ST  3,0(1) 	Store variable x
* EXPRESSION STMT
 39:    LDC  3,3(6) 	Load constant 
 40:     ST  3,-4(1) 	Save index 
 41:    LDC  3,1(6) 	Load constant 
 42:     ST  3,-3(1) 	Store variable b
* EXPRESSION STMT
 43:     ST  1,-5(1) 	Store old frame in ghost frame 
 44:    LDC  3,2(6) 	Load constant 
 45:     ST  3,-7(1) 	Save index 
 46:     ST  3,-8(1) 	Store parameter 
 47:    LDA  1,-5(1) 	Load address of new frame 
 48:    LDA  3,1(7) 	Return address in ac 
 49:    LDA  7,-44(7) 	CALL output
 50:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 51:     ST  1,-5(1) 	Store old frame in ghost frame 
 52:    LDC  3,3(6) 	Load constant 
 53:     ST  3,-7(1) 	Save index 
 54:     ST  3,-8(1) 	Store parameter 
 55:    LDA  1,-5(1) 	Load address of new frame 
 56:    LDA  3,1(7) 	Return address in ac 
 57:    LDA  7,-40(7) 	CALL outputb
 58:    LDA  3,0(2) 	Save the result in ac 
* RETURN
 59:    LDA  2,0(3) 	Copy result to rt register 
 60:     LD  3,-1(1) 	Load return address 
 61:     LD  1,0(1) 	Adjust fp 
 62:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 63:    LDC  2,0(6) 	Set return value to 0 
 64:     LD  3,-1(1) 	Load return address 
 65:     LD  1,0(1) 	Adjust fp 
 66:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,66(7) 	Jump to init 
* BEGIN Init
 67:     LD  0,0(0) 	Set the global pointer 
 68:    LDA  1,0(0) 	set first frame at end of globals 
 69:     ST  1,0(1) 	store old fp (point to self) 
 70:    LDA  3,1(7) 	Return address in ac 
 71:    LDA  7,-42(7) 	Jump to main 
 72:   HALT  0,0,0 	DONE! 
* END Init
