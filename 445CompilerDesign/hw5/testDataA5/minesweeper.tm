* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  minesweeper.c-
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
* BEGIN function Random
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 31:     LD  3,0(0) 	Load variable seed
 32:     ST  3,-3(1) 	Save left side 
 33:    LDC  3,1103515245(6) 	Load constant 
 34:     LD  4,-3(1) 	Load left into ac1 
 35:    MUL  3,4,3 	Op * 
 36:     ST  3,-3(1) 	Save left side 
 37:    LDC  3,12345(6) 	Load constant 
 38:     LD  4,-3(1) 	Load left into ac1 
 39:    ADD  3,4,3 	Op + 
 40:     ST  3,0(0) 	Store variable seed
* EXPRESSION STMT
 41:     LD  3,0(0) 	Load variable seed
 42:     ST  3,-3(1) 	Save left side 
 43:    LDC  3,65536(6) 	Load constant 
 44:     LD  4,-3(1) 	Load left into ac1 
 45:    DIV  3,4,3 	Op / 
 46:     ST  3,-3(1) 	Save left side 
 47:    LDC  3,32768(6) 	Load constant 
 48:     LD  4,-3(1) 	Load left into ac1 
 49:    DIV  5,4,3 	Op % 
 50:    MUL  5,5,3 	 
 51:    SUB  3,4,5 	 
 52:     ST  3,-2(1) 	Store variable rand
* IF
 53:     LD  3,-2(1) 	Load variable rand
 54:     ST  3,-3(1) 	Save left side 
 55:    LDC  3,0(6) 	Load constant 
 56:     LD  4,-3(1) 	Load left into ac1 
 57:    SUB  4,4,3 	Op < 
 58:    LDC  3,1(6) 	True case 
 59:    JLT  4,1(7) 	Jump if true 
 60:    LDC  3,0(6) 	False case 
 61:    JGT  3,1(7) 	Jump to then part 
* THEN
* RETURN
 63:     LD  3,-2(1) 	Load variable rand
 64:    LDC  4,0(6) 	Load 0 
 65:    SUB  3,4,3 	Op unary - 
 66:     ST  3,-3(1) 	Save left side 
 67:    LDC  3,100(6) 	Load constant 
 68:     LD  4,-3(1) 	Load left into ac1 
 69:    DIV  5,4,3 	Op % 
 70:    MUL  5,5,3 	 
 71:    SUB  3,4,5 	 
 72:    LDA  2,0(3) 	Copy result to rt register 
 73:     LD  3,-1(1) 	Load return address 
 74:     LD  1,0(1) 	Adjust fp 
 75:    LDA  7,0(3) 	Return 
* ELSE
 62:    LDA  7,14(7) 	Jump around the THEN 
* RETURN
 77:     LD  3,-2(1) 	Load variable rand
 78:     ST  3,-3(1) 	Save left side 
 79:    LDC  3,100(6) 	Load constant 
 80:     LD  4,-3(1) 	Load left into ac1 
 81:    DIV  5,4,3 	Op % 
 82:    MUL  5,5,3 	 
 83:    SUB  3,4,5 	 
 84:    LDA  2,0(3) 	Copy result to rt register 
 85:     LD  3,-1(1) 	Load return address 
 86:     LD  1,0(1) 	Adjust fp 
 87:    LDA  7,0(3) 	Return 
 76:    LDA  7,11(7) 	Jump around the ELSE 
* ENDIF
* END compound statement
* Add standard closing in case there is no return statement
 88:    LDC  2,0(6) 	Set return value to 0 
 89:     LD  3,-1(1) 	Load return address 
 90:     LD  1,0(1) 	Adjust fp 
 91:    LDA  7,0(3) 	Return 
* END of function Random
* BEGIN function CreateBoard
 92:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 93:    LDC  3,0(6) 	Load constant 
 94:     ST  3,-2(1) 	Store variable i
* WHILE
 95:     LD  3,-2(1) 	Load variable i
 96:     ST  3,-5(1) 	Save left side 
 97:    LDC  3,100(6) 	Load constant 
 98:     LD  4,-5(1) 	Load left into ac1 
 99:    SUB  4,4,3 	Op < 
100:    LDC  3,1(6) 	True case 
101:    JLT  4,1(7) 	Jump if true 
102:    LDC  3,0(6) 	False case 
103:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
105:     LD  3,-2(1) 	Load variable i
106:     ST  3,-5(1) 	Save index 
107:    LDC  3,0(6) 	Load constant 
108:     LD  4,-5(1) 	Restore index 
109:    LDA  5,-103(0) 	Load address of base of array guess
110:    SUB  5,5,4 	Compute offset of value 
111:     ST  3,0(5) 	Store variable guess
* EXPRESSION STMT
112:     LD  3,-2(1) 	load lhs variable i
113:    LDA  3,1(3) 	increment value of i
114:     ST  3,-2(1) 	Store variable i
* END compound statement
115:    LDA  7,-21(7) 	go to beginning of loop 
104:    LDA  7,11(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
116:    LDC  3,0(6) 	Load constant 
117:     ST  3,-2(1) 	Store variable i
* WHILE
118:     LD  3,-2(1) 	Load variable i
119:     ST  3,-5(1) 	Save left side 
120:    LDC  3,100(6) 	Load constant 
121:     LD  4,-5(1) 	Load left into ac1 
122:    SUB  4,4,3 	Op < 
123:    LDC  3,1(6) 	True case 
124:    JLT  4,1(7) 	Jump if true 
125:    LDC  3,0(6) 	False case 
126:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
128:     LD  3,-2(1) 	Load variable i
129:     ST  3,-5(1) 	Save index 
130:    LDC  3,0(6) 	Load constant 
131:     LD  4,-5(1) 	Restore index 
132:    LDA  5,-2(0) 	Load address of base of array board
133:    SUB  5,5,4 	Compute offset of value 
134:     ST  3,0(5) 	Store variable board
* EXPRESSION STMT
135:     LD  3,-2(1) 	load lhs variable i
136:    LDA  3,1(3) 	increment value of i
137:     ST  3,-2(1) 	Store variable i
* END compound statement
138:    LDA  7,-21(7) 	go to beginning of loop 
127:    LDA  7,11(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
139:    LDC  3,0(6) 	Load constant 
140:     ST  3,-2(1) 	Store variable i
* WHILE
141:     LD  3,-2(1) 	Load variable i
142:     ST  3,-5(1) 	Save left side 
143:    LDC  3,15(6) 	Load constant 
144:     LD  4,-5(1) 	Load left into ac1 
145:    SUB  4,4,3 	Op <= 
146:    LDC  3,1(6) 	True case 
147:    JLE  4,1(7) 	Jump if true 
148:    LDC  3,0(6) 	False case 
149:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* WHILE
151:    LDC  3,1(6) 	Load constant 
152:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
154:     ST  1,-5(1) 	Store old fp in ghost frame 
155:    LDA  1,-5(1) 	Load address of new frame 
156:    LDA  3,1(7) 	Return address in ac 
157:    LDA  7,-128(7) 	CALL Random
158:    LDA  3,0(2) 	Save the result in ac 
159:     ST  3,-4(1) 	Store variable rand
* IF
160:     LD  3,-4(1) 	Load variable rand
161:    LDA  4,-2(0) 	Load address of base of array board
162:    SUB  3,4,3 	Compute offset of value 
163:     LD  3,0(3) 	Load the value 
164:     ST  3,-5(1) 	Save left side 
165:    LDC  3,1(6) 	Load constant 
166:    LDC  4,0(6) 	Load 0 
167:    SUB  3,4,3 	Op unary - 
168:     LD  4,-5(1) 	Load left into ac1 
169:    SUB  3,4,3 	Op != 
170:    JEQ  3,1(7) 	Jump if true 
171:    LDC  3,1(6) 	True case 
172:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
174:     LD  3,-4(1) 	Load variable rand
175:     ST  3,-5(1) 	Save index 
176:    LDC  3,1(6) 	Load constant 
177:    LDC  4,0(6) 	Load 0 
178:    SUB  3,4,3 	Op unary - 
179:     LD  4,-5(1) 	Restore index 
180:    LDA  5,-2(0) 	Load address of base of array board
181:    SUB  5,5,4 	Compute offset of value 
182:     ST  3,0(5) 	Store variable board
* EXPRESSION STMT
183:     ST  1,-5(1) 	Store old fp in ghost frame 
184:     LD  3,-4(1) 	Load variable rand
185:     ST  3,-7(1) 	Store parameter 
186:    LDA  1,-5(1) 	Load address of new frame 
187:    LDA  3,1(7) 	Return address in ac 
188:    LDA  7,-183(7) 	CALL output
189:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
190:     ST  1,-5(1) 	Store old fp in ghost frame 
191:    LDA  1,-5(1) 	Load address of new frame 
192:    LDA  3,1(7) 	Return address in ac 
193:    LDA  7,-169(7) 	CALL outnl
194:    LDA  3,0(2) 	Save the result in ac 
* IF
195:     LD  3,-4(1) 	Load variable rand
196:     ST  3,-5(1) 	Save left side 
197:    LDC  3,10(6) 	Load constant 
198:     LD  4,-5(1) 	Load left into ac1 
199:    DIV  5,4,3 	Op % 
200:    MUL  5,5,3 	 
201:    SUB  3,4,5 	 
202:     ST  3,-5(1) 	Save left side 
203:    LDC  3,0(6) 	Load constant 
204:     LD  4,-5(1) 	Load left into ac1 
205:    SUB  3,4,3 	Op != 
206:    JEQ  3,1(7) 	Jump if true 
207:    LDC  3,1(6) 	True case 
208:     ST  3,-5(1) 	Save left side 
209:     LD  3,-4(1) 	Load variable rand
210:     ST  3,-6(1) 	Save left side 
211:    LDC  3,9(6) 	Load constant 
212:     LD  4,-6(1) 	Load left into ac1 
213:    SUB  4,4,3 	Op > 
214:    LDC  3,1(6) 	True case 
215:    JGT  4,1(7) 	Jump if true 
216:    LDC  3,0(6) 	False case 
217:     LD  4,-5(1) 	Load left into ac1 
218:    JEQ  3,1(7) 	Op AND 
219:    LDA  3,0(4) 	 
220:    JGT  3,1(7) 	Jump to then part 
* THEN
* IF
222:     LD  3,-4(1) 	Load variable rand
223:     ST  3,-5(1) 	Save left side 
224:    LDC  3,11(6) 	Load constant 
225:     LD  4,-5(1) 	Load left into ac1 
226:    SUB  3,4,3 	Op - 
227:    LDA  4,-2(0) 	Load address of base of array board
228:    SUB  3,4,3 	Compute offset of value 
229:     LD  3,0(3) 	Load the value 
230:     ST  3,-5(1) 	Save left side 
231:    LDC  3,1(6) 	Load constant 
232:    LDC  4,0(6) 	Load 0 
233:    SUB  3,4,3 	Op unary - 
234:     LD  4,-5(1) 	Load left into ac1 
235:    SUB  3,4,3 	Op != 
236:    JEQ  3,1(7) 	Jump if true 
237:    LDC  3,1(6) 	True case 
238:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
240:     LD  3,-4(1) 	Load variable rand
241:     ST  3,-5(1) 	Save left side 
242:    LDC  3,11(6) 	Load constant 
243:     LD  4,-5(1) 	Load left into ac1 
244:    SUB  3,4,3 	Op - 
245:    LDA  5,-2(0) 	Load address of base of array board
246:    SUB  5,5,3 	Compute offset of value 
247:     LD  3,0(5) 	load lhs variable board
248:    LDA  3,1(3) 	increment value of board
249:     ST  3,0(5) 	Store variable board
239:    LDA  7,10(7) 	Jump around the THEN 
* ENDIF
221:    LDA  7,28(7) 	Jump around the THEN 
* ENDIF
* IF
250:     LD  3,-4(1) 	Load variable rand
251:     ST  3,-5(1) 	Save left side 
252:    LDC  3,9(6) 	Load constant 
253:     LD  4,-5(1) 	Load left into ac1 
254:    SUB  4,4,3 	Op > 
255:    LDC  3,1(6) 	True case 
256:    JGT  4,1(7) 	Jump if true 
257:    LDC  3,0(6) 	False case 
258:    JGT  3,1(7) 	Jump to then part 
* THEN
* IF
260:     LD  3,-4(1) 	Load variable rand
261:     ST  3,-5(1) 	Save left side 
262:    LDC  3,10(6) 	Load constant 
263:     LD  4,-5(1) 	Load left into ac1 
264:    SUB  3,4,3 	Op - 
265:    LDA  4,-2(0) 	Load address of base of array board
266:    SUB  3,4,3 	Compute offset of value 
267:     LD  3,0(3) 	Load the value 
268:     ST  3,-5(1) 	Save left side 
269:    LDC  3,1(6) 	Load constant 
270:    LDC  4,0(6) 	Load 0 
271:    SUB  3,4,3 	Op unary - 
272:     LD  4,-5(1) 	Load left into ac1 
273:    SUB  3,4,3 	Op != 
274:    JEQ  3,1(7) 	Jump if true 
275:    LDC  3,1(6) 	True case 
276:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
278:     LD  3,-4(1) 	Load variable rand
279:     ST  3,-5(1) 	Save left side 
280:    LDC  3,10(6) 	Load constant 
281:     LD  4,-5(1) 	Load left into ac1 
282:    SUB  3,4,3 	Op - 
283:    LDA  5,-2(0) 	Load address of base of array board
284:    SUB  5,5,3 	Compute offset of value 
285:     LD  3,0(5) 	load lhs variable board
286:    LDA  3,1(3) 	increment value of board
287:     ST  3,0(5) 	Store variable board
277:    LDA  7,10(7) 	Jump around the THEN 
* ENDIF
259:    LDA  7,28(7) 	Jump around the THEN 
* ENDIF
* IF
288:     LD  3,-4(1) 	Load variable rand
289:     ST  3,-5(1) 	Save left side 
290:    LDC  3,9(6) 	Load constant 
291:     LD  4,-5(1) 	Load left into ac1 
292:    DIV  5,4,3 	Op % 
293:    MUL  5,5,3 	 
294:    SUB  3,4,5 	 
295:     ST  3,-5(1) 	Save left side 
296:    LDC  3,0(6) 	Load constant 
297:     LD  4,-5(1) 	Load left into ac1 
298:    SUB  3,4,3 	Op != 
299:    JEQ  3,1(7) 	Jump if true 
300:    LDC  3,1(6) 	True case 
301:     ST  3,-5(1) 	Save left side 
302:     LD  3,-4(1) 	Load variable rand
303:     ST  3,-6(1) 	Save left side 
304:    LDC  3,9(6) 	Load constant 
305:     LD  4,-6(1) 	Load left into ac1 
306:    SUB  4,4,3 	Op > 
307:    LDC  3,1(6) 	True case 
308:    JGT  4,1(7) 	Jump if true 
309:    LDC  3,0(6) 	False case 
310:     LD  4,-5(1) 	Load left into ac1 
311:    JEQ  3,1(7) 	Op AND 
312:    LDA  3,0(4) 	 
313:    JGT  3,1(7) 	Jump to then part 
* THEN
* IF
315:     LD  3,-4(1) 	Load variable rand
316:     ST  3,-5(1) 	Save left side 
317:    LDC  3,9(6) 	Load constant 
318:     LD  4,-5(1) 	Load left into ac1 
319:    SUB  3,4,3 	Op - 
320:    LDA  4,-2(0) 	Load address of base of array board
321:    SUB  3,4,3 	Compute offset of value 
322:     LD  3,0(3) 	Load the value 
323:     ST  3,-5(1) 	Save left side 
324:    LDC  3,1(6) 	Load constant 
325:    LDC  4,0(6) 	Load 0 
326:    SUB  3,4,3 	Op unary - 
327:     LD  4,-5(1) 	Load left into ac1 
328:    SUB  3,4,3 	Op != 
329:    JEQ  3,1(7) 	Jump if true 
330:    LDC  3,1(6) 	True case 
331:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
333:     LD  3,-4(1) 	Load variable rand
334:     ST  3,-5(1) 	Save left side 
335:    LDC  3,9(6) 	Load constant 
336:     LD  4,-5(1) 	Load left into ac1 
337:    SUB  3,4,3 	Op - 
338:    LDA  5,-2(0) 	Load address of base of array board
339:    SUB  5,5,3 	Compute offset of value 
340:     LD  3,0(5) 	load lhs variable board
341:    LDA  3,1(3) 	increment value of board
342:     ST  3,0(5) 	Store variable board
332:    LDA  7,10(7) 	Jump around the THEN 
* ENDIF
314:    LDA  7,28(7) 	Jump around the THEN 
* ENDIF
* IF
343:     LD  3,-4(1) 	Load variable rand
344:     ST  3,-5(1) 	Save left side 
345:    LDC  3,10(6) 	Load constant 
346:     LD  4,-5(1) 	Load left into ac1 
347:    DIV  5,4,3 	Op % 
348:    MUL  5,5,3 	 
349:    SUB  3,4,5 	 
350:     ST  3,-5(1) 	Save left side 
351:    LDC  3,0(6) 	Load constant 
352:     LD  4,-5(1) 	Load left into ac1 
353:    SUB  3,4,3 	Op != 
354:    JEQ  3,1(7) 	Jump if true 
355:    LDC  3,1(6) 	True case 
356:    JGT  3,1(7) 	Jump to then part 
* THEN
* IF
358:     LD  3,-4(1) 	Load variable rand
359:     ST  3,-5(1) 	Save left side 
360:    LDC  3,1(6) 	Load constant 
361:     LD  4,-5(1) 	Load left into ac1 
362:    SUB  3,4,3 	Op - 
363:    LDA  4,-2(0) 	Load address of base of array board
364:    SUB  3,4,3 	Compute offset of value 
365:     LD  3,0(3) 	Load the value 
366:     ST  3,-5(1) 	Save left side 
367:    LDC  3,1(6) 	Load constant 
368:    LDC  4,0(6) 	Load 0 
369:    SUB  3,4,3 	Op unary - 
370:     LD  4,-5(1) 	Load left into ac1 
371:    SUB  3,4,3 	Op != 
372:    JEQ  3,1(7) 	Jump if true 
373:    LDC  3,1(6) 	True case 
374:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
376:     LD  3,-4(1) 	Load variable rand
377:     ST  3,-5(1) 	Save left side 
378:    LDC  3,1(6) 	Load constant 
379:     LD  4,-5(1) 	Load left into ac1 
380:    SUB  3,4,3 	Op - 
381:    LDA  5,-2(0) 	Load address of base of array board
382:    SUB  5,5,3 	Compute offset of value 
383:     LD  3,0(5) 	load lhs variable board
384:    LDA  3,1(3) 	increment value of board
385:     ST  3,0(5) 	Store variable board
375:    LDA  7,10(7) 	Jump around the THEN 
* ENDIF
357:    LDA  7,28(7) 	Jump around the THEN 
* ENDIF
* IF
386:     LD  3,-4(1) 	Load variable rand
387:     ST  3,-5(1) 	Save left side 
388:    LDC  3,9(6) 	Load constant 
389:     LD  4,-5(1) 	Load left into ac1 
390:    DIV  5,4,3 	Op % 
391:    MUL  5,5,3 	 
392:    SUB  3,4,5 	 
393:     ST  3,-5(1) 	Save left side 
394:    LDC  3,0(6) 	Load constant 
395:     LD  4,-5(1) 	Load left into ac1 
396:    SUB  3,4,3 	Op != 
397:    JEQ  3,1(7) 	Jump if true 
398:    LDC  3,1(6) 	True case 
399:     ST  3,-5(1) 	Save left side 
400:     LD  3,-4(1) 	Load variable rand
401:     ST  3,-6(1) 	Save left side 
402:    LDC  3,0(6) 	Load constant 
403:     LD  4,-6(1) 	Load left into ac1 
404:    SUB  4,4,3 	Op == 
405:    LDC  3,1(6) 	True case 
406:    JEQ  4,1(7) 	Jump if true 
407:    LDC  3,0(6) 	False case 
408:     LD  4,-5(1) 	Load left into ac1 
409:    JGT  3,1(7) 	Op OR 
410:    LDA  3,0(4) 	 
411:    JGT  3,1(7) 	Jump to then part 
* THEN
* IF
413:     LD  3,-4(1) 	Load variable rand
414:     ST  3,-5(1) 	Save left side 
415:    LDC  3,1(6) 	Load constant 
416:     LD  4,-5(1) 	Load left into ac1 
417:    ADD  3,4,3 	Op + 
418:    LDA  4,-2(0) 	Load address of base of array board
419:    SUB  3,4,3 	Compute offset of value 
420:     LD  3,0(3) 	Load the value 
421:     ST  3,-5(1) 	Save left side 
422:    LDC  3,1(6) 	Load constant 
423:    LDC  4,0(6) 	Load 0 
424:    SUB  3,4,3 	Op unary - 
425:     LD  4,-5(1) 	Load left into ac1 
426:    SUB  3,4,3 	Op != 
427:    JEQ  3,1(7) 	Jump if true 
428:    LDC  3,1(6) 	True case 
429:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
431:     LD  3,-4(1) 	Load variable rand
432:     ST  3,-5(1) 	Save left side 
433:    LDC  3,1(6) 	Load constant 
434:     LD  4,-5(1) 	Load left into ac1 
435:    ADD  3,4,3 	Op + 
436:    LDA  5,-2(0) 	Load address of base of array board
437:    SUB  5,5,3 	Compute offset of value 
438:     LD  3,0(5) 	load lhs variable board
439:    LDA  3,1(3) 	increment value of board
440:     ST  3,0(5) 	Store variable board
430:    LDA  7,10(7) 	Jump around the THEN 
* ENDIF
412:    LDA  7,28(7) 	Jump around the THEN 
* ENDIF
* IF
441:     LD  3,-4(1) 	Load variable rand
442:     ST  3,-5(1) 	Save left side 
443:    LDC  3,10(6) 	Load constant 
444:     LD  4,-5(1) 	Load left into ac1 
445:    DIV  5,4,3 	Op % 
446:    MUL  5,5,3 	 
447:    SUB  3,4,5 	 
448:     ST  3,-5(1) 	Save left side 
449:    LDC  3,0(6) 	Load constant 
450:     LD  4,-5(1) 	Load left into ac1 
451:    SUB  3,4,3 	Op != 
452:    JEQ  3,1(7) 	Jump if true 
453:    LDC  3,1(6) 	True case 
454:     ST  3,-5(1) 	Save left side 
455:     LD  3,-4(1) 	Load variable rand
456:     ST  3,-6(1) 	Save left side 
457:    LDC  3,90(6) 	Load constant 
458:     LD  4,-6(1) 	Load left into ac1 
459:    SUB  4,4,3 	Op < 
460:    LDC  3,1(6) 	True case 
461:    JLT  4,1(7) 	Jump if true 
462:    LDC  3,0(6) 	False case 
463:     LD  4,-5(1) 	Load left into ac1 
464:    JEQ  3,1(7) 	Op AND 
465:    LDA  3,0(4) 	 
466:    JGT  3,1(7) 	Jump to then part 
* THEN
* IF
468:     LD  3,-4(1) 	Load variable rand
469:     ST  3,-5(1) 	Save left side 
470:    LDC  3,9(6) 	Load constant 
471:     LD  4,-5(1) 	Load left into ac1 
472:    ADD  3,4,3 	Op + 
473:    LDA  4,-2(0) 	Load address of base of array board
474:    SUB  3,4,3 	Compute offset of value 
475:     LD  3,0(3) 	Load the value 
476:     ST  3,-5(1) 	Save left side 
477:    LDC  3,1(6) 	Load constant 
478:    LDC  4,0(6) 	Load 0 
479:    SUB  3,4,3 	Op unary - 
480:     LD  4,-5(1) 	Load left into ac1 
481:    SUB  3,4,3 	Op != 
482:    JEQ  3,1(7) 	Jump if true 
483:    LDC  3,1(6) 	True case 
484:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
486:     LD  3,-4(1) 	Load variable rand
487:     ST  3,-5(1) 	Save left side 
488:    LDC  3,9(6) 	Load constant 
489:     LD  4,-5(1) 	Load left into ac1 
490:    ADD  3,4,3 	Op + 
491:    LDA  5,-2(0) 	Load address of base of array board
492:    SUB  5,5,3 	Compute offset of value 
493:     LD  3,0(5) 	load lhs variable board
494:    LDA  3,1(3) 	increment value of board
495:     ST  3,0(5) 	Store variable board
485:    LDA  7,10(7) 	Jump around the THEN 
* ENDIF
467:    LDA  7,28(7) 	Jump around the THEN 
* ENDIF
* IF
496:     LD  3,-4(1) 	Load variable rand
497:     ST  3,-5(1) 	Save left side 
498:    LDC  3,90(6) 	Load constant 
499:     LD  4,-5(1) 	Load left into ac1 
500:    SUB  4,4,3 	Op < 
501:    LDC  3,1(6) 	True case 
502:    JLT  4,1(7) 	Jump if true 
503:    LDC  3,0(6) 	False case 
504:    JGT  3,1(7) 	Jump to then part 
* THEN
* IF
506:     LD  3,-4(1) 	Load variable rand
507:     ST  3,-5(1) 	Save left side 
508:    LDC  3,10(6) 	Load constant 
509:     LD  4,-5(1) 	Load left into ac1 
510:    ADD  3,4,3 	Op + 
511:    LDA  4,-2(0) 	Load address of base of array board
512:    SUB  3,4,3 	Compute offset of value 
513:     LD  3,0(3) 	Load the value 
514:     ST  3,-5(1) 	Save left side 
515:    LDC  3,1(6) 	Load constant 
516:    LDC  4,0(6) 	Load 0 
517:    SUB  3,4,3 	Op unary - 
518:     LD  4,-5(1) 	Load left into ac1 
519:    SUB  3,4,3 	Op != 
520:    JEQ  3,1(7) 	Jump if true 
521:    LDC  3,1(6) 	True case 
522:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
524:     LD  3,-4(1) 	Load variable rand
525:     ST  3,-5(1) 	Save left side 
526:    LDC  3,10(6) 	Load constant 
527:     LD  4,-5(1) 	Load left into ac1 
528:    ADD  3,4,3 	Op + 
529:    LDA  5,-2(0) 	Load address of base of array board
530:    SUB  5,5,3 	Compute offset of value 
531:     LD  3,0(5) 	load lhs variable board
532:    LDA  3,1(3) 	increment value of board
533:     ST  3,0(5) 	Store variable board
523:    LDA  7,10(7) 	Jump around the THEN 
* ENDIF
505:    LDA  7,28(7) 	Jump around the THEN 
* ENDIF
* IF
534:     LD  3,-4(1) 	Load variable rand
535:     ST  3,-5(1) 	Save left side 
536:    LDC  3,9(6) 	Load constant 
537:     LD  4,-5(1) 	Load left into ac1 
538:    DIV  5,4,3 	Op % 
539:    MUL  5,5,3 	 
540:    SUB  3,4,5 	 
541:     ST  3,-5(1) 	Save left side 
542:    LDC  3,0(6) 	Load constant 
543:     LD  4,-5(1) 	Load left into ac1 
544:    SUB  3,4,3 	Op != 
545:    JEQ  3,1(7) 	Jump if true 
546:    LDC  3,1(6) 	True case 
547:     ST  3,-5(1) 	Save left side 
548:     LD  3,-4(1) 	Load variable rand
549:     ST  3,-6(1) 	Save left side 
550:    LDC  3,90(6) 	Load constant 
551:     LD  4,-6(1) 	Load left into ac1 
552:    SUB  4,4,3 	Op < 
553:    LDC  3,1(6) 	True case 
554:    JLT  4,1(7) 	Jump if true 
555:    LDC  3,0(6) 	False case 
556:     LD  4,-5(1) 	Load left into ac1 
557:    JEQ  3,1(7) 	Op AND 
558:    LDA  3,0(4) 	 
559:    JGT  3,1(7) 	Jump to then part 
* THEN
* IF
561:     LD  3,-4(1) 	Load variable rand
562:     ST  3,-5(1) 	Save left side 
563:    LDC  3,11(6) 	Load constant 
564:     LD  4,-5(1) 	Load left into ac1 
565:    ADD  3,4,3 	Op + 
566:    LDA  4,-2(0) 	Load address of base of array board
567:    SUB  3,4,3 	Compute offset of value 
568:     LD  3,0(3) 	Load the value 
569:     ST  3,-5(1) 	Save left side 
570:    LDC  3,1(6) 	Load constant 
571:    LDC  4,0(6) 	Load 0 
572:    SUB  3,4,3 	Op unary - 
573:     LD  4,-5(1) 	Load left into ac1 
574:    SUB  3,4,3 	Op != 
575:    JEQ  3,1(7) 	Jump if true 
576:    LDC  3,1(6) 	True case 
577:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
579:     LD  3,-4(1) 	Load variable rand
580:     ST  3,-5(1) 	Save left side 
581:    LDC  3,11(6) 	Load constant 
582:     LD  4,-5(1) 	Load left into ac1 
583:    ADD  3,4,3 	Op + 
584:    LDA  5,-2(0) 	Load address of base of array board
585:    SUB  5,5,3 	Compute offset of value 
586:     LD  3,0(5) 	load lhs variable board
587:    LDA  3,1(3) 	increment value of board
588:     ST  3,0(5) 	Store variable board
578:    LDA  7,10(7) 	Jump around the THEN 
* ENDIF
560:    LDA  7,28(7) 	Jump around the THEN 
* ENDIF
* BREAK
589:    LDA  7,-437(7) 	break 
* END compound statement
173:    LDA  7,416(7) 	Jump around the THEN 
* ENDIF
* END compound statement
590:    LDA  7,-440(7) 	go to beginning of loop 
153:    LDA  7,437(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
591:     LD  3,-2(1) 	load lhs variable i
592:    LDA  3,1(3) 	increment value of i
593:     ST  3,-2(1) 	Store variable i
* END compound statement
594:    LDA  7,-454(7) 	go to beginning of loop 
150:    LDA  7,444(7) 	No more loop 
* ENDWHILE
* END compound statement
* Add standard closing in case there is no return statement
595:    LDC  2,0(6) 	Set return value to 0 
596:     LD  3,-1(1) 	Load return address 
597:     LD  1,0(1) 	Adjust fp 
598:    LDA  7,0(3) 	Return 
* END of function CreateBoard
* BEGIN function PrintBoard
599:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
600:    LDC  3,1(6) 	Load constant 
601:     ST  3,-2(1) 	Store variable i
* EXPRESSION STMT
602:     ST  1,-3(1) 	Store old fp in ghost frame 
603:    LDA  1,-3(1) 	Load address of new frame 
604:    LDA  3,1(7) 	Return address in ac 
605:    LDA  7,-581(7) 	CALL outnl
606:    LDA  3,0(2) 	Save the result in ac 
* WHILE
607:     LD  3,-2(1) 	Load variable i
608:     ST  3,-3(1) 	Save left side 
609:    LDC  3,101(6) 	Load constant 
610:     LD  4,-3(1) 	Load left into ac1 
611:    SUB  4,4,3 	Op < 
612:    LDC  3,1(6) 	True case 
613:    JLT  4,1(7) 	Jump if true 
614:    LDC  3,0(6) 	False case 
615:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* IF
617:     LD  3,-2(1) 	Load variable i
618:     ST  3,-3(1) 	Save left side 
619:    LDC  3,1(6) 	Load constant 
620:     LD  4,-3(1) 	Load left into ac1 
621:    SUB  3,4,3 	Op - 
622:    LDA  4,-103(0) 	Load address of base of array guess
623:    SUB  3,4,3 	Compute offset of value 
624:     LD  3,0(3) 	Load the value 
625:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* IF
627:     LD  3,-2(1) 	Load variable i
628:     ST  3,-3(1) 	Save left side 
629:    LDC  3,1(6) 	Load constant 
630:     LD  4,-3(1) 	Load left into ac1 
631:    SUB  3,4,3 	Op - 
632:    LDA  4,-2(0) 	Load address of base of array board
633:    SUB  3,4,3 	Compute offset of value 
634:     LD  3,0(3) 	Load the value 
635:     ST  3,-3(1) 	Save left side 
636:    LDC  3,1(6) 	Load constant 
637:    LDC  4,0(6) 	Load 0 
638:    SUB  3,4,3 	Op unary - 
639:     LD  4,-3(1) 	Load left into ac1 
640:    SUB  4,4,3 	Op == 
641:    LDC  3,1(6) 	True case 
642:    JEQ  4,1(7) 	Jump if true 
643:    LDC  3,0(6) 	False case 
644:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
646:     ST  1,-3(1) 	Store old fp in ghost frame 
647:    LDC  3,1(6) 	Load constant 
648:     ST  3,-5(1) 	Store parameter 
649:    LDA  1,-3(1) 	Load address of new frame 
650:    LDA  3,1(7) 	Return address in ac 
651:    LDA  7,-634(7) 	CALL outputb
652:    LDA  3,0(2) 	Save the result in ac 
* ELSE
645:    LDA  7,8(7) 	Jump around the THEN 
* EXPRESSION STMT
654:     ST  1,-3(1) 	Store old fp in ghost frame 
655:     LD  3,-2(1) 	Load variable i
656:     ST  3,-5(1) 	Save left side 
657:    LDC  3,1(6) 	Load constant 
658:     LD  4,-5(1) 	Load left into ac1 
659:    SUB  3,4,3 	Op - 
660:    LDA  4,-2(0) 	Load address of base of array board
661:    SUB  3,4,3 	Compute offset of value 
662:     LD  3,0(3) 	Load the value 
663:     ST  3,-5(1) 	Store parameter 
664:    LDA  1,-3(1) 	Load address of new frame 
665:    LDA  3,1(7) 	Return address in ac 
666:    LDA  7,-661(7) 	CALL output
667:    LDA  3,0(2) 	Save the result in ac 
653:    LDA  7,14(7) 	Jump around the ELSE 
* ENDIF
* END compound statement
* ELSE
626:    LDA  7,42(7) 	Jump around the THEN 
* EXPRESSION STMT
669:     ST  1,-3(1) 	Store old fp in ghost frame 
670:    LDC  3,0(6) 	Load constant 
671:     ST  3,-5(1) 	Store parameter 
672:    LDA  1,-3(1) 	Load address of new frame 
673:    LDA  3,1(7) 	Return address in ac 
674:    LDA  7,-657(7) 	CALL outputb
675:    LDA  3,0(2) 	Save the result in ac 
668:    LDA  7,7(7) 	Jump around the ELSE 
* ENDIF
* IF
676:     LD  3,-2(1) 	Load variable i
677:     ST  3,-3(1) 	Save left side 
678:    LDC  3,10(6) 	Load constant 
679:     LD  4,-3(1) 	Load left into ac1 
680:    DIV  5,4,3 	Op % 
681:    MUL  5,5,3 	 
682:    SUB  3,4,5 	 
683:     ST  3,-3(1) 	Save left side 
684:    LDC  3,0(6) 	Load constant 
685:     LD  4,-3(1) 	Load left into ac1 
686:    SUB  4,4,3 	Op == 
687:    LDC  3,1(6) 	True case 
688:    JEQ  4,1(7) 	Jump if true 
689:    LDC  3,0(6) 	False case 
690:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
692:     ST  1,-3(1) 	Store old fp in ghost frame 
693:    LDA  1,-3(1) 	Load address of new frame 
694:    LDA  3,1(7) 	Return address in ac 
695:    LDA  7,-671(7) 	CALL outnl
696:    LDA  3,0(2) 	Save the result in ac 
691:    LDA  7,5(7) 	Jump around the THEN 
* ENDIF
* EXPRESSION STMT
697:     LD  3,-2(1) 	load lhs variable i
698:    LDA  3,1(3) 	increment value of i
699:     ST  3,-2(1) 	Store variable i
* END compound statement
700:    LDA  7,-94(7) 	go to beginning of loop 
616:    LDA  7,84(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
701:     ST  1,-3(1) 	Store old fp in ghost frame 
702:    LDA  1,-3(1) 	Load address of new frame 
703:    LDA  3,1(7) 	Return address in ac 
704:    LDA  7,-680(7) 	CALL outnl
705:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
706:    LDC  2,0(6) 	Set return value to 0 
707:     LD  3,-1(1) 	Load return address 
708:     LD  1,0(1) 	Adjust fp 
709:    LDA  7,0(3) 	Return 
* END of function PrintBoard
* BEGIN function Move
710:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
711:     LD  3,-2(1) 	Load variable m
712:     ST  3,-3(1) 	Save index 
713:    LDC  3,1(6) 	Load constant 
714:     LD  4,-3(1) 	Restore index 
715:    LDA  5,-103(0) 	Load address of base of array guess
716:    SUB  5,5,4 	Compute offset of value 
717:     ST  3,0(5) 	Store variable guess
* IF
718:     LD  3,-2(1) 	Load variable m
719:    LDA  4,-2(0) 	Load address of base of array board
720:    SUB  3,4,3 	Compute offset of value 
721:     LD  3,0(3) 	Load the value 
722:     ST  3,-3(1) 	Save left side 
723:    LDC  3,0(6) 	Load constant 
724:     LD  4,-3(1) 	Load left into ac1 
725:    SUB  4,4,3 	Op == 
726:    LDC  3,1(6) 	True case 
727:    JEQ  4,1(7) 	Jump if true 
728:    LDC  3,0(6) 	False case 
729:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* IF
731:     LD  3,-2(1) 	Load variable m
732:     ST  3,-3(1) 	Save left side 
733:    LDC  3,9(6) 	Load constant 
734:     LD  4,-3(1) 	Load left into ac1 
735:    SUB  4,4,3 	Op > 
736:    LDC  3,1(6) 	True case 
737:    JGT  4,1(7) 	Jump if true 
738:    LDC  3,0(6) 	False case 
739:    JGT  3,1(7) 	Jump to then part 
* THEN
* IF
741:     LD  3,-2(1) 	Load variable m
742:     ST  3,-3(1) 	Save left side 
743:    LDC  3,10(6) 	Load constant 
744:     LD  4,-3(1) 	Load left into ac1 
745:    SUB  3,4,3 	Op - 
746:    LDA  4,-2(0) 	Load address of base of array board
747:    SUB  3,4,3 	Compute offset of value 
748:     LD  3,0(3) 	Load the value 
749:     ST  3,-3(1) 	Save left side 
750:    LDC  3,0(6) 	Load constant 
751:     LD  4,-3(1) 	Load left into ac1 
752:    SUB  4,4,3 	Op == 
753:    LDC  3,1(6) 	True case 
754:    JEQ  4,1(7) 	Jump if true 
755:    LDC  3,0(6) 	False case 
756:     ST  3,-3(1) 	Save left side 
757:     LD  3,-2(1) 	Load variable m
758:     ST  3,-4(1) 	Save left side 
759:    LDC  3,10(6) 	Load constant 
760:     LD  4,-4(1) 	Load left into ac1 
761:    SUB  3,4,3 	Op - 
762:    LDA  4,-103(0) 	Load address of base of array guess
763:    SUB  3,4,3 	Compute offset of value 
764:     LD  3,0(3) 	Load the value 
765:    LDC  4,1(6) 	Load 1 
766:    SUB  3,4,3 	Op NOT 
767:     LD  4,-3(1) 	Load left into ac1 
768:    JEQ  3,1(7) 	Op AND 
769:    LDA  3,0(4) 	 
770:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
772:     ST  1,-3(1) 	Store old fp in ghost frame 
773:     LD  3,-2(1) 	Load variable m
774:     ST  3,-5(1) 	Save left side 
775:    LDC  3,10(6) 	Load constant 
776:     LD  4,-5(1) 	Load left into ac1 
777:    SUB  3,4,3 	Op - 
778:     ST  3,-5(1) 	Store parameter 
779:    LDA  1,-3(1) 	Load address of new frame 
780:    LDA  3,1(7) 	Return address in ac 
781:    LDA  7,-72(7) 	CALL Move
782:    LDA  3,0(2) 	Save the result in ac 
771:    LDA  7,11(7) 	Jump around the THEN 
* ENDIF
740:    LDA  7,42(7) 	Jump around the THEN 
* ENDIF
* IF
783:     LD  3,-2(1) 	Load variable m
784:     ST  3,-3(1) 	Save left side 
785:    LDC  3,10(6) 	Load constant 
786:     LD  4,-3(1) 	Load left into ac1 
787:    DIV  5,4,3 	Op % 
788:    MUL  5,5,3 	 
789:    SUB  3,4,5 	 
790:     ST  3,-3(1) 	Save left side 
791:    LDC  3,0(6) 	Load constant 
792:     LD  4,-3(1) 	Load left into ac1 
793:    SUB  3,4,3 	Op != 
794:    JEQ  3,1(7) 	Jump if true 
795:    LDC  3,1(6) 	True case 
796:    JGT  3,1(7) 	Jump to then part 
* THEN
* IF
798:     LD  3,-2(1) 	Load variable m
799:     ST  3,-3(1) 	Save left side 
800:    LDC  3,1(6) 	Load constant 
801:     LD  4,-3(1) 	Load left into ac1 
802:    SUB  3,4,3 	Op - 
803:    LDA  4,-2(0) 	Load address of base of array board
804:    SUB  3,4,3 	Compute offset of value 
805:     LD  3,0(3) 	Load the value 
806:     ST  3,-3(1) 	Save left side 
807:    LDC  3,0(6) 	Load constant 
808:     LD  4,-3(1) 	Load left into ac1 
809:    SUB  4,4,3 	Op == 
810:    LDC  3,1(6) 	True case 
811:    JEQ  4,1(7) 	Jump if true 
812:    LDC  3,0(6) 	False case 
813:     ST  3,-3(1) 	Save left side 
814:     LD  3,-2(1) 	Load variable m
815:     ST  3,-4(1) 	Save left side 
816:    LDC  3,1(6) 	Load constant 
817:     LD  4,-4(1) 	Load left into ac1 
818:    SUB  3,4,3 	Op - 
819:    LDA  4,-103(0) 	Load address of base of array guess
820:    SUB  3,4,3 	Compute offset of value 
821:     LD  3,0(3) 	Load the value 
822:    LDC  4,1(6) 	Load 1 
823:    SUB  3,4,3 	Op NOT 
824:     LD  4,-3(1) 	Load left into ac1 
825:    JEQ  3,1(7) 	Op AND 
826:    LDA  3,0(4) 	 
827:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
829:     ST  1,-3(1) 	Store old fp in ghost frame 
830:     LD  3,-2(1) 	Load variable m
831:     ST  3,-5(1) 	Save left side 
832:    LDC  3,1(6) 	Load constant 
833:     LD  4,-5(1) 	Load left into ac1 
834:    SUB  3,4,3 	Op - 
835:     ST  3,-5(1) 	Store parameter 
836:    LDA  1,-3(1) 	Load address of new frame 
837:    LDA  3,1(7) 	Return address in ac 
838:    LDA  7,-129(7) 	CALL Move
839:    LDA  3,0(2) 	Save the result in ac 
828:    LDA  7,11(7) 	Jump around the THEN 
* ENDIF
797:    LDA  7,42(7) 	Jump around the THEN 
* ENDIF
* IF
840:     LD  3,-2(1) 	Load variable m
841:     ST  3,-3(1) 	Save left side 
842:    LDC  3,9(6) 	Load constant 
843:     LD  4,-3(1) 	Load left into ac1 
844:    DIV  5,4,3 	Op % 
845:    MUL  5,5,3 	 
846:    SUB  3,4,5 	 
847:     ST  3,-3(1) 	Save left side 
848:    LDC  3,0(6) 	Load constant 
849:     LD  4,-3(1) 	Load left into ac1 
850:    SUB  3,4,3 	Op != 
851:    JEQ  3,1(7) 	Jump if true 
852:    LDC  3,1(6) 	True case 
853:     ST  3,-3(1) 	Save left side 
854:     LD  3,-2(1) 	Load variable m
855:     ST  3,-4(1) 	Save left side 
856:    LDC  3,0(6) 	Load constant 
857:     LD  4,-4(1) 	Load left into ac1 
858:    SUB  4,4,3 	Op == 
859:    LDC  3,1(6) 	True case 
860:    JEQ  4,1(7) 	Jump if true 
861:    LDC  3,0(6) 	False case 
862:     LD  4,-3(1) 	Load left into ac1 
863:    JGT  3,1(7) 	Op OR 
864:    LDA  3,0(4) 	 
865:    JGT  3,1(7) 	Jump to then part 
* THEN
* IF
867:     LD  3,-2(1) 	Load variable m
868:     ST  3,-3(1) 	Save left side 
869:    LDC  3,1(6) 	Load constant 
870:     LD  4,-3(1) 	Load left into ac1 
871:    ADD  3,4,3 	Op + 
872:    LDA  4,-2(0) 	Load address of base of array board
873:    SUB  3,4,3 	Compute offset of value 
874:     LD  3,0(3) 	Load the value 
875:     ST  3,-3(1) 	Save left side 
876:    LDC  3,0(6) 	Load constant 
877:     LD  4,-3(1) 	Load left into ac1 
878:    SUB  4,4,3 	Op == 
879:    LDC  3,1(6) 	True case 
880:    JEQ  4,1(7) 	Jump if true 
881:    LDC  3,0(6) 	False case 
882:     ST  3,-3(1) 	Save left side 
883:     LD  3,-2(1) 	Load variable m
884:     ST  3,-4(1) 	Save left side 
885:    LDC  3,1(6) 	Load constant 
886:     LD  4,-4(1) 	Load left into ac1 
887:    ADD  3,4,3 	Op + 
888:    LDA  4,-103(0) 	Load address of base of array guess
889:    SUB  3,4,3 	Compute offset of value 
890:     LD  3,0(3) 	Load the value 
891:    LDC  4,1(6) 	Load 1 
892:    SUB  3,4,3 	Op NOT 
893:     LD  4,-3(1) 	Load left into ac1 
894:    JEQ  3,1(7) 	Op AND 
895:    LDA  3,0(4) 	 
896:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
898:     ST  1,-3(1) 	Store old fp in ghost frame 
899:     LD  3,-2(1) 	Load variable m
900:     ST  3,-5(1) 	Save left side 
901:    LDC  3,1(6) 	Load constant 
902:     LD  4,-5(1) 	Load left into ac1 
903:    ADD  3,4,3 	Op + 
904:     ST  3,-5(1) 	Store parameter 
905:    LDA  1,-3(1) 	Load address of new frame 
906:    LDA  3,1(7) 	Return address in ac 
907:    LDA  7,-198(7) 	CALL Move
908:    LDA  3,0(2) 	Save the result in ac 
897:    LDA  7,11(7) 	Jump around the THEN 
* ENDIF
866:    LDA  7,42(7) 	Jump around the THEN 
* ENDIF
* IF
909:     LD  3,-2(1) 	Load variable m
910:     ST  3,-3(1) 	Save left side 
911:    LDC  3,90(6) 	Load constant 
912:     LD  4,-3(1) 	Load left into ac1 
913:    SUB  4,4,3 	Op < 
914:    LDC  3,1(6) 	True case 
915:    JLT  4,1(7) 	Jump if true 
916:    LDC  3,0(6) 	False case 
917:    JGT  3,1(7) 	Jump to then part 
* THEN
* IF
919:     LD  3,-2(1) 	Load variable m
920:     ST  3,-3(1) 	Save left side 
921:    LDC  3,10(6) 	Load constant 
922:     LD  4,-3(1) 	Load left into ac1 
923:    ADD  3,4,3 	Op + 
924:    LDA  4,-2(0) 	Load address of base of array board
925:    SUB  3,4,3 	Compute offset of value 
926:     LD  3,0(3) 	Load the value 
927:     ST  3,-3(1) 	Save left side 
928:    LDC  3,0(6) 	Load constant 
929:     LD  4,-3(1) 	Load left into ac1 
930:    SUB  4,4,3 	Op == 
931:    LDC  3,1(6) 	True case 
932:    JEQ  4,1(7) 	Jump if true 
933:    LDC  3,0(6) 	False case 
934:     ST  3,-3(1) 	Save left side 
935:     LD  3,-2(1) 	Load variable m
936:     ST  3,-4(1) 	Save left side 
937:    LDC  3,10(6) 	Load constant 
938:     LD  4,-4(1) 	Load left into ac1 
939:    ADD  3,4,3 	Op + 
940:    LDA  4,-103(0) 	Load address of base of array guess
941:    SUB  3,4,3 	Compute offset of value 
942:     LD  3,0(3) 	Load the value 
943:    LDC  4,1(6) 	Load 1 
944:    SUB  3,4,3 	Op NOT 
945:     LD  4,-3(1) 	Load left into ac1 
946:    JEQ  3,1(7) 	Op AND 
947:    LDA  3,0(4) 	 
948:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
950:     ST  1,-3(1) 	Store old fp in ghost frame 
951:     LD  3,-2(1) 	Load variable m
952:     ST  3,-5(1) 	Save left side 
953:    LDC  3,10(6) 	Load constant 
954:     LD  4,-5(1) 	Load left into ac1 
955:    ADD  3,4,3 	Op + 
956:     ST  3,-5(1) 	Store parameter 
957:    LDA  1,-3(1) 	Load address of new frame 
958:    LDA  3,1(7) 	Return address in ac 
959:    LDA  7,-250(7) 	CALL Move
960:    LDA  3,0(2) 	Save the result in ac 
949:    LDA  7,11(7) 	Jump around the THEN 
* ENDIF
918:    LDA  7,42(7) 	Jump around the THEN 
* ENDIF
* END compound statement
730:    LDA  7,230(7) 	Jump around the THEN 
* ENDIF
* END compound statement
* Add standard closing in case there is no return statement
961:    LDC  2,0(6) 	Set return value to 0 
962:     LD  3,-1(1) 	Load return address 
963:     LD  1,0(1) 	Adjust fp 
964:    LDA  7,0(3) 	Return 
* END of function Move
* BEGIN function main
965:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
966:     ST  1,-5(1) 	Store old fp in ghost frame 
967:    LDA  1,-5(1) 	Load address of new frame 
968:    LDA  3,1(7) 	Return address in ac 
969:    LDA  7,-969(7) 	CALL input
970:    LDA  3,0(2) 	Save the result in ac 
971:     ST  3,0(0) 	Store variable seed
* EXPRESSION STMT
972:     ST  1,-5(1) 	Store old fp in ghost frame 
973:    LDA  1,-5(1) 	Load address of new frame 
974:    LDA  3,1(7) 	Return address in ac 
975:    LDA  7,-884(7) 	CALL CreateBoard
976:    LDA  3,0(2) 	Save the result in ac 
* WHILE
977:    LDC  3,1(6) 	Load constant 
978:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
980:     ST  1,-5(1) 	Store old fp in ghost frame 
981:    LDA  1,-5(1) 	Load address of new frame 
982:    LDA  3,1(7) 	Return address in ac 
983:    LDA  7,-385(7) 	CALL PrintBoard
984:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
985:     ST  1,-5(1) 	Store old fp in ghost frame 
986:    LDA  1,-5(1) 	Load address of new frame 
987:    LDA  3,1(7) 	Return address in ac 
988:    LDA  7,-988(7) 	CALL input
989:    LDA  3,0(2) 	Save the result in ac 
990:     ST  3,-5(1) 	Save left side 
991:    LDC  3,1(6) 	Load constant 
992:     LD  4,-5(1) 	Load left into ac1 
993:    SUB  3,4,3 	Op - 
994:     ST  3,-3(1) 	Store variable x
* EXPRESSION STMT
995:     ST  1,-5(1) 	Store old fp in ghost frame 
996:    LDA  1,-5(1) 	Load address of new frame 
997:    LDA  3,1(7) 	Return address in ac 
998:    LDA  7,-998(7) 	CALL input
999:    LDA  3,0(2) 	Save the result in ac 
1000:     ST  3,-5(1) 	Save left side 
1001:    LDC  3,1(6) 	Load constant 
1002:     LD  4,-5(1) 	Load left into ac1 
1003:    SUB  3,4,3 	Op - 
1004:     ST  3,-4(1) 	Store variable y
* IF
1005:     LD  3,-3(1) 	Load variable x
1006:     ST  3,-5(1) 	Save left side 
1007:    LDC  3,9(6) 	Load constant 
1008:     LD  4,-5(1) 	Load left into ac1 
1009:    SUB  4,4,3 	Op > 
1010:    LDC  3,1(6) 	True case 
1011:    JGT  4,1(7) 	Jump if true 
1012:    LDC  3,0(6) 	False case 
1013:     ST  3,-5(1) 	Save left side 
1014:     LD  3,-4(1) 	Load variable y
1015:     ST  3,-6(1) 	Save left side 
1016:    LDC  3,9(6) 	Load constant 
1017:     LD  4,-6(1) 	Load left into ac1 
1018:    SUB  4,4,3 	Op > 
1019:    LDC  3,1(6) 	True case 
1020:    JGT  4,1(7) 	Jump if true 
1021:    LDC  3,0(6) 	False case 
1022:     LD  4,-5(1) 	Load left into ac1 
1023:    JGT  3,1(7) 	Op OR 
1024:    LDA  3,0(4) 	 
1025:     ST  3,-5(1) 	Save left side 
1026:     LD  3,-3(1) 	Load variable x
1027:     ST  3,-6(1) 	Save left side 
1028:    LDC  3,0(6) 	Load constant 
1029:     LD  4,-6(1) 	Load left into ac1 
1030:    SUB  4,4,3 	Op < 
1031:    LDC  3,1(6) 	True case 
1032:    JLT  4,1(7) 	Jump if true 
1033:    LDC  3,0(6) 	False case 
1034:     LD  4,-5(1) 	Load left into ac1 
1035:    JGT  3,1(7) 	Op OR 
1036:    LDA  3,0(4) 	 
1037:     ST  3,-5(1) 	Save left side 
1038:     LD  3,-4(1) 	Load variable y
1039:     ST  3,-6(1) 	Save left side 
1040:    LDC  3,0(6) 	Load constant 
1041:     LD  4,-6(1) 	Load left into ac1 
1042:    SUB  4,4,3 	Op < 
1043:    LDC  3,1(6) 	True case 
1044:    JLT  4,1(7) 	Jump if true 
1045:    LDC  3,0(6) 	False case 
1046:     LD  4,-5(1) 	Load left into ac1 
1047:    JGT  3,1(7) 	Op OR 
1048:    LDA  3,0(4) 	 
1049:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
1051:     ST  1,-5(1) 	Store old fp in ghost frame 
1052:    LDC  3,0(6) 	Load constant 
1053:     ST  3,-7(1) 	Store parameter 
1054:    LDA  1,-5(1) 	Load address of new frame 
1055:    LDA  3,1(7) 	Return address in ac 
1056:    LDA  7,-1039(7) 	CALL outputb
1057:    LDA  3,0(2) 	Save the result in ac 
* BREAK
1058:    LDA  7,-80(7) 	break 
* END compound statement
1050:    LDA  7,8(7) 	Jump around the THEN 
* ENDIF
* IF
1059:     LD  3,-3(1) 	Load variable x
1060:     ST  3,-5(1) 	Save left side 
1061:    LDC  3,10(6) 	Load constant 
1062:     LD  4,-5(1) 	Load left into ac1 
1063:    MUL  3,4,3 	Op * 
1064:     ST  3,-5(1) 	Save left side 
1065:     LD  3,-4(1) 	Load variable y
1066:     LD  4,-5(1) 	Load left into ac1 
1067:    ADD  3,4,3 	Op + 
1068:    LDA  4,-2(0) 	Load address of base of array board
1069:    SUB  3,4,3 	Compute offset of value 
1070:     LD  3,0(3) 	Load the value 
1071:     ST  3,-5(1) 	Save left side 
1072:    LDC  3,1(6) 	Load constant 
1073:    LDC  4,0(6) 	Load 0 
1074:    SUB  3,4,3 	Op unary - 
1075:     LD  4,-5(1) 	Load left into ac1 
1076:    SUB  4,4,3 	Op == 
1077:    LDC  3,1(6) 	True case 
1078:    JEQ  4,1(7) 	Jump if true 
1079:    LDC  3,0(6) 	False case 
1080:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
1082:    LDC  3,0(6) 	Load constant 
1083:     ST  3,-2(1) 	Store variable i
* WHILE
1084:     LD  3,-2(1) 	Load variable i
1085:     ST  3,-5(1) 	Save left side 
1086:    LDC  3,100(6) 	Load constant 
1087:     LD  4,-5(1) 	Load left into ac1 
1088:    SUB  4,4,3 	Op < 
1089:    LDC  3,1(6) 	True case 
1090:    JLT  4,1(7) 	Jump if true 
1091:    LDC  3,0(6) 	False case 
1092:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
1094:     LD  3,-2(1) 	Load variable i
1095:     ST  3,-5(1) 	Save index 
1096:    LDC  3,1(6) 	Load constant 
1097:     LD  4,-5(1) 	Restore index 
1098:    LDA  5,-103(0) 	Load address of base of array guess
1099:    SUB  5,5,4 	Compute offset of value 
1100:     ST  3,0(5) 	Store variable guess
* EXPRESSION STMT
1101:     LD  3,-2(1) 	load lhs variable i
1102:    LDA  3,1(3) 	increment value of i
1103:     ST  3,-2(1) 	Store variable i
* END compound statement
1104:    LDA  7,-21(7) 	go to beginning of loop 
1093:    LDA  7,11(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
1105:     ST  1,-5(1) 	Store old fp in ghost frame 
1106:    LDA  1,-5(1) 	Load address of new frame 
1107:    LDA  3,1(7) 	Return address in ac 
1108:    LDA  7,-510(7) 	CALL PrintBoard
1109:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
1110:     ST  1,-5(1) 	Store old fp in ghost frame 
1111:    LDC  3,0(6) 	Load constant 
1112:     ST  3,-7(1) 	Store parameter 
1113:    LDA  1,-5(1) 	Load address of new frame 
1114:    LDA  3,1(7) 	Return address in ac 
1115:    LDA  7,-1098(7) 	CALL outputb
1116:    LDA  3,0(2) 	Save the result in ac 
* BREAK
1117:    LDA  7,-139(7) 	break 
* END compound statement
1081:    LDA  7,36(7) 	Jump around the THEN 
* ENDIF
* EXPRESSION STMT
1118:    LDC  3,0(6) 	Load constant 
1119:     ST  3,-2(1) 	Store variable i
* WHILE
1120:     LD  3,-2(1) 	Load variable i
1121:    LDA  4,-103(0) 	Load address of base of array guess
1122:    SUB  3,4,3 	Compute offset of value 
1123:     LD  3,0(3) 	Load the value 
1124:     ST  3,-5(1) 	Save left side 
1125:    LDC  3,1(6) 	Load constant 
1126:     LD  4,-5(1) 	Load left into ac1 
1127:    SUB  4,4,3 	Op == 
1128:    LDC  3,1(6) 	True case 
1129:    JEQ  4,1(7) 	Jump if true 
1130:    LDC  3,0(6) 	False case 
1131:     ST  3,-5(1) 	Save left side 
1132:     LD  3,-2(1) 	Load variable i
1133:     ST  3,-6(1) 	Save left side 
1134:    LDC  3,100(6) 	Load constant 
1135:     LD  4,-6(1) 	Load left into ac1 
1136:    SUB  4,4,3 	Op < 
1137:    LDC  3,1(6) 	True case 
1138:    JLT  4,1(7) 	Jump if true 
1139:    LDC  3,0(6) 	False case 
1140:     LD  4,-5(1) 	Load left into ac1 
1141:    JEQ  3,1(7) 	Op AND 
1142:    LDA  3,0(4) 	 
1143:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
1145:     LD  3,-2(1) 	load lhs variable i
1146:    LDA  3,1(3) 	increment value of i
1147:     ST  3,-2(1) 	Store variable i
1148:    LDA  7,-29(7) 	go to beginning of loop 
1144:    LDA  7,4(7) 	No more loop 
* ENDWHILE
* IF
1149:     LD  3,-2(1) 	Load variable i
1150:     ST  3,-5(1) 	Save left side 
1151:    LDC  3,100(6) 	Load constant 
1152:     LD  4,-5(1) 	Load left into ac1 
1153:    SUB  4,4,3 	Op == 
1154:    LDC  3,1(6) 	True case 
1155:    JEQ  4,1(7) 	Jump if true 
1156:    LDC  3,0(6) 	False case 
1157:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
1159:     ST  1,-5(1) 	Store old fp in ghost frame 
1160:    LDA  1,-5(1) 	Load address of new frame 
1161:    LDA  3,1(7) 	Return address in ac 
1162:    LDA  7,-564(7) 	CALL PrintBoard
1163:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
1164:     ST  1,-5(1) 	Store old fp in ghost frame 
1165:    LDC  3,1(6) 	Load constant 
1166:     ST  3,-7(1) 	Store parameter 
1167:    LDA  1,-5(1) 	Load address of new frame 
1168:    LDA  3,1(7) 	Return address in ac 
1169:    LDA  7,-1152(7) 	CALL outputb
1170:    LDA  3,0(2) 	Save the result in ac 
* BREAK
1171:    LDA  7,-193(7) 	break 
* END compound statement
1158:    LDA  7,13(7) 	Jump around the THEN 
* ENDIF
* EXPRESSION STMT
1172:     ST  1,-5(1) 	Store old fp in ghost frame 
1173:     LD  3,-3(1) 	Load variable x
1174:     ST  3,-7(1) 	Save left side 
1175:     LD  3,-4(1) 	Load variable y
1176:     ST  3,-8(1) 	Save left side 
1177:    LDC  3,10(6) 	Load constant 
1178:     LD  4,-8(1) 	Load left into ac1 
1179:    MUL  3,4,3 	Op * 
1180:     LD  4,-7(1) 	Load left into ac1 
1181:    ADD  3,4,3 	Op + 
1182:     ST  3,-7(1) 	Store parameter 
1183:    LDA  1,-5(1) 	Load address of new frame 
1184:    LDA  3,1(7) 	Return address in ac 
1185:    LDA  7,-476(7) 	CALL Move
1186:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
1187:    LDA  7,-211(7) 	go to beginning of loop 
979:    LDA  7,208(7) 	No more loop 
* ENDWHILE
* END compound statement
* Add standard closing in case there is no return statement
1188:    LDC  2,0(6) 	Set return value to 0 
1189:     LD  3,-1(1) 	Load return address 
1190:     LD  1,0(1) 	Adjust fp 
1191:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,1191(7) 	Jump to init 
* BEGIN Init
1192:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
1193:    LDC  3,100(6) 	load size of array board
1194:     ST  3,-1(0) 	save size of array board
1195:    LDC  3,100(6) 	load size of array guess
1196:     ST  3,-102(0) 	save size of array guess
* END init of global array sizes
1197:    LDA  1,-203(0) 	set first frame at end of globals 
1198:     ST  1,0(1) 	store old fp (point to self) 
1199:    LDA  3,1(7) 	Return address in ac 
1200:    LDA  7,-236(7) 	Jump to main 
1201:   HALT  0,0,0 	DONE! 
* END Init
