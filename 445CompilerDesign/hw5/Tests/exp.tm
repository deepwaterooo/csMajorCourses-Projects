* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  exp.tm
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
* BEGIN compound statement
* EXPRESSION STMT
 31:    LDC  3,11(6) 	Load constant 
 32:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
 33:    LDC  3,12(6) 	Load constant 
 34:     ST  3,-2(1) 	Store variable y
* EXPRESSION STMT
 35:    LDC  3,13(6) 	Load constant 
 36:     ST  3,-1(1) 	Store variable g
* EXPRESSION STMT
 37:    LDC  3,3(6) 	Load constant 
 38:     ST  3,-11(1) 	Save left side 
 39:    LDC  3,4(6) 	Load constant 
 40:     ST  3,-12(1) 	Save left side 
 41:     LD  3,-2(1) 	Load variable x
 42:     LD  4,-12(1) 	Load left into ac1 
 43:    MUL  3,4,3 	Op * 
 44:     LD  4,-11(1) 	Load left into ac1 
 45:    ADD  3,4,3 	Op + 
 46:     ST  3,-11(1) 	Save left side 
 47:     LD  3,-2(1) 	Load variable y
 48:     ST  3,-12(1) 	Save left side 
 49:    LDC  3,7(6) 	Load constant 
 50:     LD  4,-12(1) 	Load left into ac1 
 51:    MUL  3,4,3 	Op * 
 52:     LD  4,-11(1) 	Load left into ac1 
 53:    ADD  3,4,3 	Op + 
 54:     ST  3,-11(1) 	Save left side 
 55:     LD  3,-2(1) 	Load variable x
 56:     ST  3,-12(1) 	Save left side 
 57:     LD  3,-2(1) 	Load variable y
 58:     ST  3,-13(1) 	Save left side 
 59:     LD  3,-1(1) 	Load variable g
 60:     LD  4,-13(1) 	Load left into ac1 
 61:    ADD  3,4,3 	Op + 
 62:     LD  4,-12(1) 	Load left into ac1 
 63:    MUL  3,4,3 	Op * 
 64:     LD  4,-11(1) 	Load left into ac1 
 65:    ADD  3,4,3 	Op + 
 66:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
 67:    LDC  3,3(6) 	Load constant 
 68:     ST  3,-11(1) 	Save left side 
 69:    LDC  3,4(6) 	Load constant 
 70:     ST  3,-12(1) 	Save left side 
 71:     LD  3,-2(1) 	Load variable x
 72:     LD  4,-12(1) 	Load left into ac1 
 73:    DIV  3,4,3 	Op / 
 74:     LD  4,-11(1) 	Load left into ac1 
 75:    SUB  3,4,3 	Op - 
 76:     ST  3,-11(1) 	Save left side 
 77:     LD  3,-2(1) 	Load variable y
 78:     ST  3,-12(1) 	Save left side 
 79:    LDC  3,7(6) 	Load constant 
 80:     LD  4,-12(1) 	Load left into ac1 
 81:    DIV  3,4,3 	Op / 
 82:     LD  4,-11(1) 	Load left into ac1 
 83:    SUB  3,4,3 	Op - 
 84:     ST  3,-11(1) 	Save left side 
 85:     LD  3,-2(1) 	Load variable x
 86:     ST  3,-12(1) 	Save left side 
 87:     LD  3,-2(1) 	Load variable y
 88:     ST  3,-13(1) 	Save left side 
 89:     LD  3,-1(1) 	Load variable g
 90:     LD  4,-13(1) 	Load left into ac1 
 91:    SUB  3,4,3 	Op - 
 92:     LD  4,-12(1) 	Load left into ac1 
 93:    DIV  3,4,3 	Op / 
 94:     LD  4,-11(1) 	Load left into ac1 
 95:    SUB  3,4,3 	Op - 
 96:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
 97:    LDC  3,3(6) 	Load constant 
 98:     ST  3,-11(1) 	Save left side 
 99:    LDC  3,4(6) 	Load constant 
100:     LD  4,-11(1) 	Load left into ac1 
101:     ST  3,-11(1) 	Save left side 
102:     LD  3,-2(1) 	Load variable x
103:     LD  4,-11(1) 	Load left into ac1 
104:    DIV  3,4,3 	Op / 
105:     ST  3,-11(1) 	Save left side 
106:     LD  3,-2(1) 	Load variable y
107:     ST  3,-12(1) 	Save left side 
108:    LDC  3,7(6) 	Load constant 
109:     LD  4,-12(1) 	Load left into ac1 
110:    DIV  3,4,3 	Op / 
111:     ST  3,-12(1) 	Save left side 
112:     LD  3,-2(1) 	Load variable x
113:     LD  4,-12(1) 	Load left into ac1 
114:     LD  4,-11(1) 	Load left into ac1 
115:     ST  3,-11(1) 	Save left side 
116:     LD  3,-2(1) 	Load variable y
117:     ST  3,-12(1) 	Save left side 
118:     LD  3,-1(1) 	Load variable g
119:     LD  4,-12(1) 	Load left into ac1 
120:     LD  4,-11(1) 	Load left into ac1 
121:    DIV  3,4,3 	Op / 
122:     ST  3,-2(1) 	Store variable x
* END compound statement
* BEGIN compound statement
123:    LDC  3,0(6) 	load size of array z
124:     ST  3,-4(1) 	save size of array z
* EXPRESSION STMT
125:    LDC  3,1(6) 	Load constant 
126:     ST  3,-4(1) 	Store variable x
* EXPRESSION STMT
127:    LDC  3,0(6) 	Load constant 
128:     ST  3,-3(1) 	Store variable y
* EXPRESSION STMT
129:    LDC  3,1(6) 	Load constant 
130:     ST  3,-11(1) 	Save left side 
131:    LDC  3,0(6) 	Load constant 
132:     ST  3,-12(1) 	Save left side 
133:     LD  3,-4(1) 	Load variable x
134:     LD  4,-12(1) 	Load left into ac1 
135:    JEQ  3,1(7) 	Op AND 
136:    LDA  3,0(4) 	 
137:     LD  4,-11(1) 	Load left into ac1 
138:     ST  3,-11(1) 	Save left side 
139:     LD  3,-3(1) 	Load variable y
140:     ST  3,-12(1) 	Save left side 
141:    LDC  3,7(6) 	Load constant 
142:     LD  4,-12(1) 	Load left into ac1 
143:    JEQ  3,1(7) 	Op AND 
144:    LDA  3,0(4) 	 
145:     LD  4,-11(1) 	Load left into ac1 
146:     ST  3,-11(1) 	Save left side 
147:     LD  3,-4(1) 	Load variable x
148:     ST  3,-12(1) 	Save left side 
149:     LD  3,-3(1) 	Load variable y
150:     ST  3,-13(1) 	Save left side 
151:     LD  3,-1(1) 	Load variable g
152:     LD  4,-13(1) 	Load left into ac1 
153:     LD  4,-12(1) 	Load left into ac1 
154:    JEQ  3,1(7) 	Op AND 
155:    LDA  3,0(4) 	 
156:     LD  4,-11(1) 	Load left into ac1 
157:     ST  3,-4(1) 	Store variable x
* EXPRESSION STMT
158:    LDC  3,1(6) 	Load constant 
159:     ST  3,-11(1) 	Save left side 
160:     LD  3,-4(1) 	Load variable x
161:     LD  4,-11(1) 	Load left into ac1 
162:     ST  3,-4(1) 	Store variable x
* EXPRESSION STMT
163:     LD  3,-4(1) 	Load variable x
164:     ST  3,-11(1) 	Save left side 
165:     LD  3,-3(1) 	Load variable y
166:     LD  4,-11(1) 	Load left into ac1 
167:    JEQ  3,1(7) 	Op AND 
168:    LDA  3,0(4) 	 
169:     ST  3,-11(1) 	Save left side 
170:     LD  3,-4(1) 	Load variable x
171:     LD  4,-11(1) 	Load left into ac1 
172:    JEQ  3,1(7) 	Op AND 
173:    LDA  3,0(4) 	 
174:     ST  3,-4(1) 	Store variable x
* EXPRESSION STMT
175:     LD  3,-4(1) 	Load variable x
176:     ST  3,-11(1) 	Save left side 
177:     LD  3,-3(1) 	Load variable y
178:     LD  4,-11(1) 	Load left into ac1 
179:     ST  3,-11(1) 	Save left side 
180:     LD  3,-4(1) 	Load variable x
181:     LD  4,-11(1) 	Load left into ac1 
182:     ST  3,-4(1) 	Store variable x
* EXPRESSION STMT
183:    LDC  3,1(6) 	Load constant 
184:     ST  3,-11(1) 	Save index 
185:     ST  3,-4(1) 	Store variable x
* EXPRESSION STMT
186:    LDC  3,1(6) 	Load constant 
187:     ST  3,-12(1) 	Save index 
188:     LD  3,-4(1) 	Load variable x
189:     ST  3,-5(1) 	Store variable z
* EXPRESSION STMT
190:    LDC  3,1(6) 	Load constant 
191:     ST  3,-13(1) 	Save index 
192:    LDC  3,2(6) 	Load constant 
193:    LDA  4,-5(1) 	Load address of base of array z
194:    SUB  3,4,3 	Compute offset of value 
195:     LD  3,0(3) 	Load the value 
196:     LD  4,-13(1) 	Restore index 
197:    LDA  5,-5(1) 	Load address of base of array z
198:    SUB  5,5,4 	Compute offset of value 
199:     ST  3,0(5) 	Store variable z
* EXPRESSION STMT
200:    LDC  3,1(6) 	Load constant 
201:     ST  3,-13(1) 	Save index 
202:    LDC  3,2(6) 	Load constant 
203:     ST  3,-14(1) 	Save index 
204:     ST  3,-15(1) 	Save left side 
205:    LDC  3,3(6) 	Load constant 
206:     ST  3,-16(1) 	Save index 
207:     LD  4,-16(1) 	Load left into ac1 
208:    ADD  3,4,3 	Op + 
209:     ST  3,-5(1) 	Store variable z
* END compound statement
* BEGIN compound statement
210:    LDC  3,0(6) 	load size of array z
211:     ST  3,-5(1) 	save size of array z
* EXPRESSION STMT
212:    LDC  3,1(6) 	Load constant 
213:     ST  3,-16(1) 	Save index 
214:     ST  3,0(1) 	Store variable x
* EXPRESSION STMT
215:    LDC  3,1(6) 	Load constant 
216:     ST  3,-17(1) 	Save index 
217:     LD  3,0(1) 	Load variable x
218:     ST  3,-6(1) 	Store variable z
* EXPRESSION STMT
219:    LDC  3,1(6) 	Load constant 
220:     ST  3,-18(1) 	Save index 
221:    LDC  3,2(6) 	Load constant 
222:    LDA  4,-6(0) 	Load address of base of array z
223:    SUB  3,4,3 	Compute offset of value 
224:     LD  3,0(3) 	Load the value 
225:     LD  4,-18(1) 	Restore index 
226:    LDA  5,-6(0) 	Load address of base of array z
227:    SUB  5,5,4 	Compute offset of value 
228:     ST  3,0(5) 	Store variable z
* EXPRESSION STMT
229:    LDC  3,1(6) 	Load constant 
230:     ST  3,-18(1) 	Save index 
231:    LDC  3,2(6) 	Load constant 
232:     ST  3,-19(1) 	Save index 
233:     ST  3,-20(1) 	Save left side 
234:    LDC  3,3(6) 	Load constant 
235:     ST  3,-21(1) 	Save index 
236:     LD  4,-21(1) 	Load left into ac1 
237:    ADD  3,4,3 	Op + 
238:     ST  3,-6(1) 	Store variable z
* EXPRESSION STMT
239:    LDC  3,1(6) 	Load constant 
240:     ST  3,-21(1) 	Save index 
241:     ST  3,-22(1) 	Save left side 
242:    LDC  3,2(6) 	Load constant 
243:     ST  3,-23(1) 	Save index 
244:     ST  3,-24(1) 	Save left side 
245:    LDC  3,0(6) 	Load constant 
246:     ST  3,-25(1) 	Save index 
247:     LD  4,-25(1) 	Load left into ac1 
248:    MUL  3,4,3 	Op * 
249:     LD  4,-24(1) 	Load left into ac1 
250:    ADD  3,4,3 	Op + 
251:     ST  3,-24(1) 	Save left side 
252:    LDC  3,3(6) 	Load constant 
253:     ST  3,-25(1) 	Save index 
254:     ST  3,-26(1) 	Save left side 
255:    LDC  3,7(6) 	Load constant 
256:     LD  4,-26(1) 	Load left into ac1 
257:    MUL  3,4,3 	Op * 
258:     LD  4,-25(1) 	Load left into ac1 
259:    ADD  3,4,3 	Op + 
260:     ST  3,-25(1) 	Save left side 
261:     LD  3,0(1) 	Load variable x
262:     ST  3,-26(1) 	Save left side 
263:    LDC  3,4(6) 	Load constant 
264:     ST  3,-27(1) 	Save index 
265:     ST  3,-28(1) 	Save left side 
266:     LD  3,-1(1) 	Load variable g
267:     LD  4,-28(1) 	Load left into ac1 
268:    ADD  3,4,3 	Op + 
269:     LD  4,-27(1) 	Load left into ac1 
270:    MUL  3,4,3 	Op * 
271:     LD  4,-26(1) 	Load left into ac1 
272:    ADD  3,4,3 	Op + 
273:     ST  3,0(1) 	Store variable x
* END compound statement
* BEGIN compound statement
* EXPRESSION STMT
* EXPRESSION STMT
274:     LD  3,-6(1) 	Load variable c
275:     ST  3,-5(1) 	Store variable b
276:     ST  3,-7(1) 	Store variable a
* EXPRESSION STMT
277:     LD  3,-5(1) 	Load variable b
278:     ST  3,-26(1) 	Save left side 
279:     LD  3,-6(1) 	Load variable c
280:     LD  4,-26(1) 	Load left into ac1 
281:    ADD  3,4,3 	Op + 
282:     ST  3,-26(1) 	Save left side 
283:     LD  3,-7(1) 	Load variable d
284:     LD  4,-26(1) 	Load left into ac1 
285:    ADD  3,4,3 	Op + 
286:     ST  3,-7(1) 	Store variable a
* EXPRESSION STMT
287:     LD  3,-5(1) 	Load variable b
288:     ST  3,-26(1) 	Save left side 
289:     LD  3,-6(1) 	Load variable c
290:     LD  4,-26(1) 	Load left into ac1 
291:    MUL  3,4,3 	Op * 
292:     ST  3,-26(1) 	Save left side 
293:     LD  3,-7(1) 	Load variable d
294:     LD  4,-26(1) 	Load left into ac1 
295:    MUL  3,4,3 	Op * 
296:     ST  3,-7(1) 	Store variable a
* EXPRESSION STMT
* EXPRESSION STMT
* EXPRESSION STMT
297:     LD  3,-6(1) 	Load variable c
298:     ST  3,-26(1) 	Save left side 
299:     LD  3,-7(1) 	Load variable d
300:     LD  4,-26(1) 	Load left into ac1 
301:    ADD  3,4,3 	Op + 
302:     ST  3,-5(1) 	Store variable b
303:     ST  3,-7(1) 	Store variable a
304:     ST  3,-1(1) 	Store variable g
* EXPRESSION STMT
* EXPRESSION STMT
305:    LDC  3,3(6) 	Load constant 
306:     ST  3,-5(1) 	Store variable b
307:     ST  3,-26(1) 	Save left side 
* EXPRESSION STMT
308:    LDC  3,4(6) 	Load constant 
309:     ST  3,-6(1) 	Store variable c
310:     LD  4,-26(1) 	Load left into ac1 
311:    ADD  3,4,3 	Op + 
312:     ST  3,-7(1) 	Store variable a
* END compound statement
* BEGIN compound statement
* EXPRESSION STMT
313:     LD  3,-9(1) 	Load variable x
314:     ST  3,-26(1) 	Save left side 
315:     LD  3,-10(1) 	Load variable y
316:     ST  3,-27(1) 	Save left side 
317:     LD  3,-8(1) 	Load variable b
318:     ST  3,-28(1) 	Save left side 
319:     LD  3,-9(1) 	Load variable a
320:     LD  4,-28(1) 	Load left into ac1 
321:    MUL  3,4,3 	Op * 
322:     ST  3,-28(1) 	Save left side 
323:     LD  3,-9(1) 	Load variable a
324:     ST  3,-29(1) 	Save left side 
325:     LD  3,-8(1) 	Load variable b
326:     LD  4,-29(1) 	Load left into ac1 
327:    ADD  3,4,3 	Op + 
328:     LD  4,-28(1) 	Load left into ac1 
329:    SUB  4,4,3 	Op > 
330:    LDC  3,1(6) 	True case 
331:    JLT  4,1(7) 	Jump if true 
332:    LDC  3,0(6) 	False case 
333:     LD  4,-27(1) 	Load left into ac1 
334:    JEQ  3,1(7) 	Op AND 
335:    LDA  3,0(4) 	 
336:     LD  4,-26(1) 	Load left into ac1 
337:     ST  3,-9(1) 	Store variable x
* END compound statement
* END compound statement
* Add standard closing in case there is no return statement
338:    LDC  2,0(6) 	Set return value to 0 
339:     LD  3,-1(1) 	Load return address 
340:     LD  1,0(1) 	Adjust fp 
341:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,341(7) 	Jump to init 
* BEGIN Init
342:     LD  0,0(0) 	Set the global pointer 
343:    LDA  1,-1(0) 	set first frame at end of globals 
344:     ST  1,0(1) 	store old fp (point to self) 
345:    LDA  3,1(7) 	Return address in ac 
346:    LDA  7,-317(7) 	Jump to main 
347:   HALT  0,0,0 	DONE! 
* END Init
