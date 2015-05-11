* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  tiny4.tm
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
* BEGIN function wolf
 30:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
 31:    LDC  3,0(6) 	load size of array w
 32:     ST  3,1(1) 	save size of array w
* RETURN
 33:    LDC  3,1(6) 	Load constant 
 34:     ST  3,-3(1) 	Save index 
 35:    LDA  2,0(3) 	Copy result to rt register 
 36:     LD  3,-1(1) 	Load return address 
 37:     LD  1,0(1) 	Adjust fp 
 38:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 39:    LDC  2,0(6) 	Set return value to 0 
 40:     LD  3,-1(1) 	Load return address 
 41:     LD  1,0(1) 	Adjust fp 
 42:    LDA  7,0(3) 	Return 
* END function wolf
* BEGIN function main
 43:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
 44:    LDC  3,0(6) 	load size of array y
 45:     ST  3,0(1) 	save size of array y
* EXPRESSION STMT
 46:    LDC  3,1(6) 	Load constant 
 47:     ST  3,-2(1) 	Save index 
 48:    LDC  3,666(6) 	Load constant 
 49:     ST  3,-1(1) 	Store variable y
* EXPRESSION STMT
 50:     ST  1,-3(1) 	Store old frame in ghost frame 
 51:     LD  3,-1(1) 	Load variable y
 52:     ST  3,-5(1) 	Store parameter 
 53:    LDA  1,-3(1) 	Load address of new frame 
 54:    LDA  3,1(7) 	Return address in ac 
 55:    LDA  7,-26(7) 	CALL wolf
 56:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 57:    LDC  2,0(6) 	Set return value to 0 
 58:     LD  3,-1(1) 	Load return address 
 59:     LD  1,0(1) 	Adjust fp 
 60:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,60(7) 	Jump to init 
* BEGIN Init
 61:     LD  0,0(0) 	Set the global pointer 
 62:    LDA  1,0(0) 	set first frame at end of globals 
 63:     ST  1,0(1) 	store old fp (point to self) 
 64:    LDA  3,1(7) 	Return address in ac 
 65:    LDA  7,-23(7) 	Jump to main 
 66:   HALT  0,0,0 	DONE! 
* END Init
