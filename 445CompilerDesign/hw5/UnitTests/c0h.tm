* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  c0h.tm
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
 31:     ST  1,-3(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
 32:    LDC  3,3(6) 	Load constant 
 33:     ST  3,-5(1) 	Save index 
 34:     ST  3,-2(1) 	Store variable x
 35:     ST  3,-6(1) 	Store parameter 
 36:    LDA  1,-3(1) 	Load address of new frame 
 37:    LDA  3,1(7) 	Return address in ac 
 38:    LDA  7,-33(7) 	CALL output
 39:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 40:     ST  1,-3(1) 	Store old frame in ghost frame 
 41:    LDA  1,-3(1) 	Load address of new frame 
 42:    LDA  3,1(7) 	Return address in ac 
 43:    LDA  7,-19(7) 	CALL outnl
 44:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 45:     ST  1,-3(1) 	Store old frame in ghost frame 
 46:    LDC  3,3(6) 	Load constant 
 47:     ST  3,-5(1) 	Save index 
 48:     ST  3,-6(1) 	Store parameter 
 49:    LDA  1,-3(1) 	Load address of new frame 
 50:    LDA  3,1(7) 	Return address in ac 
 51:    LDA  7,-46(7) 	CALL output
 52:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 53:     ST  1,-3(1) 	Store old frame in ghost frame 
 54:    LDA  1,-3(1) 	Load address of new frame 
 55:    LDA  3,1(7) 	Return address in ac 
 56:    LDA  7,-32(7) 	CALL outnl
 57:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 58:     ST  1,-3(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
 59:    LDC  3,3(6) 	Load constant 
 60:     ST  3,-5(1) 	Save index 
 61:     ST  3,-2(1) 	Store variable x
 62:     ST  3,-6(1) 	Store parameter 
 63:    LDA  1,-3(1) 	Load address of new frame 
 64:    LDA  3,1(7) 	Return address in ac 
 65:    LDA  7,-60(7) 	CALL output
 66:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 67:     ST  1,-3(1) 	Store old frame in ghost frame 
 68:    LDA  1,-3(1) 	Load address of new frame 
 69:    LDA  3,1(7) 	Return address in ac 
 70:    LDA  7,-46(7) 	CALL outnl
 71:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 72:     ST  1,-3(1) 	Store old frame in ghost frame 
 73:    LDC  3,3(6) 	Load constant 
 74:     ST  3,-5(1) 	Save index 
 75:     ST  3,-6(1) 	Store parameter 
 76:    LDA  1,-3(1) 	Load address of new frame 
 77:    LDA  3,1(7) 	Return address in ac 
 78:    LDA  7,-73(7) 	CALL output
 79:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 80:     ST  1,-3(1) 	Store old frame in ghost frame 
 81:    LDA  1,-3(1) 	Load address of new frame 
 82:    LDA  3,1(7) 	Return address in ac 
 83:    LDA  7,-59(7) 	CALL outnl
 84:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 85:    LDC  2,0(6) 	Set return value to 0 
 86:     LD  3,-1(1) 	Load return address 
 87:     LD  1,0(1) 	Adjust fp 
 88:    LDA  7,0(3) 	Return 
* END function dog
* BEGIN function main
 89:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
 90:    LDC  3,0(6) 	load size of array x
 91:     ST  3,1(1) 	save size of array x
* EXPRESSION STMT
 92:    LDC  3,3(6) 	Load constant 
 93:     ST  3,-2(1) 	Save index 
 94:    LDC  3,1023(6) 	Load constant 
 95:     ST  3,0(1) 	Store variable x
* EXPRESSION STMT
 96:     ST  1,-3(1) 	Store old frame in ghost frame 
 97:     LD  3,0(1) 	Load variable x
 98:     ST  3,-5(1) 	Store parameter 
 99:    LDA  1,-3(1) 	Load address of new frame 
100:    LDA  3,1(7) 	Return address in ac 
101:    LDA  7,-72(7) 	CALL dog
102:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
103:     ST  1,-3(1) 	Store old frame in ghost frame 
104:    LDC  3,3(6) 	Load constant 
105:     ST  3,-5(1) 	Save index 
106:     ST  3,-6(1) 	Store parameter 
107:    LDA  1,-3(1) 	Load address of new frame 
108:    LDA  3,1(7) 	Return address in ac 
109:    LDA  7,-104(7) 	CALL output
110:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
111:    LDC  2,0(6) 	Set return value to 0 
112:     LD  3,-1(1) 	Load return address 
113:     LD  1,0(1) 	Adjust fp 
114:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,114(7) 	Jump to init 
* BEGIN Init
115:     LD  0,0(0) 	Set the global pointer 
116:    LDA  1,0(0) 	set first frame at end of globals 
117:     ST  1,0(1) 	store old fp (point to self) 
118:    LDA  3,1(7) 	Return address in ac 
119:    LDA  7,-31(7) 	Jump to main 
120:   HALT  0,0,0 	DONE! 
* END Init
