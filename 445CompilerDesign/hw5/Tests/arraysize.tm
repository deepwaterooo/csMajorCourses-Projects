* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  arraysize.tm
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
* BEGIN function ford
 30:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
 31:    LDC  3,0(6) 	load size of array y
 32:     ST  3,-3(1) 	save size of array y
* EXPRESSION STMT
 33:    LDC  3,0(6) 	Load constant 
 34:     ST  3,-4(1) 	Save index 
 35:    LDC  3,666(6) 	Load constant 
 36:     ST  3,-4(1) 	Store variable y
* EXPRESSION STMT
 37:    LDC  3,0(6) 	Load constant 
 38:     ST  3,-5(1) 	Save index 
 39:    LDC  3,888(6) 	Load constant 
 40:     ST  3,-1(1) 	Store variable g
* EXPRESSION STMT
 41:     ST  1,-6(1) 	Store old frame in ghost frame 
 42:    LDC  3,0(6) 	Load constant 
 43:     ST  3,-8(1) 	Save index 
 44:     ST  3,-9(1) 	Store parameter 
 45:    LDA  1,-6(1) 	Load address of new frame 
 46:    LDA  3,1(7) 	Return address in ac 
 47:    LDA  7,-42(7) 	CALL output
 48:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 49:     ST  1,-6(1) 	Store old frame in ghost frame 
 50:     LD  3,-2(1) 	Load variable x
 51:    MUL  3,4,3 	Op * 
 52:     ST  3,-8(1) 	Store parameter 
 53:    LDA  1,-6(1) 	Load address of new frame 
 54:    LDA  3,1(7) 	Return address in ac 
 55:    LDA  7,-50(7) 	CALL output
 56:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 57:     ST  1,-6(1) 	Store old frame in ghost frame 
 58:    LDC  3,0(6) 	Load constant 
 59:     ST  3,-8(1) 	Save index 
 60:     ST  3,-9(1) 	Store parameter 
 61:    LDA  1,-6(1) 	Load address of new frame 
 62:    LDA  3,1(7) 	Return address in ac 
 63:    LDA  7,-58(7) 	CALL output
 64:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 65:     ST  1,-6(1) 	Store old frame in ghost frame 
 66:    LDC  3,1(6) 	Load constant 
 67:    LDC  4,0(6) 	Load 0 
 68:    SUB  3,4,3 	Op unary - 
 69:     ST  3,-8(1) 	Save index 
 70:     ST  3,-9(1) 	Store parameter 
 71:    LDA  1,-6(1) 	Load address of new frame 
 72:    LDA  3,1(7) 	Return address in ac 
 73:    LDA  7,-68(7) 	CALL output
 74:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 75:     ST  1,-6(1) 	Store old frame in ghost frame 
 76:    LDA  1,-6(1) 	Load address of new frame 
 77:    LDA  3,1(7) 	Return address in ac 
 78:    LDA  7,-54(7) 	CALL outnl
 79:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 80:     ST  1,-6(1) 	Store old frame in ghost frame 
 81:    LDC  3,0(6) 	Load constant 
 82:     ST  3,-8(1) 	Save index 
 83:     ST  3,-9(1) 	Store parameter 
 84:    LDA  1,-6(1) 	Load address of new frame 
 85:    LDA  3,1(7) 	Return address in ac 
 86:    LDA  7,-81(7) 	CALL output
 87:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 88:     ST  1,-6(1) 	Store old frame in ghost frame 
 89:     LD  3,-4(1) 	Load variable y
 90:    MUL  3,4,3 	Op * 
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
* END compound statement
* Add standard closing in case there is no return statement
101:    LDC  2,0(6) 	Set return value to 0 
102:     LD  3,-1(1) 	Load return address 
103:     LD  1,0(1) 	Adjust fp 
104:    LDA  7,0(3) 	Return 
* END function ford
* BEGIN function main
105:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
106:    LDC  3,0(6) 	load size of array m
107:     ST  3,-2(1) 	save size of array m
* EXPRESSION STMT
108:    LDC  3,0(6) 	Load constant 
109:     ST  3,-2(1) 	Save index 
110:    LDC  3,777(6) 	Load constant 
111:     ST  3,-3(1) 	Store variable m
* EXPRESSION STMT
112:     ST  1,-3(1) 	Store old frame in ghost frame 
113:    LDC  3,0(6) 	Load constant 
114:     ST  3,-5(1) 	Save index 
115:     ST  3,-6(1) 	Store parameter 
116:    LDA  1,-3(1) 	Load address of new frame 
117:    LDA  3,1(7) 	Return address in ac 
118:    LDA  7,-113(7) 	CALL output
119:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
120:     ST  1,-3(1) 	Store old frame in ghost frame 
121:     LD  3,-3(1) 	Load variable m
122:    MUL  3,4,3 	Op * 
123:     ST  3,-5(1) 	Store parameter 
124:    LDA  1,-3(1) 	Load address of new frame 
125:    LDA  3,1(7) 	Return address in ac 
126:    LDA  7,-121(7) 	CALL output
127:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
128:     ST  1,-3(1) 	Store old frame in ghost frame 
129:    LDC  3,0(6) 	Load constant 
130:     ST  3,-5(1) 	Save index 
131:     ST  3,-6(1) 	Store parameter 
132:    LDA  1,-3(1) 	Load address of new frame 
133:    LDA  3,1(7) 	Return address in ac 
134:    LDA  7,-129(7) 	CALL output
135:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
136:     ST  1,-3(1) 	Store old frame in ghost frame 
137:     LD  3,-1(1) 	Load variable g
138:    MUL  3,4,3 	Op * 
139:     ST  3,-5(1) 	Store parameter 
140:    LDA  1,-3(1) 	Load address of new frame 
141:    LDA  3,1(7) 	Return address in ac 
142:    LDA  7,-137(7) 	CALL output
143:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
144:     ST  1,-3(1) 	Store old frame in ghost frame 
145:    LDA  1,-3(1) 	Load address of new frame 
146:    LDA  3,1(7) 	Return address in ac 
147:    LDA  7,-123(7) 	CALL outnl
148:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
149:     ST  1,-3(1) 	Store old frame in ghost frame 
150:     LD  3,-3(1) 	Load variable m
151:     ST  3,-5(1) 	Store parameter 
152:    LDA  1,-3(1) 	Load address of new frame 
153:    LDA  3,1(7) 	Return address in ac 
154:    LDA  7,-125(7) 	CALL ford
155:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
156:     ST  1,-3(1) 	Store old frame in ghost frame 
157:     LD  3,-1(1) 	Load variable g
158:     ST  3,-5(1) 	Store parameter 
159:    LDA  1,-3(1) 	Load address of new frame 
160:    LDA  3,1(7) 	Return address in ac 
161:    LDA  7,-132(7) 	CALL ford
162:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
163:     ST  1,-3(1) 	Store old frame in ghost frame 
164:     LD  3,-3(1) 	Load variable m
165:    MUL  3,4,3 	Op * 
166:     ST  3,-5(1) 	Save left side 
167:     LD  3,-1(1) 	Load variable g
168:    MUL  3,4,3 	Op * 
169:     LD  4,-5(1) 	Load left into ac1 
170:    MUL  3,4,3 	Op * 
171:     ST  3,-5(1) 	Store parameter 
172:    LDA  1,-3(1) 	Load address of new frame 
173:    LDA  3,1(7) 	Return address in ac 
174:    LDA  7,-169(7) 	CALL output
175:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
176:     ST  1,-3(1) 	Store old frame in ghost frame 
177:    LDA  1,-3(1) 	Load address of new frame 
178:    LDA  3,1(7) 	Return address in ac 
179:    LDA  7,-155(7) 	CALL outnl
180:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
181:    LDC  2,0(6) 	Set return value to 0 
182:     LD  3,-1(1) 	Load return address 
183:     LD  1,0(1) 	Adjust fp 
184:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,184(7) 	Jump to init 
* BEGIN Init
185:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
186:    LDC  3,0(6) 	load size of array g
187:     ST  3,-1(0) 	save size of array g
* END init of global array sizes
188:    LDA  1,-1(0) 	set first frame at end of globals 
189:     ST  1,0(1) 	store old fp (point to self) 
190:    LDA  3,1(7) 	Return address in ac 
191:    LDA  7,-87(7) 	Jump to main 
192:   HALT  0,0,0 	DONE! 
* END Init
