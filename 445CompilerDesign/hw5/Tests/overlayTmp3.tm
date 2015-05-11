* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  overlayTmp3.tm
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
* RETURN
 31:     LD  3,-2(1) 	Load variable pig
 32:    LDA  2,0(3) 	Copy result to rt register 
 33:     LD  3,-1(1) 	Load return address 
 34:     LD  1,0(1) 	Adjust fp 
 35:    LDA  7,0(3) 	Return 
* Add standard closing in case there is no return statement
 36:    LDC  2,0(6) 	Set return value to 0 
 37:     LD  3,-1(1) 	Load return address 
 38:     LD  1,0(1) 	Adjust fp 
 39:    LDA  7,0(3) 	Return 
* END function dog
* BEGIN function main
 40:     ST  3,-1(1) 	Store return address 
* IfK:
* IfK: t->child[0] condition
 41:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* BEGIN compound statement
* EXPRESSION STMT
 43:    LDC  3,111(6) 	Load constant 
 44:     ST  3,0(1) 	Store variable z
* BEGIN compound statement
* EXPRESSION STMT
 45:    LDC  3,222(6) 	Load constant 
 46:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
 47:    LDC  3,666(6) 	Load constant 
 48:     ST  3,-3(1) 	Save left side 
* EXPRESSION STMT
 49:     ST  1,-4(1) 	Store old frame in ghost frame 
 50:     LD  3,-2(1) 	Load variable x
 51:     ST  3,-6(1) 	Store parameter 
 52:    LDA  1,-4(1) 	Load address of new frame 
 53:    LDA  3,1(7) 	Return address in ac 
 54:    LDA  7,-25(7) 	CALL dog
 55:    LDA  3,0(2) 	Save the result in ac 
 56:     LD  4,-3(1) 	Load left into ac1 
 57:    ADD  3,4,3 	Op + 
 58:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
 59:     ST  1,-3(1) 	Store old frame in ghost frame 
 60:     LD  3,-2(1) 	Load variable x
 61:     ST  3,-5(1) 	Store parameter 
 62:    LDA  1,-3(1) 	Load address of new frame 
 63:    LDA  3,1(7) 	Return address in ac 
 64:    LDA  7,-59(7) 	CALL output
 65:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 66:     ST  1,-3(1) 	Store old frame in ghost frame 
 67:    LDA  1,-3(1) 	Load address of new frame 
 68:    LDA  3,1(7) 	Return address in ac 
 69:    LDA  7,-45(7) 	CALL outnl
 70:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* BEGIN compound statement
* EXPRESSION STMT
 71:    LDC  3,333(6) 	Load constant 
 72:     ST  3,-4(1) 	Store variable y
* EXPRESSION STMT
 73:    LDC  3,666(6) 	Load constant 
 74:     ST  3,-3(1) 	Save left side 
* EXPRESSION STMT
 75:     ST  1,-4(1) 	Store old frame in ghost frame 
 76:     LD  3,-4(1) 	Load variable y
 77:     ST  3,-6(1) 	Store parameter 
 78:    LDA  1,-4(1) 	Load address of new frame 
 79:    LDA  3,1(7) 	Return address in ac 
 80:    LDA  7,-51(7) 	CALL dog
 81:    LDA  3,0(2) 	Save the result in ac 
 82:     LD  4,-3(1) 	Load left into ac1 
 83:    ADD  3,4,3 	Op + 
 84:     ST  3,-4(1) 	Store variable y
* EXPRESSION STMT
 85:     ST  1,-3(1) 	Store old frame in ghost frame 
 86:     LD  3,-4(1) 	Load variable y
 87:     ST  3,-5(1) 	Store parameter 
 88:    LDA  1,-3(1) 	Load address of new frame 
 89:    LDA  3,1(7) 	Return address in ac 
 90:    LDA  7,-85(7) 	CALL output
 91:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 92:     ST  1,-3(1) 	Store old frame in ghost frame 
 93:    LDA  1,-3(1) 	Load address of new frame 
 94:    LDA  3,1(7) 	Return address in ac 
 95:    LDA  7,-71(7) 	CALL outnl
 96:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* EXPRESSION STMT
 97:    LDC  3,666(6) 	Load constant 
 98:     ST  3,-3(1) 	Save left side 
* EXPRESSION STMT
 99:     ST  1,-4(1) 	Store old frame in ghost frame 
100:     LD  3,0(1) 	Load variable z
101:     ST  3,-6(1) 	Store parameter 
102:    LDA  1,-4(1) 	Load address of new frame 
103:    LDA  3,1(7) 	Return address in ac 
104:    LDA  7,-75(7) 	CALL dog
105:    LDA  3,0(2) 	Save the result in ac 
106:     LD  4,-3(1) 	Load left into ac1 
107:    ADD  3,4,3 	Op + 
108:     ST  3,0(1) 	Store variable z
* EXPRESSION STMT
109:     ST  1,-3(1) 	Store old frame in ghost frame 
110:     LD  3,0(1) 	Load variable z
111:     ST  3,-5(1) 	Store parameter 
112:    LDA  1,-3(1) 	Load address of new frame 
113:    LDA  3,1(7) 	Return address in ac 
114:    LDA  7,-109(7) 	CALL output
115:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
116:     ST  1,-3(1) 	Store old frame in ghost frame 
117:    LDA  1,-3(1) 	Load address of new frame 
118:    LDA  3,1(7) 	Return address in ac 
119:    LDA  7,-95(7) 	CALL outnl
120:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
 42:    JEQ  3,79(7) 	if: jmp to else 
* IfK: t->child[2] else part
121:    LDA  7,0(7) 	jmp to end 
* ENDIF
* Add standard closing in case there is no return statement
122:    LDC  2,0(6) 	Set return value to 0 
123:     LD  3,-1(1) 	Load return address 
124:     LD  1,0(1) 	Adjust fp 
125:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,125(7) 	Jump to init 
* BEGIN Init
126:     LD  0,0(0) 	Set the global pointer 
127:    LDA  1,0(0) 	set first frame at end of globals 
128:     ST  1,0(1) 	store old fp (point to self) 
129:    LDA  3,1(7) 	Return address in ac 
130:    LDA  7,-91(7) 	Jump to main 
131:   HALT  0,0,0 	DONE! 
* END Init
