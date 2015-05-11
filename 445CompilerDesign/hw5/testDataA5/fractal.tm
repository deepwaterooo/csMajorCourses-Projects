* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  fractal.c-
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
* BEGIN function Mandelbrot
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* WHILE
 31:     LD  3,0(0) 	Load variable TOP
 32:     ST  3,-8(1) 	Save left side 
 33:     LD  3,-7(0) 	Load variable YMax
 34:     LD  4,-8(1) 	Load left into ac1 
 35:    SUB  4,4,3 	Op < 
 36:    LDC  3,1(6) 	True case 
 37:    JLT  4,1(7) 	Jump if true 
 38:    LDC  3,0(6) 	False case 
 39:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 41:    LDC  3,512(6) 	Load constant 
 42:    LDC  4,0(6) 	Load 0 
 43:    SUB  3,4,3 	Op unary - 
 44:     ST  3,-1(0) 	Store variable LEFT
* WHILE
 45:     LD  3,-1(0) 	Load variable LEFT
 46:     ST  3,-8(1) 	Save left side 
 47:     LD  3,-6(0) 	Load variable XMax
 48:     LD  4,-8(1) 	Load left into ac1 
 49:    SUB  4,4,3 	Op < 
 50:    LDC  3,1(6) 	True case 
 51:    JLT  4,1(7) 	Jump if true 
 52:    LDC  3,0(6) 	False case 
 53:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 55:     LD  3,-1(0) 	Load variable LEFT
 56:     ST  3,-5(1) 	Store variable A
* EXPRESSION STMT
 57:     LD  3,0(0) 	Load variable TOP
 58:     ST  3,-4(1) 	Store variable Bi
* EXPRESSION STMT
 59:     LD  3,-5(1) 	Load variable A
 60:     ST  3,-8(1) 	Save left side 
 61:     LD  3,-5(1) 	Load variable A
 62:     LD  4,-8(1) 	Load left into ac1 
 63:    MUL  3,4,3 	Op * 
 64:     ST  3,-8(1) 	Save left side 
 65:    LDC  3,256(6) 	Load constant 
 66:     LD  4,-8(1) 	Load left into ac1 
 67:    DIV  3,4,3 	Op / 
 68:     ST  3,-6(1) 	Store variable NextA
* EXPRESSION STMT
 69:     LD  3,-4(1) 	Load variable Bi
 70:     ST  3,-8(1) 	Save left side 
 71:     LD  3,-4(1) 	Load variable Bi
 72:     LD  4,-8(1) 	Load left into ac1 
 73:    MUL  3,4,3 	Op * 
 74:     ST  3,-8(1) 	Save left side 
 75:    LDC  3,256(6) 	Load constant 
 76:     LD  4,-8(1) 	Load left into ac1 
 77:    DIV  3,4,3 	Op / 
 78:     ST  3,-7(1) 	Store variable NextBi
* EXPRESSION STMT
 79:     LD  3,-6(1) 	Load variable NextA
 80:     ST  3,-8(1) 	Save left side 
 81:     LD  3,-7(1) 	Load variable NextBi
 82:     LD  4,-8(1) 	Load left into ac1 
 83:    ADD  3,4,3 	Op + 
 84:     ST  3,-3(1) 	Store variable Len
* EXPRESSION STMT
 85:    LDC  3,0(6) 	Load constant 
 86:     ST  3,-8(0) 	Store variable iter
* WHILE
 87:     LD  3,-3(1) 	Load variable Len
 88:     ST  3,-8(1) 	Save left side 
 89:    LDC  3,1024(6) 	Load constant 
 90:     LD  4,-8(1) 	Load left into ac1 
 91:    SUB  4,4,3 	Op <= 
 92:    LDC  3,1(6) 	True case 
 93:    JLE  4,1(7) 	Jump if true 
 94:    LDC  3,0(6) 	False case 
 95:     ST  3,-8(1) 	Save left side 
 96:     LD  3,-8(0) 	Load variable iter
 97:     ST  3,-9(1) 	Save left side 
 98:    LDC  3,11(6) 	Load constant 
 99:     LD  4,-9(1) 	Load left into ac1 
100:    SUB  4,4,3 	Op < 
101:    LDC  3,1(6) 	True case 
102:    JLT  4,1(7) 	Jump if true 
103:    LDC  3,0(6) 	False case 
104:     LD  4,-8(1) 	Load left into ac1 
105:    JEQ  3,1(7) 	Op AND 
106:    LDA  3,0(4) 	 
107:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
109:    LDC  3,2(6) 	Load constant 
110:     ST  3,-8(1) 	Save left side 
111:     LD  3,-5(1) 	Load variable A
112:     ST  3,-9(1) 	Save left side 
113:     LD  3,-4(1) 	Load variable Bi
114:     LD  4,-9(1) 	Load left into ac1 
115:    MUL  3,4,3 	Op * 
116:     LD  4,-8(1) 	Load left into ac1 
117:    MUL  3,4,3 	Op * 
118:     ST  3,-8(1) 	Save left side 
119:    LDC  3,256(6) 	Load constant 
120:     LD  4,-8(1) 	Load left into ac1 
121:    DIV  3,4,3 	Op / 
122:     ST  3,-8(1) 	Save left side 
123:     LD  3,0(0) 	Load variable TOP
124:     LD  4,-8(1) 	Load left into ac1 
125:    ADD  3,4,3 	Op + 
126:     ST  3,-4(1) 	Store variable Bi
* EXPRESSION STMT
127:     LD  3,-6(1) 	Load variable NextA
128:     ST  3,-8(1) 	Save left side 
129:     LD  3,-7(1) 	Load variable NextBi
130:     LD  4,-8(1) 	Load left into ac1 
131:    SUB  3,4,3 	Op - 
132:     ST  3,-8(1) 	Save left side 
133:     LD  3,-1(0) 	Load variable LEFT
134:     LD  4,-8(1) 	Load left into ac1 
135:    ADD  3,4,3 	Op + 
136:     ST  3,-5(1) 	Store variable A
* EXPRESSION STMT
137:     LD  3,-5(1) 	Load variable A
138:     ST  3,-8(1) 	Save left side 
139:     LD  3,-5(1) 	Load variable A
140:     LD  4,-8(1) 	Load left into ac1 
141:    MUL  3,4,3 	Op * 
142:     ST  3,-8(1) 	Save left side 
143:    LDC  3,256(6) 	Load constant 
144:     LD  4,-8(1) 	Load left into ac1 
145:    DIV  3,4,3 	Op / 
146:     ST  3,-6(1) 	Store variable NextA
* EXPRESSION STMT
147:     LD  3,-4(1) 	Load variable Bi
148:     ST  3,-8(1) 	Save left side 
149:     LD  3,-4(1) 	Load variable Bi
150:     LD  4,-8(1) 	Load left into ac1 
151:    MUL  3,4,3 	Op * 
152:     ST  3,-8(1) 	Save left side 
153:    LDC  3,256(6) 	Load constant 
154:     LD  4,-8(1) 	Load left into ac1 
155:    DIV  3,4,3 	Op / 
156:     ST  3,-7(1) 	Store variable NextBi
* EXPRESSION STMT
157:     LD  3,-6(1) 	Load variable NextA
158:     ST  3,-8(1) 	Save left side 
159:     LD  3,-7(1) 	Load variable NextBi
160:     LD  4,-8(1) 	Load left into ac1 
161:    ADD  3,4,3 	Op + 
162:     ST  3,-3(1) 	Store variable Len
* EXPRESSION STMT
163:     LD  3,-8(0) 	load lhs variable iter
164:    LDA  3,1(3) 	increment value of iter
165:     ST  3,-8(0) 	Store variable iter
* END compound statement
166:    LDA  7,-80(7) 	go to beginning of loop 
108:    LDA  7,58(7) 	No more loop 
* ENDWHILE
* IF
167:     LD  3,-8(0) 	Load variable iter
168:     ST  3,-8(1) 	Save left side 
169:    LDC  3,10(6) 	Load constant 
170:     LD  4,-8(1) 	Load left into ac1 
171:    SUB  4,4,3 	Op < 
172:    LDC  3,1(6) 	True case 
173:    JLT  4,1(7) 	Jump if true 
174:    LDC  3,0(6) 	False case 
175:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
177:     ST  1,-8(1) 	Store old fp in ghost frame 
178:     LD  3,-8(0) 	Load variable iter
179:     ST  3,-10(1) 	Store parameter 
180:    LDA  1,-8(1) 	Load address of new frame 
181:    LDA  3,1(7) 	Return address in ac 
182:    LDA  7,-177(7) 	CALL output
183:    LDA  3,0(2) 	Save the result in ac 
* ELSE
176:    LDA  7,8(7) 	Jump around the THEN 
* EXPRESSION STMT
185:     ST  1,-8(1) 	Store old fp in ghost frame 
186:     LD  3,-8(0) 	Load variable iter
187:     ST  3,-10(1) 	Save left side 
188:    LDC  3,11(6) 	Load constant 
189:     LD  4,-10(1) 	Load left into ac1 
190:    SUB  4,4,3 	Op == 
191:    LDC  3,1(6) 	True case 
192:    JEQ  4,1(7) 	Jump if true 
193:    LDC  3,0(6) 	False case 
194:     ST  3,-10(1) 	Store parameter 
195:    LDA  1,-8(1) 	Load address of new frame 
196:    LDA  3,1(7) 	Return address in ac 
197:    LDA  7,-180(7) 	CALL outputb
198:    LDA  3,0(2) 	Save the result in ac 
184:    LDA  7,14(7) 	Jump around the ELSE 
* ENDIF
* IF
199:     LD  3,-8(0) 	Load variable iter
200:     ST  3,-8(1) 	Save left side 
201:    LDC  3,11(6) 	Load constant 
202:     LD  4,-8(1) 	Load left into ac1 
203:    SUB  4,4,3 	Op == 
204:    LDC  3,1(6) 	True case 
205:    JEQ  4,1(7) 	Jump if true 
206:    LDC  3,0(6) 	False case 
207:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
209:    LDC  3,0(6) 	Load constant 
210:     ST  3,-8(1) 	Save index 
211:     LD  3,-1(0) 	Load variable LEFT
212:     LD  4,-8(1) 	Restore index 
213:     LD  5,-2(1) 	Load address of base of array JuliaVals
214:    SUB  5,5,4 	Compute offset of value 
215:     ST  3,0(5) 	Store variable JuliaVals
* EXPRESSION STMT
216:    LDC  3,1(6) 	Load constant 
217:     ST  3,-8(1) 	Save index 
218:     LD  3,0(0) 	Load variable TOP
219:     LD  4,-8(1) 	Restore index 
220:     LD  5,-2(1) 	Load address of base of array JuliaVals
221:    SUB  5,5,4 	Compute offset of value 
222:     ST  3,0(5) 	Store variable JuliaVals
* END compound statement
208:    LDA  7,14(7) 	Jump around the THEN 
* ENDIF
* EXPRESSION STMT
223:     LD  3,-4(0) 	Load variable XStep
224:     LD  4,-1(0) 	load lhs variable LEFT
225:    ADD  3,4,3 	op += 
226:     ST  3,-1(0) 	Store variable LEFT
* END compound statement
227:    LDA  7,-183(7) 	go to beginning of loop 
 54:    LDA  7,173(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
228:     ST  1,-8(1) 	Store old fp in ghost frame 
229:    LDA  1,-8(1) 	Load address of new frame 
230:    LDA  3,1(7) 	Return address in ac 
231:    LDA  7,-207(7) 	CALL outnl
232:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
233:     LD  3,-5(0) 	Load variable YStep
234:     LD  4,0(0) 	load lhs variable TOP
235:    ADD  3,4,3 	op += 
236:     ST  3,0(0) 	Store variable TOP
* END compound statement
237:    LDA  7,-207(7) 	go to beginning of loop 
 40:    LDA  7,197(7) 	No more loop 
* ENDWHILE
* END compound statement
* Add standard closing in case there is no return statement
238:    LDC  2,0(6) 	Set return value to 0 
239:     LD  3,-1(1) 	Load return address 
240:     LD  1,0(1) 	Adjust fp 
241:    LDA  7,0(3) 	Return 
* END of function Mandelbrot
* BEGIN function Julia
242:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* WHILE
243:     LD  3,0(0) 	Load variable TOP
244:     ST  3,-9(1) 	Save left side 
245:     LD  3,-7(0) 	Load variable YMax
246:     LD  4,-9(1) 	Load left into ac1 
247:    SUB  4,4,3 	Op < 
248:    LDC  3,1(6) 	True case 
249:    JLT  4,1(7) 	Jump if true 
250:    LDC  3,0(6) 	False case 
251:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
253:    LDC  3,512(6) 	Load constant 
254:    LDC  4,0(6) 	Load 0 
255:    SUB  3,4,3 	Op unary - 
256:     ST  3,-1(0) 	Store variable LEFT
* WHILE
257:     LD  3,-1(0) 	Load variable LEFT
258:     ST  3,-9(1) 	Save left side 
259:     LD  3,-6(0) 	Load variable XMax
260:     LD  4,-9(1) 	Load left into ac1 
261:    SUB  4,4,3 	Op < 
262:    LDC  3,1(6) 	True case 
263:    JLT  4,1(7) 	Jump if true 
264:    LDC  3,0(6) 	False case 
265:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
267:     LD  3,-1(0) 	Load variable LEFT
268:     ST  3,-6(1) 	Store variable A
* EXPRESSION STMT
269:     LD  3,0(0) 	Load variable TOP
270:     ST  3,-5(1) 	Store variable Bi
* EXPRESSION STMT
271:     LD  3,-6(1) 	Load variable A
272:     ST  3,-9(1) 	Save left side 
273:     LD  3,-6(1) 	Load variable A
274:     LD  4,-9(1) 	Load left into ac1 
275:    MUL  3,4,3 	Op * 
276:     ST  3,-9(1) 	Save left side 
277:    LDC  3,256(6) 	Load constant 
278:     LD  4,-9(1) 	Load left into ac1 
279:    DIV  3,4,3 	Op / 
280:     ST  3,-7(1) 	Store variable NextA
* EXPRESSION STMT
281:     LD  3,-5(1) 	Load variable Bi
282:     ST  3,-9(1) 	Save left side 
283:     LD  3,-5(1) 	Load variable Bi
284:     LD  4,-9(1) 	Load left into ac1 
285:    MUL  3,4,3 	Op * 
286:     ST  3,-9(1) 	Save left side 
287:    LDC  3,256(6) 	Load constant 
288:     LD  4,-9(1) 	Load left into ac1 
289:    DIV  3,4,3 	Op / 
290:     ST  3,-8(1) 	Store variable NextBi
* EXPRESSION STMT
291:     LD  3,-7(1) 	Load variable NextA
292:     ST  3,-9(1) 	Save left side 
293:     LD  3,-8(1) 	Load variable NextBi
294:     LD  4,-9(1) 	Load left into ac1 
295:    ADD  3,4,3 	Op + 
296:     ST  3,-4(1) 	Store variable Len
* EXPRESSION STMT
297:    LDC  3,0(6) 	Load constant 
298:     ST  3,-8(0) 	Store variable iter
* WHILE
299:     LD  3,-4(1) 	Load variable Len
300:     ST  3,-9(1) 	Save left side 
301:    LDC  3,1024(6) 	Load constant 
302:     LD  4,-9(1) 	Load left into ac1 
303:    SUB  4,4,3 	Op <= 
304:    LDC  3,1(6) 	True case 
305:    JLE  4,1(7) 	Jump if true 
306:    LDC  3,0(6) 	False case 
307:     ST  3,-9(1) 	Save left side 
308:     LD  3,-8(0) 	Load variable iter
309:     ST  3,-10(1) 	Save left side 
310:    LDC  3,11(6) 	Load constant 
311:     LD  4,-10(1) 	Load left into ac1 
312:    SUB  4,4,3 	Op < 
313:    LDC  3,1(6) 	True case 
314:    JLT  4,1(7) 	Jump if true 
315:    LDC  3,0(6) 	False case 
316:     LD  4,-9(1) 	Load left into ac1 
317:    JEQ  3,1(7) 	Op AND 
318:    LDA  3,0(4) 	 
319:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
321:    LDC  3,2(6) 	Load constant 
322:     ST  3,-9(1) 	Save left side 
323:     LD  3,-6(1) 	Load variable A
324:     ST  3,-10(1) 	Save left side 
325:     LD  3,-5(1) 	Load variable Bi
326:     LD  4,-10(1) 	Load left into ac1 
327:    MUL  3,4,3 	Op * 
328:     LD  4,-9(1) 	Load left into ac1 
329:    MUL  3,4,3 	Op * 
330:     ST  3,-9(1) 	Save left side 
331:    LDC  3,256(6) 	Load constant 
332:     LD  4,-9(1) 	Load left into ac1 
333:    DIV  3,4,3 	Op / 
334:     ST  3,-9(1) 	Save left side 
335:     LD  3,-3(1) 	Load variable CBi
336:     LD  4,-9(1) 	Load left into ac1 
337:    ADD  3,4,3 	Op + 
338:     ST  3,-5(1) 	Store variable Bi
* EXPRESSION STMT
339:     LD  3,-7(1) 	Load variable NextA
340:     ST  3,-9(1) 	Save left side 
341:     LD  3,-8(1) 	Load variable NextBi
342:     LD  4,-9(1) 	Load left into ac1 
343:    SUB  3,4,3 	Op - 
344:     ST  3,-9(1) 	Save left side 
345:     LD  3,-2(1) 	Load variable CA
346:     LD  4,-9(1) 	Load left into ac1 
347:    ADD  3,4,3 	Op + 
348:     ST  3,-6(1) 	Store variable A
* EXPRESSION STMT
349:     LD  3,-6(1) 	Load variable A
350:     ST  3,-9(1) 	Save left side 
351:     LD  3,-6(1) 	Load variable A
352:     LD  4,-9(1) 	Load left into ac1 
353:    MUL  3,4,3 	Op * 
354:     ST  3,-9(1) 	Save left side 
355:    LDC  3,256(6) 	Load constant 
356:     LD  4,-9(1) 	Load left into ac1 
357:    DIV  3,4,3 	Op / 
358:     ST  3,-7(1) 	Store variable NextA
* EXPRESSION STMT
359:     LD  3,-5(1) 	Load variable Bi
360:     ST  3,-9(1) 	Save left side 
361:     LD  3,-5(1) 	Load variable Bi
362:     LD  4,-9(1) 	Load left into ac1 
363:    MUL  3,4,3 	Op * 
364:     ST  3,-9(1) 	Save left side 
365:    LDC  3,256(6) 	Load constant 
366:     LD  4,-9(1) 	Load left into ac1 
367:    DIV  3,4,3 	Op / 
368:     ST  3,-8(1) 	Store variable NextBi
* EXPRESSION STMT
369:     LD  3,-7(1) 	Load variable NextA
370:     ST  3,-9(1) 	Save left side 
371:     LD  3,-8(1) 	Load variable NextBi
372:     LD  4,-9(1) 	Load left into ac1 
373:    ADD  3,4,3 	Op + 
374:     ST  3,-4(1) 	Store variable Len
* EXPRESSION STMT
375:     LD  3,-8(0) 	load lhs variable iter
376:    LDA  3,1(3) 	increment value of iter
377:     ST  3,-8(0) 	Store variable iter
* END compound statement
378:    LDA  7,-80(7) 	go to beginning of loop 
320:    LDA  7,58(7) 	No more loop 
* ENDWHILE
* IF
379:     LD  3,-8(0) 	Load variable iter
380:     ST  3,-9(1) 	Save left side 
381:    LDC  3,10(6) 	Load constant 
382:     LD  4,-9(1) 	Load left into ac1 
383:    SUB  4,4,3 	Op < 
384:    LDC  3,1(6) 	True case 
385:    JLT  4,1(7) 	Jump if true 
386:    LDC  3,0(6) 	False case 
387:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
389:     ST  1,-9(1) 	Store old fp in ghost frame 
390:     LD  3,-8(0) 	Load variable iter
391:     ST  3,-11(1) 	Store parameter 
392:    LDA  1,-9(1) 	Load address of new frame 
393:    LDA  3,1(7) 	Return address in ac 
394:    LDA  7,-389(7) 	CALL output
395:    LDA  3,0(2) 	Save the result in ac 
* ELSE
388:    LDA  7,8(7) 	Jump around the THEN 
* EXPRESSION STMT
397:     ST  1,-9(1) 	Store old fp in ghost frame 
398:     LD  3,-8(0) 	Load variable iter
399:     ST  3,-11(1) 	Save left side 
400:    LDC  3,11(6) 	Load constant 
401:     LD  4,-11(1) 	Load left into ac1 
402:    SUB  4,4,3 	Op == 
403:    LDC  3,1(6) 	True case 
404:    JEQ  4,1(7) 	Jump if true 
405:    LDC  3,0(6) 	False case 
406:     ST  3,-11(1) 	Store parameter 
407:    LDA  1,-9(1) 	Load address of new frame 
408:    LDA  3,1(7) 	Return address in ac 
409:    LDA  7,-392(7) 	CALL outputb
410:    LDA  3,0(2) 	Save the result in ac 
396:    LDA  7,14(7) 	Jump around the ELSE 
* ENDIF
* EXPRESSION STMT
411:     LD  3,-4(0) 	Load variable XStep
412:     LD  4,-1(0) 	load lhs variable LEFT
413:    ADD  3,4,3 	op += 
414:     ST  3,-1(0) 	Store variable LEFT
* END compound statement
415:    LDA  7,-159(7) 	go to beginning of loop 
266:    LDA  7,149(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
416:     ST  1,-9(1) 	Store old fp in ghost frame 
417:    LDA  1,-9(1) 	Load address of new frame 
418:    LDA  3,1(7) 	Return address in ac 
419:    LDA  7,-395(7) 	CALL outnl
420:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
421:     LD  3,-5(0) 	Load variable YStep
422:     LD  4,0(0) 	load lhs variable TOP
423:    ADD  3,4,3 	op += 
424:     ST  3,0(0) 	Store variable TOP
* END compound statement
425:    LDA  7,-183(7) 	go to beginning of loop 
252:    LDA  7,173(7) 	No more loop 
* ENDWHILE
* END compound statement
* Add standard closing in case there is no return statement
426:    LDC  2,0(6) 	Set return value to 0 
427:     LD  3,-1(1) 	Load return address 
428:     LD  1,0(1) 	Adjust fp 
429:    LDA  7,0(3) 	Return 
* END of function Julia
* BEGIN function main
430:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
431:    LDC  3,2(6) 	load size of array JuliaVals
432:     ST  3,-2(1) 	save size of array JuliaVals
* EXPRESSION STMT
433:    LDC  3,320(6) 	Load constant 
434:    LDC  4,0(6) 	Load 0 
435:    SUB  3,4,3 	Op unary - 
436:     ST  3,0(0) 	Store variable TOP
* EXPRESSION STMT
437:    LDC  3,512(6) 	Load constant 
438:    LDC  4,0(6) 	Load 0 
439:    SUB  3,4,3 	Op unary - 
440:     ST  3,-1(0) 	Store variable LEFT
* EXPRESSION STMT
441:    LDC  3,640(6) 	Load constant 
442:     ST  3,-2(0) 	Store variable HEIGHT
* EXPRESSION STMT
443:    LDC  3,716(6) 	Load constant 
444:     ST  3,-3(0) 	Store variable WIDTH
* EXPRESSION STMT
445:     LD  3,-3(0) 	Load variable WIDTH
446:     ST  3,-5(1) 	Save left side 
447:    LDC  3,40(6) 	Load constant 
448:     LD  4,-5(1) 	Load left into ac1 
449:    DIV  3,4,3 	Op / 
450:     ST  3,-4(0) 	Store variable XStep
* EXPRESSION STMT
451:     LD  3,-2(0) 	Load variable HEIGHT
452:     ST  3,-5(1) 	Save left side 
453:    LDC  3,36(6) 	Load constant 
454:     LD  4,-5(1) 	Load left into ac1 
455:    DIV  3,4,3 	Op / 
456:     ST  3,-5(0) 	Store variable YStep
* EXPRESSION STMT
457:     LD  3,-1(0) 	Load variable LEFT
458:     ST  3,-5(1) 	Save left side 
459:     LD  3,-3(0) 	Load variable WIDTH
460:     LD  4,-5(1) 	Load left into ac1 
461:    ADD  3,4,3 	Op + 
462:     ST  3,-6(0) 	Store variable XMax
* EXPRESSION STMT
463:     LD  3,0(0) 	Load variable TOP
464:     ST  3,-5(1) 	Save left side 
465:     LD  3,-2(0) 	Load variable HEIGHT
466:     LD  4,-5(1) 	Load left into ac1 
467:    ADD  3,4,3 	Op + 
468:     ST  3,-7(0) 	Store variable YMax
* EXPRESSION STMT
469:     ST  1,-5(1) 	Store old fp in ghost frame 
470:    LDA  3,-3(1) 	Load address of base of array JuliaVals
471:     ST  3,-7(1) 	Store parameter 
472:    LDA  1,-5(1) 	Load address of new frame 
473:    LDA  3,1(7) 	Return address in ac 
474:    LDA  7,-445(7) 	CALL Mandelbrot
475:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
476:     ST  1,-5(1) 	Store old fp in ghost frame 
477:    LDA  1,-5(1) 	Load address of new frame 
478:    LDA  3,1(7) 	Return address in ac 
479:    LDA  7,-455(7) 	CALL outnl
480:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
481:    LDC  3,320(6) 	Load constant 
482:    LDC  4,0(6) 	Load 0 
483:    SUB  3,4,3 	Op unary - 
484:     ST  3,0(0) 	Store variable TOP
* EXPRESSION STMT
485:    LDC  3,512(6) 	Load constant 
486:    LDC  4,0(6) 	Load 0 
487:    SUB  3,4,3 	Op unary - 
488:     ST  3,-1(0) 	Store variable LEFT
* EXPRESSION STMT
489:    LDC  3,640(6) 	Load constant 
490:     ST  3,-2(0) 	Store variable HEIGHT
* EXPRESSION STMT
491:    LDC  3,716(6) 	Load constant 
492:     ST  3,-3(0) 	Store variable WIDTH
* EXPRESSION STMT
493:     LD  3,-3(0) 	Load variable WIDTH
494:     ST  3,-5(1) 	Save left side 
495:    LDC  3,40(6) 	Load constant 
496:     LD  4,-5(1) 	Load left into ac1 
497:    DIV  3,4,3 	Op / 
498:     ST  3,-4(0) 	Store variable XStep
* EXPRESSION STMT
499:     LD  3,-2(0) 	Load variable HEIGHT
500:     ST  3,-5(1) 	Save left side 
501:    LDC  3,36(6) 	Load constant 
502:     LD  4,-5(1) 	Load left into ac1 
503:    DIV  3,4,3 	Op / 
504:     ST  3,-5(0) 	Store variable YStep
* EXPRESSION STMT
505:     LD  3,-1(0) 	Load variable LEFT
506:     ST  3,-5(1) 	Save left side 
507:     LD  3,-3(0) 	Load variable WIDTH
508:     LD  4,-5(1) 	Load left into ac1 
509:    ADD  3,4,3 	Op + 
510:     ST  3,-6(0) 	Store variable XMax
* EXPRESSION STMT
511:     LD  3,0(0) 	Load variable TOP
512:     ST  3,-5(1) 	Save left side 
513:     LD  3,-2(0) 	Load variable HEIGHT
514:     LD  4,-5(1) 	Load left into ac1 
515:    ADD  3,4,3 	Op + 
516:     ST  3,-7(0) 	Store variable YMax
* EXPRESSION STMT
517:     ST  1,-5(1) 	Store old fp in ghost frame 
518:    LDC  3,0(6) 	Load constant 
519:    LDA  4,-3(1) 	Load address of base of array JuliaVals
520:    SUB  3,4,3 	Compute offset of value 
521:     LD  3,0(3) 	Load the value 
522:     ST  3,-7(1) 	Store parameter 
523:    LDC  3,1(6) 	Load constant 
524:    LDA  4,-3(1) 	Load address of base of array JuliaVals
525:    SUB  3,4,3 	Compute offset of value 
526:     LD  3,0(3) 	Load the value 
527:     ST  3,-8(1) 	Store parameter 
528:    LDA  1,-5(1) 	Load address of new frame 
529:    LDA  3,1(7) 	Return address in ac 
530:    LDA  7,-289(7) 	CALL Julia
531:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
532:    LDC  2,0(6) 	Set return value to 0 
533:     LD  3,-1(1) 	Load return address 
534:     LD  1,0(1) 	Adjust fp 
535:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,535(7) 	Jump to init 
* BEGIN Init
536:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
537:    LDA  1,-9(0) 	set first frame at end of globals 
538:     ST  1,0(1) 	store old fp (point to self) 
539:    LDA  3,1(7) 	Return address in ac 
540:    LDA  7,-111(7) 	Jump to main 
541:   HALT  0,0,0 	DONE! 
* END Init
