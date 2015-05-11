* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  exp3.c-
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
 31:    LDC  3,1(6) 	Load constant 
 32:     ST  3,-3(1) 	Store variable bilbo
* EXPRESSION STMT
 33:    LDC  3,10(6) 	Load constant 
 34:     ST  3,-2(1) 	Store variable frodo
* EXPRESSION STMT
 35:    LDC  3,100(6) 	Load constant 
 36:     ST  3,-4(1) 	Store variable sam
* EXPRESSION STMT
 37:    LDC  3,1000(6) 	Load constant 
 38:     ST  3,-5(1) 	Store variable merry
* EXPRESSION STMT
 39:    LDC  3,10000(6) 	Load constant 
 40:     ST  3,-6(1) 	Store variable pippin
* EXPRESSION STMT
 41:     LD  3,-3(1) 	Load variable bilbo
 42:     ST  3,-3(1) 	Store variable bilbo
* EXPRESSION STMT
 43:     ST  1,-8(1) 	Store old fp in ghost frame 
 44:     LD  3,-3(1) 	Load variable bilbo
 45:     ST  3,-10(1) 	Store parameter 
 46:    LDA  1,-8(1) 	Load address of new frame 
 47:    LDA  3,1(7) 	Return address in ac 
 48:    LDA  7,-43(7) 	CALL output
 49:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 50:     ST  1,-8(1) 	Store old fp in ghost frame 
 51:    LDA  1,-8(1) 	Load address of new frame 
 52:    LDA  3,1(7) 	Return address in ac 
 53:    LDA  7,-29(7) 	CALL outnl
 54:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 55:     LD  3,-3(1) 	Load variable bilbo
 56:     ST  3,-8(1) 	Save left side 
 57:    LDC  3,1(6) 	Load constant 
 58:     LD  4,-8(1) 	Load left into ac1 
 59:    ADD  3,4,3 	Op + 
 60:     ST  3,-3(1) 	Store variable bilbo
* EXPRESSION STMT
 61:     ST  1,-8(1) 	Store old fp in ghost frame 
 62:     LD  3,-3(1) 	Load variable bilbo
 63:     ST  3,-10(1) 	Store parameter 
 64:    LDA  1,-8(1) 	Load address of new frame 
 65:    LDA  3,1(7) 	Return address in ac 
 66:    LDA  7,-61(7) 	CALL output
 67:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 68:     ST  1,-8(1) 	Store old fp in ghost frame 
 69:    LDA  1,-8(1) 	Load address of new frame 
 70:    LDA  3,1(7) 	Return address in ac 
 71:    LDA  7,-47(7) 	CALL outnl
 72:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 73:     LD  3,-2(1) 	Load variable frodo
 74:     ST  3,-8(1) 	Save left side 
 75:     LD  3,-3(1) 	Load variable bilbo
 76:     ST  3,-9(1) 	Save left side 
 77:     LD  3,-4(1) 	Load variable sam
 78:     ST  3,-10(1) 	Save left side 
 79:     LD  3,-5(1) 	Load variable merry
 80:     ST  3,-11(1) 	Save left side 
 81:     LD  3,-6(1) 	Load variable pippin
 82:     LD  4,-11(1) 	Load left into ac1 
 83:    MUL  3,4,3 	Op * 
 84:     LD  4,-10(1) 	Load left into ac1 
 85:    ADD  3,4,3 	Op + 
 86:     LD  4,-9(1) 	Load left into ac1 
 87:    MUL  3,4,3 	Op * 
 88:     LD  4,-8(1) 	Load left into ac1 
 89:    ADD  3,4,3 	Op + 
 90:     ST  3,-3(1) 	Store variable bilbo
* EXPRESSION STMT
 91:     ST  1,-8(1) 	Store old fp in ghost frame 
 92:     LD  3,-3(1) 	Load variable bilbo
 93:     ST  3,-10(1) 	Store parameter 
 94:    LDA  1,-8(1) 	Load address of new frame 
 95:    LDA  3,1(7) 	Return address in ac 
 96:    LDA  7,-91(7) 	CALL output
 97:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 98:     ST  1,-8(1) 	Store old fp in ghost frame 
 99:    LDA  1,-8(1) 	Load address of new frame 
100:    LDA  3,1(7) 	Return address in ac 
101:    LDA  7,-77(7) 	CALL outnl
102:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
103:     LD  3,-5(1) 	Load variable merry
104:     ST  3,-8(1) 	Save left side 
105:     LD  3,-6(1) 	Load variable pippin
106:     LD  4,-8(1) 	Load left into ac1 
107:    MUL  3,4,3 	Op * 
108:     ST  3,-8(1) 	Save left side 
109:     LD  3,-4(1) 	Load variable sam
110:     LD  4,-8(1) 	Load left into ac1 
111:    ADD  3,4,3 	Op + 
112:     ST  3,-8(1) 	Save left side 
113:     LD  3,-3(1) 	Load variable bilbo
114:     LD  4,-8(1) 	Load left into ac1 
115:    MUL  3,4,3 	Op * 
116:     ST  3,-8(1) 	Save left side 
117:     LD  3,-2(1) 	Load variable frodo
118:     LD  4,-8(1) 	Load left into ac1 
119:    ADD  3,4,3 	Op + 
120:     ST  3,-3(1) 	Store variable bilbo
* EXPRESSION STMT
121:     ST  1,-8(1) 	Store old fp in ghost frame 
122:     LD  3,-3(1) 	Load variable bilbo
123:     ST  3,-10(1) 	Store parameter 
124:    LDA  1,-8(1) 	Load address of new frame 
125:    LDA  3,1(7) 	Return address in ac 
126:    LDA  7,-121(7) 	CALL output
127:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
128:     ST  1,-8(1) 	Store old fp in ghost frame 
129:    LDA  1,-8(1) 	Load address of new frame 
130:    LDA  3,1(7) 	Return address in ac 
131:    LDA  7,-107(7) 	CALL outnl
132:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
133:     LD  3,-3(1) 	Load variable bilbo
134:     ST  3,-8(1) 	Save left side 
135:     LD  3,-3(1) 	Load variable bilbo
136:     ST  3,-9(1) 	Save left side 
137:     LD  3,-3(1) 	Load variable bilbo
138:     ST  3,-10(1) 	Save left side 
139:     LD  3,-3(1) 	Load variable bilbo
140:     ST  3,-11(1) 	Save left side 
141:     LD  3,-3(1) 	Load variable bilbo
142:     ST  3,-12(1) 	Save left side 
143:     LD  3,-3(1) 	Load variable bilbo
144:     LD  4,-12(1) 	Load left into ac1 
145:    ADD  3,4,3 	Op + 
146:     LD  4,-11(1) 	Load left into ac1 
147:    SUB  3,4,3 	Op - 
148:     LD  4,-10(1) 	Load left into ac1 
149:    ADD  3,4,3 	Op + 
150:     LD  4,-9(1) 	Load left into ac1 
151:    SUB  3,4,3 	Op - 
152:     LD  4,-8(1) 	Load left into ac1 
153:    ADD  3,4,3 	Op + 
154:     ST  3,-3(1) 	Store variable bilbo
* EXPRESSION STMT
155:     ST  1,-8(1) 	Store old fp in ghost frame 
156:     LD  3,-3(1) 	Load variable bilbo
157:     ST  3,-10(1) 	Store parameter 
158:    LDA  1,-8(1) 	Load address of new frame 
159:    LDA  3,1(7) 	Return address in ac 
160:    LDA  7,-155(7) 	CALL output
161:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
162:     ST  1,-8(1) 	Store old fp in ghost frame 
163:    LDA  1,-8(1) 	Load address of new frame 
164:    LDA  3,1(7) 	Return address in ac 
165:    LDA  7,-141(7) 	CALL outnl
166:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
167:    LDC  3,1(6) 	Load constant 
168:     ST  3,-7(1) 	Store variable arwen
* EXPRESSION STMT
169:    LDC  3,0(6) 	Load constant 
170:     ST  3,-8(1) 	Save left side 
171:     LD  3,-7(1) 	Load variable arwen
172:     ST  3,-9(1) 	Save left side 
173:     LD  3,-5(1) 	Load variable merry
174:    LDC  4,0(6) 	Load 0 
175:    SUB  3,4,3 	Op unary - 
176:     ST  3,-10(1) 	Save left side 
177:     LD  3,-4(1) 	Load variable sam
178:    LDC  4,0(6) 	Load 0 
179:    SUB  3,4,3 	Op unary - 
180:     LD  4,-10(1) 	Load left into ac1 
181:    MUL  3,4,3 	Op * 
182:     ST  3,-10(1) 	Save left side 
183:     LD  3,-6(1) 	Load variable pippin
184:     LD  4,-10(1) 	Load left into ac1 
185:    ADD  3,4,3 	Op + 
186:     ST  3,-10(1) 	Save left side 
187:     LD  3,-3(1) 	Load variable bilbo
188:     ST  3,-11(1) 	Save left side 
189:     LD  3,-2(1) 	Load variable frodo
190:     ST  3,-12(1) 	Save left side 
191:     LD  3,-2(1) 	Load variable frodo
192:    LDC  4,0(6) 	Load 0 
193:    SUB  3,4,3 	Op unary - 
194:     LD  4,-12(1) 	Load left into ac1 
195:    MUL  3,4,3 	Op * 
196:     LD  4,-11(1) 	Load left into ac1 
197:    ADD  3,4,3 	Op + 
198:     LD  4,-10(1) 	Load left into ac1 
199:    SUB  4,4,3 	Op >= 
200:    LDC  3,1(6) 	True case 
201:    JGE  4,1(7) 	Jump if true 
202:    LDC  3,0(6) 	False case 
203:    LDC  4,1(6) 	Load 1 
204:    SUB  3,4,3 	Op NOT 
205:     LD  4,-9(1) 	Load left into ac1 
206:    JEQ  3,1(7) 	Op AND 
207:    LDA  3,0(4) 	 
208:     LD  4,-8(1) 	Load left into ac1 
209:    JGT  3,1(7) 	Op OR 
210:    LDA  3,0(4) 	 
211:     ST  3,-7(1) 	Store variable arwen
* EXPRESSION STMT
212:     ST  1,-8(1) 	Store old fp in ghost frame 
213:     LD  3,-7(1) 	Load variable arwen
214:     ST  3,-10(1) 	Store parameter 
215:    LDA  1,-8(1) 	Load address of new frame 
216:    LDA  3,1(7) 	Return address in ac 
217:    LDA  7,-200(7) 	CALL outputb
218:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
219:     ST  1,-8(1) 	Store old fp in ghost frame 
220:    LDA  1,-8(1) 	Load address of new frame 
221:    LDA  3,1(7) 	Return address in ac 
222:    LDA  7,-198(7) 	CALL outnl
223:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
224:    LDC  2,0(6) 	Set return value to 0 
225:     LD  3,-1(1) 	Load return address 
226:     LD  1,0(1) 	Adjust fp 
227:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,227(7) 	Jump to init 
* BEGIN Init
228:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
229:    LDA  1,0(0) 	set first frame at end of globals 
230:     ST  1,0(1) 	store old fp (point to self) 
231:    LDA  3,1(7) 	Return address in ac 
232:    LDA  7,-203(7) 	Jump to main 
233:   HALT  0,0,0 	DONE! 
* END Init
