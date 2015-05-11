* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  c0f.tm
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
* EXPRESSION STMT
 33:    LDC  3,3(6) 	Load constant 
 34:     ST  3,-2(1) 	Save index 
 35:    LDC  3,1023(6) 	Load constant 
 36:     ST  3,0(1) 	Store variable x
* EXPRESSION STMT
 37:     ST  1,-3(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
 38:    LDC  3,3(6) 	Load constant 
 39:     ST  3,-5(1) 	Save index 
 40:     ST  3,0(1) 	Store variable x
 41:     ST  3,-6(1) 	Store parameter 
 42:    LDA  1,-3(1) 	Load address of new frame 
 43:    LDA  3,1(7) 	Return address in ac 
 44:    LDA  7,-39(7) 	CALL output
 45:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 46:     ST  1,-3(1) 	Store old frame in ghost frame 
 47:    LDA  1,-3(1) 	Load address of new frame 
 48:    LDA  3,1(7) 	Return address in ac 
 49:    LDA  7,-25(7) 	CALL outnl
 50:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 51:     ST  1,-3(1) 	Store old frame in ghost frame 
 52:    LDC  3,3(6) 	Load constant 
 53:     ST  3,-5(1) 	Save index 
 54:     ST  3,-6(1) 	Store parameter 
 55:    LDA  1,-3(1) 	Load address of new frame 
 56:    LDA  3,1(7) 	Return address in ac 
 57:    LDA  7,-52(7) 	CALL output
 58:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 59:     ST  1,-3(1) 	Store old frame in ghost frame 
 60:    LDA  1,-3(1) 	Load address of new frame 
 61:    LDA  3,1(7) 	Return address in ac 
 62:    LDA  7,-38(7) 	CALL outnl
 63:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 64:     ST  1,-3(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
 65:    LDC  3,3(6) 	Load constant 
 66:     ST  3,-5(1) 	Save index 
 67:     ST  3,0(1) 	Store variable x
 68:     ST  3,-6(1) 	Store parameter 
 69:    LDA  1,-3(1) 	Load address of new frame 
 70:    LDA  3,1(7) 	Return address in ac 
 71:    LDA  7,-66(7) 	CALL output
 72:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 73:     ST  1,-3(1) 	Store old frame in ghost frame 
 74:    LDA  1,-3(1) 	Load address of new frame 
 75:    LDA  3,1(7) 	Return address in ac 
 76:    LDA  7,-52(7) 	CALL outnl
 77:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 78:     ST  1,-3(1) 	Store old frame in ghost frame 
 79:    LDC  3,3(6) 	Load constant 
 80:     ST  3,-5(1) 	Save index 
 81:     ST  3,-6(1) 	Store parameter 
 82:    LDA  1,-3(1) 	Load address of new frame 
 83:    LDA  3,1(7) 	Return address in ac 
 84:    LDA  7,-79(7) 	CALL output
 85:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 86:     ST  1,-3(1) 	Store old frame in ghost frame 
 87:    LDA  1,-3(1) 	Load address of new frame 
 88:    LDA  3,1(7) 	Return address in ac 
 89:    LDA  7,-65(7) 	CALL outnl
 90:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 91:    LDC  2,0(6) 	Set return value to 0 
 92:     LD  3,-1(1) 	Load return address 
 93:     LD  1,0(1) 	Adjust fp 
 94:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,94(7) 	Jump to init 
* BEGIN Init
 95:     LD  0,0(0) 	Set the global pointer 
 96:    LDA  1,0(0) 	set first frame at end of globals 
 97:     ST  1,0(1) 	store old fp (point to self) 
 98:    LDA  3,1(7) 	Return address in ac 
 99:    LDA  7,-70(7) 	Jump to main 
100:   HALT  0,0,0 	DONE! 
* END Init
