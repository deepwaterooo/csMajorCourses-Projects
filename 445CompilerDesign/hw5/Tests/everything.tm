* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  everything.tm
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
* BEGIN function wallace
 30:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
 31:     LD  3,-2(1) 	Load variable close
* EXPRESSION STMT
 32:     LD  3,-4(1) 	Load variable shave
 33:     ST  3,-2(1) 	Store variable close
* EXPRESSION STMT
 34:     LD  3,-3(1) 	Load variable trousers
 35:     ST  3,-12(1) 	Save left side 
 36:    LDC  3,666(6) 	Load constant 
 37:     ST  3,-13(1) 	Save left side 
 38:     LD  3,-2(1) 	Load variable wrong
 39:     LD  4,-13(1) 	Load left into ac1 
 40:    DIV  3,4,3 	Op / 
 41:     LD  4,-12(1) 	Load left into ac1 
 42:     ST  3,-2(1) 	Store variable wrong
* EXPRESSION STMT
 43:     LD  3,-2(1) 	Load variable wrong
 44:     ST  3,-12(1) 	Save left side 
 45:     LD  3,-3(1) 	Load variable trousers
 46:     LD  4,-12(1) 	Load left into ac1 
 47:    MUL  3,4,3 	Op * 
 48:     ST  3,-12(1) 	Save left side 
 49:     LD  3,-1(1) 	Load variable gromit
 50:     LD  4,-12(1) 	Load left into ac1 
 51:    SUB  3,4,3 	Op - 
 52:     ST  3,-12(1) 	Save left side 
 53:    LDC  3,42(6) 	Load constant 
 54:    LDC  4,0(6) 	Load 0 
 55:    SUB  3,4,3 	Op unary - 
 56:     LD  4,-12(1) 	Load left into ac1 
 57:    ADD  3,4,3 	Op + 
 58:     ST  3,-1(1) 	Store variable gromit
* EXPRESSION STMT
 59:    LDC  3,27182818(6) 	Load constant 
 60:     ST  3,-1(1) 	Store variable gromit
* EXPRESSION STMT
 61:    LDC  3,31415927(6) 	Load constant 
 62:     ST  3,-1(1) 	Store variable gromit
* EXPRESSION STMT
 63:     LD  3,-2(1) 	Load variable wrong
 64:     ST  3,-12(1) 	Save left side 
 65:     LD  3,-3(1) 	Load variable trousers
 66:     LD  4,-12(1) 	Load left into ac1 
 67:    SUB  4,4,3 	Op < 
 68:    LDC  3,1(6) 	True case 
 69:    JLT  4,1(7) 	Jump if true 
 70:    LDC  3,0(6) 	False case 
 71:     ST  3,-12(1) 	Save left side 
 72:     LD  3,-3(1) 	Load variable trousers
 73:     ST  3,-13(1) 	Save left side 
 74:     LD  3,-1(1) 	Load variable gromit
 75:     LD  4,-13(1) 	Load left into ac1 
 76:     LD  4,-12(1) 	Load left into ac1 
 77:    JEQ  3,1(7) 	Op AND 
 78:    LDA  3,0(4) 	 
 79:     ST  3,-2(1) 	Store variable close
* EXPRESSION STMT
 80:     LD  3,-2(1) 	Load variable wrong
 81:     ST  3,-12(1) 	Save left side 
 82:     LD  3,-3(1) 	Load variable trousers
 83:     LD  4,-12(1) 	Load left into ac1 
 84:    SUB  4,4,3 	Op > 
 85:    LDC  3,1(6) 	True case 
 86:    JLT  4,1(7) 	Jump if true 
 87:    LDC  3,0(6) 	False case 
 88:     ST  3,-12(1) 	Save left side 
 89:     LD  3,-3(1) 	Load variable trousers
 90:     ST  3,-13(1) 	Save left side 
 91:     LD  3,-1(1) 	Load variable gromit
 92:     LD  4,-13(1) 	Load left into ac1 
 93:     LD  4,-12(1) 	Load left into ac1 
 94:    JEQ  3,1(7) 	Op AND 
 95:    LDA  3,0(4) 	 
 96:     ST  3,-4(1) 	Store variable shave
* BEGIN compound statement
* EXPRESSION STMT
* EXPRESSION STMT
* EXPRESSION STMT
 97:     LD  3,-7(1) 	Load variable out
 98:     ST  3,-6(1) 	Store variable day
 99:     ST  3,-5(1) 	Store variable grand
100:     ST  3,-4(1) 	Store variable a
* END compound statement
* EXPRESSION STMT
101:    LDC  3,1(6) 	Load constant 
102:    LDC  4,0(6) 	Load 0 
103:    SUB  3,4,3 	Op unary - 
104:     ST  3,-12(1) 	Save left side 
105:    LDC  3,2(6) 	Load constant 
106:     LD  4,-12(1) 	Load left into ac1 
107:    MUL  3,4,3 	Op * 
108:     ST  3,-12(1) 	Save left side 
109:    LDC  3,3(6) 	Load constant 
110:     LD  4,-12(1) 	Load left into ac1 
111:    ADD  3,4,3 	Op + 
112:     ST  3,-12(1) 	Save left side 
113:    LDC  3,4(6) 	Load constant 
114:     ST  3,-13(1) 	Save left side 
115:    LDC  3,5(6) 	Load constant 
116:     LD  4,-13(1) 	Load left into ac1 
117:    MUL  3,4,3 	Op * 
118:     LD  4,-12(1) 	Load left into ac1 
119:    SUB  4,4,3 	Op < 
120:    LDC  3,1(6) 	True case 
121:    JLT  4,1(7) 	Jump if true 
122:    LDC  3,0(6) 	False case 
123:     ST  3,-12(1) 	Save left side 
124:    LDC  3,6(6) 	Load constant 
125:     ST  3,-13(1) 	Save left side 
126:    LDC  3,7(6) 	Load constant 
127:     LD  4,-13(1) 	Load left into ac1 
128:    ADD  3,4,3 	Op + 
129:     ST  3,-13(1) 	Save left side 
130:    LDC  3,3(6) 	Load constant 
131:    LDC  4,0(6) 	Load 0 
132:    SUB  3,4,3 	Op unary - 
133:     LD  4,-13(1) 	Load left into ac1 
134:    SUB  4,4,3 	Op > 
135:    LDC  3,1(6) 	True case 
136:    JLT  4,1(7) 	Jump if true 
137:    LDC  3,0(6) 	False case 
138:     LD  4,-12(1) 	Load left into ac1 
139:    JEQ  3,1(7) 	Op AND 
140:    LDA  3,0(4) 	 
141:     ST  3,-2(1) 	Store variable close
* EXPRESSION STMT
142:    LDC  3,1(6) 	Load constant 
143:     ST  3,-12(1) 	Save left side 
144:    LDC  3,1(6) 	Load constant 
145:     ST  3,-13(1) 	Save left side 
146:    LDC  3,2(6) 	Load constant 
147:     ST  3,-14(1) 	Save left side 
148:    LDC  3,3(6) 	Load constant 
149:     LD  4,-14(1) 	Load left into ac1 
150:    ADD  3,4,3 	Op + 
151:     LD  4,-13(1) 	Load left into ac1 
152:    MUL  3,4,3 	Op * 
153:    LDC  4,0(6) 	Load 0 
154:    SUB  3,4,3 	Op unary - 
155:     ST  3,-13(1) 	Save left side 
156:    LDC  3,4(6) 	Load constant 
157:     ST  3,-14(1) 	Save left side 
158:    LDC  3,5(6) 	Load constant 
159:     LD  4,-14(1) 	Load left into ac1 
160:    MUL  3,4,3 	Op * 
161:     LD  4,-13(1) 	Load left into ac1 
162:    SUB  4,4,3 	Op < 
163:    LDC  3,1(6) 	True case 
164:    JLT  4,1(7) 	Jump if true 
165:    LDC  3,0(6) 	False case 
166:     ST  3,-13(1) 	Save left side 
167:    LDC  3,6(6) 	Load constant 
168:     ST  3,-14(1) 	Save left side 
169:    LDC  3,7(6) 	Load constant 
170:     LD  4,-14(1) 	Load left into ac1 
171:    ADD  3,4,3 	Op + 
172:     ST  3,-14(1) 	Save left side 
173:    LDC  3,3(6) 	Load constant 
174:    LDC  4,0(6) 	Load 0 
175:    SUB  3,4,3 	Op unary - 
176:     LD  4,-14(1) 	Load left into ac1 
177:    SUB  4,4,3 	Op > 
178:    LDC  3,1(6) 	True case 
179:    JLT  4,1(7) 	Jump if true 
180:    LDC  3,0(6) 	False case 
181:     LD  4,-13(1) 	Load left into ac1 
182:    JEQ  3,1(7) 	Op AND 
183:    LDA  3,0(4) 	 
184:     LD  4,-12(1) 	Load left into ac1 
185:     ST  3,-4(1) 	Store variable shave
* IfK:
* IfK: t->child[0] condition
186:     LD  3,-4(1) 	Load variable shave
187:     ST  3,-12(1) 	Save left side 
188:     LD  3,-2(1) 	Load variable close
189:     LD  4,-12(1) 	Load left into ac1 
* IfK: t->child[1] then part
* EXPRESSION STMT
191:     LD  3,-2(1) 	Load variable close
192:     ST  3,-4(1) 	Store variable shave
190:    JEQ  3,3(7) 	if: jmp to else 
* IfK: t->child[2] else part
193:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
194:     LD  3,-4(1) 	Load variable shave
195:     ST  3,-12(1) 	Save left side 
196:     LD  3,-2(1) 	Load variable close
197:     LD  4,-12(1) 	Load left into ac1 
198:    SUB  4,4,3 	Op == 
199:    LDC  3,1(6) 	True case 
200:    JEQ  4,1(7) 	Jump if true 
201:    LDC  3,0(6) 	False case 
202:     ST  3,-12(1) 	Save left side 
203:     LD  3,-2(1) 	Load variable close
204:     LD  4,-12(1) 	Load left into ac1 
* IfK: t->child[1] then part
* EXPRESSION STMT
206:    LDC  3,1(6) 	Load constant 
207:     ST  3,-4(1) 	Store variable shave
205:    JEQ  3,3(7) 	if: jmp to else 
* IfK: t->child[2] else part
* EXPRESSION STMT
209:    LDC  3,0(6) 	Load constant 
210:     ST  3,-2(1) 	Store variable close
208:    LDA  7,2(7) 	jmp to end 
* ENDIF
* WHILE
211:     LD  3,-4(1) 	Load variable shave
212:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
214:    LDC  3,0(6) 	load size of array sheep
215:     ST  3,-9(1) 	save size of array sheep
* EXPRESSION STMT
216:    LDC  3,2(6) 	Load constant 
217:     ST  3,-12(1) 	Save index 
218:    LDC  3,1618(6) 	Load constant 
219:     ST  3,-10(1) 	Store variable sheep
* IfK:
* IfK: t->child[0] condition
220:    LDC  3,2(6) 	Load constant 
221:     ST  3,-13(1) 	Save index 
222:     ST  3,-14(1) 	Save left side 
223:    LDC  3,496(6) 	Load constant 
224:     LD  4,-14(1) 	Load left into ac1 
225:    SUB  4,4,3 	Op < 
226:    LDC  3,1(6) 	True case 
227:    JLT  4,1(7) 	Jump if true 
228:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
229:    JEQ  3,1(7) 	if: jmp to else 
* IfK: t->child[2] else part
230:    LDA  7,0(7) 	jmp to end 
* ENDIF
* EXPRESSION STMT
231:     ST  1,-14(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
232:     ST  3,-1(1) 	Store variable gromit
233:     LD  3,-6(1) 	Load variable were
234:     ST  3,-16(1) 	Save left side 
235:     LD  3,-8(1) 	Load variable rabbit
236:     LD  4,-16(1) 	Load left into ac1 
237:    SUB  3,4,3 	Op - 
238:     ST  3,-16(1) 	Store parameter 
239:     LD  3,-6(1) 	Load variable were
240:     ST  3,-17(1) 	Save left side 
241:     LD  3,-8(1) 	Load variable rabbit
242:     LD  4,-17(1) 	Load left into ac1 
243:    SUB  3,4,3 	Op - 
244:     ST  3,-17(1) 	Store parameter 
245:    LDA  1,-14(1) 	Load address of new frame 
246:    LDA  3,1(7) 	Return address in ac 
247:    LDA  7,-218(7) 	CALL wallace
248:    LDA  3,0(2) 	Save the result in ac 
* BEGIN compound statement
* EXPRESSION STMT
* EXPRESSION STMT
* EXPRESSION STMT
249:     ST  3,-11(1) 	Store variable trousers
250:     ST  3,-10(1) 	Store variable wrong
251:     ST  3,-8(1) 	Store variable the
* IfK:
* IfK: t->child[0] condition
252:     LD  3,-6(1) 	Load variable were
253:     ST  3,-14(1) 	Save left side 
254:     LD  3,-8(1) 	Load variable rabbit
255:     LD  4,-14(1) 	Load left into ac1 
256:    SUB  4,4,3 	Op == 
257:    LDC  3,1(6) 	True case 
258:    JEQ  4,1(7) 	Jump if true 
259:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
* EXPRESSION STMT
* EXPRESSION STMT
261:     ST  3,-10(1) 	Store variable wrong
262:     ST  3,-6(1) 	Store variable were
260:    JEQ  3,3(7) 	if: jmp to else 
* IfK: t->child[2] else part
263:    LDA  7,0(7) 	jmp to end 
* ENDIF
* END compound statement
* END compound statement
264:    LDA  7,-54(7) 	go to beginning of loop 
213:    LDA  7,51(7) 	No more loop 
* ENDWHILE
* RETURN
265:    LDA  2,0(3) 	Copy result to rt register 
266:     LD  3,-1(1) 	Load return address 
267:     LD  1,0(1) 	Adjust fp 
268:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
269:    LDC  2,0(6) 	Set return value to 0 
270:     LD  3,-1(1) 	Load return address 
271:     LD  1,0(1) 	Adjust fp 
272:    LDA  7,0(3) 	Return 
* END function wallace
* BEGIN function main
273:     ST  3,-1(1) 	Store return address 
* BEGIN compound statement
274:    LDC  3,0(6) 	load size of array yarn
275:     ST  3,-2(1) 	save size of array yarn
276:    LDC  3,0(6) 	load size of array preston
277:     ST  3,-4(1) 	save size of array preston
* EXPRESSION STMT
278:     ST  1,-5(1) 	Store old frame in ghost frame 
* EXPRESSION STMT
279:     ST  1,-7(1) 	Store old frame in ghost frame 
280:    LDC  3,62(6) 	Load constant 
281:     ST  3,-9(1) 	Store parameter 
282:    LDC  3,62(6) 	Load 