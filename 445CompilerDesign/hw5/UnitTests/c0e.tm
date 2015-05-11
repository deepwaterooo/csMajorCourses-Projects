* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  c0e.tm
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
 31:    LDC  3,1023(6) 	Load constant 
 32:     ST  3,0(1) 	Store variable x
* EXPRESSION STMT
 33:     ST  1,-2(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
 34:     ST  3,0(1) 	Store variable x
 35:     ST  3,-4(1) 	Store parameter 
 36:    LDA  1,-2(1) 	Load address of new frame 
 37:    LDA  3,1(7) 	Return address in ac 
 38:    LDA  7,-33(7) 	CALL output
 39:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 40:     ST  1,-2(1) 	Store old frame in ghost frame 
 41:    LDA  1,-2(1) 	Load address of new frame 
 42:    LDA  3,1(7) 	Return address in ac 
 43:    LDA  7,-19(7) 	CALL outnl
 44:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 45:     ST  1,-2(1) 	Store old frame in ghost frame 
 46:     LD  3,0(1) 	Load variable x
 47:     ST  3,-4(1) 	Store parameter 
 48:    LDA  1,-2(1) 	Load address of new frame 
 49:    LDA  3,1(7) 	Return address in ac 
 50:    LDA  7,-45(7) 	CALL output
 51:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 52:     ST  1,-2(1) 	Store old frame in ghost frame 
 53:    LDA  1,-2(1) 	Load address of new frame 
 54:    LDA  3,1(7) 	Return address in ac 
 55:    LDA  7,-31(7) 	CALL outnl
 56:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 57:     ST  1,-2(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
 58:     ST  3,0(1) 	Store variable x
 59:     ST  3,-4(1) 	Store parameter 
 60:    LDA  1,-2(1) 	Load address of new frame 
 61:    LDA  3,1(7) 	Return address in ac 
 62:    LDA  7,-57(7) 	CALL output
 63:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 64:     ST  1,-2(1) 	Store old frame in ghost frame 
 65:    LDA  1,-2(1) 	Load address of new frame 
 66:    LDA  3,1(7) 	Return address in ac 
 67:    LDA  7,-43(7) 	CALL outnl
 68:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 69:     ST  1,-2(1) 	Store old frame in ghost frame 
 70:     LD  3,0(1) 	Load variable x
 71:     ST  3,-4(1) 	Store parameter 
 72:    LDA  1,-2(1) 	Load address of new frame 
 73:    LDA  3,1(7) 	Return address in ac 
 74:    LDA  7,-69(7) 	CALL output
 75:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 76:     ST  1,-2(1) 	Store old frame in ghost frame 
 77:    LDA  1,-2(1) 	Load address of new frame 
 78:    LDA  3,1(7) 	Return address in ac 
 79:    LDA  7,-55(7) 	CALL outnl
 80:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 81:    LDC  2,0(6) 	Set return value to 0 
 82:     LD  3,-1(1) 	Load return address 
 83:     LD  1,0(1) 	Adjust fp 
 84:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,84(7) 	Jump to init 
* BEGIN Init
 85:     LD  0,0(0) 	Set the global pointer 
 86:    LDA  1,0(0) 	set first frame at end of globals 
 87:     ST  1,0(1) 	store old fp (point to self) 
 88:    LDA  3,1(7) 	Return address in ac 
 89:    LDA  7,-60(7) 	Jump to main 
 90:   HALT  0,0,0 	DONE! 
* END Init
