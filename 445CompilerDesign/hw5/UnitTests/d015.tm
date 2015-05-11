* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  d015.tm
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
 36:    SUB  4,4,3 	Op < 
 37:    LDC  3,1(6) 	True case 
 38:    JLT  4,1(7) 	Jump if true 
 39:    LDC  3,0(6) 	False case 
 40:     ST  3,-4(1) 	Store parameter 
 41:    LDA  1,-2(1) 	Load address of new frame 
 42:    LDA  3,1(7) 	Return address in ac 
 43:    LDA  7,-26(7) 	CALL outputb
 44:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 45:     ST  1,-2(1) 	Store old frame in ghost frame 
 46:    LDC  3,0(6) 	Load constant 
 47:     ST  3,-4(1) 	Save left side 
 48:    LDC  3,0(6) 	Load constant 
 49:     LD  4,-4(1) 	Load left into ac1 
 50:    SUB  4,4,3 	Op > 
 51:    LDC  3,1(6) 	True case 
 52:    JLT  4,1(7) 	Jump if true 
 53:    LDC  3,0(6) 	False case 
 54:     ST  3,-4(1) 	Store parameter 
 55:    LDA  1,-2(1) 	Load address of new frame 
 56:    LDA  3,1(7) 	Return address in ac 
 57:    LDA  7,-40(7) 	CALL outputb
 58:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 59:     ST  1,-2(1) 	Store old frame in ghost frame 
 60:    LDC  3,0(6) 	Load constant 
 61:     ST  3,-4(1) 	Save left side 
 62:    LDC  3,0(6) 	Load constant 
 63:     LD  4,-4(1) 	Load left into ac1 
 64:    SUB  4,4,3 	Op == 
 65:    LDC  3,1(6) 	True case 
 66:    JEQ  4,1(7) 	Jump if true 
 67:    LDC  3,0(6) 	False case 
 68:     ST  3,-4(1) 	Store parameter 
 69:    LDA  1,-2(1) 	Load address of new frame 
 70:    LDA  3,1(7) 	Return address in ac 
 71:    LDA  7,-54(7) 	CALL outputb
 72:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 73:     ST  1,-2(1) 	Store old frame in ghost frame 
 74:    LDC  3,0(6) 	Load constant 
 75:     ST  3,-4(1) 	Save left side 
 76:    LDC  3,0(6) 	Load constant 
 77:     LD  4,-4(1) 	Load left into ac1 
 78:     ST  3,-4(1) 	Store parameter 
 79:    LDA  1,-2(1) 	Load address of new frame 
 80:    LDA  3,1(7) 	Return address in ac 
 81:    LDA  7,-64(7) 	CALL outputb
 82:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 83:     ST  1,-2(1) 	Store old frame in ghost frame 
 84:    LDC  3,0(6) 	Load constant 
 85:     ST  3,-4(1) 	Save left side 
 86:    LDC  3,0(6) 	Load constant 
 87:     LD  4,-4(1) 	Load left into ac1 
 88:     ST  3,-4(1) 	Store parameter 
 89:    LDA  1,-2(1) 	Load address of new frame 
 90:    LDA  3,1(7) 	Return address in ac 
 91:    LDA  7,-74(7) 	CALL outputb
 92:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 93:     ST  1,-2(1) 	Store old frame in ghost frame 
 94:    LDC  3,0(6) 	Load constant 
 95:     ST  3,-4(1) 	Save left side 
 96:    LDC  3,0(6) 	Load constant 
 97:     LD  4,-4(1) 	Load left into ac1 
 98:     ST  3,-4(1) 	Store parameter 
 99:    LDA  1,-2(1) 	Load address of new frame 
100:    LDA  3,1(7) 	Return address in ac 
101:    LDA  7,-84(7) 	CALL outputb
102:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
103:     ST  1,-2(1) 	Store old frame in ghost frame 
104:    LDC  3,0(6) 	Load constant 
105:     ST  3,-4(1) 	Save left side 
106:    LDC  3,0(6) 	Load constant 
107:     LD  4,-4(1) 	Load left into ac1 
108:    SUB  4,4,3 	Op == 
109:    LDC  3,1(6) 	True case 
110:    JEQ  4,1(7) 	Jump if true 
111:    LDC  3,0(6) 	False case 
112:     ST  3,-4(1) 	Store parameter 
113:    LDA  1,-2(1) 	Load address of new frame 
114:    LDA  3,1(7) 	Return address in ac 
115:    LDA  7,-98(7) 	CALL outputb
116:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
117:     ST  1,-2(1) 	Store old frame in ghost frame 
118:    LDC  3,0(6) 	Load constant 
119:     ST  3,-4(1) 	Save left side 
120:    LDC  3,0(6) 	Load constant 
121:     LD  4,-4(1) 	Load left into ac1 
122:     ST  3,-4(1) 	Store parameter 
123:    LDA  1,-2(1) 	Load address of new frame 
124:    LDA  3,1(7) 	Return address in ac 
125:    LDA  7,-108(7) 	CALL outputb
126:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
127:     ST  1,-2(1) 	Store old frame in ghost frame 
128:    LDC  3,0(6) 	Load constant 
129:     ST  3,-4(1) 	Save left side 
130:    LDC  3,0(6) 	Load constant 
131:     LD  4,-4(1) 	Load left into ac1 
132:     ST  3,-4(1) 	Store parameter 
133:    LDA  1,-2(1) 	Load address of new frame 
134:    LDA  3,1(7) 	Return address in ac 
135:    LDA  7,-118(7) 	CALL outputb
136:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
137:     ST  1,-2(1) 	Store old frame in ghost frame 
138:    LDC  3,0(6) 	Load constant 
139:     ST  3,-4(1) 	Save left side 
140:    LDC  3,0(6) 	Load constant 
141:     LD  4,-4(1) 	Load left into ac1 
142:     ST  3,-4(1) 	Store parameter 
143:    LDA  1,-2(1) 	Load address of new frame 
144:    LDA  3,1(7) 	Return address in ac 
145:    LDA  7,-128(7) 	CALL outputb
146:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
147:    LDC  2,0(6) 	Set return value to 0 
148:     LD  3,-1(1) 	Load return address 
149:     LD  1,0(1) 	Adjust fp 
150:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,150(7) 	Jump to init 
* BEGIN Init
151:     LD  0,0(0) 	Set the global pointer 
152:    LDA  1,0(0) 	set first frame at end of globals 
153:     ST  1,0(1) 	store old fp (point to self) 
154:    LDA  3,1(7) 	Return address in ac 
155:    LDA  7,-126(7) 	Jump to main 
156:   HALT  0,0,0 	DONE! 
* END Init