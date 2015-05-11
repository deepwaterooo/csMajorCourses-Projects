* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  c0g.tm
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
* EXPRESSION STMT
 31:    LDC  3,3(6) 	Load constant 
 32:     ST  3,-2(1) 	Save index 
 33:    LDC  3,1023(6) 	Load constant 
 34:     ST  3,-1(1) 	Store variable x
* EXPRESSION STMT
 35:     ST  1,-3(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
 36:    LDC  3,3(6) 	Load constant 
 37:     ST  3,-5(1) 	Save index 
 38:     ST  3,-1(1) 	Store variable x
 39:     ST  3,-6(1) 	Store parameter 
 40:    LDA  1,-3(1) 	Load address of new frame 
 41:    LDA  3,1(7) 	Return address in ac 
 42:    LDA  7,-37(7) 	CALL output
 43:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 44:     ST  1,-3(1) 	Store old frame in ghost frame 
 45:    LDA  1,-3(1) 	Load address of new frame 
 46:    LDA  3,1(7) 	Return address in ac 
 47:    LDA  7,-23(7) 	CALL outnl
 48:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 49:     ST  1,-3(1) 	Store old frame in ghost frame 
 50:    LDC  3,3(6) 	Load constant 
 51:     ST  3,-5(1) 	Save index 
 52:     ST  3,-6(1) 	Store parameter 
 53:    LDA  1,-3(1) 	Load address of new frame 
 54:    LDA  3,1(7) 	Return address in ac 
 55:    LDA  7,-50(7) 	CALL output
 56:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 57:     ST  1,-3(1) 	Store old frame in ghost frame 
 58:    LDA  1,-3(1) 	Load address of new frame 
 59:    LDA  3,1(7) 	Return address in ac 
 60:    LDA  7,-36(7) 	CALL outnl
 61:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 62:     ST  1,-3(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
 63:    LDC  3,3(6) 	Load constant 
 64:     ST  3,-5(1) 	Save index 
 65:     ST  3,-1(1) 	Store variable x
 66:     ST  3,-6(1) 	Store parameter 
 67:    LDA  1,-3(1) 	Load address of new frame 
 68:    LDA  3,1(7) 	Return address in ac 
 69:    LDA  7,-64(7) 	CALL output
 70:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 71:     ST  1,-3(1) 	Store old frame in ghost frame 
 72:    LDA  1,-3(1) 	Load address of new frame 
 73:    LDA  3,1(7) 	Return address in ac 
 74:    LDA  7,-50(7) 	CALL outnl
 75:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 76:     ST  1,-3(1) 	Store old frame in ghost frame 
 77:    LDC  3,3(6) 	Load constant 
 78:     ST  3,-5(1) 	Save index 
 79:     ST  3,-6(1) 	Store parameter 
 80:    LDA  1,-3(1) 	Load address of new frame 
 81:    LDA  3,1(7) 	Return address in ac 
 82:    LDA  7,-77(7) 	CALL output
 83:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 84:     ST  1,-3(1) 	Store old frame in ghost frame 
 85:    LDA  1,-3(1) 	Load address of new frame 
 86:    LDA  3,1(7) 	Return address in ac 
 87:    LDA  7,-63(7) 	CALL outnl
 88:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 89:    LDC  2,0(6) 	Set return value to 0 
 90:     LD  3,-1(1) 	Load return address 
 91:     LD  1,0(1) 	Adjust fp 
 92:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,92(7) 	Jump to init 
* BEGIN Init
 93:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
 94:    LDC  3,0(6) 	load size of array x
 95:     ST  3,-1(0) 	save size of array x
* END init of global array sizes
 96:    LDA  1,-1(0) 	set first frame at end of globals 
 97:     ST  1,0(1) 	store old fp (point to self) 
 98:    LDA  3,1(7) 	Return address in ac 
 99:    LDA  7,-70(7) 	Jump to main 
100:   HALT  0,0,0 	DONE! 
* END Init
