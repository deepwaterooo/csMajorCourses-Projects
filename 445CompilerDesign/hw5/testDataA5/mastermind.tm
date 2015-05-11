* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  mastermind.c-
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
* BEGIN function rand
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* IF
 31:     LD  3,-1(0) 	Load variable n
 32:     ST  3,-2(1) 	Save left side 
 33:    LDC  3,0(6) 	Load constant 
 34:     LD  4,-2(1) 	Load left into ac1 
 35:    SUB  4,4,3 	Op < 
 36:    LDC  3,1(6) 	True case 
 37:    JLT  4,1(7) 	Jump if true 
 38:    LDC  3,0(6) 	False case 
 39:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
 41:     LD  3,-1(0) 	Load variable n
 42:    LDC  4,0(6) 	Load 0 
 43:    SUB  3,4,3 	Op unary - 
 44:     ST  3,-1(0) 	Store variable n
 40:    LDA  7,4(7) 	Jump around the THEN 
* ENDIF
* IF
 45:     LD  3,-1(0) 	Load variable n
 46:     ST  3,-2(1) 	Save left side 
 47:    LDC  3,128(6) 	Load constant 
 48:     LD  4,-2(1) 	Load left into ac1 
 49:    SUB  4,4,3 	Op > 
 50:    LDC  3,1(6) 	True case 
 51:    JGT  4,1(7) 	Jump if true 
 52:    LDC  3,0(6) 	False case 
 53:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
 55:     LD  3,-1(0) 	Load variable n
 56:     ST  3,-2(1) 	Save left side 
 57:    LDC  3,128(6) 	Load constant 
 58:     LD  4,-2(1) 	Load left into ac1 
 59:    DIV  5,4,3 	Op % 
 60:    MUL  5,5,3 	 
 61:    SUB  3,4,5 	 
 62:     ST  3,-1(0) 	Store variable n
 54:    LDA  7,8(7) 	Jump around the THEN 
* ENDIF
* EXPRESSION STMT
 63:     LD  3,-1(0) 	load lhs variable n
 64:    LDA  3,1(3) 	increment value of n
 65:     ST  3,-1(0) 	Store variable n
* EXPRESSION STMT
 66:     LD  3,-1(0) 	Load variable n
 67:     ST  3,-2(1) 	Save index 
 68:    LDC  3,1366(6) 	Load constant 
 69:     ST  3,-3(1) 	Save left side 
 70:     LD  3,-1(0) 	Load variable n
 71:     ST  3,-4(1) 	Save left side 
 72:    LDC  3,1(6) 	Load constant 
 73:     LD  4,-4(1) 	Load left into ac1 
 74:    SUB  3,4,3 	Op - 
 75:    LDA  4,-3(0) 	Load address of base of array r
 76:    SUB  3,4,3 	Compute offset of value 
 77:     LD  3,0(3) 	Load the value 
 78:     LD  4,-3(1) 	Load left into ac1 
 79:    MUL  3,4,3 	Op * 
 80:     ST  3,-3(1) 	Save left side 
 81:    LDC  3,150889(6) 	Load constant 
 82:     LD  4,-3(1) 	Load left into ac1 
 83:    ADD  3,4,3 	Op + 
 84:     ST  3,-3(1) 	Save left side 
 85:    LDC  3,714025(6) 	Load constant 
 86:     LD  4,-3(1) 	Load left into ac1 
 87:    DIV  5,4,3 	Op % 
 88:    MUL  5,5,3 	 
 89:    SUB  3,4,5 	 
 90:     LD  4,-2(1) 	Restore index 
 91:    LDA  5,-3(0) 	Load address of base of array r
 92:    SUB  5,5,4 	Compute offset of value 
 93:     ST  3,0(5) 	Store variable r
* RETURN
 94:     LD  3,-1(0) 	Load variable n
 95:    LDA  4,-3(0) 	Load address of base of array r
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
* END of function rand
* BEGIN function search
106:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
107:    LDC  3,0(6) 	Load constant 
108:     ST  3,-4(1) 	Store variable i
* WHILE
109:     LD  3,-4(1) 	Load variable i
110:     ST  3,-5(1) 	Save left side 
111:    LDC  3,4(6) 	Load constant 
112:     LD  4,-5(1) 	Load left into ac1 
113:    SUB  4,4,3 	Op < 
114:    LDC  3,1(6) 	True case 
115:    JLT  4,1(7) 	Jump if true 
116:    LDC  3,0(6) 	False case 
117:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* IF
119:     LD  3,-4(1) 	Load variable i
120:     LD  4,-2(1) 	Load address of base of array a
121:    SUB  3,4,3 	Compute offset of value 
122:     LD  3,0(3) 	Load the value 
123:     ST  3,-5(1) 	Save left side 
124:     LD  3,-3(1) 	Load variable k
125:     LD  4,-5(1) 	Load left into ac1 
126:    SUB  4,4,3 	Op == 
127:    LDC  3,1(6) 	True case 
128:    JEQ  4,1(7) 	Jump if true 
129:    LDC  3,0(6) 	False case 
130:    JGT  3,1(7) 	Jump to then part 
* THEN
* RETURN
132:    LDC  3,1(6) 	Load constant 
133:    LDA  2,0(3) 	Copy result to rt register 
134:     LD  3,-1(1) 	Load return address 
135:     LD  1,0(1) 	Adjust fp 
136:    LDA  7,0(3) 	Return 
131:    LDA  7,5(7) 	Jump around the THEN 
* ENDIF
* EXPRESSION STMT
137:     LD  3,-4(1) 	load lhs variable i
138:    LDA  3,1(3) 	increment value of i
139:     ST  3,-4(1) 	Store variable i
* END compound statement
140:    LDA  7,-32(7) 	go to beginning of loop 
118:    LDA  7,22(7) 	No more loop 
* ENDWHILE
* RETURN
141:    LDC  3,0(6) 	Load constant 
142:    LDA  2,0(3) 	Copy result to rt register 
143:     LD  3,-1(1) 	Load return address 
144:     LD  1,0(1) 	Adjust fp 
145:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
146:    LDC  2,0(6) 	Set return value to 0 
147:     LD  3,-1(1) 	Load return address 
148:     LD  1,0(1) 	Adjust fp 
149:    LDA  7,0(3) 	Return 
* END of function search
* BEGIN function check
150:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
151:    LDC  3,0(6) 	Load constant 
152:     ST  3,-4(1) 	Store variable c2
153:     ST  3,-3(1) 	Store variable c1
154:     ST  3,-2(1) 	Store variable i
* WHILE
155:     LD  3,-2(1) 	Load variable i
156:     ST  3,-5(1) 	Save left side 
157:    LDC  3,4(6) 	Load constant 
158:     LD  4,-5(1) 	Load left into ac1 
159:    SUB  4,4,3 	Op < 
160:    LDC  3,1(6) 	True case 
161:    JLT  4,1(7) 	Jump if true 
162:    LDC  3,0(6) 	False case 
163:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* IF
165:     LD  3,-2(1) 	Load variable i
166:    LDA  4,-132(0) 	Load address of base of array known
167:    SUB  3,4,3 	Compute offset of value 
168:     LD  3,0(3) 	Load the value 
169:     ST  3,-5(1) 	Save left side 
170:     LD  3,-2(1) 	Load variable i
171:    LDA  4,-137(0) 	Load address of base of array guess
172:    SUB  3,4,3 	Compute offset of value 
173:     LD  3,0(3) 	Load the value 
174:     LD  4,-5(1) 	Load left into ac1 
175:    SUB  4,4,3 	Op == 
176:    LDC  3,1(6) 	True case 
177:    JEQ  4,1(7) 	Jump if true 
178:    LDC  3,0(6) 	False case 
179:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
181:     LD  3,-4(1) 	load lhs variable c2
182:    LDA  3,1(3) 	increment value of c2
183:     ST  3,-4(1) 	Store variable c2
* ELSE
180:    LDA  7,4(7) 	Jump around the THEN 
* IF
185:     ST  1,-5(1) 	Store old fp in ghost frame 
186:    LDA  3,-132(0) 	Load address of base of array known
187:     ST  3,-7(1) 	Store parameter 
188:     LD  3,-2(1) 	Load variable i
189:    LDA  4,-137(0) 	Load address of base of array guess
190:    SUB  3,4,3 	Compute offset of value 
191:     LD  3,0(3) 	Load the value 
192:     ST  3,-8(1) 	Store parameter 
193:    LDA  1,-5(1) 	Load address of new frame 
194:    LDA  3,1(7) 	Return address in ac 
195:    LDA  7,-90(7) 	CALL search
196:    LDA  3,0(2) 	Save the result in ac 
197:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
199:     LD  3,-3(1) 	load lhs variable c1
200:    LDA  3,1(3) 	increment value of c1
201:     ST  3,-3(1) 	Store variable c1
198:    LDA  7,3(7) 	Jump around the THEN 
* ENDIF
184:    LDA  7,17(7) 	Jump around the ELSE 
* ENDIF
* EXPRESSION STMT
202:     LD  3,-2(1) 	load lhs variable i
203:    LDA  3,1(3) 	increment value of i
204:     ST  3,-2(1) 	Store variable i
* END compound statement
205:    LDA  7,-51(7) 	go to beginning of loop 
164:    LDA  7,41(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
206:     ST  1,-5(1) 	Store old fp in ghost frame 
207:     LD  3,-3(1) 	Load variable c1
208:     ST  3,-7(1) 	Store parameter 
209:    LDA  1,-5(1) 	Load address of new frame 
210:    LDA  3,1(7) 	Return address in ac 
211:    LDA  7,-206(7) 	CALL output
212:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
213:     ST  1,-5(1) 	Store old fp in ghost frame 
214:     LD  3,-4(1) 	Load variable c2
215:     ST  3,-7(1) 	Store parameter 
216:    LDA  1,-5(1) 	Load address of new frame 
217:    LDA  3,1(7) 	Return address in ac 
218:    LDA  7,-213(7) 	CALL output
219:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
220:     ST  1,-5(1) 	Store old fp in ghost frame 
221:    LDA  1,-5(1) 	Load address of new frame 
222:    LDA  3,1(7) 	Return address in ac 
223:    LDA  7,-199(7) 	CALL outnl
224:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
225:     ST  1,-5(1) 	Store old fp in ghost frame 
226:    LDA  1,-5(1) 	Load address of new frame 
227:    LDA  3,1(7) 	Return address in ac 
228:    LDA  7,-204(7) 	CALL outnl
229:    LDA  3,0(2) 	Save the result in ac 
* IF
230:     LD  3,-4(1) 	Load variable c2
231:     ST  3,-5(1) 	Save left side 
232:    LDC  3,4(6) 	Load constant 
233:     LD  4,-5(1) 	Load left into ac1 
234:    SUB  4,4,3 	Op == 
235:    LDC  3,1(6) 	True case 
236:    JEQ  4,1(7) 	Jump if true 
237:    LDC  3,0(6) 	False case 
238:    JGT  3,1(7) 	Jump to then part 
* THEN
* RETURN
240:    LDC  3,1(6) 	Load constant 
241:    LDA  2,0(3) 	Copy result to rt register 
242:     LD  3,-1(1) 	Load return address 
243:     LD  1,0(1) 	Adjust fp 
244:    LDA  7,0(3) 	Return 
* ELSE
239:    LDA  7,6(7) 	Jump around the THEN 
* RETURN
246:    LDC  3,0(6) 	Load constant 
247:    LDA  2,0(3) 	Copy result to rt register 
248:     LD  3,-1(1) 	Load return address 
249:     LD  1,0(1) 	Adjust fp 
250:    LDA  7,0(3) 	Return 
245:    LDA  7,5(7) 	Jump around the ELSE 
* ENDIF
* END compound statement
* Add standard closing in case there is no return statement
251:    LDC  2,0(6) 	Set return value to 0 
252:     LD  3,-1(1) 	Load return address 
253:     LD  1,0(1) 	Adjust fp 
254:    LDA  7,0(3) 	Return 
* END of function check
* BEGIN function turn
255:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
256:     LD  3,0(0) 	load lhs variable turns
257:    LDA  3,1(3) 	increment value of turns
258:     ST  3,0(0) 	Store variable turns
* EXPRESSION STMT
259:     ST  1,-3(1) 	Store old fp in ghost frame 
260:     LD  3,0(0) 	Load variable turns
261:     ST  3,-5(1) 	Store parameter 
262:    LDA  1,-3(1) 	Load address of new frame 
263:    LDA  3,1(7) 	Return address in ac 
264:    LDA  7,-259(7) 	CALL output
265:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
266:     ST  1,-3(1) 	Store old fp in ghost frame 
267:    LDA  1,-3(1) 	Load address of new frame 
268:    LDA  3,1(7) 	Return address in ac 
269:    LDA  7,-245(7) 	CALL outnl
270:    LDA  3,0(2) 	Save the result in ac 
* IF
271:     LD  3,0(0) 	Load variable turns
272:     ST  3,-3(1) 	Save left side 
273:    LDC  3,20(6) 	Load constant 
274:     LD  4,-3(1) 	Load left into ac1 
275:    SUB  4,4,3 	Op <= 
276:    LDC  3,1(6) 	True case 
277:    JLE  4,1(7) 	Jump if true 
278:    LDC  3,0(6) 	False case 
279:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
281:    LDC  3,0(6) 	Load constant 
282:     ST  3,-2(1) 	Store variable i
* WHILE
283:     LD  3,-2(1) 	Load variable i
284:     ST  3,-3(1) 	Save left side 
285:    LDC  3,4(6) 	Load constant 
286:     LD  4,-3(1) 	Load left into ac1 
287:    SUB  4,4,3 	Op < 
288:    LDC  3,1(6) 	True case 
289:    JLT  4,1(7) 	Jump if true 
290:    LDC  3,0(6) 	False case 
291:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
293:     LD  3,-2(1) 	Load variable i
294:     ST  3,-3(1) 	Save index 
295:     ST  1,-4(1) 	Store old fp in ghost frame 
296:    LDA  1,-4(1) 	Load address of new frame 
297:    LDA  3,1(7) 	Return address in ac 
298:    LDA  7,-298(7) 	CALL input
299:    LDA  3,0(2) 	Save the result in ac 
300:     LD  4,-3(1) 	Restore index 
301:    LDA  5,-137(0) 	Load address of base of array guess
302:    SUB  5,5,4 	Compute offset of value 
303:     ST  3,0(5) 	Store variable guess
* IF
304:     LD  3,-2(1) 	Load variable i
305:    LDA  4,-137(0) 	Load address of base of array guess
306:    SUB  3,4,3 	Compute offset of value 
307:     LD  3,0(3) 	Load the value 
308:     ST  3,-3(1) 	Save left side 
309:    LDC  3,0(6) 	Load constant 
310:     LD  4,-3(1) 	Load left into ac1 
311:    SUB  4,4,3 	Op < 
312:    LDC  3,1(6) 	True case 
313:    JLT  4,1(7) 	Jump if true 
314:    LDC  3,0(6) 	False case 
315:    JGT  3,1(7) 	Jump to then part 
* THEN
* RETURN
317:    LDC  3,0(6) 	Load constant 
318:    LDA  2,0(3) 	Copy result to rt register 
319:     LD  3,-1(1) 	Load return address 
320:     LD  1,0(1) 	Adjust fp 
321:    LDA  7,0(3) 	Return 
316:    LDA  7,5(7) 	Jump around the THEN 
* ENDIF
* IF
322:     LD  3,-2(1) 	Load variable i
323:    LDA  4,-137(0) 	Load address of base of array guess
324:    SUB  3,4,3 	Compute offset of value 
325:     LD  3,0(3) 	Load the value 
326:     ST  3,-3(1) 	Save left side 
327:    LDC  3,10(6) 	Load constant 
328:     LD  4,-3(1) 	Load left into ac1 
329:    SUB  4,4,3 	Op > 
330:    LDC  3,1(6) 	True case 
331:    JGT  4,1(7) 	Jump if true 
332:    LDC  3,0(6) 	False case 
333:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
335:     LD  3,-2(1) 	Load variable i
336:     ST  3,-3(1) 	Save index 
337:     LD  3,-2(1) 	Load variable i
338:    LDA  4,-137(0) 	Load address of base of array guess
339:    SUB  3,4,3 	Compute offset of value 
340:     LD  3,0(3) 	Load the value 
341:     ST  3,-4(1) 	Save left side 
342:    LDC  3,10(6) 	Load constant 
343:     LD  4,-4(1) 	Load left into ac1 
344:    DIV  5,4,3 	Op % 
345:    MUL  5,5,3 	 
346:    SUB  3,4,5 	 
347:     LD  4,-3(1) 	Restore index 
348:    LDA  5,-137(0) 	Load address of base of array guess
349:    SUB  5,5,4 	Compute offset of value 
350:     ST  3,0(5) 	Store variable guess
334:    LDA  7,16(7) 	Jump around the THEN 
* ENDIF
* EXPRESSION STMT
351:     LD  3,-2(1) 	load lhs variable i
352:    LDA  3,1(3) 	increment value of i
353:     ST  3,-2(1) 	Store variable i
* END compound statement
354:    LDA  7,-72(7) 	go to beginning of loop 
292:    LDA  7,62(7) 	No more loop 
* ENDWHILE
* IF
355:     ST  1,-3(1) 	Store old fp in ghost frame 
356:    LDA  1,-3(1) 	Load address of new frame 
357:    LDA  3,1(7) 	Return address in ac 
358:    LDA  7,-209(7) 	CALL check
359:    LDA  3,0(2) 	Save the result in ac 
360:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
362:    LDC  3,0(6) 	Load constant 
363:     ST  3,-2(1) 	Store variable i
* WHILE
364:     LD  3,-2(1) 	Load variable i
365:     ST  3,-3(1) 	Save left side 
366:    LDC  3,10(6) 	Load constant 
367:     LD  4,-3(1) 	Load left into ac1 
368:    SUB  4,4,3 	Op < 
369:    LDC  3,1(6) 	True case 
370:    JLT  4,1(7) 	Jump if true 
371:    LDC  3,0(6) 	False case 
372:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
374:     ST  1,-3(1) 	Store old fp in ghost frame 
375:    LDC  3,1(6) 	Load constant 
376:     ST  3,-5(1) 	Store parameter 
377:    LDA  1,-3(1) 	Load address of new frame 
378:    LDA  3,1(7) 	Return address in ac 
379:    LDA  7,-362(7) 	CALL outputb
380:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
381:     LD  3,-2(1) 	load lhs variable i
382:    LDA  3,1(3) 	increment value of i
383:     ST  3,-2(1) 	Store variable i
* END compound statement
384:    LDA  7,-21(7) 	go to beginning of loop 
373:    LDA  7,11(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
385:     ST  1,-3(1) 	Store old fp in ghost frame 
386:    LDA  1,-3(1) 	Load address of new frame 
387:    LDA  3,1(7) 	Return address in ac 
388:    LDA  7,-364(7) 	CALL outnl
389:    LDA  3,0(2) 	Save the result in ac 
* RETURN
390:    LDC  3,0(6) 	Load constant 
391:    LDA  2,0(3) 	Copy result to rt register 
392:     LD  3,-1(1) 	Load return address 
393:     LD  1,0(1) 	Adjust fp 
394:    LDA  7,0(3) 	Return 
* END compound statement
* ELSE
361:    LDA  7,34(7) 	Jump around the THEN 
* BEGIN compound statement
* RETURN
396:    LDC  3,1(6) 	Load constant 
397:    LDA  2,0(3) 	Copy result to rt register 
398:     LD  3,-1(1) 	Load return address 
399:     LD  1,0(1) 	Adjust fp 
400:    LDA  7,0(3) 	Return 
* END compound statement
395:    LDA  7,5(7) 	Jump around the ELSE 
* ENDIF
* END compound statement
280:    LDA  7,120(7) 	Jump around the THEN 
* ENDIF
* EXPRESSION STMT
401:    LDC  3,0(6) 	Load constant 
402:     ST  3,-2(1) 	Store variable i
* WHILE
403:     LD  3,-2(1) 	Load variable i
404:     ST  3,-3(1) 	Save left side 
405:    LDC  3,10(6) 	Load constant 
406:     LD  4,-3(1) 	Load left into ac1 
407:    SUB  4,4,3 	Op < 
408:    LDC  3,1(6) 	True case 
409:    JLT  4,1(7) 	Jump if true 
410:    LDC  3,0(6) 	False case 
411:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
413:     ST  1,-3(1) 	Store old fp in ghost frame 
414:    LDC  3,0(6) 	Load constant 
415:     ST  3,-5(1) 	Store parameter 
416:    LDA  1,-3(1) 	Load address of new frame 
417:    LDA  3,1(7) 	Return address in ac 
418:    LDA  7,-401(7) 	CALL outputb
419:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
420:     LD  3,-2(1) 	load lhs variable i
421:    LDA  3,1(3) 	increment value of i
422:     ST  3,-2(1) 	Store variable i
* END compound statement
423:    LDA  7,-21(7) 	go to beginning of loop 
412:    LDA  7,11(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
424:     ST  1,-3(1) 	Store old fp in ghost frame 
425:    LDA  1,-3(1) 	Load address of new frame 
426:    LDA  3,1(7) 	Return address in ac 
427:    LDA  7,-403(7) 	CALL outnl
428:    LDA  3,0(2) 	Save the result in ac 
* RETURN
429:    LDC  3,0(6) 	Load constant 
430:    LDA  2,0(3) 	Copy result to rt register 
431:     LD  3,-1(1) 	Load return address 
432:     LD  1,0(1) 	Adjust fp 
433:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
434:    LDC  2,0(6) 	Set return value to 0 
435:     LD  3,-1(1) 	Load return address 
436:     LD  1,0(1) 	Adjust fp 
437:    LDA  7,0(3) 	Return 
* END of function turn
* BEGIN function main
438:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
439:    LDC  3,0(6) 	Load constant 
440:     ST  3,-1(0) 	Store variable n
* EXPRESSION STMT
441:    LDC  3,0(6) 	Load constant 
442:     ST  3,-3(1) 	Save index 
443:     ST  1,-4(1) 	Store old fp in ghost frame 
444:    LDA  1,-4(1) 	Load address of new frame 
445:    LDA  3,1(7) 	Return address in ac 
446:    LDA  7,-446(7) 	CALL input
447:    LDA  3,0(2) 	Save the result in ac 
448:     LD  4,-3(1) 	Restore index 
449:    LDA  5,-3(0) 	Load address of base of array r
450:    SUB  5,5,4 	Compute offset of value 
451:     ST  3,0(5) 	Store variable r
* EXPRESSION STMT
452:     ST  1,-3(1) 	Store old fp in ghost frame 
453:    LDA  1,-3(1) 	Load address of new frame 
454:    LDA  3,1(7) 	Return address in ac 
455:    LDA  7,-431(7) 	CALL outnl
456:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
457:    LDC  3,0(6) 	Load constant 
458:     ST  3,-2(1) 	Store variable i
* WHILE
459:     LD  3,-2(1) 	Load variable i
460:     ST  3,-3(1) 	Save left side 
461:    LDC  3,4(6) 	Load constant 
462:     LD  4,-3(1) 	Load left into ac1 
463:    SUB  4,4,3 	Op < 
464:    LDC  3,1(6) 	True case 
465:    JLT  4,1(7) 	Jump if true 
466:    LDC  3,0(6) 	False case 
467:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
469:     LD  3,-2(1) 	Load variable i
470:     ST  3,-3(1) 	Save index 
471:     ST  1,-4(1) 	Store old fp in ghost frame 
472:    LDA  1,-4(1) 	Load address of new frame 
473:    LDA  3,1(7) 	Return address in ac 
474:    LDA  7,-445(7) 	CALL rand
475:    LDA  3,0(2) 	Save the result in ac 
476:     ST  3,-4(1) 	Save left side 
477:    LDC  3,10(6) 	Load constant 
478:     LD  4,-4(1) 	Load left into ac1 
479:    DIV  5,4,3 	Op % 
480:    MUL  5,5,3 	 
481:    SUB  3,4,5 	 
482:     LD  4,-3(1) 	Restore index 
483:    LDA  5,-132(0) 	Load address of base of array known
484:    SUB  5,5,4 	Compute offset of value 
485:     ST  3,0(5) 	Store variable known
* EXPRESSION STMT
486:     LD  3,-2(1) 	load lhs variable i
487:    LDA  3,1(3) 	increment value of i
488:     ST  3,-2(1) 	Store variable i
* END compound statement
489:    LDA  7,-31(7) 	go to beginning of loop 
468:    LDA  7,21(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
490:    LDC  3,0(6) 	Load constant 
491:     ST  3,0(0) 	Store variable turns
* WHILE
492:     ST  1,-3(1) 	Store old fp in ghost frame 
493:    LDA  1,-3(1) 	Load address of new frame 
494:    LDA  3,1(7) 	Return address in ac 
495:    LDA  7,-241(7) 	CALL turn
496:    LDA  3,0(2) 	Save the result in ac 
497:    JGT  3,1(7) 	Jump to while part 
* DO
499:    LDA  7,-8(7) 	go to beginning of loop 
498:    LDA  7,1(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
500:     ST  1,-3(1) 	Store old fp in ghost frame 
501:    LDA  1,-3(1) 	Load address of new frame 
502:    LDA  3,1(7) 	Return address in ac 
503:    LDA  7,-479(7) 	CALL outnl
504:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
505:    LDC  3,0(6) 	Load constant 
506:     ST  3,-2(1) 	Store variable i
* WHILE
507:     LD  3,-2(1) 	Load variable i
508:     ST  3,-3(1) 	Save left side 
509:    LDC  3,4(6) 	Load constant 
510:     LD  4,-3(1) 	Load left into ac1 
511:    SUB  4,4,3 	Op < 
512:    LDC  3,1(6) 	True case 
513:    JLT  4,1(7) 	Jump if true 
514:    LDC  3,0(6) 	False case 
515:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
517:     ST  1,-3(1) 	Store old fp in ghost frame 
518:     LD  3,-2(1) 	Load variable i
519:    LDA  4,-132(0) 	Load address of base of array known
520:    SUB  3,4,3 	Compute offset of value 
521:     LD  3,0(3) 	Load the value 
522:     ST  3,-5(1) 	Store parameter 
523:    LDA  1,-3(1) 	Load address of new frame 
524:    LDA  3,1(7) 	Return address in ac 
525:    LDA  7,-520(7) 	CALL output
526:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
527:     ST  1,-3(1) 	Store old fp in ghost frame 
528:    LDA  1,-3(1) 	Load address of new frame 
529:    LDA  3,1(7) 	Return address in ac 
530:    LDA  7,-506(7) 	CALL outnl
531:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
532:     LD  3,-2(1) 	load lhs variable i
533:    LDA  3,1(3) 	increment value of i
534:     ST  3,-2(1) 	Store variable i
* END compound statement
535:    LDA  7,-29(7) 	go to beginning of loop 
516:    LDA  7,19(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
536:     ST  1,-3(1) 	Store old fp in ghost frame 
537:    LDA  1,-3(1) 	Load address of new frame 
538:    LDA  3,1(7) 	Return address in ac 
539:    LDA  7,-515(7) 	CALL outnl
540:    LDA  3,0(2) 	Save the result in ac 
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
546:    LDC  3,128(6) 	load size of array r
547:     ST  3,-2(0) 	save size of array r
548:    LDC  3,4(6) 	load size of array known
549:     ST  3,-131(0) 	save size of array known
550:    LDC  3,4(6) 	load size of array guess
551:     ST  3,-136(0) 	save size of array guess
* END init of global array sizes
552:    LDA  1,-141(0) 	set first frame at end of globals 
553:     ST  1,0(1) 	store old fp (point to self) 
554:    LDA  3,1(7) 	Return address in ac 
555:    LDA  7,-118(7) 	Jump to main 
556:   HALT  0,0,0 	DONE! 
* END Init
