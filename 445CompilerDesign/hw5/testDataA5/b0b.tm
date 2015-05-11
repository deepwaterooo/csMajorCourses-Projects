* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  b0b.c-
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
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 31:     ST  1,-2(1) 	Store old fp in ghost frame 
 32:    LDC  3,0(6) 	Load constant 
 33:     ST  3,-4(1) 	Save left side 
 34:    LDC  3,0(6) 	Load constant 
 35:     LD  4,-4(1) 	Load left into ac1 
 36:    JGT  3,1(7) 	Op OR 
 37:    LDA  3,0(4) 	 
 38:     ST  3,-4(1) 	Store parameter 
 39:    LDA  1,-2(1) 	Load address of new frame 
 40:    LDA  3,1(7) 	Return address in ac 
 41:    LDA  7,-24(7) 	CALL outputb
 42:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 43:     ST  1,-2(1) 	Store old fp in ghost frame 
 44:    LDC  3,0(6) 	Load constant 
 45:     ST  3,-4(1) 	Save left side 
 46:    LDC  3,1(6) 	Load constant 
 47:     LD  4,-4(1) 	Load left into ac1 
 48:    JGT  3,1(7) 	Op OR 
 49:    LDA  3,0(4) 	 
 50:     ST  3,-4(1) 	Store parameter 
 51:    LDA  1,-2(1) 	Load address of new frame 
 52:    LDA  3,1(7) 	Return address in ac 
 53:    LDA  7,-36(7) 	CALL outputb
 54:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 55:     ST  1,-2(1) 	Store old fp in ghost frame 
 56:    LDC  3,1(6) 	Load constant 
 57:     ST  3,-4(1) 	Save left side 
 58:    LDC  3,0(6) 	Load constant 
 59:     LD  4,-4(1) 	Load left into ac1 
 60:    JGT  3,1(7) 	Op OR 
 61:    LDA  3,0(4) 	 
 62:     ST  3,-4(1) 	Store parameter 
 63:    LDA  1,-2(1) 	Load address of new frame 
 64:    LDA  3,1(7) 	Return address in ac 
 65:    LDA  7,-48(7) 	CALL outputb
 66:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 67:     ST  1,-2(1) 	Store old fp in ghost frame 
 68:    LDC  3,1(6) 	Load constant 
 69:     ST  3,-4(1) 	Save left side 
 70:    LDC  3,1(6) 	Load constant 
 71:     LD  4,-4(1) 	Load left into ac1 
 72:    JGT  3,1(7) 	Op OR 
 73:    LDA  3,0(4) 	 
 74:     ST  3,-4(1) 	Store parameter 
 75:    LDA  1,-2(1) 	Load address of new frame 
 76:    LDA  3,1(7) 	Return address in ac 
 77:    LDA  7,-60(7) 	CALL outputb
 78:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 79:     ST  1,-2(1) 	Store old fp in ghost frame 
 80:    LDC  3,0(6) 	Load constant 
 81:     ST  3,-4(1) 	Save left side 
 82:    LDC  3,0(6) 	Load constant 
 83:     LD  4,-4(1) 	Load left into ac1 
 84:    JEQ  3,1(7) 	Op AND 
 85:    LDA  3,0(4) 	 
 86:     ST  3,-4(1) 	Store parameter 
 87:    LDA  1,-2(1) 	Load address of new frame 
 88:    LDA  3,1(7) 	Return address in ac 
 89:    LDA  7,-72(7) 	CALL outputb
 90:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 91:     ST  1,-2(1) 	Store old fp in ghost frame 
 92:    LDC  3,0(6) 	Load constant 
 93:     ST  3,-4(1) 	Save left side 
 94:    LDC  3,1(6) 	Load constant 
 95:     LD  4,-4(1) 	Load left into ac1 
 96:    JEQ  3,1(7) 	Op AND 
 97:    LDA  3,0(4) 	 
 98:     ST  3,-4(1) 	Store parameter 
 99:    LDA  1,-2(1) 	Load address of new frame 
100:    LDA  3,1(7) 	Return address in ac 
101:    LDA  7,-84(7) 	CALL outputb
102:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
103:     ST  1,-2(1) 	Store old fp in ghost frame 
104:    LDC  3,1(6) 	Load constant 
105:     ST  3,-4(1) 	Save left side 
106:    LDC  3,0(6) 	Load constant 
107:     LD  4,-4(1) 	Load left into ac1 
108:    JEQ  3,1(7) 	Op AND 
109:    LDA  3,0(4) 	 
110:     ST  3,-4(1) 	Store parameter 
111:    LDA  1,-2(1) 	Load address of new frame 
112:    LDA  3,1(7) 	Return address in ac 
113:    LDA  7,-96(7) 	CALL outputb
114:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
115:     ST  1,-2(1) 	Store old fp in ghost frame 
116:    LDC  3,1(6) 	Load constant 
117:     ST  3,-4(1) 	Save left side 
118:    LDC  3,1(6) 	Load constant 
119:     LD  4,-4(1) 	Load left into ac1 
120:    JEQ  3,1(7) 	Op AND 
121:    LDA  3,0(4) 	 
122:     ST  3,-4(1) 	Store parameter 
123:    LDA  1,-2(1) 	Load address of new frame 
124:    LDA  3,1(7) 	Return address in ac 
125:    LDA  7,-108(7) 	CALL outputb
126:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
127:     ST  1,-2(1) 	Store old fp in ghost frame 
128:    LDC  3,0(6) 	Load constant 
129:    LDC  4,1(6) 	Load 1 
130:    SUB  3,4,3 	Op NOT 
131:     ST  3,-4(1) 	Store parameter 
132:    LDA  1,-2(1) 	Load address of new frame 
133:    LDA  3,1(7) 	Return address in ac 
134:    LDA  7,-117(7) 	CALL outputb
135:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
136:     ST  1,-2(1) 	Store old fp in ghost frame 
137:    LDC  3,1(6) 	Load constant 
138:    LDC  4,1(6) 	Load 1 
139:    SUB  3,4,3 	Op NOT 
140:     ST  3,-4(1) 	Store parameter 
141:    LDA  1,-2(1) 	Load address of new frame 
142:    LDA  3,1(7) 	Return address in ac 
143:    LDA  7,-126(7) 	CALL outputb
144:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
145:     ST  1,-2(1) 	Store old fp in ghost frame 
146:    LDA  1,-2(1) 	Load address of new frame 
147:    LDA  3,1(7) 	Return address in ac 
148:    LDA  7,-124(7) 	CALL outnl
149:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
150:    LDC  2,0(6) 	Set return value to 0 
151:     LD  3,-1(1) 	Load return address 
152:     LD  1,0(1) 	Adjust fp 
153:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,153(7) 	Jump to init 
* BEGIN Init
154:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
155:    LDA  1,0(0) 	set first frame at end of globals 
156:     ST  1,0(1) 	store old fp (point to self) 
157:    LDA  3,1(7) 	Return address in ac 
158:    LDA  7,-129(7) 	Jump to main 
159:   HALT  0,0,0 	DONE! 
* END Init
