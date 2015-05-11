* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  examplearray2.tm
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
* BEGIN function dog
 30:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* EXPRESSION STMT
 31:    LDC  3,10(6) 	Load constant 
 32:     ST  3,-3(1) 	Save index 
 33:    LDC  3,333(6) 	Load constant 
 34:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
 35:    LDC  3,11(6) 	Load constant 
 36:     ST  3,-4(1) 	Save index 
 37:    LDC  3,444(6) 	Load constant 
 38:     ST  3,-1(1) 	Store variable w
* END compound statement
* Add standard closing in case there is no return statement
 39:    LDC  2,0(6) 	Set return value to 0 
 40:     LD  3,-1(1) 	Load return address 
 41:     LD  1,0(1) 	Adjust fp 
 42:    LDA  7,0(3) 	Return 
* END function dog
* BEGIN function main
 43:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
 44:    LDC  3,0(6) 	load size of array y
 45:     ST  3,0(1) 	save size of array y
* EXPRESSION STMT
 46:     ST  1,-2(1) 	Store old frame in ghost frame 
 47:     LD  3,-1(1) 	Load variable y
 48:     ST  3,-4(1) 	Store parameter 
 49:    LDA  1,-2(1) 	Load address of new frame 
 50:    LDA  3,1(7) 	Return address in ac 
 51:    LDA  7,-22(7) 	CALL dog
 52:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 53:    LDC  2,0(6) 	Set return value to 0 
 54:     LD  3,-1(1) 	Load return address 
 55:     LD  1,0(1) 	Adjust fp 
 56:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,56(7) 	Jump to init 
* BEGIN Init
 57:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
 58:    LDC  3,0(6) 	load size of array w
 59:     ST  3,-1(0) 	save size of array w
* END init of global array sizes
 60:    LDA  1,-1(0) 	set first frame at end of globals 
 61:     ST  1,0(1) 	store old fp (point to self) 
 62:    LDA  3,1(7) 	Return address in ac 
 63:    LDA  7,-21(7) 	Jump to main 
 64:   HALT  0,0,0 	DONE! 
* END Init
