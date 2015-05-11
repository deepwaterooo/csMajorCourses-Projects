* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  logic2.tm
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
 31:     ST  1,-3(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
 32:    LDC  3,1(6) 	Load constant 
 33:     ST  3,0(1) 	Store variable a
 34:     ST  3,-5(1) 	Store parameter 
 35:    LDA  1,-3(1) 	Load address of new frame 
 36:    LDA  3,1(7) 	Return address in ac 
 37:    LDA  7,-32(7) 	CALL output
 38:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 39:     ST  1,-3(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
 40:    LDC  3,0(6) 	Load constant 
 41:     ST  3,-2(1) 	Store variable b
 42:     ST  3,-5(1) 	Store parameter 
 43:    LDA  1,-3(1) 	Load address of new frame 
 44:    LDA  3,1(7) 	Return address in ac 
 45:    LDA  7,-40(7) 	CALL output
 46:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 47:     ST  1,-3(1) 	Store old frame in ghost frame 
 48:     LD  3,0(1) 	Load variable a
 49:     ST  3,-5(1) 	Save left side 
 50:     LD  3,-2(1) 	Load variable b
 51:     LD  4,-5(1) 	Load left into ac1 
 52:    JEQ  3,1(7) 	Op AND 
 53:    LDA  3,0(4) 	 
 54:     ST  3,-5(1) 	Store parameter 
 55:    LDA  1,-3(1) 	Load address of new frame 
 56:    LDA  3,1(7) 	Return address in ac 
 57:    LDA  7,-52(7) 	CALL output
 58:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 59:     ST  1,-3(1) 	Store old frame in ghost frame 
 60:     LD  3,0(1) 	Load variable a
 61:     ST  3,-5(1) 	Save left side 
 62:     LD  3,-2(1) 	Load variable b
 63:     LD  4,-5(1) 	Load left into ac1 
 64:     ST  3,-5(1) 	Store parameter 
 65:    LDA  1,-3(1) 	Load address of new frame 
 66:    LDA  3,1(7) 	Return address in ac 
 67:    LDA  7,-62(7) 	CALL output
 68:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 69:     ST  1,-3(1) 	Store old frame in ghost frame 
 70:     LD  3,0(1) 	Load variable a
 71:     ST  3,-5(1) 	Store parameter 
 72:    LDA  1,-3(1) 	Load address of new frame 
 73:    LDA  3,1(7) 	Return address in ac 
 74:    LDA  7,-69(7) 	CALL output
 75:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 76:     ST  1,-3(1) 	Store old frame in ghost frame 
 77:    LDC  3,111(6) 	Load constant 
 78:     ST  3,-5(1) 	Save left side 
 79:    LDC  3,222(6) 	Load constant 
 80:     LD  4,-5(1) 	Load left into ac1 
 81:    SUB  4,4,3 	Op > 
 82:    LDC  3,1(6) 	True case 
 83:    JLT  4,1(7) 	Jump if true 
 84:    LDC  3,0(6) 	False case 
 85:     ST  3,-5(1) 	Store parameter 
 86:    LDA  1,-3(1) 	Load address of new frame 
 87:    LDA  3,1(7) 	Return address in ac 
 88:    LDA  7,-83(7) 	CALL output
 89:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 90:     ST  1,-3(1) 	Store old frame in ghost frame 
 91:    LDC  3,111(6) 	Load constant 
 92:     ST  3,-5(1) 	Save left side 
 93:    LDC  3,222(6) 	Load constant 
 94:     LD  4,-5(1) 	Load left into ac1 
 95:    SUB  4,4,3 	Op < 
 96:    LDC  3,1(6) 	True case 
 97:    JLT  4,1(7) 	Jump if true 
 98:    LDC  3,0(6) 	False case 
 99:     ST  3,-5(1) 	Store parameter 
100:    LDA  1,-3(1) 	Load address of new frame 
101:    LDA  3,1(7) 	Return address in ac 
102:    LDA  7,-97(7) 	CALL output
103:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
104:     ST  1,-3(1) 	Store old frame in ghost frame 
105:    LDC  3,111(6) 	Load constant 
106:     ST  3,-5(1) 	Save left side 
107:    LDC  3,222(6) 	Load constant 
108:     LD  4,-5(1) 	Load left into ac1 
109:    SUB  4,4,3 	Op == 
110:    LDC  3,1(6) 	True case 
111:    JEQ  4,1(7) 	Jump if true 
112:    LDC  3,0(6) 	False case 
113:     ST  3,-5(1) 	Store parameter 
114:    LDA  1,-3(1) 	Load address of new frame 
115:    LDA  3,1(7) 	Return address in ac 
116:    LDA  7,-111(7) 	CALL output
117:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
118:     ST  1,-3(1) 	Store old frame in ghost frame 
119:    LDC  3,111(6) 	Load constant 
120:     ST  3,-5(1) 	Save left side 
121:    LDC  3,222(6) 	Load constant 
122:     LD  4,-5(1) 	Load left into ac1 
123:     ST  3,-5(1) 	Store parameter 
124:    LDA  1,-3(1) 	Load address of new frame 
125:    LDA  3,1(7) 	Return address in ac 
126:    LDA  7,-121(7) 	CALL output
127:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
128:     ST  1,-3(1) 	Store old frame in ghost frame 
129:    LDC  3,111(6) 	Load constant 
130:     ST  3,-5(1) 	Save left side 
131:    LDC  3,222(6) 	Load constant 
132:     LD  4,-5(1) 	Load left into ac1 
133:     ST  3,-5(1) 	Store parameter 
134:    LDA  1,-3(1) 	Load address of new frame 
135:    LDA  3,1(7) 	Return address in ac 
136:    LDA  7,-131(7) 	CALL output
137:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
138:     ST  1,-3(1) 	Store old frame in ghost frame 
139:    LDC  3,111(6) 	Load constant 
140:     ST  3,-5(1) 	Save left side 
141:    LDC  3,222(6) 	Load constant 
142:     LD  4,-5(1) 	Load left into ac1 
143:     ST  3,-5(1) 	Store parameter 
144:    LDA  1,-3(1) 	Load address of new frame 
145:    LDA  3,1(7) 	Return address in ac 
146:    LDA  7,-141(7) 	CALL output
147:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
148:    LDC  2,0(6) 	Set return value to 0 
149:     LD  3,-1(1) 	Load return address 
150:     LD  1,0(1) 	Adjust fp 
151:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,151(7) 	Jump to init 
* BEGIN Init
152:     LD  0,0(0) 	Set the global pointer 
153:    LDA  1,0(0) 	set first frame at end of globals 
154:     ST  1,0(1) 	store old fp (point to self) 
155:    LDA  3,1(7) 	Return address in ac 
156:    LDA  7,-127(7) 	Jump to main 
157:   HALT  0,0,0 	DONE! 
* END Init
