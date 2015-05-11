* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  compare.tm
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
 32:    LDC  3,1(6) 	Load constant 
 33:     ST  3,-4(1) 	Save left side 
 34:    LDC  3,2(6) 	Load constant 
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
 46:    LDC  3,2(6) 	Load constant 
 47:     ST  3,-4(1) 	Save left side 
 48:    LDC  3,2(6) 	Load constant 
 49:     LD  4,-4(1) 	Load left into ac1 
 50:    SUB  4,4,3 	Op < 
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
 60:    LDC  3,3(6) 	Load constant 
 61:     ST  3,-4(1) 	Save left side 
 62:    LDC  3,2(6) 	Load constant 
 63:     LD  4,-4(1) 	Load left into ac1 
 64:    SUB  4,4,3 	Op < 
 65:    LDC  3,1(6) 	True case 
 66:    JLT  4,1(7) 	Jump if true 
 67:    LDC  3,0(6) 	False case 
 68:     ST  3,-4(1) 	Store parameter 
 69:    LDA  1,-2(1) 	Load address of new frame 
 70:    LDA  3,1(7) 	Return address in ac 
 71:    LDA  7,-54(7) 	CALL outputb
 72:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 73:     ST  1,-2(1) 	Store old frame in ghost frame 
 74:    LDC  3,1(6) 	Load constant 
 75:     ST  3,-4(1) 	Save left side 
 76:    LDC  3,2(6) 	Load constant 
 77:     LD  4,-4(1) 	Load left into ac1 
 78:    SUB  4,4,3 	Op == 
 79:    LDC  3,1(6) 	True case 
 80:    JEQ  4,1(7) 	Jump if true 
 81:    LDC  3,0(6) 	False case 
 82:     ST  3,-4(1) 	Store parameter 
 83:    LDA  1,-2(1) 	Load address of new frame 
 84:    LDA  3,1(7) 	Return address in ac 
 85:    LDA  7,-68(7) 	CALL outputb
 86:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 87:     ST  1,-2(1) 	Store old frame in ghost frame 
 88:    LDC  3,2(6) 	Load constant 
 89:     ST  3,-4(1) 	Save left side 
 90:    LDC  3,2(6) 	Load constant 
 91:     LD  4,-4(1) 	Load left into ac1 
 92:    SUB  4,4,3 	Op == 
 93:    LDC  3,1(6) 	True case 
 94:    JEQ  4,1(7) 	Jump if true 
 95:    LDC  3,0(6) 	False case 
 96:     ST  3,-4(1) 	Store parameter 
 97:    LDA  1,-2(1) 	Load address of new frame 
 98:    LDA  3,1(7) 	Return address in ac 
 99:    LDA  7,-82(7) 	CALL outputb
100:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
101:     ST  1,-2(1) 	Store old frame in ghost frame 
102:    LDC  3,3(6) 	Load constant 
103:     ST  3,-4(1) 	Save left side 
104:    LDC  3,2(6) 	Load constant 
105:     LD  4,-4(1) 	Load left into ac1 
106:    SUB  4,4,3 	Op == 
107:    LDC  3,1(6) 	True case 
108:    JEQ  4,1(7) 	Jump if true 
109:    LDC  3,0(6) 	False case 
110:     ST  3,-4(1) 	Store parameter 
111:    LDA  1,-2(1) 	Load address of new frame 
112:    LDA  3,1(7) 	Return address in ac 
113:    LDA  7,-96(7) 	CALL outputb
114:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
115:     ST  1,-2(1) 	Store old frame in ghost frame 
116:    LDC  3,1(6) 	Load constant 
117:     ST  3,-4(1) 	Save left side 
118:    LDC  3,2(6) 	Load constant 
119:     LD  4,-4(1) 	Load left into ac1 
120:    SUB  4,4,3 	Op > 
121:    LDC  3,1(6) 	True case 
122:    JLT  4,1(7) 	Jump if true 
123:    LDC  3,0(6) 	False case 
124:     ST  3,-4(1) 	Store parameter 
125:    LDA  1,-2(1) 	Load address of new frame 
126:    LDA  3,1(7) 	Return address in ac 
127:    LDA  7,-110(7) 	CALL outputb
128:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
129:     ST  1,-2(1) 	Store old frame in ghost frame 
130:    LDC  3,2(6) 	Load constant 
131:     ST  3,-4(1) 	Save left side 
132:    LDC  3,2(6) 	Load constant 
133:     LD  4,-4(1) 	Load left into ac1 
134:    SUB  4,4,3 	Op > 
135:    LDC  3,1(6) 	True case 
136:    JLT  4,1(7) 	Jump if true 
137:    LDC  3,0(6) 	False case 
138:     ST  3,-4(1) 	Store parameter 
139:    LDA  1,-2(1) 	Load address of new frame 
140:    LDA  3,1(7) 	Return address in ac 
141:    LDA  7,-124(7) 	CALL outputb
142:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
143:     ST  1,-2(1) 	Store old frame in ghost frame 
144:    LDC  3,3(6) 	Load constant 
145:     ST  3,-4(1) 	Save left side 
146:    LDC  3,2(6) 	Load constant 
147:     LD  4,-4(1) 	Load left into ac1 
148:    SUB  4,4,3 	Op > 
149:    LDC  3,1(6) 	True case 
150:    JLT  4,1(7) 	Jump if true 
151:    LDC  3,0(6) 	False case 
152:     ST  3,-4(1) 	Store parameter 
153:    LDA  1,-2(1) 	Load address of new frame 
154:    LDA  3,1(7) 	Return address in ac 
155:    LDA  7,-138(7) 	CALL outputb
156:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
157:     ST  1,-2(1) 	Store old frame in ghost frame 
158:    LDC  3,1(6) 	Load constant 
159:     ST  3,-4(1) 	Save left side 
160:    LDC  3,2(6) 	Load constant 
161:     LD  4,-4(1) 	Load left into ac1 
162:     ST  3,-4(1) 	Store parameter 
163:    LDA  1,-2(1) 	Load address of new frame 
164:    LDA  3,1(7) 	Return address in ac 
165:    LDA  7,-148(7) 	CALL outputb
166:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
167:     ST  1,-2(1) 	Store old frame in ghost frame 
168:    LDC  3,2(6) 	Load constant 
169:     ST  3,-4(1) 	Save left side 
170:    LDC  3,2(6) 	Load constant 
171:     LD  4,-4(1) 	Load left into ac1 
172:     ST  3,-4(1) 	Store parameter 
173:    LDA  1,-2(1) 	Load address of new frame 
174:    LDA  3,1(7) 	Return address in ac 
175:    LDA  7,-158(7) 	CALL outputb
176:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
177:     ST  1,-2(1) 	Store old frame in ghost frame 
178:    LDC  3,3(6) 	Load constant 
179:     ST  3,-4(1) 	Save left side 
180:    LDC  3,2(6) 	Load constant 
181:     LD  4,-4(1) 	Load left into ac1 
182:     ST  3,-4(1) 	Store parameter 
183:    LDA  1,-2(1) 	Load address of new frame 
184:    LDA  3,1(7) 	Return address in ac 
185:    LDA  7,-168(7) 	CALL outputb
186:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
187:     ST  1,-2(1) 	Store old frame in ghost frame 
188:    LDC  3,1(6) 	Load constant 
189:     ST  3,-4(1) 	Save left side 
190:    LDC  3,2(6) 	Load constant 
191:     LD  4,-4(1) 	Load left into ac1 
192:     ST  3,-4(1) 	Store parameter 
193:    LDA  1,-2(1) 	Load address of new frame 
194:    LDA  3,1(7) 	Return address in ac 
195:    LDA  7,-178(7) 	CALL outputb
196:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
197:     ST  1,-2(1) 	Store old frame in ghost frame 
198:    LDC  3,2(6) 	Load constant 
199:     ST  3,-4(1) 	Save left side 
200:    LDC  3,2(6) 	Load constant 
201:     LD  4,-4(1) 	Load left into ac1 
202:     ST  3,-4(1) 	Store parameter 
203:    LDA  1,-2(1) 	Load address of new frame 
204:    LDA  3,1(7) 	Return address in ac 
205:    LDA  7,-188(7) 	CALL outputb
206:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
207:     ST  1,-2(1) 	Store old frame in ghost frame 
208:    LDC  3,3(6) 	Load constant 
209:     ST  3,-4(1) 	Save left side 
210:    LDC  3,2(6) 	Load constant 
211:     LD  4,-4(1) 	Load left into ac1 
212:     ST  3,-4(1) 	Store parameter 
213:    LDA  1,-2(1) 	Load address of new frame 
214:    LDA  3,1(7) 	Return address in ac 
215:    LDA  7,-198(7) 	CALL outputb
216:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
217:     ST  1,-2(1) 	Store old frame in ghost frame 
218:    LDC  3,1(6) 	Load constant 
219:     ST  3,-4(1) 	Save left side 
220:    LDC  3,2(6) 	Load constant 
221:     LD  4,-4(1) 	Load left into ac1 
222:     ST  3,-4(1) 	Store parameter 
223:    LDA  1,-2(1) 	Load address of new frame 
224:    LDA  3,1(7) 	Return address in ac 
225:    LDA  7,-208(7) 	CALL outputb
226:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
227:     ST  1,-2(1) 	Store old frame in ghost frame 
228:    LDC  3,2(6) 	Load constant 
229:     ST  3,-4(1) 	Save left side 
230:    LDC  3,2(6) 	Load constant 
231:     LD  4,-4(1) 	Load left into ac1 
232:     ST  3,-4(1) 	Store parameter 
233:    LDA  1,-2(1) 	Load address of new frame 
234:    LDA  3,1(7) 	Return address in ac 
235:    LDA  7,-218(7) 	CALL outputb
236:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
237:     ST  1,-2(1) 	Store old frame in ghost frame 
238:    LDC  3,3(6) 	Load constant 
239:     ST  3,-4(1) 	Save left side 
240:    LDC  3,2(6) 	Load constant 
241:     LD  4,-4(1) 	Load left into ac1 
242:     ST  3,-4(1) 	Store parameter 
243:    LDA  1,-2(1) 	Load address of new frame 
244:    LDA  3,1(7) 	Return address in ac 
245:    LDA  7,-228(7) 	CALL outputb
246:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
247:    LDC  2,0(6) 	Set return value to 0 
248:     LD  3,-1(1) 	Load return address 
249:     LD  1,0(1) 	Adjust fp 
250:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,250(7) 	Jump to init 
* BEGIN Init
251:     LD  0,0(0) 	Set the global pointer 
252:    LDA  1,0(0) 	set first frame at end of globals 
253:     ST  1,0(1) 	store old fp (point to self) 
254:    LDA  3,1(7) 	Return address in ac 
255:    LDA  7,-226(7) 	Jump to main 
256:   HALT  0,0,0 	DONE! 
* END Init
