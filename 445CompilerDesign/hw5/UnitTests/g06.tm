* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  g06.tm
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
 31:    LDC  3,3(6) 	Load constant 
 32:     ST  3,-3(1) 	Save index 
 33:    LDA  2,0(3) 	Copy result to rt register 
 34:     LD  3,-1(1) 	Load return address 
 35:     LD  1,0(1) 	Adjust fp 
 36:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 37:    LDC  2,0(6) 	Set return value to 0 
 38:     LD  3,-1(1) 	Load return address 
 39:     LD  1,0(1) 	Adjust fp 
 40:    LDA  7,0(3) 	Return 
* END function cat
* BEGIN function main
 41:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
 42:    LDC  3,0(6) 	load size of array z
 43:     ST  3,1(1) 	save size of array z
* EXPRESSION STMT
 44:    LDC  3,3(6) 	Load constant 
 45:     ST  3,-2(1) 	Save index 
 46:    LDC  3,445(6) 	Load constant 
 47:     ST  3,0(1) 	Store variable z
* EXPRESSION STMT
 48:     ST  1,-3(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
 49:     ST  1,-5(1) 	Store old frame in ghost frame 
 50:     LD  3,0(1) 	Load variable z
 51:     ST  3,-7(1) 	Store parameter 
 52:    LDA  1,-5(1) 	Load address of new frame 
 53:    LDA  3,1(7) 	Return address in ac 
 54:    LDA  7,-25(7) 	CALL cat
 55:    LDA  3,0(2) 	Save the result in ac 
 56:     ST  3,-5(1) 	Store parameter 
 57:    LDA  1,-3(1) 	Load address of new frame 
 58:    LDA  3,1(7) 	Return address in ac 
 59:    LDA  7,-54(7) 	CALL output
 60:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 61:    LDC  2,0(6) 	Set return value to 0 
 62:     LD  3,-1(1) 	Load return address 
 63:     LD  1,0(1) 	Adjust fp 
 64:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,64(7) 	Jump to init 
* BEGIN Init
 65:     LD  0,0(0) 	Set the global pointer 
 66:    LDA  1,0(0) 	set first frame at end of globals 
 67:     ST  1,0(1) 	store old fp (point to self) 
 68:    LDA  3,1(7) 	Return address in ac 
 69:    LDA  7,-29(7) 	Jump to main 
 70:   HALT  0,0,0 	DONE! 
* END Init
