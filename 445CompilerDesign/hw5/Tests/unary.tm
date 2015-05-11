* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  unary.tm
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
 31:    LDC  3,0(6) 	load size of array a
 32:     ST  3,-3(1) 	save size of array a
 33:    LDC  3,0(6) 	load size of array b
 34:     ST  3,-4(1) 	save size of array b
* EXPRESSION STMT
 35:    LDC  3,88(6) 	Load constant 
 36:     ST  3,0(1) 	Store variable x
* EXPRESSION STMT
 37:     LD  3,0(1) 	Load variable x
 38:     ST  3,-6(1) 	Save left side 
 39:    LDC  3,9(6) 	Load constant 
 40:     LD  4,-6(1) 	Load left into ac1 
 41:    SUB  3,4,3 	Op - 
 42:     ST  3,-2(1) 	Store variable y
* EXPRESSION STMT
 43:     LD  3,0(1) 	Load variable x
 44:    LDC  4,0(6) 	Load 0 
 45:    SUB  3,4,3 	Op unary - 
 46:     ST  3,-2(1) 	Store variable y
* EXPRESSION STMT
 47:     ST  1,-6(1) 	Store old frame in ghost frame 
 48:     LD  3,0(1) 	Load variable x
 49:    LDC  4,0(6) 	Load 0 
 50:    SUB  3,4,3 	Op unary - 
 51:     ST  3,-8(1) 	Store parameter 
 52:    LDA  1,-6(1) 	Load address of new frame 
 53:    LDA  3,1(7) 	Return address in ac 
 54:    LDA  7,-49(7) 	CALL output
 55:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 56:     ST  1,-6(1) 	Store old frame in ghost frame 
 57:     LD  3,-2(1) 	Load variable y
 58:     ST  3,-8(1) 	Store parameter 
 59:    LDA  1,-6(1) 	Load address of new frame 
 60:    LDA  3,1(7) 	Return address in ac 
 61:    LDA  7,-56(7) 	CALL output
 62:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 63:     ST  1,-6(1) 	Store old frame in ghost frame 
 64:    LDA  1,-6(1) 	Load address of new frame 
 65:    LDA  3,1(7) 	Return address in ac 
 66:    LDA  7,-42(7) 	CALL outnl
 67:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 68:     ST  1,-6(1) 	Store old frame in ghost frame 
 69:    LDC  3,3(6) 	Load constant 
 70:    LDC  4,0(6) 	Load 0 
 71:    SUB  3,4,3 	Op unary - 
 72:    LDC  4,0(6) 	Load 0 
 73:    SUB  3,4,3 	Op unary - 
 74:     ST  3,-8(1) 	Save left side 
 75:    LDC  3,5(6) 	Load constant 
 76:    LDC  4,0(6) 	Load 0 
 77:    SUB  3,4,3 	Op unary - 
 78:     LD  4,-8(1) 	Load left into ac1 
 79:    MUL  3,4,3 	Op * 
 80:     ST  3,-8(1) 	Store parameter 
 81:    LDA  1,-6(1) 	Load address of new frame 
 82:    LDA  3,1(7) 	Return address in ac 
 83:    LDA  7,-78(7) 	CALL output
 84:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 85:     ST  1,-6(1) 	Store old frame in ghost frame 
 86:    LDC  3,3(6) 	Load constant 
 87:    LDC  4,0(6) 	Load 0 
 88:    SUB  3,4,3 	Op unary - 
 89:    LDC  4,0(6) 	Load 0 
 90:    SUB  3,4,3 	Op unary - 
 91:     ST  3,-8(1) 	Store parameter 
 92:    LDA  1,-6(1) 	Load address of new frame 
 93:    LDA  3,1(7) 	Return address in ac 
 94:    LDA  7,-89(7) 	CALL output
 95:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 96:     ST  1,-6(1) 	Store old frame in ghost frame 
 97:    LDA  1,-6(1) 	Load address of new frame 
 98:    LDA  3,1(7) 	Return address in ac 
 99:    LDA  7,-75(7) 	CALL outnl
100:    LDA  3,0(2) 	Save the result in ac 
* BEGIN compound statement
* EXPRESSION STMT
101:    LDC  3,0(6) 	Load constant 
102:     ST  3,0(1) 	Store variable x
* EXPRESSION STMT
103:     LD  3,0(1) 	Load variable x
104:     ST  3,-2(1) 	Store variable y
* EXPRESSION STMT
105:     ST  1,-6(1) 	Store old frame in ghost frame 
106:     LD  3,0(1) 	Load variable x
107:     ST  3,-8(1) 	Store parameter 
108:    LDA  1,-6(1) 	Load address of new frame 
109:    LDA  3,1(7) 	Return address in ac 
110:    LDA  7,-93(7) 	CALL outputb
111:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
112:     ST  1,-6(1) 	Store old frame in ghost frame 
113:     LD  3,-2(1) 	Load variable y
114:     ST  3,-8(1) 	Store parameter 
115:    LDA  1,-6(1) 	Load address of new frame 
116:    LDA  3,1(7) 	Return address in ac 
117:    LDA  7,-100(7) 	CALL outputb
118:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
119:     ST  1,-6(1) 	Store old frame in ghost frame 
120:     LD  3,0(1) 	Load variable x
121:     ST  3,-8(1) 	Save left side 
122:     LD  3,-2(1) 	Load variable y
123:     LD  4,-8(1) 	Load left into ac1 
124:    JEQ  3,1(7) 	Op AND 
125:    LDA  3,0(4) 	 
126:     ST  3,-8(1) 	Store parameter 
127:    LDA  1,-6(1) 	Load address of new frame 
128:    LDA  3,1(7) 	Return address in ac 
129:    LDA  7,-112(7) 	CALL outputb
130:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
131:     ST  1,-6(1) 	Store old frame in ghost frame 
132:     LD  3,0(1) 	Load variable x
133:     ST  3,-8(1) 	Save left side 
134:     LD  3,-2(1) 	Load variable y
135:     LD  4,-8(1) 	Load left into ac1 
136:     ST  3,-8(1) 	Store parameter 
137:    LDA  1,-6(1) 	Load address of new frame 
138:    LDA  3,1(7) 	Return address in ac 
139:    LDA  7,-122(7) 	CALL outputb
140:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
141:     ST  1,-6(1) 	Store old frame in ghost frame 
142:     LD  3,-2(1) 	Load variable y
143:     ST  3,-8(1) 	Save left side 
144:     LD  3,0(1) 	Load variable x
145:     LD  4,-8(1) 	Load left into ac1 
146:     ST  3,-8(1) 	Store parameter 
147:    LDA  1,-6(1) 	Load address of new frame 
148:    LDA  3,1(7) 	Return address in ac 
149:    LDA  7,-132(7) 	CALL outputb
150:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
151:     ST  1,-6(1) 	Store old frame in ghost frame 
152:     LD  3,0(1) 	Load variable x
153:     ST  3,-8(1) 	Store parameter 
154:    LDA  1,-6(1) 	Load address of new frame 
155:    LDA  3,1(7) 	Return address in ac 
156:    LDA  7,-139(7) 	CALL outputb
157:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
158:     ST  1,-6(1) 	Store old frame in ghost frame 
159:    LDA  1,-6(1) 	Load address of new frame 
160:    LDA  3,1(7) 	Return address in ac 
161:    LDA  7,-137(7) 	CALL outnl
162:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* EXPRESSION STMT
163:     ST  1,-6(1) 	Store old frame in ghost frame 
164:     LD  3,-4(1) 	Load variable a
165:    MUL  3,4,3 	Op * 
166:     ST  3,-8(1) 	Store parameter 
167:    LDA  1,-6(1) 	Load address of new frame 
168:    LDA  3,1(7) 	Return address in ac 
169:    LDA  7,-164(7) 	CALL output
170:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
171:     ST  1,-6(1) 	Store old frame in ghost frame 
172:     LD  3,-5(1) 	Load variable b
173:    MUL  3,4,3 	Op * 
174:     ST  3,-8(1) 	Store parameter 
175:    LDA  1,-6(1) 	Load address of new frame 
176:    LDA  3,1(7) 	Return address in ac 
177:    LDA  7,-172(7) 	CALL output
178:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
179:    LDC  2,0(6) 	Set return value to 0 
180:     LD  3,-1(1) 	Load return address 
181:     LD  1,0(1) 	Adjust fp 
182:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,182(7) 	Jump to init 
* BEGIN Init
183:     LD  0,0(0) 	Set the global pointer 
184:    LDA  1,0(0) 	set first frame at end of globals 
185:     ST  1,0(1) 	store old fp (point to self) 
186:    LDA  3,1(7) 	Return address in ac 
187:    LDA  7,-158(7) 	Jump to main 
188:   HALT  0,0,0 	DONE! 
* END Init
