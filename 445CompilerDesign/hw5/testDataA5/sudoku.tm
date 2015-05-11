* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  sudoku.c-
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
* BEGIN function initBoard
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 31:    LDC  3,0(6) 	Load constant 
 32:     ST  3,-2(1) 	Store variable i
* WHILE
 33:     LD  3,-2(1) 	Load variable i
 34:     ST  3,-3(1) 	Save left side 
 35:    LDC  3,81(6) 	Load constant 
 36:     LD  4,-3(1) 	Load left into ac1 
 37:    SUB  4,4,3 	Op < 
 38:    LDC  3,1(6) 	True case 
 39:    JLT  4,1(7) 	Jump if true 
 40:    LDC  3,0(6) 	False case 
 41:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 43:     LD  3,-2(1) 	Load variable i
 44:     ST  3,-3(1) 	Save index 
 45:    LDC  3,0(6) 	Load constant 
 46:     LD  4,-3(1) 	Restore index 
 47:    LDA  5,-1(0) 	Load address of base of array board
 48:    SUB  5,5,4 	Compute offset of value 
 49:     ST  3,0(5) 	Store variable board
* EXPRESSION STMT
 50:     LD  3,-2(1) 	Load variable i
 51:     ST  3,-3(1) 	Save index 
 52:    LDC  3,0(6) 	Load constant 
 53:     LD  4,-3(1) 	Restore index 
 54:    LDA  5,-83(0) 	Load address of base of array locked
 55:    SUB  5,5,4 	Compute offset of value 
 56:     ST  3,0(5) 	Store variable locked
* EXPRESSION STMT
 57:     LD  3,-2(1) 	load lhs variable i
 58:    LDA  3,1(3) 	increment value of i
 59:     ST  3,-2(1) 	Store variable i
* END compound statement
 60:    LDA  7,-28(7) 	go to beginning of loop 
 42:    LDA  7,18(7) 	No more loop 
* ENDWHILE
* END compound statement
* Add standard closing in case there is no return statement
 61:    LDC  2,0(6) 	Set return value to 0 
 62:     LD  3,-1(1) 	Load return address 
 63:     LD  1,0(1) 	Adjust fp 
 64:    LDA  7,0(3) 	Return 
* END of function initBoard
* BEGIN function setValue
 65:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 66:     LD  3,-2(1) 	Load variable row
 67:     ST  3,-5(1) 	Save left side 
 68:    LDC  3,9(6) 	Load constant 
 69:     LD  4,-5(1) 	Load left into ac1 
 70:    MUL  3,4,3 	Op * 
 71:     ST  3,-5(1) 	Save left side 
 72:     LD  3,-3(1) 	Load variable col
 73:     LD  4,-5(1) 	Load left into ac1 
 74:    ADD  3,4,3 	Op + 
 75:     ST  3,-5(1) 	Save index 
 76:     LD  3,-4(1) 	Load variable value
 77:     LD  4,-5(1) 	Restore index 
 78:    LDA  5,-1(0) 	Load address of base of array board
 79:    SUB  5,5,4 	Compute offset of value 
 80:     ST  3,0(5) 	Store variable board
* END compound statement
* Add standard closing in case there is no return statement
 81:    LDC  2,0(6) 	Set return value to 0 
 82:     LD  3,-1(1) 	Load return address 
 83:     LD  1,0(1) 	Adjust fp 
 84:    LDA  7,0(3) 	Return 
* END of function setValue
* BEGIN function getValue
 85:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* RETURN
 86:     LD  3,-2(1) 	Load variable row
 87:     ST  3,-4(1) 	Save left side 
 88:    LDC  3,9(6) 	Load constant 
 89:     LD  4,-4(1) 	Load left into ac1 
 90:    MUL  3,4,3 	Op * 
 91:     ST  3,-4(1) 	Save left side 
 92:     LD  3,-3(1) 	Load variable col
 93:     LD  4,-4(1) 	Load left into ac1 
 94:    ADD  3,4,3 	Op + 
 95:    LDA  4,-1(0) 	Load address of base of array board
 96:    SUB  3,4,3 	Compute offset of value 
 97:     LD  3,0(3) 	Load the value 
 98:    LDA  2,0(3) 	Copy result to rt register 
 99:     LD  3,-1(1) 	Load return address 
100:     LD  1,0(1) 	Adjust fp 
101:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
102:    LDC  2,0(6) 	Set return value to 0 
103:     LD  3,-1(1) 	Load return address 
104:     LD  1,0(1) 	Adjust fp 
105:    LDA  7,0(3) 	Return 
* END of function getValue
* BEGIN function setLocked
106:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
107:     LD  3,-2(1) 	Load variable row
108:     ST  3,-5(1) 	Save left side 
109:    LDC  3,9(6) 	Load constant 
110:     LD  4,-5(1) 	Load left into ac1 
111:    MUL  3,4,3 	Op * 
112:     ST  3,-5(1) 	Save left side 
113:     LD  3,-3(1) 	Load variable col
114:     LD  4,-5(1) 	Load left into ac1 
115:    ADD  3,4,3 	Op + 
116:     ST  3,-5(1) 	Save index 
117:     LD  3,-4(1) 	Load variable value
118:     LD  4,-5(1) 	Restore index 
119:    LDA  5,-83(0) 	Load address of base of array locked
120:    SUB  5,5,4 	Compute offset of value 
121:     ST  3,0(5) 	Store variable locked
* END compound statement
* Add standard closing in case there is no return statement
122:    LDC  2,0(6) 	Set return value to 0 
123:     LD  3,-1(1) 	Load return address 
124:     LD  1,0(1) 	Adjust fp 
125:    LDA  7,0(3) 	Return 
* END of function setLocked
* BEGIN function getLocked
126:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* RETURN
127:     LD  3,-2(1) 	Load variable row
128:     ST  3,-4(1) 	Save left side 
129:    LDC  3,9(6) 	Load constant 
130:     LD  4,-4(1) 	Load left into ac1 
131:    MUL  3,4,3 	Op * 
132:     ST  3,-4(1) 	Save left side 
133:     LD  3,-3(1) 	Load variable col
134:     LD  4,-4(1) 	Load left into ac1 
135:    ADD  3,4,3 	Op + 
136:    LDA  4,-83(0) 	Load address of base of array locked
137:    SUB  3,4,3 	Compute offset of value 
138:     LD  3,0(3) 	Load the value 
139:    LDA  2,0(3) 	Copy result to rt register 
140:     LD  3,-1(1) 	Load return address 
141:     LD  1,0(1) 	Adjust fp 
142:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
143:    LDC  2,0(6) 	Set return value to 0 
144:     LD  3,-1(1) 	Load return address 
145:     LD  1,0(1) 	Adjust fp 
146:    LDA  7,0(3) 	Return 
* END of function getLocked
* BEGIN function isOkAt
147:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
148:    LDC  3,0(6) 	Load constant 
149:     ST  3,-5(1) 	Store variable i
* WHILE
150:     LD  3,-5(1) 	Load variable i
151:     ST  3,-9(1) 	Save left side 
152:    LDC  3,9(6) 	Load constant 
153:     LD  4,-9(1) 	Load left into ac1 
154:    SUB  4,4,3 	Op < 
155:    LDC  3,1(6) 	True case 
156:    JLT  4,1(7) 	Jump if true 
157:    LDC  3,0(6) 	False case 
158:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* IF
160:     ST  1,-9(1) 	Store old fp in ghost frame 
161:     LD  3,-5(1) 	Load variable i
162:     ST  3,-11(1) 	Store parameter 
163:     LD  3,-3(1) 	Load variable col
164:     ST  3,-12(1) 	Store parameter 
165:    LDA  1,-9(1) 	Load address of new frame 
166:    LDA  3,1(7) 	Return address in ac 
167:    LDA  7,-83(7) 	CALL getValue
168:    LDA  3,0(2) 	Save the result in ac 
169:     ST  3,-9(1) 	Save left side 
170:     LD  3,-4(1) 	Load variable value
171:     LD  4,-9(1) 	Load left into ac1 
172:    SUB  4,4,3 	Op == 
173:    LDC  3,1(6) 	True case 
174:    JEQ  4,1(7) 	Jump if true 
175:    LDC  3,0(6) 	False case 
176:    JGT  3,1(7) 	Jump to then part 
* THEN
* RETURN
178:    LDC  3,0(6) 	Load constant 
179:    LDA  2,0(3) 	Copy result to rt register 
180:     LD  3,-1(1) 	Load return address 
181:     LD  1,0(1) 	Adjust fp 
182:    LDA  7,0(3) 	Return 
177:    LDA  7,5(7) 	Jump around the THEN 
* ENDIF
* IF
183:     ST  1,-9(1) 	Store old fp in ghost frame 
184:     LD  3,-2(1) 	Load variable row
185:     ST  3,-11(1) 	Store parameter 
186:     LD  3,-5(1) 	Load variable i
187:     ST  3,-12(1) 	Store parameter 
188:    LDA  1,-9(1) 	Load address of new frame 
189:    LDA  3,1(7) 	Return address in ac 
190:    LDA  7,-106(7) 	CALL getValue
191:    LDA  3,0(2) 	Save the result in ac 
192:     ST  3,-9(1) 	Save left side 
193:     LD  3,-4(1) 	Load variable value
194:     LD  4,-9(1) 	Load left into ac1 
195:    SUB  4,4,3 	Op == 
196:    LDC  3,1(6) 	True case 
197:    JEQ  4,1(7) 	Jump if true 
198:    LDC  3,0(6) 	False case 
199:    JGT  3,1(7) 	Jump to then part 
* THEN
* RETURN
201:    LDC  3,0(6) 	Load constant 
202:    LDA  2,0(3) 	Copy result to rt register 
203:     LD  3,-1(1) 	Load return address 
204:     LD  1,0(1) 	Adjust fp 
205:    LDA  7,0(3) 	Return 
200:    LDA  7,5(7) 	Jump around the THEN 
* ENDIF
* EXPRESSION STMT
206:     LD  3,-5(1) 	load lhs variable i
207:    LDA  3,1(3) 	increment value of i
208:     ST  3,-5(1) 	Store variable i
* END compound statement
209:    LDA  7,-60(7) 	go to beginning of loop 
159:    LDA  7,50(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
210:     LD  3,-2(1) 	Load variable row
211:     ST  3,-9(1) 	Save left side 
212:    LDC  3,3(6) 	Load constant 
213:     LD  4,-9(1) 	Load left into ac1 
214:    DIV  3,4,3 	Op / 
215:     ST  3,-9(1) 	Save left side 
216:    LDC  3,3(6) 	Load constant 
217:     LD  4,-9(1) 	Load left into ac1 
218:    MUL  3,4,3 	Op * 
219:     ST  3,-7(1) 	Store variable boxRowStart
* EXPRESSION STMT
220:     LD  3,-3(1) 	Load variable col
221:     ST  3,-9(1) 	Save left side 
222:    LDC  3,3(6) 	Load constant 
223:     LD  4,-9(1) 	Load left into ac1 
224:    DIV  3,4,3 	Op / 
225:     ST  3,-9(1) 	Save left side 
226:    LDC  3,3(6) 	Load constant 
227:     LD  4,-9(1) 	Load left into ac1 
228:    MUL  3,4,3 	Op * 
229:     ST  3,-8(1) 	Store variable boxColStart
* EXPRESSION STMT
230:    LDC  3,0(6) 	Load constant 
231:     ST  3,-5(1) 	Store variable i
* WHILE
232:     LD  3,-5(1) 	Load variable i
233:     ST  3,-9(1) 	Save left side 
234:    LDC  3,3(6) 	Load constant 
235:     LD  4,-9(1) 	Load left into ac1 
236:    SUB  4,4,3 	Op < 
237:    LDC  3,1(6) 	True case 
238:    JLT  4,1(7) 	Jump if true 
239:    LDC  3,0(6) 	False case 
240:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
242:    LDC  3,0(6) 	Load constant 
243:     ST  3,-6(1) 	Store variable j
* WHILE
244:     LD  3,-6(1) 	Load variable j
245:     ST  3,-9(1) 	Save left side 
246:    LDC  3,3(6) 	Load constant 
247:     LD  4,-9(1) 	Load left into ac1 
248:    SUB  4,4,3 	Op < 
249:    LDC  3,1(6) 	True case 
250:    JLT  4,1(7) 	Jump if true 
251:    LDC  3,0(6) 	False case 
252:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* IF
254:     ST  1,-9(1) 	Store old fp in ghost frame 
255:     LD  3,-7(1) 	Load variable boxRowStart
256:     ST  3,-11(1) 	Save left side 
257:     LD  3,-5(1) 	Load variable i
258:     LD  4,-11(1) 	Load left into ac1 
259:    ADD  3,4,3 	Op + 
260:     ST  3,-11(1) 	Store parameter 
261:     LD  3,-8(1) 	Load variable boxColStart
262:     ST  3,-12(1) 	Save left side 
263:     LD  3,-6(1) 	Load variable j
264:     LD  4,-12(1) 	Load left into ac1 
265:    ADD  3,4,3 	Op + 
266:     ST  3,-12(1) 	Store parameter 
267:    LDA  1,-9(1) 	Load address of new frame 
268:    LDA  3,1(7) 	Return address in ac 
269:    LDA  7,-185(7) 	CALL getValue
270:    LDA  3,0(2) 	Save the result in ac 
271:     ST  3,-9(1) 	Save left side 
272:     LD  3,-4(1) 	Load variable value
273:     LD  4,-9(1) 	Load left into ac1 
274:    SUB  4,4,3 	Op == 
275:    LDC  3,1(6) 	True case 
276:    JEQ  4,1(7) 	Jump if true 
277:    LDC  3,0(6) 	False case 
278:    JGT  3,1(7) 	Jump to then part 
* THEN
* RETURN
280:    LDC  3,0(6) 	Load constant 
281:    LDA  2,0(3) 	Copy result to rt register 
282:     LD  3,-1(1) 	Load return address 
283:     LD  1,0(1) 	Adjust fp 
284:    LDA  7,0(3) 	Return 
279:    LDA  7,5(7) 	Jump around the THEN 
* ENDIF
* EXPRESSION STMT
285:     LD  3,-6(1) 	load lhs variable j
286:    LDA  3,1(3) 	increment value of j
287:     ST  3,-6(1) 	Store variable j
* END compound statement
288:    LDA  7,-45(7) 	go to beginning of loop 
253:    LDA  7,35(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
289:     LD  3,-5(1) 	load lhs variable i
290:    LDA  3,1(3) 	increment value of i
291:     ST  3,-5(1) 	Store variable i
* END compound statement
292:    LDA  7,-61(7) 	go to beginning of loop 
241:    LDA  7,51(7) 	No more loop 
* ENDWHILE
* RETURN
293:    LDC  3,1(6) 	Load constant 
294:    LDA  2,0(3) 	Copy result to rt register 
295:     LD  3,-1(1) 	Load return address 
296:     LD  1,0(1) 	Adjust fp 
297:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
298:    LDC  2,0(6) 	Set return value to 0 
299:     LD  3,-1(1) 	Load return address 
300:     LD  1,0(1) 	Adjust fp 
301:    LDA  7,0(3) 	Return 
* END of function isOkAt
* BEGIN function search
302:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* IF
303:     ST  1,-6(1) 	Store old fp in ghost frame 
304:     LD  3,-2(1) 	Load variable i
305:     ST  3,-8(1) 	Store parameter 
306:     LD  3,-3(1) 	Load variable j
307:     ST  3,-9(1) 	Store parameter 
308:    LDA  1,-6(1) 	Load address of new frame 
309:    LDA  3,1(7) 	Return address in ac 
310:    LDA  7,-185(7) 	CALL getLocked
311:    LDA  3,0(2) 	Save the result in ac 
312:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* IF
314:     LD  3,-2(1) 	Load variable i
315:     ST  3,-6(1) 	Save left side 
316:    LDC  3,8(6) 	Load constant 
317:     LD  4,-6(1) 	Load left into ac1 
318:    SUB  4,4,3 	Op == 
319:    LDC  3,1(6) 	True case 
320:    JEQ  4,1(7) 	Jump if true 
321:    LDC  3,0(6) 	False case 
322:     ST  3,-6(1) 	Save left side 
323:     LD  3,-3(1) 	Load variable j
324:     ST  3,-7(1) 	Save left side 
325:    LDC  3,8(6) 	Load constant 
326:     LD  4,-7(1) 	Load left into ac1 
327:    SUB  4,4,3 	Op == 
328:    LDC  3,1(6) 	True case 
329:    JEQ  4,1(7) 	Jump if true 
330:    LDC  3,0(6) 	False case 
331:     LD  4,-6(1) 	Load left into ac1 
332:    JEQ  3,1(7) 	Op AND 
333:    LDA  3,0(4) 	 
334:    JGT  3,1(7) 	Jump to then part 
* THEN
* RETURN
336:    LDC  3,1(6) 	Load constant 
337:    LDA  2,0(3) 	Copy result to rt register 
338:     LD  3,-1(1) 	Load return address 
339:     LD  1,0(1) 	Adjust fp 
340:    LDA  7,0(3) 	Return 
* ELSE
335:    LDA  7,6(7) 	Jump around the THEN 
* IF
342:     LD  3,-3(1) 	Load variable j
343:     ST  3,-6(1) 	Save left side 
344:    LDC  3,8(6) 	Load constant 
345:     LD  4,-6(1) 	Load left into ac1 
346:    SUB  4,4,3 	Op == 
347:    LDC  3,1(6) 	True case 
348:    JEQ  4,1(7) 	Jump if true 
349:    LDC  3,0(6) 	False case 
350:    JGT  3,1(7) 	Jump to then part 
* THEN
* RETURN
352:     ST  1,-6(1) 	Store old fp in ghost frame 
353:     LD  3,-2(1) 	Load variable i
354:     ST  3,-8(1) 	Save left side 
355:    LDC  3,1(6) 	Load constant 
356:     LD  4,-8(1) 	Load left into ac1 
357:    ADD  3,4,3 	Op + 
358:     ST  3,-8(1) 	Store parameter 
359:    LDC  3,0(6) 	Load constant 
360:     ST  3,-9(1) 	Store parameter 
361:    LDA  1,-6(1) 	Load address of new frame 
362:    LDA  3,1(7) 	Return address in ac 
363:    LDA  7,-62(7) 	CALL search
364:    LDA  3,0(2) 	Save the result in ac 
365:    LDA  2,0(3) 	Copy result to rt register 
366:     LD  3,-1(1) 	Load return address 
367:     LD  1,0(1) 	Adjust fp 
368:    LDA  7,0(3) 	Return 
* ELSE
351:    LDA  7,18(7) 	Jump around the THEN 
* RETURN
370:     ST  1,-6(1) 	Store old fp in ghost frame 
371:     LD  3,-2(1) 	Load variable i
372:     ST  3,-8(1) 	Store parameter 
373:     LD  3,-3(1) 	Load variable j
374:     ST  3,-9(1) 	Save left side 
375:    LDC  3,1(6) 	Load constant 
376:     LD  4,-9(1) 	Load left into ac1 
377:    ADD  3,4,3 	Op + 
378:     ST  3,-9(1) 	Store parameter 
379:    LDA  1,-6(1) 	Load address of new frame 
380:    LDA  3,1(7) 	Return address in ac 
381:    LDA  7,-80(7) 	CALL search
382:    LDA  3,0(2) 	Save the result in ac 
383:    LDA  2,0(3) 	Copy result to rt register 
384:     LD  3,-1(1) 	Load return address 
385:     LD  1,0(1) 	Adjust fp 
386:    LDA  7,0(3) 	Return 
369:    LDA  7,17(7) 	Jump around the ELSE 
* ENDIF
341:    LDA  7,45(7) 	Jump around the ELSE 
* ENDIF
* END compound statement
* ELSE
313:    LDA  7,74(7) 	Jump around the THEN 
* BEGIN compound statement
* EXPRESSION STMT
388:    LDC  3,1(6) 	Load constant 
389:     ST  3,-4(1) 	Store variable n
* WHILE
390:     LD  3,-4(1) 	Load variable n
391:     ST  3,-6(1) 	Save left side 
392:    LDC  3,9(6) 	Load constant 
393:     LD  4,-6(1) 	Load left into ac1 
394:    SUB  4,4,3 	Op <= 
395:    LDC  3,1(6) 	True case 
396:    JLE  4,1(7) 	Jump if true 
397:    LDC  3,0(6) 	False case 
398:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* IF
400:     ST  1,-6(1) 	Store old fp in ghost frame 
401:     LD  3,-2(1) 	Load variable i
402:     ST  3,-8(1) 	Store parameter 
403:     LD  3,-3(1) 	Load variable j
404:     ST  3,-9(1) 	Store parameter 
405:     LD  3,-4(1) 	Load variable n
406:     ST  3,-10(1) 	Store parameter 
407:    LDA  1,-6(1) 	Load address of new frame 
408:    LDA  3,1(7) 	Return address in ac 
409:    LDA  7,-263(7) 	CALL isOkAt
410:    LDA  3,0(2) 	Save the result in ac 
411:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
413:     ST  1,-6(1) 	Store old fp in ghost frame 
414:     LD  3,-2(1) 	Load variable i
415:     ST  3,-8(1) 	Store parameter 
416:     LD  3,-3(1) 	Load variable j
417:     ST  3,-9(1) 	Store parameter 
418:     LD  3,-4(1) 	Load variable n
419:     ST  3,-10(1) 	Store parameter 
420:    LDA  1,-6(1) 	Load address of new frame 
421:    LDA  3,1(7) 	Return address in ac 
422:    LDA  7,-358(7) 	CALL setValue
423:    LDA  3,0(2) 	Save the result in ac 
* IF
424:     LD  3,-2(1) 	Load variable i
425:     ST  3,-6(1) 	Save left side 
426:    LDC  3,8(6) 	Load constant 
427:     LD  4,-6(1) 	Load left into ac1 
428:    SUB  4,4,3 	Op == 
429:    LDC  3,1(6) 	True case 
430:    JEQ  4,1(7) 	Jump if true 
431:    LDC  3,0(6) 	False case 
432:     ST  3,-6(1) 	Save left side 
433:     LD  3,-3(1) 	Load variable j
434:     ST  3,-7(1) 	Save left side 
435:    LDC  3,8(6) 	Load constant 
436:     LD  4,-7(1) 	Load left into ac1 
437:    SUB  4,4,3 	Op == 
438:    LDC  3,1(6) 	True case 
439:    JEQ  4,1(7) 	Jump if true 
440:    LDC  3,0(6) 	False case 
441:     LD  4,-6(1) 	Load left into ac1 
442:    JEQ  3,1(7) 	Op AND 
443:    LDA  3,0(4) 	 
444:    JGT  3,1(7) 	Jump to then part 
* THEN
* RETURN
446:    LDC  3,1(6) 	Load constant 
447:    LDA  2,0(3) 	Copy result to rt register 
448:     LD  3,-1(1) 	Load return address 
449:     LD  1,0(1) 	Adjust fp 
450:    LDA  7,0(3) 	Return 
* ELSE
445:    LDA  7,6(7) 	Jump around the THEN 
* IF
452:     LD  3,-3(1) 	Load variable j
453:     ST  3,-6(1) 	Save left side 
454:    LDC  3,8(6) 	Load constant 
455:     LD  4,-6(1) 	Load left into ac1 
456:    SUB  4,4,3 	Op == 
457:    LDC  3,1(6) 	True case 
458:    JEQ  4,1(7) 	Jump if true 
459:    LDC  3,0(6) 	False case 
460:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
462:     ST  1,-6(1) 	Store old fp in ghost frame 
463:     LD  3,-2(1) 	Load variable i
464:     ST  3,-8(1) 	Save left side 
465:    LDC  3,1(6) 	Load constant 
466:     LD  4,-8(1) 	Load left into ac1 
467:    ADD  3,4,3 	Op + 
468:     ST  3,-8(1) 	Store parameter 
469:    LDC  3,0(6) 	Load constant 
470:     ST  3,-9(1) 	Store parameter 
471:    LDA  1,-6(1) 	Load address of new frame 
472:    LDA  3,1(7) 	Return address in ac 
473:    LDA  7,-172(7) 	CALL search
474:    LDA  3,0(2) 	Save the result in ac 
475:     ST  3,-5(1) 	Store variable foundOne
* ELSE
461:    LDA  7,15(7) 	Jump around the THEN 
* EXPRESSION STMT
477:     ST  1,-6(1) 	Store old fp in ghost frame 
478:     LD  3,-2(1) 	Load variable i
479:     ST  3,-8(1) 	Store parameter 
480:     LD  3,-3(1) 	Load variable j
481:     ST  3,-9(1) 	Save left side 
482:    LDC  3,1(6) 	Load constant 
483:     LD  4,-9(1) 	Load left into ac1 
484:    ADD  3,4,3 	Op + 
485:     ST  3,-9(1) 	Store parameter 
486:    LDA  1,-6(1) 	Load address of new frame 
487:    LDA  3,1(7) 	Return address in ac 
488:    LDA  7,-187(7) 	CALL search
489:    LDA  3,0(2) 	Save the result in ac 
490:     ST  3,-5(1) 	Store variable foundOne
476:    LDA  7,14(7) 	Jump around the ELSE 
* ENDIF
451:    LDA  7,39(7) 	Jump around the ELSE 
* ENDIF
* IF
491:     LD  3,-5(1) 	Load variable foundOne
492:    JGT  3,1(7) 	Jump to then part 
* THEN
* RETURN
494:    LDC  3,1(6) 	Load constant 
495:    LDA  2,0(3) 	Copy result to rt register 
496:     LD  3,-1(1) 	Load return address 
497:     LD  1,0(1) 	Adjust fp 
498:    LDA  7,0(3) 	Return 
* ELSE
493:    LDA  7,6(7) 	Jump around the THEN 
* EXPRESSION STMT
500:     ST  1,-6(1) 	Store old fp in ghost frame 
501:     LD  3,-2(1) 	Load variable i
502:     ST  3,-8(1) 	Store parameter 
503:     LD  3,-3(1) 	Load variable j
504:     ST  3,-9(1) 	Store parameter 
505:    LDC  3,0(6) 	Load constant 
506:     ST  3,-10(1) 	Store parameter 
507:    LDA  1,-6(1) 	Load address of new frame 
508:    LDA  3,1(7) 	Return address in ac 
509:    LDA  7,-445(7) 	CALL setValue
510:    LDA  3,0(2) 	Save the result in ac 
499:    LDA  7,11(7) 	Jump around the ELSE 
* ENDIF
* END compound statement
412:    LDA  7,98(7) 	Jump around the THEN 
* ENDIF
* EXPRESSION STMT
511:     LD  3,-4(1) 	load lhs variable n
512:    LDA  3,1(3) 	increment value of n
513:     ST  3,-4(1) 	Store variable n
* END compound statement
514:    LDA  7,-125(7) 	go to beginning of loop 
399:    LDA  7,115(7) 	No more loop 
* ENDWHILE
* END compound statement
387:    LDA  7,127(7) 	Jump around the ELSE 
* ENDIF
* RETURN
515:    LDC  3,0(6) 	Load constant 
516:    LDA  2,0(3) 	Copy result to rt register 
517:     LD  3,-1(1) 	Load return address 
518:     LD  1,0(1) 	Adjust fp 
519:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
520:    LDC  2,0(6) 	Set return value to 0 
521:     LD  3,-1(1) 	Load return address 
522:     LD  1,0(1) 	Adjust fp 
523:    LDA  7,0(3) 	Return 
* END of function search
* BEGIN function searchTrivial
524:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
525:    LDC  3,1(6) 	Load constant 
526:     ST  3,-6(1) 	Store variable changed
* WHILE
527:     LD  3,-6(1) 	Load variable changed
528:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
530:    LDC  3,0(6) 	Load constant 
531:     ST  3,-6(1) 	Store variable changed
* EXPRESSION STMT
532:    LDC  3,0(6) 	Load constant 
533:     ST  3,-2(1) 	Store variable i
* WHILE
534:     LD  3,-2(1) 	Load variable i
535:     ST  3,-8(1) 	Save left side 
536:    LDC  3,9(6) 	Load constant 
537:     LD  4,-8(1) 	Load left into ac1 
538:    SUB  4,4,3 	Op < 
539:    LDC  3,1(6) 	True case 
540:    JLT  4,1(7) 	Jump if true 
541:    LDC  3,0(6) 	False case 
542:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
544:    LDC  3,0(6) 	Load constant 
545:     ST  3,-3(1) 	Store variable j
* WHILE
546:     LD  3,-3(1) 	Load variable j
547:     ST  3,-8(1) 	Save left side 
548:    LDC  3,9(6) 	Load constant 
549:     LD  4,-8(1) 	Load left into ac1 
550:    SUB  4,4,3 	Op < 
551:    LDC  3,1(6) 	True case 
552:    JLT  4,1(7) 	Jump if true 
553:    LDC  3,0(6) 	False case 
554:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* IF
556:     ST  1,-8(1) 	Store old fp in ghost frame 
557:     LD  3,-2(1) 	Load variable i
558:     ST  3,-10(1) 	Store parameter 
559:     LD  3,-3(1) 	Load variable j
560:     ST  3,-11(1) 	Store parameter 
561:    LDA  1,-8(1) 	Load address of new frame 
562:    LDA  3,1(7) 	Return address in ac 
563:    LDA  7,-438(7) 	CALL getLocked
564:    LDA  3,0(2) 	Save the result in ac 
565:     ST  3,-8(1) 	Save left side 
566:    LDC  3,0(6) 	Load constant 
567:     LD  4,-8(1) 	Load left into ac1 
568:    SUB  4,4,3 	Op == 
569:    LDC  3,1(6) 	True case 
570:    JEQ  4,1(7) 	Jump if true 
571:    LDC  3,0(6) 	False case 
572:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
574:    LDC  3,1(6) 	Load constant 
575:     ST  3,-4(1) 	Store variable test
* EXPRESSION STMT
576:    LDC  3,0(6) 	Load constant 
577:     ST  3,-7(1) 	Store variable foundOne
* WHILE
578:     LD  3,-4(1) 	Load variable test
579:     ST  3,-8(1) 	Save left side 
580:    LDC  3,9(6) 	Load constant 
581:     LD  4,-8(1) 	Load left into ac1 
582:    SUB  4,4,3 	Op <= 
583:    LDC  3,1(6) 	True case 
584:    JLE  4,1(7) 	Jump if true 
585:    LDC  3,0(6) 	False case 
586:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* IF
588:     ST  1,-8(1) 	Store old fp in ghost frame 
589:     LD  3,-2(1) 	Load variable i
590:     ST  3,-10(1) 	Store parameter 
591:     LD  3,-3(1) 	Load variable j
592:     ST  3,-11(1) 	Store parameter 
593:     LD  3,-4(1) 	Load variable test
594:     ST  3,-12(1) 	Store parameter 
595:    LDA  1,-8(1) 	Load address of new frame 
596:    LDA  3,1(7) 	Return address in ac 
597:    LDA  7,-451(7) 	CALL isOkAt
598:    LDA  3,0(2) 	Save the result in ac 
599:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* IF
601:     LD  3,-7(1) 	Load variable foundOne
602:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
604:    LDC  3,0(6) 	Load constant 
605:     ST  3,-7(1) 	Store variable foundOne
* BREAK
606:    LDA  7,-20(7) 	break 
* END compound statement
* ELSE
603:    LDA  7,4(7) 	Jump around the THEN 
* BEGIN compound statement
* EXPRESSION STMT
608:    LDC  3,1(6) 	Load constant 
609:     ST  3,-7(1) 	Store variable foundOne
* EXPRESSION STMT
610:     LD  3,-4(1) 	Load variable test
611:     ST  3,-5(1) 	Store variable value
* END compound statement
607:    LDA  7,4(7) 	Jump around the ELSE 
* ENDIF
* END compound statement
600:    LDA  7,11(7) 	Jump around the THEN 
* ENDIF
* EXPRESSION STMT
612:     LD  3,-4(1) 	load lhs variable test
613:    LDA  3,1(3) 	increment value of test
614:     ST  3,-4(1) 	Store variable test
* END compound statement
615:    LDA  7,-38(7) 	go to beginning of loop 
587:    LDA  7,28(7) 	No more loop 
* ENDWHILE
* IF
616:     LD  3,-7(1) 	Load variable foundOne
617:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
619:     ST  1,-8(1) 	Store old fp in ghost frame 
620:     LD  3,-2(1) 	Load variable i
621:     ST  3,-10(1) 	Store parameter 
622:     LD  3,-3(1) 	Load variable j
623:     ST  3,-11(1) 	Store parameter 
624:     LD  3,-5(1) 	Load variable value
625:     ST  3,-12(1) 	Store parameter 
626:    LDA  1,-8(1) 	Load address of new frame 
627:    LDA  3,1(7) 	Return address in ac 
628:    LDA  7,-564(7) 	CALL setValue
629:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
630:     ST  1,-8(1) 	Store old fp in ghost frame 
631:     LD  3,-2(1) 	Load variable i
632:     ST  3,-10(1) 	Store parameter 
633:     LD  3,-3(1) 	Load variable j
634:     ST  3,-11(1) 	Store parameter 
635:    LDC  3,1(6) 	Load constant 
636:     ST  3,-12(1) 	Store parameter 
637:    LDA  1,-8(1) 	Load address of new frame 
638:    LDA  3,1(7) 	Return address in ac 
639:    LDA  7,-534(7) 	CALL setLocked
640:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
641:    LDC  3,1(6) 	Load constant 
642:     ST  3,-6(1) 	Store variable changed
* END compound statement
618:    LDA  7,24(7) 	Jump around the THEN 
* ENDIF
* END compound statement
573:    LDA  7,69(7) 	Jump around the THEN 
* ENDIF
* EXPRESSION STMT
643:     LD  3,-3(1) 	load lhs variable j
644:    LDA  3,1(3) 	increment value of j
645:     ST  3,-3(1) 	Store variable j
* END compound statement
646:    LDA  7,-101(7) 	go to beginning of loop 
555:    LDA  7,91(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
647:     LD  3,-2(1) 	load lhs variable i
648:    LDA  3,1(3) 	increment value of i
649:     ST  3,-2(1) 	Store variable i
* END compound statement
650:    LDA  7,-117(7) 	go to beginning of loop 
543:    LDA  7,107(7) 	No more loop 
* ENDWHILE
* END compound statement
651:    LDA  7,-125(7) 	go to beginning of loop 
529:    LDA  7,122(7) 	No more loop 
* ENDWHILE
* END compound statement
* Add standard closing in case there is no return statement
652:    LDC  2,0(6) 	Set return value to 0 
653:     LD  3,-1(1) 	Load return address 
654:     LD  1,0(1) 	Adjust fp 
655:    LDA  7,0(3) 	Return 
* END of function searchTrivial
* BEGIN function solve
656:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
657:    LDC  3,0(6) 	Load constant 
658:     ST  3,-2(1) 	Store variable i
* WHILE
659:     LD  3,-2(1) 	Load variable i
660:     ST  3,-5(1) 	Save left side 
661:    LDC  3,9(6) 	Load constant 
662:     LD  4,-5(1) 	Load left into ac1 
663:    SUB  4,4,3 	Op < 
664:    LDC  3,1(6) 	True case 
665:    JLT  4,1(7) 	Jump if true 
666:    LDC  3,0(6) 	False case 
667:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
669:    LDC  3,0(6) 	Load constant 
670:     ST  3,-3(1) 	Store variable j
* WHILE
671:     LD  3,-3(1) 	Load variable j
672:     ST  3,-5(1) 	Save left side 
673:    LDC  3,9(6) 	Load constant 
674:     LD  4,-5(1) 	Load left into ac1 
675:    SUB  4,4,3 	Op < 
676:    LDC  3,1(6) 	True case 
677:    JLT  4,1(7) 	Jump if true 
678:    LDC  3,0(6) 	False case 
679:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
681:     ST  1,-5(1) 	Store old fp in ghost frame 
682:     LD  3,-2(1) 	Load variable i
683:     ST  3,-7(1) 	Store parameter 
684:     LD  3,-3(1) 	Load variable j
685:     ST  3,-8(1) 	Store parameter 
686:    LDA  1,-5(1) 	Load address of new frame 
687:    LDA  3,1(7) 	Return address in ac 
688:    LDA  7,-604(7) 	CALL getValue
689:    LDA  3,0(2) 	Save the result in ac 
690:     ST  3,-4(1) 	Store variable n
* EXPRESSION STMT
691:     ST  1,-5(1) 	Store old fp in ghost frame 
692:     LD  3,-2(1) 	Load variable i
693:     ST  3,-7(1) 	Store parameter 
694:     LD  3,-3(1) 	Load variable j
695:     ST  3,-8(1) 	Store parameter 
696:    LDC  3,0(6) 	Load constant 
697:     ST  3,-9(1) 	Store parameter 
698:    LDA  1,-5(1) 	Load address of new frame 
699:    LDA  3,1(7) 	Return address in ac 
700:    LDA  7,-636(7) 	CALL setValue
701:    LDA  3,0(2) 	Save the result in ac 
* IF
702:     ST  1,-5(1) 	Store old fp in ghost frame 
703:     LD  3,-2(1) 	Load variable i
704:     ST  3,-7(1) 	Store parameter 
705:     LD  3,-3(1) 	Load variable j
706:     ST  3,-8(1) 	Store parameter 
707:    LDA  1,-5(1) 	Load address of new frame 
708:    LDA  3,1(7) 	Return address in ac 
709:    LDA  7,-584(7) 	CALL getLocked
710:    LDA  3,0(2) 	Save the result in ac 
711:     ST  3,-5(1) 	Save left side 
712:    LDC  3,1(6) 	Load constant 
713:     LD  4,-5(1) 	Load left into ac1 
714:    SUB  4,4,3 	Op == 
715:    LDC  3,1(6) 	True case 
716:    JEQ  4,1(7) 	Jump if true 
717:    LDC  3,0(6) 	False case 
718:     ST  3,-5(1) 	Save left side 
719:     ST  1,-6(1) 	Store old fp in ghost frame 
720:     LD  3,-2(1) 	Load variable i
721:     ST  3,-8(1) 	Store parameter 
722:     LD  3,-3(1) 	Load variable j
723:     ST  3,-9(1) 	Store parameter 
724:     LD  3,-4(1) 	Load variable n
725:     ST  3,-10(1) 	Store parameter 
726:    LDA  1,-6(1) 	Load address of new frame 
727:    LDA  3,1(7) 	Return address in ac 
728:    LDA  7,-582(7) 	CALL isOkAt
729:    LDA  3,0(2) 	Save the result in ac 
730:     ST  3,-6(1) 	Save left side 
731:    LDC  3,0(6) 	Load constant 
732:     LD  4,-6(1) 	Load left into ac1 
733:    SUB  4,4,3 	Op == 
734:    LDC  3,1(6) 	True case 
735:    JEQ  4,1(7) 	Jump if true 
736:    LDC  3,0(6) 	False case 
737:     LD  4,-5(1) 	Load left into ac1 
738:    JEQ  3,1(7) 	Op AND 
739:    LDA  3,0(4) 	 
740:    JGT  3,1(7) 	Jump to then part 
* THEN
* RETURN
742:    LDC  3,0(6) 	Load constant 
743:    LDA  2,0(3) 	Copy result to rt register 
744:     LD  3,-1(1) 	Load return address 
745:     LD  1,0(1) 	Adjust fp 
746:    LDA  7,0(3) 	Return 
741:    LDA  7,5(7) 	Jump around the THEN 
* ENDIF
* EXPRESSION STMT
747:     ST  1,-5(1) 	Store old fp in ghost frame 
748:     LD  3,-2(1) 	Load variable i
749:     ST  3,-7(1) 	Store parameter 
750:     LD  3,-3(1) 	Load variable j
751:     ST  3,-8(1) 	Store parameter 
752:     LD  3,-4(1) 	Load variable n
753:     ST  3,-9(1) 	Store parameter 
754:    LDA  1,-5(1) 	Load address of new frame 
755:    LDA  3,1(7) 	Return address in ac 
756:    LDA  7,-692(7) 	CALL setValue
757:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
758:     LD  3,-3(1) 	load lhs variable j
759:    LDA  3,1(3) 	increment value of j
760:     ST  3,-3(1) 	Store variable j
* END compound statement
761:    LDA  7,-91(7) 	go to beginning of loop 
680:    LDA  7,81(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
762:     LD  3,-2(1) 	load lhs variable i
763:    LDA  3,1(3) 	increment value of i
764:     ST  3,-2(1) 	Store variable i
* END compound statement
765:    LDA  7,-107(7) 	go to beginning of loop 
668:    LDA  7,97(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
766:     ST  1,-5(1) 	Store old fp in ghost frame 
767:    LDA  1,-5(1) 	Load address of new frame 
768:    LDA  3,1(7) 	Return address in ac 
769:    LDA  7,-246(7) 	CALL searchTrivial
770:    LDA  3,0(2) 	Save the result in ac 
* RETURN
771:     ST  1,-5(1) 	Store old fp in ghost frame 
772:    LDC  3,0(6) 	Load constant 
773:     ST  3,-7(1) 	Store parameter 
774:    LDC  3,0(6) 	Load constant 
775:     ST  3,-8(1) 	Store parameter 
776:    LDA  1,-5(1) 	Load address of new frame 
777:    LDA  3,1(7) 	Return address in ac 
778:    LDA  7,-477(7) 	CALL search
779:    LDA  3,0(2) 	Save the result in ac 
780:    LDA  2,0(3) 	Copy result to rt register 
781:     LD  3,-1(1) 	Load return address 
782:     LD  1,0(1) 	Adjust fp 
783:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
784:    LDC  2,0(6) 	Set return value to 0 
785:     LD  3,-1(1) 	Load return address 
786:     LD  1,0(1) 	Adjust fp 
787:    LDA  7,0(3) 	Return 
* END of function solve
* BEGIN function showBoard
788:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
789:     ST  1,-4(1) 	Store old fp in ghost frame 
790:    LDA  1,-4(1) 	Load address of new frame 
791:    LDA  3,1(7) 	Return address in ac 
792:    LDA  7,-768(7) 	CALL outnl
793:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
794:    LDC  3,0(6) 	Load constant 
795:     ST  3,-2(1) 	Store variable i
* WHILE
796:     LD  3,-2(1) 	Load variable i
797:     ST  3,-4(1) 	Save left side 
798:    LDC  3,9(6) 	Load constant 
799:     LD  4,-4(1) 	Load left into ac1 
800:    SUB  4,4,3 	Op < 
801:    LDC  3,1(6) 	True case 
802:    JLT  4,1(7) 	Jump if true 
803:    LDC  3,0(6) 	False case 
804:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
806:    LDC  3,0(6) 	Load constant 
807:     ST  3,-3(1) 	Store variable j
* WHILE
808:     LD  3,-3(1) 	Load variable j
809:     ST  3,-4(1) 	Save left side 
810:    LDC  3,9(6) 	Load constant 
811:     LD  4,-4(1) 	Load left into ac1 
812:    SUB  4,4,3 	Op < 
813:    LDC  3,1(6) 	True case 
814:    JLT  4,1(7) 	Jump if true 
815:    LDC  3,0(6) 	False case 
816:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
818:     ST  1,-4(1) 	Store old fp in ghost frame 
819:     ST  1,-6(1) 	Store old fp in ghost frame 
820:     LD  3,-2(1) 	Load variable i
821:     ST  3,-8(1) 	Store parameter 
822:     LD  3,-3(1) 	Load variable j
823:     ST  3,-9(1) 	Store parameter 
824:    LDA  1,-6(1) 	Load address of new frame 
825:    LDA  3,1(7) 	Return address in ac 
826:    LDA  7,-742(7) 	CALL getValue
827:    LDA  3,0(2) 	Save the result in ac 
828:     ST  3,-6(1) 	Store parameter 
829:    LDA  1,-4(1) 	Load address of new frame 
830:    LDA  3,1(7) 	Return address in ac 
831:    LDA  7,-826(7) 	CALL output
832:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
833:     LD  3,-3(1) 	load lhs variable j
834:    LDA  3,1(3) 	increment value of j
835:     ST  3,-3(1) 	Store variable j
* END compound statement
836:    LDA  7,-29(7) 	go to beginning of loop 
817:    LDA  7,19(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
837:     ST  1,-4(1) 	Store old fp in ghost frame 
838:    LDA  1,-4(1) 	Load address of new frame 
839:    LDA  3,1(7) 	Return address in ac 
840:    LDA  7,-816(7) 	CALL outnl
841:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
842:     LD  3,-2(1) 	load lhs variable i
843:    LDA  3,1(3) 	increment value of i
844:     ST  3,-2(1) 	Store variable i
* END compound statement
845:    LDA  7,-50(7) 	go to beginning of loop 
805:    LDA  7,40(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
846:     ST  1,-4(1) 	Store old fp in ghost frame 
847:    LDA  1,-4(1) 	Load address of new frame 
848:    LDA  3,1(7) 	Return address in ac 
849:    LDA  7,-825(7) 	CALL outnl
850:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
851:    LDC  2,0(6) 	Set return value to 0 
852:     LD  3,-1(1) 	Load return address 
853:     LD  1,0(1) 	Adjust fp 
854:    LDA  7,0(3) 	Return 
* END of function showBoard
* BEGIN function getInput
855:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
856:    LDC  3,0(6) 	Load constant 
857:     ST  3,-2(1) 	Store variable i
* WHILE
858:     LD  3,-2(1) 	Load variable i
859:     ST  3,-5(1) 	Save left side 
860:    LDC  3,9(6) 	Load constant 
861:     LD  4,-5(1) 	Load left into ac1 
862:    SUB  4,4,3 	Op < 
863:    LDC  3,1(6) 	True case 
864:    JLT  4,1(7) 	Jump if true 
865:    LDC  3,0(6) 	False case 
866:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
868:    LDC  3,0(6) 	Load constant 
869:     ST  3,-3(1) 	Store variable j
* WHILE
870:     LD  3,-3(1) 	Load variable j
871:     ST  3,-5(1) 	Save left side 
872:    LDC  3,9(6) 	Load constant 
873:     LD  4,-5(1) 	Load left into ac1 
874:    SUB  4,4,3 	Op < 
875:    LDC  3,1(6) 	True case 
876:    JLT  4,1(7) 	Jump if true 
877:    LDC  3,0(6) 	False case 
878:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
880:     ST  1,-5(1) 	Store old fp in ghost frame 
881:    LDA  1,-5(1) 	Load address of new frame 
882:    LDA  3,1(7) 	Return address in ac 
883:    LDA  7,-883(7) 	CALL input
884:    LDA  3,0(2) 	Save the result in ac 
885:     ST  3,-4(1) 	Store variable inputVal
* IF
886:     LD  3,-4(1) 	Load variable inputVal
887:     ST  3,-5(1) 	Save left side 
888:    LDC  3,0(6) 	Load constant 
889:     LD  4,-5(1) 	Load left into ac1 
890:    SUB  4,4,3 	Op > 
891:    LDC  3,1(6) 	True case 
892:    JGT  4,1(7) 	Jump if true 
893:    LDC  3,0(6) 	False case 
894:     ST  3,-5(1) 	Save left side 
895:     LD  3,-4(1) 	Load variable inputVal
896:     ST  3,-6(1) 	Save left side 
897:    LDC  3,10(6) 	Load constant 
898:     LD  4,-6(1) 	Load left into ac1 
899:    SUB  4,4,3 	Op < 
900:    LDC  3,1(6) 	True case 
901:    JLT  4,1(7) 	Jump if true 
902:    LDC  3,0(6) 	False case 
903:     LD  4,-5(1) 	Load left into ac1 
904:    JEQ  3,1(7) 	Op AND 
905:    LDA  3,0(4) 	 
906:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
908:     ST  1,-5(1) 	Store old fp in ghost frame 
909:     LD  3,-2(1) 	Load variable i
910:     ST  3,-7(1) 	Store parameter 
911:     LD  3,-3(1) 	Load variable j
912:     ST  3,-8(1) 	Store parameter 
913:     LD  3,-4(1) 	Load variable inputVal
914:     ST  3,-9(1) 	Store parameter 
915:    LDA  1,-5(1) 	Load address of new frame 
916:    LDA  3,1(7) 	Return address in ac 
917:    LDA  7,-853(7) 	CALL setValue
918:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
919:     ST  1,-5(1) 	Store old fp in ghost frame 
920:     LD  3,-2(1) 	Load variable i
921:     ST  3,-7(1) 	Store parameter 
922:     LD  3,-3(1) 	Load variable j
923:     ST  3,-8(1) 	Store parameter 
924:    LDC  3,1(6) 	Load constant 
925:     ST  3,-9(1) 	Store parameter 
926:    LDA  1,-5(1) 	Load address of new frame 
927:    LDA  3,1(7) 	Return address in ac 
928:    LDA  7,-823(7) 	CALL setLocked
929:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
907:    LDA  7,22(7) 	Jump around the THEN 
* ENDIF
* EXPRESSION STMT
930:     LD  3,-3(1) 	load lhs variable j
931:    LDA  3,1(3) 	increment value of j
932:     ST  3,-3(1) 	Store variable j
* END compound statement
933:    LDA  7,-64(7) 	go to beginning of loop 
879:    LDA  7,54(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
934:     ST  1,-5(1) 	Store old fp in ghost frame 
935:    LDA  1,-5(1) 	Load address of new frame 
936:    LDA  3,1(7) 	Return address in ac 
937:    LDA  7,-913(7) 	CALL outnl
938:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
939:     LD  3,-2(1) 	load lhs variable i
940:    LDA  3,1(3) 	increment value of i
941:     ST  3,-2(1) 	Store variable i
* END compound statement
942:    LDA  7,-85(7) 	go to beginning of loop 
867:    LDA  7,75(7) 	No more loop 
* ENDWHILE
* END compound statement
* Add standard closing in case there is no return statement
943:    LDC  2,0(6) 	Set return value to 0 
944:     LD  3,-1(1) 	Load return address 
945:     LD  1,0(1) 	Adjust fp 
946:    LDA  7,0(3) 	Return 
* END of function getInput
* BEGIN function main
947:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
948:     ST  1,-2(1) 	Store old fp in ghost frame 
949:    LDA  1,-2(1) 	Load address of new frame 
950:    LDA  3,1(7) 	Return address in ac 
951:    LDA  7,-922(7) 	CALL initBoard
952:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
953:     ST  1,-2(1) 	Store old fp in ghost frame 
954:    LDA  1,-2(1) 	Load address of new frame 
955:    LDA  3,1(7) 	Return address in ac 
956:    LDA  7,-102(7) 	CALL getInput
957:    LDA  3,0(2) 	Save the result in ac 
* IF
958:     ST  1,-2(1) 	Store old fp in ghost frame 
959:    LDA  1,-2(1) 	Load address of new frame 
960:    LDA  3,1(7) 	Return address in ac 
961:    LDA  7,-306(7) 	CALL solve
962:    LDA  3,0(2) 	Save the result in ac 
963:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
965:     ST  1,-2(1) 	Store old fp in ghost frame 
966:    LDA  1,-2(1) 	Load address of new frame 
967:    LDA  3,1(7) 	Return address in ac 
968:    LDA  7,-181(7) 	CALL showBoard
969:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* ELSE
964:    LDA  7,6(7) 	Jump around the THEN 
* BEGIN compound statement
* EXPRESSION STMT
971:     ST  1,-2(1) 	Store old fp in ghost frame 
972:    LDC  3,0(6) 	Load constant 
973:     ST  3,-4(1) 	Store parameter 
974:    LDA  1,-2(1) 	Load address of new frame 
975:    LDA  3,1(7) 	Return address in ac 
976:    LDA  7,-959(7) 	CALL outputb
977:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
978:     ST  1,-2(1) 	Store old fp in ghost frame 
979:    LDA  1,-2(1) 	Load address of new frame 
980:    LDA  3,1(7) 	Return address in ac 
981:    LDA  7,-957(7) 	CALL outnl
982:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
970:    LDA  7,12(7) 	Jump around the ELSE 
* ENDIF
* RETURN
983:    LDC  3,0(6) 	Load constant 
984:    LDA  2,0(3) 	Copy result to rt register 
985:     LD  3,-1(1) 	Load return address 
986:     LD  1,0(1) 	Adjust fp 
987:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
988:    LDC  2,0(6) 	Set return value to 0 
989:     LD  3,-1(1) 	Load return address 
990:     LD  1,0(1) 	Adjust fp 
991:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,991(7) 	Jump to init 
* BEGIN Init
992:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
993:    LDC  3,81(6) 	load size of array board
994:     ST  3,0(0) 	save size of array board
995:    LDC  3,81(6) 	load size of array locked
996:     ST  3,-82(0) 	save size of array locked
* END init of global array sizes
997:    LDA  1,-164(0) 	set first frame at end of globals 
998:     ST  1,0(1) 	store old fp (point to self) 
999:    LDA  3,1(7) 	Return address in ac 
1000:    LDA  7,-54(7) 	Jump to main 
1001:   HALT  0,0,0 	DONE! 
* END Init
