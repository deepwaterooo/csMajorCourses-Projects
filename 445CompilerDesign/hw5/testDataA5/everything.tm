* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  everything.c-
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
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 31:     LD  3,-4(1) 	Load variable close
* EXPRESSION STMT
 32:     LD  3,-5(1) 	Load variable shave
 33:     ST  3,-4(1) 	Store variable close
* EXPRESSION STMT
 34:     LD  3,-3(1) 	Load variable trousers
 35:     ST  3,-26(1) 	Save left side 
 36:    LDC  3,666(6) 	Load constant 
 37:     ST  3,-27(1) 	Save left side 
 38:     LD  3,-2(1) 	Load variable wrong
 39:     LD  4,-27(1) 	Load left into ac1 
 40:    DIV  3,4,3 	Op / 
 41:     LD  4,-26(1) 	Load left into ac1 
 42:    DIV  5,4,3 	Op % 
 43:    MUL  5,5,3 	 
 44:    SUB  3,4,5 	 
 45:     ST  3,-2(1) 	Store variable wrong
* EXPRESSION STMT
 46:     LD  3,-2(1) 	Load variable wrong
 47:     ST  3,-26(1) 	Save left side 
 48:     LD  3,-3(1) 	Load variable trousers
 49:     LD  4,-26(1) 	Load left into ac1 
 50:    MUL  3,4,3 	Op * 
 51:     ST  3,-26(1) 	Save left side 
 52:     LD  3,0(0) 	Load variable gromit
 53:     LD  4,-26(1) 	Load left into ac1 
 54:    SUB  3,4,3 	Op - 
 55:     ST  3,-26(1) 	Save left side 
 56:    LDC  3,42(6) 	Load constant 
 57:    LDC  4,0(6) 	Load 0 
 58:    SUB  3,4,3 	Op unary - 
 59:     LD  4,-26(1) 	Load left into ac1 
 60:    ADD  3,4,3 	Op + 
 61:     ST  3,0(0) 	Store variable gromit
* EXPRESSION STMT
 62:    LDC  3,27182818(6) 	Load constant 
 63:     LD  4,0(0) 	load lhs variable gromit
 64:    ADD  3,4,3 	op += 
 65:     ST  3,0(0) 	Store variable gromit
* EXPRESSION STMT
 66:    LDC  3,31415927(6) 	Load constant 
 67:     LD  4,0(0) 	load lhs variable gromit
 68:    SUB  3,4,3 	op -= 
 69:     ST  3,0(0) 	Store variable gromit
* EXPRESSION STMT
 70:     LD  3,-2(1) 	Load variable wrong
 71:     ST  3,-26(1) 	Save left side 
 72:     LD  3,-3(1) 	Load variable trousers
 73:     LD  4,-26(1) 	Load left into ac1 
 74:    SUB  4,4,3 	Op < 
 75:    LDC  3,1(6) 	True case 
 76:    JLT  4,1(7) 	Jump if true 
 77:    LDC  3,0(6) 	False case 
 78:     ST  3,-26(1) 	Save left side 
 79:     LD  3,-3(1) 	Load variable trousers
 80:     ST  3,-27(1) 	Save left side 
 81:     LD  3,0(0) 	Load variable gromit
 82:     LD  4,-27(1) 	Load left into ac1 
 83:    SUB  4,4,3 	Op <= 
 84:    LDC  3,1(6) 	True case 
 85:    JLE  4,1(7) 	Jump if true 
 86:    LDC  3,0(6) 	False case 
 87:     LD  4,-26(1) 	Load left into ac1 
 88:    JEQ  3,1(7) 	Op AND 
 89:    LDA  3,0(4) 	 
 90:     ST  3,-4(1) 	Store variable close
* EXPRESSION STMT
 91:     LD  3,-2(1) 	Load variable wrong
 92:     ST  3,-26(1) 	Save left side 
 93:     LD  3,-3(1) 	Load variable trousers
 94:     LD  4,-26(1) 	Load left into ac1 
 95:    SUB  4,4,3 	Op > 
 96:    LDC  3,1(6) 	True case 
 97:    JGT  4,1(7) 	Jump if true 
 98:    LDC  3,0(6) 	False case 
 99:     ST  3,-26(1) 	Save left side 
100:     LD  3,-3(1) 	Load variable trousers
101:     ST  3,-27(1) 	Save left side 
102:     LD  3,0(0) 	Load variable gromit
103:     LD  4,-27(1) 	Load left into ac1 
104:    SUB  4,4,3 	Op >= 
105:    LDC  3,1(6) 	True case 
106:    JGE  4,1(7) 	Jump if true 
107:    LDC  3,0(6) 	False case 
108:     LD  4,-26(1) 	Load left into ac1 
109:    JEQ  3,1(7) 	Op AND 
110:    LDA  3,0(4) 	 
111:     ST  3,-5(1) 	Store variable shave
* BEGIN compound statement
* EXPRESSION STMT
112:     LD  3,-9(1) 	Load variable out
113:     LD  4,-8(1) 	load lhs variable day
114:    SUB  3,4,3 	op -= 
115:     ST  3,-8(1) 	Store variable day
116:     LD  4,-7(1) 	load lhs variable grand
117:    ADD  3,4,3 	op += 
118:     ST  3,-7(1) 	Store variable grand
119:     ST  3,-6(1) 	Store variable a
* END compound statement
* EXPRESSION STMT
120:    LDC  3,1(6) 	Load constant 
121:    LDC  4,0(6) 	Load 0 
122:    SUB  3,4,3 	Op unary - 
123:     ST  3,-26(1) 	Save left side 
124:    LDC  3,2(6) 	Load constant 
125:     LD  4,-26(1) 	Load left into ac1 
126:    MUL  3,4,3 	Op * 
127:     ST  3,-26(1) 	Save left side 
128:    LDC  3,3(6) 	Load constant 
129:     LD  4,-26(1) 	Load left into ac1 
130:    ADD  3,4,3 	Op + 
131:     ST  3,-26(1) 	Save left side 
132:    LDC  3,4(6) 	Load constant 
133:     ST  3,-27(1) 	Save left side 
134:    LDC  3,5(6) 	Load constant 
135:     LD  4,-27(1) 	Load left into ac1 
136:    MUL  3,4,3 	Op * 
137:     LD  4,-26(1) 	Load left into ac1 
138:    SUB  4,4,3 	Op < 
139:    LDC  3,1(6) 	True case 
140:    JLT  4,1(7) 	Jump if true 
141:    LDC  3,0(6) 	False case 
142:     ST  3,-26(1) 	Save left side 
143:    LDC  3,6(6) 	Load constant 
144:     ST  3,-27(1) 	Save left side 
145:    LDC  3,7(6) 	Load constant 
146:     LD  4,-27(1) 	Load left into ac1 
147:    ADD  3,4,3 	Op + 
148:     ST  3,-27(1) 	Save left side 
149:    LDC  3,3(6) 	Load constant 
150:    LDC  4,0(6) 	Load 0 
151:    SUB  3,4,3 	Op unary - 
152:     LD  4,-27(1) 	Load left into ac1 
153:    SUB  4,4,3 	Op > 
154:    LDC  3,1(6) 	True case 
155:    JGT  4,1(7) 	Jump if true 
156:    LDC  3,0(6) 	False case 
157:     LD  4,-26(1) 	Load left into ac1 
158:    JEQ  3,1(7) 	Op AND 
159:    LDA  3,0(4) 	 
160:     ST  3,-4(1) 	Store variable close
* EXPRESSION STMT
161:    LDC  3,1(6) 	Load constant 
162:     ST  3,-26(1) 	Save left side 
163:    LDC  3,1(6) 	Load constant 
164:     ST  3,-27(1) 	Save left side 
165:    LDC  3,2(6) 	Load constant 
166:     ST  3,-28(1) 	Save left side 
167:    LDC  3,3(6) 	Load constant 
168:     LD  4,-28(1) 	Load left into ac1 
169:    ADD  3,4,3 	Op + 
170:     LD  4,-27(1) 	Load left into ac1 
171:    MUL  3,4,3 	Op * 
172:    LDC  4,0(6) 	Load 0 
173:    SUB  3,4,3 	Op unary - 
174:     ST  3,-27(1) 	Save left side 
175:    LDC  3,4(6) 	Load constant 
176:     ST  3,-28(1) 	Save left side 
177:    LDC  3,5(6) 	Load constant 
178:     LD  4,-28(1) 	Load left into ac1 
179:    MUL  3,4,3 	Op * 
180:     LD  4,-27(1) 	Load left into ac1 
181:    SUB  4,4,3 	Op < 
182:    LDC  3,1(6) 	True case 
183:    JLT  4,1(7) 	Jump if true 
184:    LDC  3,0(6) 	False case 
185:     ST  3,-27(1) 	Save left side 
186:    LDC  3,6(6) 	Load constant 
187:     ST  3,-28(1) 	Save left side 
188:    LDC  3,7(6) 	Load constant 
189:     LD  4,-28(1) 	Load left into ac1 
190:    ADD  3,4,3 	Op + 
191:     ST  3,-28(1) 	Save left side 
192:    LDC  3,3(6) 	Load constant 
193:    LDC  4,0(6) 	Load 0 
194:    SUB  3,4,3 	Op unary - 
195:     LD  4,-28(1) 	Load left into ac1 
196:    SUB  4,4,3 	Op > 
197:    LDC  3,1(6) 	True case 
198:    JGT  4,1(7) 	Jump if true 
199:    LDC  3,0(6) 	False case 
200:     LD  4,-27(1) 	Load left into ac1 
201:    JEQ  3,1(7) 	Op AND 
202:    LDA  3,0(4) 	 
203:     LD  4,-26(1) 	Load left into ac1 
204:    JGT  3,1(7) 	Op OR 
205:    LDA  3,0(4) 	 
206:     ST  3,-5(1) 	Store variable shave
* IF
207:     LD  3,-5(1) 	Load variable shave
208:     ST  3,-26(1) 	Save left side 
209:     LD  3,-4(1) 	Load variable close
210:     LD  4,-26(1) 	Load left into ac1 
211:    SUB  3,4,3 	Op != 
212:    JEQ  3,1(7) 	Jump if true 
213:    LDC  3,1(6) 	True case 
214:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
216:     LD  3,-4(1) 	Load variable close
217:    LDC  4,1(6) 	Load 1 
218:    SUB  3,4,3 	Op NOT 
219:     ST  3,-5(1) 	Store variable shave
215:    LDA  7,4(7) 	Jump around the THEN 
* ENDIF
* IF
220:     LD  3,-5(1) 	Load variable shave
221:     ST  3,-26(1) 	Save left side 
222:     LD  3,-4(1) 	Load variable close
223:     LD  4,-26(1) 	Load left into ac1 
224:    SUB  4,4,3 	Op == 
225:    LDC  3,1(6) 	True case 
226:    JEQ  4,1(7) 	Jump if true 
227:    LDC  3,0(6) 	False case 
228:    LDC  4,1(6) 	Load 1 
229:    SUB  3,4,3 	Op NOT 
230:     ST  3,-26(1) 	Save left side 
231:     LD  3,-4(1) 	Load variable close
232:    LDC  4,1(6) 	Load 1 
233:    SUB  3,4,3 	Op NOT 
234:     LD  4,-26(1) 	Load left into ac1 
235:    JGT  3,1(7) 	Op OR 
236:    LDA  3,0(4) 	 
237:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
239:    LDC  3,1(6) 	Load constant 
240:     ST  3,-5(1) 	Store variable shave
* ELSE
238:    LDA  7,3(7) 	Jump around the THEN 
* EXPRESSION STMT
242:    LDC  3,0(6) 	Load constant 
243:     ST  3,-4(1) 	Store variable close
241:    LDA  7,2(7) 	Jump around the ELSE 
* ENDIF
* WHILE
244:     LD  3,-5(1) 	Load variable shave
245:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
247:    LDC  3,10(6) 	load size of array sheep
248:     ST  3,-12(1) 	save size of array sheep
* EXPRESSION STMT
249:    LDC  3,2(6) 	Load constant 
250:     ST  3,-26(1) 	Save index 
251:    LDC  3,1618(6) 	Load constant 
252:     LD  4,-26(1) 	Restore index 
253:    LDA  5,-13(1) 	Load address of base of array sheep
254:    SUB  5,5,4 	Compute offset of value 
255:     ST  3,0(5) 	Store variable sheep
* IF
256:    LDC  3,2(6) 	Load constant 
257:    LDA  4,-13(1) 	Load address of base of array sheep
258:    SUB  3,4,3 	Compute offset of value 
259:     LD  3,0(3) 	Load the value 
260:     ST  3,-26(1) 	Save left side 
261:    LDC  3,496(6) 	Load constant 
262:     LD  4,-26(1) 	Load left into ac1 
263:    SUB  4,4,3 	Op < 
264:    LDC  3,1(6) 	True case 
265:    JLT  4,1(7) 	Jump if true 
266:    LDC  3,0(6) 	False case 
267:    JGT  3,1(7) 	Jump to then part 
* THEN
* BREAK
269:    LDA  7,-24(7) 	break 
268:    LDA  7,1(7) 	Jump around the THEN 
* ENDIF
* EXPRESSION STMT
270:     ST  1,-26(1) 	Store old fp in ghost frame 
271:     LD  3,0(0) 	load lhs variable gromit
272:    LDA  3,-1(3) 	decrement value of gromit
273:     ST  3,0(0) 	Store variable gromit
274:     ST  3,-28(1) 	Store parameter 
275:     LD  3,-10(1) 	Load variable were
276:     ST  3,-29(1) 	Save left side 
277:     LD  3,-11(1) 	Load variable rabbit
278:     LD  4,-29(1) 	Load left into ac1 
279:    SUB  3,4,3 	Op - 
280:     ST  3,-29(1) 	Store parameter 
281:    LDA  1,-26(1) 	Load address of new frame 
282:    LDA  3,1(7) 	Return address in ac 
283:    LDA  7,-254(7) 	CALL wallace
284:    LDA  3,0(2) 	Save the result in ac 
* BEGIN compound statement
* EXPRESSION STMT
285:     LD  3,-25(1) 	load lhs variable trousers
286:    LDA  3,1(3) 	increment value of trousers
287:     ST  3,-25(1) 	Store variable trousers
288:     LD  4,-24(1) 	load lhs variable wrong
289:    ADD  3,4,3 	op += 
290:     ST  3,-24(1) 	Store variable wrong
291:     ST  3,-23(1) 	Store variable the
* IF
292:     LD  3,-10(1) 	Load variable were
293:     ST  3,-26(1) 	Save left side 
294:     LD  3,-11(1) 	Load variable rabbit
295:     LD  4,-26(1) 	Load left into ac1 
296:    SUB  4,4,3 	Op == 
297:    LDC  3,1(6) 	True case 
298:    JEQ  4,1(7) 	Jump if true 
299:    LDC  3,0(6) 	False case 
300:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
302:     LD  3,-24(1) 	load lhs variable wrong
303:    LDA  3,-1(3) 	decrement value of wrong
304:     ST  3,-24(1) 	Store variable wrong
305:     ST  3,-10(1) 	Store variable were
301:    LDA  7,4(7) 	Jump around the THEN 
* ENDIF
* END compound statement
* END compound statement
306:    LDA  7,-63(7) 	go to beginning of loop 
246:    LDA  7,60(7) 	No more loop 
* ENDWHILE
* RETURN
307:    LDA  2,0(3) 	Copy result to rt register 
308:     LD  3,-1(1) 	Load return address 
309:     LD  1,0(1) 	Adjust fp 
310:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
311:    LDC  2,0(6) 	Set return value to 0 
312:     LD  3,-1(1) 	Load return address 
313:     LD  1,0(1) 	Adjust fp 
314:    LDA  7,0(3) 	Return 
* END of function wallace
* BEGIN function Wendolene
315:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* RETURN
316:     LD  3,-2(1) 	Load variable wool
317:     ST  3,-6(1) 	Save left side 
318:    LDC  3,0(6) 	Load constant 
319:     LD  4,-4(1) 	Load address of base of array yarn
320:    SUB  3,4,3 	Compute offset of value 
321:     LD  3,0(3) 	Load the value 
322:     LD  4,-6(1) 	Load left into ac1 
323:    ADD  3,4,3 	Op + 
324:     ST  3,-6(1) 	Save left side 
325:     LD  3,-4(1) 	Load address of base of array yarn
326:     LD  3,1(3) 	Load array size 
327:     LD  4,-6(1) 	Load left into ac1 
328:    ADD  3,4,3 	Op + 
329:     ST  3,-6(1) 	Save left side 
330:    LDC  3,7(6) 	Load constant 
331:     ST  3,-7(1) 	Save left side 
332:     LD  3,-2(1) 	Load variable wool
333:     LD  4,-7(1) 	Load left into ac1 
334:    MUL  3,4,3 	Op * 
335:     LD  4,-4(1) 	Load address of base of array yarn
336:    SUB  3,4,3 	Compute offset of value 
337:     LD  3,0(3) 	Load the value 
338:     LD  4,-6(1) 	Load left into ac1 
339:    ADD  3,4,3 	Op + 
340:    LDA  2,0(3) 	Copy result to rt register 
341:     LD  3,-1(1) 	Load return address 
342:     LD  1,0(1) 	Adjust fp 
343:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
344:    LDC  2,0(6) 	Set return value to 0 
345:     LD  3,-1(1) 	Load return address 
346:     LD  1,0(1) 	Adjust fp 
347:    LDA  7,0(3) 	Return 
* END of function Wendolene
* BEGIN function ramsBottom
348:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
349:    LDC  3,2(6) 	load size of array chicken
350:     ST  3,-2(1) 	save size of array chicken
351:    LDC  3,3(6) 	load size of array run
352:     ST  3,-5(1) 	save size of array run
353:    LDC  3,2(6) 	load size of array wallace
354:     ST  3,-9(1) 	save size of array wallace
355:    LDC  3,3(6) 	load size of array gromit
356:     ST  3,-12(1) 	save size of array gromit
* EXPRESSION STMT
357:    LDC  3,42(6) 	Load constant 
358:     ST  3,-16(1) 	Save left side 
359:     ST  1,-17(1) 	Store old fp in ghost frame 
360:    LDC  3,1(6) 	Load constant 
361:     ST  3,-19(1) 	Save left side 
362:    LDC  3,2(6) 	Load constant 
363:     LD  4,-19(1) 	Load left into ac1 
364:    ADD  3,4,3 	Op + 
365:     ST  3,-19(1) 	Save left side 
366:    LDC  3,3(6) 	Load constant 
367:     LD  4,-19(1) 	Load left into ac1 
368:    ADD  3,4,3 	Op + 
369:     ST  3,-19(1) 	Store parameter 
370:    LDC  3,1(6) 	Load constant 
371:    LDC  4,1(6) 	Load 1 
372:    SUB  3,4,3 	Op NOT 
373:     ST  3,-20(1) 	Save left side 
374:    LDC  3,1(6) 	Load constant 
375:     ST  3,-21(1) 	Save left side 
376:    LDC  3,0(6) 	Load constant 
377:     LD  4,-21(1) 	Load left into ac1 
378:    JEQ  3,1(7) 	Op AND 
379:    LDA  3,0(4) 	 
380:     LD  4,-20(1) 	Load left into ac1 
381:    JGT  3,1(7) 	Op OR 
382:    LDA  3,0(4) 	 
383:     ST  3,-20(1) 	Store parameter 
384:    LDA  3,-3(1) 	Load address of base of array chicken
385:     ST  3,-21(1) 	Store parameter 
386:    LDA  3,-6(1) 	Load address of base of array run
387:     ST  3,-22(1) 	Store parameter 
388:    LDA  1,-17(1) 	Load address of new frame 
389:    LDA  3,1(7) 	Return address in ac 
390:    LDA  7,-76(7) 	CALL Wendolene
391:    LDA  3,0(2) 	Save the result in ac 
392:     LD  4,-16(1) 	Load left into ac1 
393:    MUL  3,4,3 	Op * 
* EXPRESSION STMT
394:    LDA  3,-6(1) 	Load address of base of array run
395:     LD  3,1(3) 	Load array size 
396:     ST  3,-16(1) 	Save left side 
397:    LDC  3,1(6) 	Load constant 
398:     LD  4,-16(1) 	Load left into ac1 
399:    SUB  3,4,3 	Op - 
400:    LDA  4,-6(1) 	Load address of base of array run
401:    SUB  3,4,3 	Compute offset of value 
402:     LD  3,0(3) 	Load the value 
* RETURN
403:    LDC  3,1(6) 	Load constant 
404:    LDA  4,-10(1) 	Load address of base of array wallace
405:    SUB  3,4,3 	Compute offset of value 
406:     LD  3,0(3) 	Load the value 
407:     ST  3,-16(1) 	Save left side 
408:    LDC  3,2(6) 	Load constant 
409:    LDA  4,-13(1) 	Load address of base of array gromit
410:    SUB  3,4,3 	Compute offset of value 
411:     LD  3,0(3) 	Load the value 
412:    LDC  4,0(6) 	Load 0 
413:    SUB  3,4,3 	Op unary - 
414:     ST  3,-17(1) 	Save left side 
415:    LDC  3,3(6) 	Load constant 
416:     LD  4,-17(1) 	Load left into ac1 
417:    MUL  3,4,3 	Op * 
418:     LD  4,-16(1) 	Load left into ac1 
419:    SUB  4,4,3 	Op >= 
420:    LDC  3,1(6) 	True case 
421:    JGE  4,1(7) 	Jump if true 
422:    LDC  3,0(6) 	False case 
423:    LDC  4,1(6) 	Load 1 
424:    SUB  3,4,3 	Op NOT 
425:    LDA  2,0(3) 	Copy result to rt register 
426:     LD  3,-1(1) 	Load return address 
427:     LD  1,0(1) 	Adjust fp 
428:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
429:    LDC  2,0(6) 	Set return value to 0 
430:     LD  3,-1(1) 	Load return address 
431:     LD  1,0(1) 	Adjust fp 
432:    LDA  7,0(3) 	Return 
* END of function ramsBottom
* BEGIN function cheese
433:     ST  3,-1(1) 	Store return address. 
* WHILE
434:     LD  3,-2(1) 	Load variable x
435:     ST  3,-4(1) 	Save left side 
436:    LDC  3,0(6) 	Load constant 
437:     LD  4,-4(1) 	Load left into ac1 
438:    SUB  4,4,3 	Op > 
439:    LDC  3,1(6) 	True case 
440:    JGT  4,1(7) 	Jump if true 
441:    LDC  3,0(6) 	False case 
442:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
444:     LD  3,-3(1) 	Load variable y
445:     ST  3,-4(1) 	Save left side 
446:    LDC  3,3(6) 	Load constant 
447:     LD  4,-4(1) 	Load left into ac1 
448:    SUB  4,4,3 	Op > 
449:    LDC  3,1(6) 	True case 
450:    JGT  4,1(7) 	Jump if true 
451:    LDC  3,0(6) 	False case 
452:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
454:     LD  3,-2(1) 	load lhs variable x
455:    LDA  3,-1(3) 	decrement value of x
456:     ST  3,-2(1) 	Store variable x
* ELSE
453:    LDA  7,4(7) 	Jump around the THEN 
* RETURN
458:     LD  3,-2(1) 	Load variable x
459:     ST  3,-4(1) 	Save left side 
460:     LD  3,-2(1) 	Load variable x
461:     LD  4,-4(1) 	Load left into ac1 
462:    MUL  3,4,3 	Op * 
463:     ST  3,-4(1) 	Save left side 
464:     LD  3,-3(1) 	Load variable y
465:     LD  4,-4(1) 	Load left into ac1 
466:    DIV  5,4,3 	Op % 
467:    MUL  5,5,3 	 
468:    SUB  3,4,5 	 
469:    LDA  2,0(3) 	Copy result to rt register 
470:     LD  3,-1(1) 	Load return address 
471:     LD  1,0(1) 	Adjust fp 
472:    LDA  7,0(3) 	Return 
457:    LDA  7,15(7) 	Jump around the ELSE 
* ENDIF
473:    LDA  7,-40(7) 	go to beginning of loop 
443:    LDA  7,30(7) 	No more loop 
* ENDWHILE
* Add standard closing in case there is no return statement
474:    LDC  2,0(6) 	Set return value to 0 
475:     LD  3,-1(1) 	Load return address 
476:     LD  1,0(1) 	Adjust fp 
477:    LDA  7,0(3) 	Return 
* END of function cheese
* BEGIN function Wensleydale
478:     ST  3,-1(1) 	Store return address. 
* RETURN
479:     ST  1,-4(1) 	Store old fp in ghost frame 
480:     LD  3,-2(1) 	Load variable x
481:     ST  3,-6(1) 	Store parameter 
482:     LD  3,0(0) 	Load variable gromit
483:     ST  3,-7(1) 	Store parameter 
484:    LDA  1,-4(1) 	Load address of new frame 
485:    LDA  3,1(7) 	Return address in ac 
486:    LDA  7,-54(7) 	CALL cheese
487:    LDA  3,0(2) 	Save the result in ac 
488:    LDA  2,0(3) 	Copy result to rt register 
489:     LD  3,-1(1) 	Load return address 
490:     LD  1,0(1) 	Adjust fp 
491:    LDA  7,0(3) 	Return 
* Add standard closing in case there is no return statement
492:    LDC  2,0(6) 	Set return value to 0 
493:     LD  3,-1(1) 	Load return address 
494:     LD  1,0(1) 	Adjust fp 
495:    LDA  7,0(3) 	Return 
* END of function Wensleydale
* BEGIN function main
496:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
497:    LDC  3,113(6) 	load size of array yarn
498:     ST  3,-3(1) 	save size of array yarn
499:    LDC  3,22(6) 	load size of array preston
500:     ST  3,-118(1) 	save size of array preston
* EXPRESSION STMT
501:     ST  1,-141(1) 	Store old fp in ghost frame 
502:     ST  1,-143(1) 	Store old fp in ghost frame 
503:    LDC  3,62(6) 	Load constant 
504:     ST  3,-145(1) 	Store parameter 
505:    LDC  3,62(6) 	Load constant 
506:     ST  3,-146(1) 	Store parameter 
507:    LDA  1,-143(1) 	Load address of new frame 
508:    LDA  3,1(7) 	Return address in ac 
509:    LDA  7,-77(7) 	CALL cheese
510:    LDA  3,0(2) 	Save the result in ac 
511:     ST  3,-143(1) 	Store parameter 
512:     LD  3,0(0) 	Load variable gromit
513:     ST  3,-144(1) 	Store parameter 
514:    LDA  1,-141(1) 	Load address of new frame 
515:    LDA  3,1(7) 	Return address in ac 
516:    LDA  7,-487(7) 	CALL wallace
517:    LDA  3,0(2) 	Save the result in ac 
* RETURN
518:     ST  1,-141(1) 	Store old fp in ghost frame 
519:    LDA  3,-119(1) 	Load address of base of array preston
520:     LD  3,1(3) 	Load array size 
521:     ST  3,-143(1) 	Save left side 
522:    LDA  3,-4(1) 	Load address of base of array yarn
523:     LD  3,1(3) 	Load array size 
524:     LD  4,-143(1) 	Load left into ac1 
525:    MUL  3,4,3 	Op * 
526:     ST  3,-143(1) 	Store parameter 
527:     LD  3,-117(1) 	Load variable shawn
528:     ST  3,-144(1) 	Store parameter 
529:    LDA  3,-4(1) 	Load address of base of array yarn
530:     ST  3,-145(1) 	Store parameter 
531:    LDA  3,-119(1) 	Load address of base of array preston
532:     ST  3,-146(1) 	Store parameter 
533:    LDA  1,-141(1) 	Load address of new frame 
534:    LDA  3,1(7) 	Return address in ac 
535:    LDA  7,-221(7) 	CALL Wendolene
536:    LDA  3,0(2) 	Save the result in ac 
537:    LDA  2,0(3) 	Copy result to rt register 
538:     LD  3,-1(1) 	Load return address 
539:     LD  1,0(1) 	Adjust fp 
540:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
541:    LDC  2,0(6) 	Set return value to 0 
542:     LD  3,-1(1) 	Load return address 
543:     LD  1,0(1) 	Adjust fp 
544:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,544(7) 	Jump to init 
* BEGIN Init
545:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
546:    LDA  1,-1(0) 	set first frame at end of globals 
547:     ST  1,0(1) 	store old fp (point to self) 
548:    LDA  3,1(7) 	Return address in ac 
549:    LDA  7,-54(7) 	Jump to main 
550:   HALT  0,0,0 	DONE! 
* END Init
