* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  logic.tm
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
 31:     ST  1,-2(1) 	Store old frame in ghost frame 
 32:    LDC  3,0(6) 	Load constant 
 33:     ST  3,-4(1) 	Save left side 
 34:    LDC  3,0(6) 	Load constant 
 35:     LD  4,-4(1) 	Load left into ac1 
 36:    JEQ  3,1(7) 	Op AND 
 37:    LDA  3,0(4) 	 
 38:     ST  3,-4(1) 	Store parameter 
 39:    LDA  1,-2(1) 	Load address of new frame 
 40:    LDA  3,1(7) 	Return address in ac 
 41:    LDA  7,-24(7) 	CALL outputb
 42:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 43:     ST  1,-2(1) 	Store old frame in ghost frame 
 44:    LDC  3,0(6) 	Load constant 
 45:     ST  3,-4(1) 	Save left side 
 46:    LDC  3,1(6) 	Load constant 
 47:     LD  4,-4(1) 	Load left into ac1 
 48:    JEQ  3,1(7) 	Op AND 
 49:    LDA  3,0(4) 	 
 50:     ST  3,-4(1) 	Store parameter 
 51:    LDA  1,-2(1) 	Load address of new frame 
 52:    LDA  3,1(7) 	Return address in ac 
 53:    LDA  7,-36(7) 	CALL outputb
 54:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 55:     ST  1,-2(1) 	Store old frame in ghost frame 
 56:    LDC  3,1(6) 	Load constant 
 57:     ST  3,-4(1) 	Save left side 
 58:    LDC  3,0(6) 	Load constant 
 59:     LD  4,-4(1) 	Load left into ac1 
 60:    JEQ  3,1(7) 	Op AND 
 61:    LDA  3,0(4) 	 
 62:     ST  3,-4(1) 	Store parameter 
 63:    LDA  1,-2(1) 	Load address of new frame 
 64:    LDA  3,1(7) 	Return address in ac 
 65:    LDA  7,-48(7) 	CALL outputb
 66:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 67:     ST  1,-2(1) 	Store old frame in ghost frame 
 68:    LDC  3,1(6) 	Load constant 
 69:     ST  3,-4(1) 	Save left side 
 70:    LDC  3,1(6) 	Load constant 
 71:     LD  4,-4(1) 	Load left into ac1 
 72:    JEQ  3,1(7) 	Op AND 
 73:    LDA  3,0(4) 	 
 74:     ST  3,-4(1) 	Store parameter 
 75:    LDA  1,-2(1) 	Load address of new frame 
 76:    LDA  3,1(7) 	Return address in ac 
 77:    LDA  7,-60(7) 	CALL outputb
 78:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 79:     ST  1,-2(1) 	Store old frame in ghost frame 
 80:    LDA  1,-2(1) 	Load address of new frame 
 81:    LDA  3,1(7) 	Return address in ac 
 82:    LDA  7,-58(7) 	CALL outnl
 83:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 84:     ST  1,-2(1) 	Store old frame in ghost frame 
 85:    LDC  3,0(6) 	Load constant 
 86:     ST  3,-4(1) 	Save left side 
 87:    LDC  3,0(6) 	Load constant 
 88:     LD  4,-4(1) 	Load left into ac1 
 89:     ST  3,-4(1) 	Store parameter 
 90:    LDA  1,-2(1) 	Load address of new frame 
 91:    LDA  3,1(7) 	Return address in ac 
 92:    LDA  7,-75(7) 	CALL outputb
 93:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 94:     ST  1,-2(1) 	Store old frame in ghost frame 
 95:    LDC  3,0(6) 	Load constant 
 96:     ST  3,-4(1) 	Save left side 
 97:    LDC  3,1(6) 	Load constant 
 98:     LD  4,-4(1) 	Load left into ac1 
 99:     ST  3,-4(1) 	Store parameter 
100:    LDA  1,-2(1) 	Load address of new frame 
101:    LDA  3,1(7) 	Return address in ac 
102:    LDA  7,-85(7) 	CALL outputb
103:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
104:     ST  1,-2(1) 	Store old frame in ghost frame 
105:    LDC  3,1(6) 	Load constant 
106:     ST  3,-4(1) 	Save left side 
107:    LDC  3,0(6) 	Load constant 
108:     LD  4,-4(1) 	Load left into ac1 
109:     ST  3,-4(1) 	Store parameter 
110:    LDA  1,-2(1) 	Load address of new frame 
111:    LDA  3,1(7) 	Return address in ac 
112:    LDA  7,-95(7) 	CALL outputb
113:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
114:     ST  1,-2(1) 	Store old frame in ghost frame 
115:    LDC  3,1(6) 	Load constant 
116:     ST  3,-4(1) 	Save left side 
117:    LDC  3,1(6) 	Load constant 
118:     LD  4,-4(1) 	Load left into ac1 
119:     ST  3,-4(1) 	Store parameter 
120:    LDA  1,-2(1) 	Load address of new frame 
121:    LDA  3,1(7) 	Return address in ac 
122:    LDA  7,-105(7) 	CALL outputb
123:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
124:     ST  1,-2(1) 	Store old frame in ghost frame 
125:    LDA  1,-2(1) 	Load address of new frame 
126:    LDA  3,1(7) 	Return address in ac 
127:    LDA  7,-103(7) 	CALL outnl
128:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
129:    LDC  2,0(6) 	Set return value to 0 
130:     LD  3,-1(1) 	Load return address 
131:     LD  1,0(1) 	Adjust fp 
132:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,132(7) 	Jump to init 
* BEGIN Init
133:     LD  0,0(0) 	Set the global pointer 
134:    LDA  1,0(0) 	set first frame at end of globals 
135:     ST  1,0(1) 	store old fp (point to self) 
136:    LDA  3,1(7) 	Return address in ac 
137:    LDA  7,-108(7) 	Jump to main 
138:   HALT  0,0,0 	DONE! 
* END Init
