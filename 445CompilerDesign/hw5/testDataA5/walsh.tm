* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  walsh.c-
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
* BEGIN function pow
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 31:    LDC  3,1(6) 	Load constant 
 32:     ST  3,-5(1) 	Store variable ans
* EXPRESSION STMT
 33:     LD  3,-2(1) 	Load variable n
 34:     ST  3,-4(1) 	Store variable sqr
* WHILE
 35:    LDC  3,1(6) 	Load constant 
 36:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* IF
 38:     LD  3,-3(1) 	Load variable p
 39:     ST  3,-6(1) 	Save left side 
 40:    LDC  3,2(6) 	Load constant 
 41:     LD  4,-6(1) 	Load left into ac1 
 42:    DIV  5,4,3 	Op % 
 43:    MUL  5,5,3 	 
 44:    SUB  3,4,5 	 
 45:     ST  3,-6(1) 	Save left side 
 46:    LDC  3,1(6) 	Load constant 
 47:     LD  4,-6(1) 	Load left into ac1 
 48:    SUB  4,4,3 	Op == 
 49:    LDC  3,1(6) 	True case 
 50:    JEQ  4,1(7) 	Jump if true 
 51:    LDC  3,0(6) 	False case 
 52:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
 54:     LD  3,-5(1) 	Load variable ans
 55:     ST  3,-6(1) 	Save left side 
 56:     LD  3,-4(1) 	Load variable sqr
 57:     LD  4,-6(1) 	Load left into ac1 
 58:    MUL  3,4,3 	Op * 
 59:     ST  3,-5(1) 	Store variable ans
 53:    LDA  7,6(7) 	Jump around the THEN 
* ENDIF
* EXPRESSION STMT
 60:     LD  3,-3(1) 	Load variable p
 61:     ST  3,-6(1) 	Save left side 
 62:    LDC  3,2(6) 	Load constant 
 63:     LD  4,-6(1) 	Load left into ac1 
 64:    DIV  3,4,3 	Op / 
 65:     ST  3,-3(1) 	Store variable p
* IF
 66:     LD  3,-3(1) 	Load variable p
 67:     ST  3,-6(1) 	Save left side 
 68:    LDC  3,0(6) 	Load constant 
 69:     LD  4,-6(1) 	Load left into ac1 
 70:    SUB  4,4,3 	Op == 
 71:    LDC  3,1(6) 	True case 
 72:    JEQ  4,1(7) 	Jump if true 
 73:    LDC  3,0(6) 	False case 
 74:    JGT  3,1(7) 	Jump to then part 
* THEN
* RETURN
 76:     LD  3,-5(1) 	Load variable ans
 77:    LDA  2,0(3) 	Copy result to rt register 
 78:     LD  3,-1(1) 	Load return address 
 79:     LD  1,0(1) 	Adjust fp 
 80:    LDA  7,0(3) 	Return 
 75:    LDA  7,5(7) 	Jump around the THEN 
* ENDIF
* EXPRESSION STMT
 81:     LD  3,-4(1) 	Load variable sqr
 82:     ST  3,-6(1) 	Save left side 
 83:     LD  3,-4(1) 	Load variable sqr
 84:     LD  4,-6(1) 	Load left into ac1 
 85:    MUL  3,4,3 	Op * 
 86:     ST  3,-4(1) 	Store variable sqr
* END compound statement
 87:    LDA  7,-53(7) 	go to beginning of loop 
 37:    LDA  7,50(7) 	No more loop 
* ENDWHILE
* END compound statement
* Add standard closing in case there is no return statement
 88:    LDC  2,0(6) 	Set return value to 0 
 89:     LD  3,-1(1) 	Load return address 
 90:     LD  1,0(1) 	Adjust fp 
 91:    LDA  7,0(3) 	Return 
* END of function pow
* BEGIN function getFunc
 92:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* IF
 93:     ST  1,-6(1) 	Store old fp in ghost frame 
 94:    LDA  1,-6(1) 	Load address of new frame 
 95:    LDA  3,1(7) 	Return address in ac 
 96:    LDA  7,-96(7) 	CALL input
 97:    LDA  3,0(2) 	Save the result in ac 
 98:     ST  3,-3(1) 	Store variable numbits
 99:     ST  3,-6(1) 	Save left side 
100:    LDC  3,0(6) 	Load constant 
101:     LD  4,-6(1) 	Load left into ac1 
102:    SUB  4,4,3 	Op == 
103:    LDC  3,1(6) 	True case 
104:    JEQ  4,1(7) 	Jump if true 
105:    LDC  3,0(6) 	False case 
106:    JGT  3,1(7) 	Jump to then part 
* THEN
* RETURN
108:    LDC  3,0(6) 	Load constant 
109:    LDA  2,0(3) 	Copy result to rt register 
110:     LD  3,-1(1) 	Load return address 
111:     LD  1,0(1) 	Adjust fp 
112:    LDA  7,0(3) 	Return 
107:    LDA  7,5(7) 	Jump around the THEN 
* ENDIF
* EXPRESSION STMT
113:     ST  1,-6(1) 	Store old fp in ghost frame 
114:    LDC  3,2(6) 	Load constant 
115:     ST  3,-8(1) 	Store parameter 
116:     LD  3,-3(1) 	Load variable numbits
117:     ST  3,-9(1) 	Store parameter 
118:    LDA  1,-6(1) 	Load address of new frame 
119:    LDA  3,1(7) 	Return address in ac 
120:    LDA  7,-91(7) 	CALL pow
121:    LDA  3,0(2) 	Save the result in ac 
122:     ST  3,-5(1) 	Store variable size
* EXPRESSION STMT
123:    LDC  3,0(6) 	Load constant 
124:     ST  3,-4(1) 	Store variable i
* WHILE
125:     LD  3,-4(1) 	Load variable i
126:     ST  3,-6(1) 	Save left side 
127:     LD  3,-5(1) 	Load variable size
128:     LD  4,-6(1) 	Load left into ac1 
129:    SUB  4,4,3 	Op < 
130:    LDC  3,1(6) 	True case 
131:    JLT  4,1(7) 	Jump if true 
132:    LDC  3,0(6) 	False case 
133:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
135:     LD  3,-4(1) 	Load variable i
136:     ST  3,-6(1) 	Save index 
137:     ST  1,-7(1) 	Store old fp in ghost frame 
138:    LDA  1,-7(1) 	Load address of new frame 
139:    LDA  3,1(7) 	Return address in ac 
140:    LDA  7,-140(7) 	CALL input
141:    LDA  3,0(2) 	Save the result in ac 
142:     LD  4,-6(1) 	Restore index 
143:     LD  5,-2(1) 	Load address of base of array f
144:    SUB  5,5,4 	Compute offset of value 
145:     ST  3,0(5) 	Store variable f
* EXPRESSION STMT
146:     LD  3,-4(1) 	Load variable i
147:     ST  3,-6(1) 	Save left side 
148:    LDC  3,1(6) 	Load constant 
149:     LD  4,-6(1) 	Load left into ac1 
150:    ADD  3,4,3 	Op + 
151:     ST  3,-4(1) 	Store variable i
* END compound statement
152:    LDA  7,-28(7) 	go to beginning of loop 
134:    LDA  7,18(7) 	No more loop 
* ENDWHILE
* RETURN
153:     LD  3,-3(1) 	Load variable numbits
154:    LDA  2,0(3) 	Copy result to rt register 
155:     LD  3,-1(1) 	Load return address 
156:     LD  1,0(1) 	Adjust fp 
157:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
158:    LDC  2,0(6) 	Set return value to 0 
159:     LD  3,-1(1) 	Load return address 
160:     LD  1,0(1) 	Adjust fp 
161:    LDA  7,0(3) 	Return 
* END of function getFunc
* BEGIN function printFunc
162:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
163:    LDC  3,0(6) 	Load constant 
164:     ST  3,-4(1) 	Store variable i
* WHILE
165:     LD  3,-4(1) 	Load variable i
166:     ST  3,-5(1) 	Save left side 
167:     LD  3,-3(1) 	Load variable size
168:     LD  4,-5(1) 	Load left into ac1 
169:    SUB  4,4,3 	Op < 
170:    LDC  3,1(6) 	True case 
171:    JLT  4,1(7) 	Jump if true 
172:    LDC  3,0(6) 	False case 
173:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
175:     ST  1,-5(1) 	Store old fp in ghost frame 
176:     LD  3,-4(1) 	Load variable i
177:     LD  4,-2(1) 	Load address of base of array f
178:    SUB  3,4,3 	Compute offset of value 
179:     LD  3,0(3) 	Load the value 
180:     ST  3,-7(1) 	Store parameter 
181:    LDA  1,-5(1) 	Load address of new frame 
182:    LDA  3,1(7) 	Return address in ac 
183:    LDA  7,-178(7) 	CALL output
184:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
185:     LD  3,-4(1) 	Load variable i
186:     ST  3,-5(1) 	Save left side 
187:    LDC  3,1(6) 	Load constant 
188:     LD  4,-5(1) 	Load left into ac1 
189:    ADD  3,4,3 	Op + 
190:     ST  3,-4(1) 	Store variable i
* END compound statement
191:    LDA  7,-27(7) 	go to beginning of loop 
174:    LDA  7,17(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
192:     ST  1,-5(1) 	Store old fp in ghost frame 
193:    LDA  1,-5(1) 	Load address of new frame 
194:    LDA  3,1(7) 	Return address in ac 
195:    LDA  7,-171(7) 	CALL outnl
196:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
197:    LDC  2,0(6) 	Set return value to 0 
198:     LD  3,-1(1) 	Load return address 
199:     LD  1,0(1) 	Adjust fp 
200:    LDA  7,0(3) 	Return 
* END of function printFunc
* BEGIN function fwt
201:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
202:     LD  3,-4(1) 	Load variable size
203:     ST  3,-8(1) 	Save left side 
204:    LDC  3,2(6) 	Load constant 
205:     LD  4,-8(1) 	Load left into ac1 
206:    DIV  3,4,3 	Op / 
207:     ST  3,-4(1) 	Store variable size
* IF
208:     LD  3,-4(1) 	Load variable size
209:     ST  3,-8(1) 	Save left side 
210:    LDC  3,1(6) 	Load constant 
211:     LD  4,-8(1) 	Load left into ac1 
212:    SUB  4,4,3 	Op > 
213:    LDC  3,1(6) 	True case 
214:    JGT  4,1(7) 	Jump if true 
215:    LDC  3,0(6) 	False case 
216:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
218:     ST  1,-8(1) 	Store old fp in ghost frame 
219:     LD  3,-2(1) 	Load address of base of array w
220:     ST  3,-10(1) 	Store parameter 
221:     LD  3,-3(1) 	Load variable start
222:     ST  3,-11(1) 	Store parameter 
223:     LD  3,-4(1) 	Load variable size
224:     ST  3,-12(1) 	Store parameter 
225:    LDA  1,-8(1) 	Load address of new frame 
226:    LDA  3,1(7) 	Return address in ac 
227:    LDA  7,-27(7) 	CALL fwt
228:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
229:     ST  1,-8(1) 	Store old fp in ghost frame 
230:     LD  3,-2(1) 	Load address of base of array w
231:     ST  3,-10(1) 	Store parameter 
232:     LD  3,-3(1) 	Load variable start
233:     ST  3,-11(1) 	Save left side 
234:     LD  3,-4(1) 	Load variable size
235:     LD  4,-11(1) 	Load left into ac1 
236:    ADD  3,4,3 	Op + 
237:     ST  3,-11(1) 	Store parameter 
238:     LD  3,-4(1) 	Load variable size
239:     ST  3,-12(1) 	Store parameter 
240:    LDA  1,-8(1) 	Load address of new frame 
241:    LDA  3,1(7) 	Return address in ac 
242:    LDA  7,-42(7) 	CALL fwt
243:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
217:    LDA  7,26(7) 	Jump around the THEN 
* ENDIF
* EXPRESSION STMT
244:     LD  3,-3(1) 	Load variable start
245:     ST  3,-5(1) 	Store variable a
* EXPRESSION STMT
246:     LD  3,-3(1) 	Load variable start
247:     ST  3,-8(1) 	Save left side 
248:     LD  3,-4(1) 	Load variable size
249:     LD  4,-8(1) 	Load left into ac1 
250:    ADD  3,4,3 	Op + 
251:     ST  3,-6(1) 	Store variable b
* WHILE
252:     LD  3,-5(1) 	Load variable a
253:     ST  3,-8(1) 	Save left side 
254:     LD  3,-3(1) 	Load variable start
255:     ST  3,-9(1) 	Save left side 
256:     LD  3,-4(1) 	Load variable size
257:     LD  4,-9(1) 	Load left into ac1 
258:    ADD  3,4,3 	Op + 
259:     LD  4,-8(1) 	Load left into ac1 
260:    SUB  4,4,3 	Op < 
261:    LDC  3,1(6) 	True case 
262:    JLT  4,1(7) 	Jump if true 
263:    LDC  3,0(6) 	False case 
264:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
266:     LD  3,-5(1) 	Load variable a
267:     LD  4,-2(1) 	Load address of base of array w
268:    SUB  3,4,3 	Compute offset of value 
269:     LD  3,0(3) 	Load the value 
270:     ST  3,-7(1) 	Store variable tmp
* EXPRESSION STMT
271:     LD  3,-5(1) 	Load variable a
272:     ST  3,-8(1) 	Save index 
273:     LD  3,-5(1) 	Load variable a
274:     LD  4,-2(1) 	Load address of base of array w
275:    SUB  3,4,3 	Compute offset of value 
276:     LD  3,0(3) 	Load the value 
277:     ST  3,-9(1) 	Save left side 
278:     LD  3,-6(1) 	Load variable b
279:     LD  4,-2(1) 	Load address of base of array w
280:    SUB  3,4,3 	Compute offset of value 
281:     LD  3,0(3) 	Load the value 
282:     LD  4,-9(1) 	Load left into ac1 
283:    ADD  3,4,3 	Op + 
284:     LD  4,-8(1) 	Restore index 
285:     LD  5,-2(1) 	Load address of base of array w
286:    SUB  5,5,4 	Compute offset of value 
287:     ST  3,0(5) 	Store variable w
* EXPRESSION STMT
288:     LD  3,-6(1) 	Load variable b
289:     ST  3,-8(1) 	Save index 
290:     LD  3,-7(1) 	Load variable tmp
291:     ST  3,-9(1) 	Save left side 
292:     LD  3,-6(1) 	Load variable b
293:     LD  4,-2(1) 	Load address of base of array w
294:    SUB  3,4,3 	Compute offset of value 
295:     LD  3,0(3) 	Load the value 
296:     LD  4,-9(1) 	Load left into ac1 
297:    SUB  3,4,3 	Op - 
298:     LD  4,-8(1) 	Restore index 
299:     LD  5,-2(1) 	Load address of base of array w
300:    SUB  5,5,4 	Compute offset of value 
301:     ST  3,0(5) 	Store variable w
* EXPRESSION STMT
302:     LD  3,-5(1) 	Load variable a
303:     ST  3,-8(1) 	Save left side 
304:    LDC  3,1(6) 	Load constant 
305:     LD  4,-8(1) 	Load left into ac1 
306:    ADD  3,4,3 	Op + 
307:     ST  3,-5(1) 	Store variable a
* EXPRESSION STMT
308:     LD  3,-6(1) 	Load variable b
309:     ST  3,-8(1) 	Save left side 
310:    LDC  3,1(6) 	Load constant 
311:     LD  4,-8(1) 	Load left into ac1 
312:    ADD  3,4,3 	Op + 
313:     ST  3,-6(1) 	Store variable b
* END compound statement
314:    LDA  7,-63(7) 	go to beginning of loop 
265:    LDA  7,49(7) 	No more loop 
* ENDWHILE
* END compound statement
* Add standard closing in case there is no return statement
315:    LDC  2,0(6) 	Set return value to 0 
316:     LD  3,-1(1) 	Load return address 
317:     LD  1,0(1) 	Adjust fp 
318:    LDA  7,0(3) 	Return 
* END of function fwt
* BEGIN function div
319:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
320:    LDC  3,0(6) 	Load constant 
321:     ST  3,-4(1) 	Store variable i
* WHILE
322:     LD  3,-4(1) 	Load variable i
323:     ST  3,-5(1) 	Save left side 
324:     LD  3,-3(1) 	Load variable size
325:     LD  4,-5(1) 	Load left into ac1 
326:    SUB  4,4,3 	Op < 
327:    LDC  3,1(6) 	True case 
328:    JLT  4,1(7) 	Jump if true 
329:    LDC  3,0(6) 	False case 
330:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
332:     LD  3,-4(1) 	Load variable i
333:     ST  3,-5(1) 	Save index 
334:     LD  3,-4(1) 	Load variable i
335:     LD  4,-2(1) 	Load address of base of array f
336:    SUB  3,4,3 	Compute offset of value 
337:     LD  3,0(3) 	Load the value 
338:     ST  3,-6(1) 	Save left side 
339:     LD  3,-3(1) 	Load variable size
340:     LD  4,-6(1) 	Load left into ac1 
341:    DIV  3,4,3 	Op / 
342:     LD  4,-5(1) 	Restore index 
343:     LD  5,-2(1) 	Load address of base of array f
344:    SUB  5,5,4 	Compute offset of value 
345:     ST  3,0(5) 	Store variable f
* EXPRESSION STMT
346:     LD  3,-4(1) 	load lhs variable i
347:    LDA  3,1(3) 	increment value of i
348:     ST  3,-4(1) 	Store variable i
* END compound statement
349:    LDA  7,-28(7) 	go to beginning of loop 
331:    LDA  7,18(7) 	No more loop 
* ENDWHILE
* END compound statement
* Add standard closing in case there is no return statement
350:    LDC  2,0(6) 	Set return value to 0 
351:     LD  3,-1(1) 	Load return address 
352:     LD  1,0(1) 	Adjust fp 
353:    LDA  7,0(3) 	Return 
* END of function div
* BEGIN function main
354:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
355:    LDC  3,256(6) 	load size of array f
356:     ST  3,-2(1) 	save size of array f
* WHILE
357:    LDC  3,1(6) 	Load constant 
358:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* IF
360:     ST  1,-263(1) 	Store old fp in ghost frame 
361:    LDA  3,-3(1) 	Load address of base of array f
362:     ST  3,-265(1) 	Store parameter 
363:    LDA  1,-263(1) 	Load address of new frame 
364:    LDA  3,1(7) 	Return address in ac 
365:    LDA  7,-274(7) 	CALL getFunc
366:    LDA  3,0(2) 	Save the result in ac 
367:     ST  3,-261(1) 	Store variable numbits
368:     ST  3,-263(1) 	Save left side 
369:    LDC  3,0(6) 	Load constant 
370:     LD  4,-263(1) 	Load left into ac1 
371:    SUB  4,4,3 	Op == 
372:    LDC  3,1(6) 	True case 
373:    JEQ  4,1(7) 	Jump if true 
374:    LDC  3,0(6) 	False case 
375:    JGT  3,1(7) 	Jump to then part 
* THEN
* RETURN
377:    LDC  3,0(6) 	Load constant 
378:    LDA  2,0(3) 	Copy result to rt register 
379:     LD  3,-1(1) 	Load return address 
380:     LD  1,0(1) 	Adjust fp 
381:    LDA  7,0(3) 	Return 
376:    LDA  7,5(7) 	Jump around the THEN 
* ENDIF
* EXPRESSION STMT
382:     ST  1,-263(1) 	Store old fp in ghost frame 
383:    LDC  3,2(6) 	Load constant 
384:     ST  3,-265(1) 	Store parameter 
385:     LD  3,-261(1) 	Load variable numbits
386:     ST  3,-266(1) 	Store parameter 
387:    LDA  1,-263(1) 	Load address of new frame 
388:    LDA  3,1(7) 	Return address in ac 
389:    LDA  7,-360(7) 	CALL pow
390:    LDA  3,0(2) 	Save the result in ac 
391:     ST  3,-260(1) 	Store variable size
* EXPRESSION STMT
392:     LD  3,-260(1) 	Load variable size
393:     ST  3,-263(1) 	Save left side 
394:    LDC  3,2(6) 	Load constant 
395:     LD  4,-263(1) 	Load left into ac1 
396:    DIV  3,4,3 	Op / 
397:     ST  3,-262(1) 	Store variable half
* EXPRESSION STMT
398:     ST  1,-263(1) 	Store old fp in ghost frame 
399:    LDA  3,-3(1) 	Load address of base of array f
400:     ST  3,-265(1) 	Store parameter 
401:    LDC  3,0(6) 	Load constant 
402:     ST  3,-266(1) 	Store parameter 
403:     LD  3,-260(1) 	Load variable size
404:     ST  3,-267(1) 	Store parameter 
405:    LDA  1,-263(1) 	Load address of new frame 
406:    LDA  3,1(7) 	Return address in ac 
407:    LDA  7,-207(7) 	CALL fwt
408:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
409:     ST  1,-263(1) 	Store old fp in ghost frame 
410:    LDA  3,-3(1) 	Load address of base of array f
411:     ST  3,-265(1) 	Store parameter 
412:     LD  3,-260(1) 	Load variable size
413:     ST  3,-266(1) 	Store parameter 
414:    LDA  1,-263(1) 	Load address of new frame 
415:    LDA  3,1(7) 	Return address in ac 
416:    LDA  7,-255(7) 	CALL printFunc
417:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
418:     ST  1,-263(1) 	Store old fp in ghost frame 
419:    LDA  3,-3(1) 	Load address of base of array f
420:     ST  3,-265(1) 	Store parameter 
421:    LDC  3,0(6) 	Load constant 
422:     ST  3,-266(1) 	Store parameter 
423:     LD  3,-260(1) 	Load variable size
424:     ST  3,-267(1) 	Store parameter 
425:    LDA  1,-263(1) 	Load address of new frame 
426:    LDA  3,1(7) 	Return address in ac 
427:    LDA  7,-227(7) 	CALL fwt
428:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
429:     ST  1,-263(1) 	Store old fp in ghost frame 
430:    LDA  3,-3(1) 	Load address of base of array f
431:     ST  3,-265(1) 	Store parameter 
432:     LD  3,-260(1) 	Load variable size
433:     ST  3,-266(1) 	Store parameter 
434:    LDA  1,-263(1) 	Load address of new frame 
435:    LDA  3,1(7) 	Return address in ac 
436:    LDA  7,-118(7) 	CALL div
437:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
438:     ST  1,-263(1) 	Store old fp in ghost frame 
439:    LDA  3,-3(1) 	Load address of base of array f
440:     ST  3,-265(1) 	Store parameter 
441:     LD  3,-260(1) 	Load variable size
442:     ST  3,-266(1) 	Store parameter 
443:    LDA  1,-263(1) 	Load address of new frame 
444:    LDA  3,1(7) 	Return address in ac 
445:    LDA  7,-284(7) 	CALL printFunc
446:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
447:    LDA  7,-91(7) 	go to beginning of loop 
359:    LDA  7,88(7) 	No more loop 
* ENDWHILE
* RETURN
448:    LDC  3,0(6) 	Load constant 
449:    LDA  2,0(3) 	Copy result to rt register 
450:     LD  3,-1(1) 	Load return address 
451:     LD  1,0(1) 	Adjust fp 
452:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
453:    LDC  2,0(6) 	Set return value to 0 
454:     LD  3,-1(1) 	Load return address 
455:     LD  1,0(1) 	Adjust fp 
456:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,456(7) 	Jump to init 
* BEGIN Init
457:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
458:    LDA  1,0(0) 	set first frame at end of globals 
459:     ST  1,0(1) 	store old fp (point to self) 
460:    LDA  3,1(7) 	Return address in ac 
461:    LDA  7,-108(7) 	Jump to main 
462:   HALT  0,0,0 	DONE! 
* END Init
