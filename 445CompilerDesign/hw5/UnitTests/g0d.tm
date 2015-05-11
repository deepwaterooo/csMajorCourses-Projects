* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  g0d.tm
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
* RETURN
 31:     LD  3,-2(1) 	Load variable x
 32:     ST  3,-3(1) 	Save left side 
 33:     LD  3,-2(1) 	Load variable x
 34:     LD  4,-3(1) 	Load left into ac1 
 35:    ADD  3,4,3 	Op + 
 36:    LDA  2,0(3) 	Copy result to rt register 
 37:     LD  3,-1(1) 	Load return address 
 38:     LD  1,0(1) 	Adjust fp 
 39:    LDA  7,0(3) 	Return 
* Add standard closing in case there is no return statement
 40:    LDC  2,0(6) 	Set return value to 0 
 41:     LD  3,-1(1) 	Load return address 
 42:     LD  1,0(1) 	Adjust fp 
 43:    LDA  7,0(3) 	Return 
* END function cat
* BEGIN function main
 44:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
* EXPRESSION STMT
 45:     ST  1,-2(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
 46:     ST  1,-4(1) 	Store old frame in ghost frame 
 47:    LDC  3,88(6) 	Load constant 
 48:     ST  3,-6(1) 	Store parameter 
 49:    LDA  1,-4(1) 	Load address of new frame 
 50:    LDA  3,1(7) 	Return address in ac 
 51:    LDA  7,-22(7) 	CALL cat
 52:    LDA  3,0(2) 	Save the result in ac 
 53:     ST  3,-4(1) 	Store parameter 
 54:    LDA  1,-2(1) 	Load address of new frame 
 55:    LDA  3,1(7) 	Return address in ac 
 56:    LDA  7,-51(7) 	CALL output
 57:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 58:    LDC  2,0(6) 	Set return value to 0 
 59:     LD  3,-1(1) 	Load return address 
 60:     LD  1,0(1) 	Adjust fp 
 61:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,61(7) 	Jump to init 
* BEGIN Init
 62:     LD  0,0(0) 	Set the global pointer 
 63:    LDA  1,0(0) 	set first frame at end of globals 
 64:     ST  1,0(1) 	store old fp (point to self) 
 65:    LDA  3,1(7) 	Return address in ac 
 66:    LDA  7,-23(7) 	Jump to main 
 67:   HALT  0,0,0 	DONE! 
* END Init