* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  e05.tm
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
* IfK:
* IfK: t->child[0] condition
 31:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* IfK:
* IfK: t->child[0] condition
 33:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* EXPRESSION STMT
 35:     ST  1,-2(1) 	Store old frame in ghost frame 
 36:    LDC  3,13(6) 	Load constant 
 37:     ST  3,-4(1) 	Store parameter 
 38:    LDA  1,-2(1) 	Load address of new frame 
 39:    LDA  3,1(7) 	Return address in ac 
 40:    LDA  7,-35(7) 	CALL output
 41:    LDA  3,0(2) 	Save the result in ac 
 34:    JEQ  3,8(7) 	if: jmp to else 
* IfK: t->child[2] else part
 42:    LDA  7,0(7) 	jmp to end 
* ENDIF
 32:    JEQ  3,11(7) 	if: jmp to else 
* IfK: t->child[2] else part
 43:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
 44:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* IfK:
* IfK: t->child[0] condition
 46:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* EXPRESSION STMT
 48:     ST  1,-2(1) 	Store old frame in ghost frame 
 49:    LDC  3,23(6) 	Load constant 
 50:     ST  3,-4(1) 	Store parameter 
 51:    LDA  1,-2(1) 	Load address of new frame 
 52:    LDA  3,1(7) 	Return address in ac 
 53:    LDA  7,-48(7) 	CALL output
 54:    LDA  3,0(2) 	Save the result in ac 
 47:    JEQ  3,8(7) 	if: jmp to else 
* IfK: t->child[2] else part
 55:    LDA  7,0(7) 	jmp to end 
* ENDIF
 45:    JEQ  3,11(7) 	if: jmp to else 
* IfK: t->child[2] else part
 56:    LDA  7,0(7) 	jmp to end 
* ENDIF
* EXPRESSION STMT
 57:    LDC  3,0(6) 	Load constant 
 58:     ST  3,0(1) 	Store variable x
* IfK:
* IfK: t->child[0] condition
 59:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* IfK:
* IfK: t->child[0] condition
 61:     LD  3,0(1) 	Load variable x
* IfK: t->child[1] then part
* EXPRESSION STMT
 63:     ST  1,-2(1) 	Store old frame in ghost frame 
 64:    LDC  3,44(6) 	Load constant 
 65:     ST  3,-4(1) 	Store parameter 
 66:    LDA  1,-2(1) 	Load address of new frame 
 67:    LDA  3,1(7) 	Return address in ac 
 68:    LDA  7,-63(7) 	CALL output
 69:    LDA  3,0(2) 	Save the result in ac 
 62:    JEQ  3,8(7) 	if: jmp to else 
* IfK: t->child[2] else part
 70:    LDA  7,0(7) 	jmp to end 
* ENDIF
 60:    JEQ  3,11(7) 	if: jmp to else 
* IfK: t->child[2] else part
 71:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
 72:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* IfK:
* IfK: t->child[0] condition
 74:     LD  3,0(1) 	Load variable x
* IfK: t->child[1] then part
* EXPRESSION STMT
 76:     ST  1,-2(1) 	Store old frame in ghost frame 
 77:    LDC  3,55(6) 	Load constant 
 78:     ST  3,-4(1) 	Store parameter 
 79:    LDA  1,-2(1) 	Load address of new frame 
 80:    LDA  3,1(7) 	Return address in ac 
 81:    LDA  7,-76(7) 	CALL output
 82:    LDA  3,0(2) 	Save the result in ac 
 75:    JEQ  3,8(7) 	if: jmp to else 
* IfK: t->child[2] else part
 83:    LDA  7,0(7) 	jmp to end 
* ENDIF
 73:    JEQ  3,11(7) 	if: jmp to else 
* IfK: t->child[2] else part
 84:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
 85:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* IfK:
* IfK: t->child[0] condition
 87:    LDC  3,3(6) 	Load constant 
 88:     ST  3,-2(1) 	Save left side 
 89:    LDC  3,1(6) 	Load constant 
 90:     LD  4,-2(1) 	Load left into ac1 
 91:    SUB  4,4,3 	Op > 
 92:    LDC  3,1(6) 	True case 
 93:    JLT  4,1(7) 	Jump if true 
 94:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
* EXPRESSION STMT
 96:     ST  1,-2(1) 	Store old frame in ghost frame 
 97:    LDC  3,987(6) 	Load constant 
 98:     ST  3,-4(1) 	Store parameter 
 99:    LDA  1,-2(1) 	Load address of new frame 
100:    LDA  3,1(7) 	Return address in ac 
101:    LDA  7,-96(7) 	CALL output
102:    LDA  3,0(2) 	Save the result in ac 
 95:    JEQ  3,8(7) 	if: jmp to else 
* IfK: t->child[2] else part
103:    LDA  7,0(7) 	jmp to end 
* ENDIF
 86:    JEQ  3,18(7) 	if: jmp to else 
* IfK: t->child[2] else part
104:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
105:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* IfK:
* IfK: t->child[0] condition
107:    LDC  3,3(6) 	Load constant 
108:     ST  3,-2(1) 	Save left side 
109:    LDC  3,1(6) 	Load constant 
110:     LD  4,-2(1) 	Load left into ac1 
111:    SUB  4,4,3 	Op < 
112:    LDC  3,1(6) 	True case 
113:    JLT  4,1(7) 	Jump if true 
114:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
* EXPRESSION STMT
116:     ST  1,-2(1) 	Store old frame in ghost frame 
117:    LDC  3,211(6) 	Load constant 
118:     ST  3,-4(1) 	Store parameter 
119:    LDA  1,-2(1) 	Load address of new frame 
120:    LDA  3,1(7) 	Return address in ac 
121:    LDA  7,-116(7) 	CALL output
122:    LDA  3,0(2) 	Save the result in ac 
115:    JEQ  3,8(7) 	if: jmp to else 
* IfK: t->child[2] else part
123:    LDA  7,0(7) 	jmp to end 
* ENDIF
106:    JEQ  3,18(7) 	if: jmp to else 
* IfK: t->child[2] else part
124:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
125:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* IfK:
* IfK: t->child[0] condition
127:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* EXPRESSION STMT
129:     ST  1,-2(1) 	Store old frame in ghost frame 
130:    LDC  3,13(6) 	Load constant 
131:     ST  3,-4(1) 	Store parameter 
132:    LDA  1,-2(1) 	Load address of new frame 
133:    LDA  3,1(7) 	Return address in ac 
134:    LDA  7,-129(7) 	CALL output
135:    LDA  3,0(2) 	Save the result in ac 
128:    JEQ  3,8(7) 	if: jmp to else 
* IfK: t->child[2] else part
* EXPRESSION STMT
137:     ST  1,-2(1) 	Store old frame in ghost frame 
138:    LDC  3,51(6) 	Load constant 
139:     ST  3,-4(1) 	Store parameter 
140:    LDA  1,-2(1) 	Load address of new frame 
141:    LDA  3,1(7) 	Return address in ac 
142:    LDA  7,-137(7) 	CALL output
143:    LDA  3,0(2) 	Save the result in ac 
136:    LDA  7,7(7) 	jmp to end 
* ENDIF
126:    JEQ  3,18(7) 	if: jmp to else 
* IfK: t->child[2] else part
144:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
145:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* IfK:
* IfK: t->child[0] condition
147:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* EXPRESSION STMT
149:     ST  1,-2(1) 	Store old frame in ghost frame 
150:    LDC  3,23(6) 	Load constant 
151:     ST  3,-4(1) 	Store parameter 
152:    LDA  1,-2(1) 	Load address of new frame 
153:    LDA  3,1(7) 	Return address in ac 
154:    LDA  7,-149(7) 	CALL output
155:    LDA  3,0(2) 	Save the result in ac 
148:    JEQ  3,8(7) 	if: jmp to else 
* IfK: t->child[2] else part
* EXPRESSION STMT
157:     ST  1,-2(1) 	Store old frame in ghost frame 
158:    LDC  3,451(6) 	Load constant 
159:     ST  3,-4(1) 	Store parameter 
160:    LDA  1,-2(1) 	Load address of new frame 
161:    LDA  3,1(7) 	Return address in ac 
162:    LDA  7,-157(7) 	CALL output
163:    LDA  3,0(2) 	Save the result in ac 
156:    LDA  7,7(7) 	jmp to end 
* ENDIF
146:    JEQ  3,18(7) 	if: jmp to else 
* IfK: t->child[2] else part
164:    LDA  7,0(7) 	jmp to end 
* ENDIF
* EXPRESSION STMT
165:    LDC  3,0(6) 	Load constant 
166:     ST  3,0(1) 	Store variable x
* IfK:
* IfK: t->child[0] condition
167:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* IfK:
* IfK: t->child[0] condition
169:     LD  3,0(1) 	Load variable x
* IfK: t->child[1] then part
* EXPRESSION STMT
171:     ST  1,-2(1) 	Store old frame in ghost frame 
172:    LDC  3,44(6) 	Load constant 
173:     ST  3,-4(1) 	Store parameter 
174:    LDA  1,-2(1) 	Load address of new frame 
175:    LDA  3,1(7) 	Return address in ac 
176:    LDA  7,-171(7) 	CALL output
177:    LDA  3,0(2) 	Save the result in ac 
170:    JEQ  3,8(7) 	if: jmp to else 
* IfK: t->child[2] else part
* EXPRESSION STMT
179:     ST  1,-2(1) 	Store old frame in ghost frame 
180:    LDC  3,514(6) 	Load constant 
181:     ST  3,-4(1) 	Store parameter 
182:    LDA  1,-2(1) 	Load address of new frame 
183:    LDA  3,1(7) 	Return address in ac 
184:    LDA  7,-179(7) 	CALL output
185:    LDA  3,0(2) 	Save the result in ac 
178:    LDA  7,7(7) 	jmp to end 
* ENDIF
168:    JEQ  3,18(7) 	if: jmp to else 
* IfK: t->child[2] else part
186:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
187:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* IfK:
* IfK: t->child[0] condition
189:     LD  3,0(1) 	Load variable x
* IfK: t->child[1] then part
* EXPRESSION STMT
191:     ST  1,-2(1) 	Store old frame in ghost frame 
192:    LDC  3,55(6) 	Load constant 
193:     ST  3,-4(1) 	Store parameter 
194:    LDA  1,-2(1) 	Load address of new frame 
195:    LDA  3,1(7) 	Return address in ac 
196:    LDA  7,-191(7) 	CALL output
197:    LDA  3,0(2) 	Save the result in ac 
190:    JEQ  3,8(7) 	if: jmp to else 
* IfK: t->child[2] else part
* EXPRESSION STMT
199:     ST  1,-2(1) 	Store old frame in ghost frame 
200:    LDC  3,1514(6) 	Load constant 
201:     ST  3,-4(1) 	Store parameter 
202:    LDA  1,-2(1) 	Load address of new frame 
203:    LDA  3,1(7) 	Return address in ac 
204:    LDA  7,-199(7) 	CALL output
205:    LDA  3,0(2) 	Save the result in ac 
198:    LDA  7,7(7) 	jmp to end 
* ENDIF
188:    JEQ  3,18(7) 	if: jmp to else 
* IfK: t->child[2] else part
206:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
207:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* IfK:
* IfK: t->child[0] condition
209:    LDC  3,3(6) 	Load constant 
210:     ST  3,-2(1) 	Save left side 
211:    LDC  3,1(6) 	Load constant 
212:     LD  4,-2(1) 	Load left into ac1 
213:    SUB  4,4,3 	Op > 
214:    LDC  3,1(6) 	True case 
215:    JLT  4,1(7) 	Jump if true 
216:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
* EXPRESSION STMT
218:     ST  1,-2(1) 	Store old frame in ghost frame 
219:    LDC  3,987(6) 	Load constant 
220:     ST  3,-4(1) 	Store parameter 
221:    LDA  1,-2(1) 	Load address of new frame 
222:    LDA  3,1(7) 	Return address in ac 
223:    LDA  7,-218(7) 	CALL output
224:    LDA  3,0(2) 	Save the result in ac 
217:    JEQ  3,8(7) 	if: jmp to else 
* IfK: t->child[2] else part
* EXPRESSION STMT
226:     ST  1,-2(1) 	Store old frame in ghost frame 
227:    LDC  3,114(6) 	Load constant 
228:     ST  3,-4(1) 	Store parameter 
229:    LDA  1,-2(1) 	Load address of new frame 
230:    LDA  3,1(7) 	Return address in ac 
231:    LDA  7,-226(7) 	CALL output
232:    LDA  3,0(2) 	Save the result in ac 
225:    LDA  7,7(7) 	jmp to end 
* ENDIF
208:    JEQ  3,25(7) 	if: jmp to else 
* IfK: t->child[2] else part
233:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
234:    LDC  3,0(6) 	Load constant 
* IfK: t->child[1] then part
* IfK:
* IfK: t->child[0] condition
236:    LDC  3,3(6) 	Load constant 
237:     ST  3,-2(1) 	Save left side 
238:    LDC  3,1(6) 	Load constant 
239:     LD  4,-2(1) 	Load left into ac1 
240:    SUB  4,4,3 	Op < 
241:    LDC  3,1(6) 	True case 
242:    JLT  4,1(7) 	Jump if true 
243:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
* EXPRESSION STMT
245:     ST  1,-2(1) 	Store old frame in ghost frame 
246:    LDC  3,211(6) 	Load constant 
247:     ST  3,-4(1) 	Store parameter 
248:    LDA  1,-2(1) 	Load address of new frame 
249:    LDA  3,1(7) 	Return address in ac 
250:    LDA  7,-245(7) 	CALL output
251:    LDA  3,0(2) 	Save the result in ac 
244:    JEQ  3,8(7) 	if: jmp to else 
* IfK: t->child[2] else part
* EXPRESSION STMT
253:     ST  1,-2(1) 	Store old frame in ghost frame 
254:    LDC  3,1614(6) 	Load constant 
255:     ST  3,-4(1) 	Store parameter 
256:    LDA  1,-2(1) 	Load address of new frame 
257:    LDA  3,1(7) 	Return address in ac 
258:    LDA  7,-253(7) 	CALL output
259:    LDA  3,0(2) 	Save the result in ac 
252:    LDA  7,7(7) 	jmp to end 
* ENDIF
235:    JEQ  3,25(7) 	if: jmp to else 
* IfK: t->child[2] else part
260:    LDA  7,0(7) 	jmp to end 
* ENDIF
* END compound statement
* Add standard closing in case there is no return statement
261:    LDC  2,0(6) 	Set return value to 0 
262:     LD  3,-1(1) 	Load return address 
263:     LD  1,0(1) 	Adjust fp 
264:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,264(7) 	Jump to init 
* BEGIN Init
265:     LD  0,0(0) 	Set the global pointer 
266:    LDA  1,0(0) 	set first frame at end of globals 
267:     ST  1,0(1) 	store old fp (point to self) 
268:    LDA  3,1(7) 	Return address in ac 
269:    LDA  7,-240(7) 	Jump to main 
270:   HALT  0,0,0 	DONE! 
* END Init
