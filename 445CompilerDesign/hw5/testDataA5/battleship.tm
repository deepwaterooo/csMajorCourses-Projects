* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  battleship.c-
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
* BEGIN function Print
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 31:     ST  1,-3(1) 	Store old fp in ghost frame 
 32:     LD  3,-2(1) 	Load variable what
 33:     ST  3,-5(1) 	Store parameter 
 34:    LDA  1,-3(1) 	Load address of new frame 
 35:    LDA  3,1(7) 	Return address in ac 
 36:    LDA  7,-31(7) 	CALL output
 37:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 38:    LDC  2,0(6) 	Set return value to 0 
 39:     LD  3,-1(1) 	Load return address 
 40:     LD  1,0(1) 	Adjust fp 
 41:    LDA  7,0(3) 	Return 
* END of function Print
* BEGIN function NewLine
 42:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 43:     ST  1,-2(1) 	Store old fp in ghost frame 
 44:    LDA  1,-2(1) 	Load address of new frame 
 45:    LDA  3,1(7) 	Return address in ac 
 46:    LDA  7,-22(7) 	CALL outnl
 47:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 48:    LDC  2,0(6) 	Set return value to 0 
 49:     LD  3,-1(1) 	Load return address 
 50:     LD  1,0(1) 	Adjust fp 
 51:    LDA  7,0(3) 	Return 
* END of function NewLine
* BEGIN function Display
 52:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 53:    LDC  3,0(6) 	Load constant 
 54:     ST  3,-4(1) 	Store variable r
* EXPRESSION STMT
 55:     ST  1,-6(1) 	Store old fp in ghost frame 
 56:    LDA  1,-6(1) 	Load address of new frame 
 57:    LDA  3,1(7) 	Return address in ac 
 58:    LDA  7,-17(7) 	CALL NewLine
 59:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 60:     ST  1,-6(1) 	Store old fp in ghost frame 
 61:    LDA  1,-6(1) 	Load address of new frame 
 62:    LDA  3,1(7) 	Return address in ac 
 63:    LDA  7,-22(7) 	CALL NewLine
 64:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 65:     ST  1,-6(1) 	Store old fp in ghost frame 
 66:     LD  3,-1(0) 	Load variable NumShots
 67:     ST  3,-8(1) 	Store parameter 
 68:    LDA  1,-6(1) 	Load address of new frame 
 69:    LDA  3,1(7) 	Return address in ac 
 70:    LDA  7,-41(7) 	CALL Print
 71:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 72:     ST  1,-6(1) 	Store old fp in ghost frame 
 73:    LDA  1,-6(1) 	Load address of new frame 
 74:    LDA  3,1(7) 	Return address in ac 
 75:    LDA  7,-34(7) 	CALL NewLine
 76:    LDA  3,0(2) 	Save the result in ac 
* WHILE
 77:     LD  3,-4(1) 	Load variable r
 78:     ST  3,-6(1) 	Save left side 
 79:     LD  3,-3(1) 	Load variable dimension
 80:     LD  4,-6(1) 	Load left into ac1 
 81:    SUB  4,4,3 	Op < 
 82:    LDC  3,1(6) 	True case 
 83:    JLT  4,1(7) 	Jump if true 
 84:    LDC  3,0(6) 	False case 
 85:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 87:    LDC  3,0(6) 	Load constant 
 88:     ST  3,-5(1) 	Store variable c
* WHILE
 89:     LD  3,-5(1) 	Load variable c
 90:     ST  3,-6(1) 	Save left side 
 91:     LD  3,-3(1) 	Load variable dimension
 92:     LD  4,-6(1) 	Load left into ac1 
 93:    SUB  4,4,3 	Op < 
 94:    LDC  3,1(6) 	True case 
 95:    JLT  4,1(7) 	Jump if true 
 96:    LDC  3,0(6) 	False case 
 97:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* IF
 99:     LD  3,-4(1) 	Load variable r
100:     ST  3,-6(1) 	Save left side 
101:    LDC  3,10(6) 	Load constant 
102:     LD  4,-6(1) 	Load left into ac1 
103:    MUL  3,4,3 	Op * 
104:     ST  3,-6(1) 	Save left side 
105:     LD  3,-5(1) 	Load variable c
106:     LD  4,-6(1) 	Load left into ac1 
107:    ADD  3,4,3 	Op + 
108:     LD  4,-2(1) 	Load address of base of array arr
109:    SUB  3,4,3 	Compute offset of value 
110:     LD  3,0(3) 	Load the value 
111:     ST  3,-6(1) 	Save left side 
112:    LDC  3,7(6) 	Load constant 
113:     LD  4,-6(1) 	Load left into ac1 
114:    SUB  4,4,3 	Op == 
115:    LDC  3,1(6) 	True case 
116:    JEQ  4,1(7) 	Jump if true 
117:    LDC  3,0(6) 	False case 
118:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
120:     ST  1,-6(1) 	Store old fp in ghost frame 
121:    LDC  3,4(6) 	Load constant 
122:     ST  3,-8(1) 	Store parameter 
123:    LDA  1,-6(1) 	Load address of new frame 
124:    LDA  3,1(7) 	Return address in ac 
125:    LDA  7,-96(7) 	CALL Print
126:    LDA  3,0(2) 	Save the result in ac 
* ELSE
119:    LDA  7,8(7) 	Jump around the THEN 
* EXPRESSION STMT
128:     ST  1,-6(1) 	Store old fp in ghost frame 
129:     LD  3,-4(1) 	Load variable r
130:     ST  3,-8(1) 	Save left side 
131:    LDC  3,10(6) 	Load constant 
132:     LD  4,-8(1) 	Load left into ac1 
133:    MUL  3,4,3 	Op * 
134:     ST  3,-8(1) 	Save left side 
135:     LD  3,-5(1) 	Load variable c
136:     LD  4,-8(1) 	Load left into ac1 
137:    ADD  3,4,3 	Op + 
138:     LD  4,-2(1) 	Load address of base of array arr
139:    SUB  3,4,3 	Compute offset of value 
140:     LD  3,0(3) 	Load the value 
141:     ST  3,-8(1) 	Store parameter 
142:    LDA  1,-6(1) 	Load address of new frame 
143:    LDA  3,1(7) 	Return address in ac 
144:    LDA  7,-115(7) 	CALL Print
145:    LDA  3,0(2) 	Save the result in ac 
127:    LDA  7,18(7) 	Jump around the ELSE 
* ENDIF
* EXPRESSION STMT
146:     LD  3,-5(1) 	Load variable c
147:     ST  3,-6(1) 	Save left side 
148:    LDC  3,1(6) 	Load constant 
149:     LD  4,-6(1) 	Load left into ac1 
150:    ADD  3,4,3 	Op + 
151:     ST  3,-5(1) 	Store variable c
* END compound statement
152:    LDA  7,-64(7) 	go to beginning of loop 
 98:    LDA  7,54(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
153:     ST  1,-6(1) 	Store old fp in ghost frame 
154:    LDA  1,-6(1) 	Load address of new frame 
155:    LDA  3,1(7) 	Return address in ac 
156:    LDA  7,-115(7) 	CALL NewLine
157:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
158:     LD  3,-4(1) 	load lhs variable r
159:    LDA  3,1(3) 	increment value of r
160:     ST  3,-4(1) 	Store variable r
* END compound statement
161:    LDA  7,-85(7) 	go to beginning of loop 
 86:    LDA  7,75(7) 	No more loop 
* ENDWHILE
* END compound statement
* Add standard closing in case there is no return statement
162:    LDC  2,0(6) 	Set return value to 0 
163:     LD  3,-1(1) 	Load return address 
164:     LD  1,0(1) 	Adjust fp 
165:    LDA  7,0(3) 	Return 
* END of function Display
* BEGIN function Randomize
166:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
167:     LD  3,-2(1) 	Load variable seed
168:     ST  3,-4(1) 	Save left side 
169:    LDC  3,2(6) 	Load constant 
170:     LD  4,-4(1) 	Load left into ac1 
171:    DIV  5,4,3 	Op % 
172:    MUL  5,5,3 	 
173:    SUB  3,4,5 	 
174:     ST  3,-4(1) 	Save left side 
175:    LDC  3,0(6) 	Load constant 
176:     LD  4,-4(1) 	Load left into ac1 
177:    SUB  4,4,3 	Op == 
178:    LDC  3,1(6) 	True case 
179:    JEQ  4,1(7) 	Jump if true 
180:    LDC  3,0(6) 	False case 
181:     ST  3,-3(0) 	Store variable iseven
* EXPRESSION STMT
182:     LD  3,-3(1) 	Load variable dim
183:     LD  4,-2(1) 	load lhs variable seed
184:    ADD  3,4,3 	op += 
185:     ST  3,-2(1) 	Store variable seed
* EXPRESSION STMT
186:    LDC  3,17(6) 	Load constant 
187:     ST  3,-4(1) 	Save left side 
188:     LD  3,-2(1) 	Load variable seed
189:     LD  4,-4(1) 	Load left into ac1 
190:    MUL  3,4,3 	Op * 
191:     ST  3,-4(1) 	Save left side 
192:    LDC  3,11(6) 	Load constant 
193:     LD  4,-4(1) 	Load left into ac1 
194:    ADD  3,4,3 	Op + 
195:     ST  3,-2(1) 	Store variable seed
* EXPRESSION STMT
196:     LD  3,-2(1) 	Load variable seed
197:     ST  3,-4(1) 	Save left side 
198:     LD  3,-3(1) 	Load variable dim
199:     ST  3,-5(1) 	Save left side 
200:     LD  3,-3(1) 	Load variable dim
201:     LD  4,-5(1) 	Load left into ac1 
202:    MUL  3,4,3 	Op * 
203:     LD  4,-4(1) 	Load left into ac1 
204:    DIV  5,4,3 	Op % 
205:    MUL  5,5,3 	 
206:    SUB  3,4,5 	 
207:     ST  3,-2(1) 	Store variable seed
* RETURN
208:     LD  3,-2(1) 	Load variable seed
209:    LDA  2,0(3) 	Copy result to rt register 
210:     LD  3,-1(1) 	Load return address 
211:     LD  1,0(1) 	Adjust fp 
212:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
213:    LDC  2,0(6) 	Set return value to 0 
214:     LD  3,-1(1) 	Load return address 
215:     LD  1,0(1) 	Adjust fp 
216:    LDA  7,0(3) 	Return 
* END of function Randomize
* BEGIN function HideShip
217:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
218:     ST  1,-8(1) 	Store old fp in ghost frame 
219:     ST  1,-10(1) 	Store old fp in ghost frame 
220:    LDA  1,-10(1) 	Load address of new frame 
221:    LDA  3,1(7) 	Return address in ac 
222:    LDA  7,-222(7) 	CALL input
223:    LDA  3,0(2) 	Save the result in ac 
224:     ST  3,-10(1) 	Store parameter 
225:     LD  3,-3(1) 	Load variable dimen
226:     ST  3,-11(1) 	Store parameter 
227:    LDA  1,-8(1) 	Load address of new frame 
228:    LDA  3,1(7) 	Return address in ac 
229:    LDA  7,-64(7) 	CALL Randomize
230:    LDA  3,0(2) 	Save the result in ac 
231:     ST  3,-4(1) 	Store variable pos
* EXPRESSION STMT
232:     LD  3,-4(1) 	Load variable pos
233:     ST  3,-8(1) 	Save left side 
234:     LD  3,-3(1) 	Load variable dimen
235:     LD  4,-8(1) 	Load left into ac1 
236:    DIV  3,4,3 	Op / 
237:     ST  3,-5(1) 	Store variable row
* EXPRESSION STMT
238:     LD  3,-4(1) 	Load variable pos
239:     ST  3,-8(1) 	Save left side 
240:     LD  3,-4(1) 	Load variable pos
241:     ST  3,-9(1) 	Save left side 
242:     LD  3,-3(1) 	Load variable dimen
243:     LD  4,-9(1) 	Load left into ac1 
244:    DIV  3,4,3 	Op / 
245:     ST  3,-9(1) 	Save left side 
246:     LD  3,-3(1) 	Load variable dimen
247:     LD  4,-9(1) 	Load left into ac1 
248:    MUL  3,4,3 	Op * 
249:     LD  4,-8(1) 	Load left into ac1 
250:    SUB  3,4,3 	Op - 
251:     ST  3,-6(1) 	Store variable col
* IF
252:     LD  3,-3(0) 	Load variable iseven
253:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* IF
255:     LD  3,-6(1) 	Load variable col
256:     ST  3,-8(1) 	Save left side 
257:     LD  3,-3(1) 	Load variable dimen
258:     ST  3,-9(1) 	Save left side 
259:     LD  3,0(0) 	Load variable shipsize
260:     LD  4,-9(1) 	Load left into ac1 
261:    SUB  3,4,3 	Op - 
262:     LD  4,-8(1) 	Load left into ac1 
263:    SUB  4,4,3 	Op > 
264:    LDC  3,1(6) 	True case 
265:    JGT  4,1(7) 	Jump if true 
266:    LDC  3,0(6) 	False case 
267:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
269:     LD  3,-3(1) 	Load variable dimen
270:     ST  3,-8(1) 	Save left side 
271:     LD  3,0(0) 	Load variable shipsize
272:     LD  4,-8(1) 	Load left into ac1 
273:    SUB  3,4,3 	Op - 
274:     ST  3,-6(1) 	Store variable col
268:    LDA  7,6(7) 	Jump around the THEN 
* ENDIF
* EXPRESSION STMT
275:    LDC  3,0(6) 	Load constant 
276:     ST  3,-7(1) 	Store variable i
* WHILE
277:     LD  3,-7(1) 	Load variable i
278:     ST  3,-8(1) 	Save left side 
279:     LD  3,0(0) 	Load variable shipsize
280:     LD  4,-8(1) 	Load left into ac1 
281:    SUB  4,4,3 	Op < 
282:    LDC  3,1(6) 	True case 
283:    JLT  4,1(7) 	Jump if true 
284:    LDC  3,0(6) 	False case 
285:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
287:     LD  3,-5(1) 	Load variable row
288:     ST  3,-8(1) 	Save left side 
289:     LD  3,-3(1) 	Load variable dimen
290:     LD  4,-8(1) 	Load left into ac1 
291:    MUL  3,4,3 	Op * 
292:     ST  3,-8(1) 	Save left side 
293:     LD  3,-6(1) 	Load variable col
294:     LD  4,-8(1) 	Load left into ac1 
295:    ADD  3,4,3 	Op + 
296:     ST  3,-8(1) 	Save index 
297:    LDC  3,7(6) 	Load constant 
298:     LD  4,-8(1) 	Restore index 
299:     LD  5,-2(1) 	Load address of base of array arr
300:    SUB  5,5,4 	Compute offset of value 
301:     ST  3,0(5) 	Store variable arr
* EXPRESSION STMT
302:     LD  3,-6(1) 	load lhs variable col
303:    LDA  3,1(3) 	increment value of col
304:     ST  3,-6(1) 	Store variable col
* EXPRESSION STMT
305:     LD  3,-7(1) 	load lhs variable i
306:    LDA  3,1(3) 	increment value of i
307:     ST  3,-7(1) 	Store variable i
* END compound statement
308:    LDA  7,-32(7) 	go to beginning of loop 
286:    LDA  7,22(7) 	No more loop 
* ENDWHILE
* END compound statement
* ELSE
254:    LDA  7,55(7) 	Jump around the THEN 
* BEGIN compound statement
* IF
310:     LD  3,-5(1) 	Load variable row
311:     ST  3,-8(1) 	Save left side 
312:     LD  3,-3(1) 	Load variable dimen
313:     ST  3,-9(1) 	Save left side 
314:     LD  3,0(0) 	Load variable shipsize
315:     LD  4,-9(1) 	Load left into ac1 
316:    SUB  3,4,3 	Op - 
317:     LD  4,-8(1) 	Load left into ac1 
318:    SUB  4,4,3 	Op > 
319:    LDC  3,1(6) 	True case 
320:    JGT  4,1(7) 	Jump if true 
321:    LDC  3,0(6) 	False case 
322:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
324:     LD  3,-3(1) 	Load variable dimen
325:     ST  3,-8(1) 	Save left side 
326:     LD  3,0(0) 	Load variable shipsize
327:     LD  4,-8(1) 	Load left into ac1 
328:    SUB  3,4,3 	Op - 
329:     ST  3,-5(1) 	Store variable row
323:    LDA  7,6(7) 	Jump around the THEN 
* ENDIF
* EXPRESSION STMT
330:    LDC  3,0(6) 	Load constant 
331:     ST  3,-7(1) 	Store variable i
* WHILE
332:     LD  3,-7(1) 	Load variable i
333:     ST  3,-8(1) 	Save left side 
334:     LD  3,0(0) 	Load variable shipsize
335:     LD  4,-8(1) 	Load left into ac1 
336:    SUB  4,4,3 	Op < 
337:    LDC  3,1(6) 	True case 
338:    JLT  4,1(7) 	Jump if true 
339:    LDC  3,0(6) 	False case 
340:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
342:     LD  3,-5(1) 	Load variable row
343:     ST  3,-8(1) 	Save left side 
344:     LD  3,-3(1) 	Load variable dimen
345:     LD  4,-8(1) 	Load left into ac1 
346:    MUL  3,4,3 	Op * 
347:     ST  3,-8(1) 	Save left side 
348:     LD  3,-6(1) 	Load variable col
349:     LD  4,-8(1) 	Load left into ac1 
350:    ADD  3,4,3 	Op + 
351:     ST  3,-8(1) 	Save index 
352:    LDC  3,7(6) 	Load constant 
353:     LD  4,-8(1) 	Restore index 
354:     LD  5,-2(1) 	Load address of base of array arr
355:    SUB  5,5,4 	Compute offset of value 
356:     ST  3,0(5) 	Store variable arr
* EXPRESSION STMT
357:     LD  3,-3(1) 	Load variable dimen
358:     LD  4,-6(1) 	load lhs variable col
359:    ADD  3,4,3 	op += 
360:     ST  3,-6(1) 	Store variable col
* EXPRESSION STMT
361:     LD  3,-7(1) 	load lhs variable i
362:    LDA  3,1(3) 	increment value of i
363:     ST  3,-7(1) 	Store variable i
* END compound statement
364:    LDA  7,-33(7) 	go to beginning of loop 
341:    LDA  7,23(7) 	No more loop 
* ENDWHILE
* END compound statement
309:    LDA  7,55(7) 	Jump around the ELSE 
* ENDIF
* END compound statement
* Add standard closing in case there is no return statement
365:    LDC  2,0(6) 	Set return value to 0 
366:     LD  3,-1(1) 	Load return address 
367:     LD  1,0(1) 	Adjust fp 
368:    LDA  7,0(3) 	Return 
* END of function HideShip
* BEGIN function Aim
369:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
370:    LDC  3,666(6) 	Load constant 
371:    LDC  4,0(6) 	Load 0 
372:    SUB  3,4,3 	Op unary - 
373:     ST  3,-2(1) 	Store variable shot
* WHILE
374:     LD  3,-2(1) 	Load variable shot
375:     ST  3,-3(1) 	Save left side 
376:    LDC  3,666(6) 	Load constant 
377:    LDC  4,0(6) 	Load 0 
378:    SUB  3,4,3 	Op unary - 
379:     LD  4,-3(1) 	Load left into ac1 
380:    SUB  4,4,3 	Op == 
381:    LDC  3,1(6) 	True case 
382:    JEQ  4,1(7) 	Jump if true 
383:    LDC  3,0(6) 	False case 
384:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
386:     ST  1,-3(1) 	Store old fp in ghost frame 
387:    LDA  1,-3(1) 	Load address of new frame 
388:    LDA  3,1(7) 	Return address in ac 
389:    LDA  7,-389(7) 	CALL input
390:    LDA  3,0(2) 	Save the result in ac 
391:     ST  3,-2(1) 	Store variable shot
* IF
392:     LD  3,-2(1) 	Load variable shot
393:     ST  3,-3(1) 	Save left side 
394:    LDC  3,0(6) 	Load constant 
395:     LD  4,-3(1) 	Load left into ac1 
396:    SUB  4,4,3 	Op < 
397:    LDC  3,1(6) 	True case 
398:    JLT  4,1(7) 	Jump if true 
399:    LDC  3,0(6) 	False case 
400:     ST  3,-3(1) 	Save left side 
401:     LD  3,-2(1) 	Load variable shot
402:     ST  3,-4(1) 	Save left side 
403:    LDC  3,99(6) 	Load constant 
404:     LD  4,-4(1) 	Load left into ac1 
405:    SUB  4,4,3 	Op > 
406:    LDC  3,1(6) 	True case 
407:    JGT  4,1(7) 	Jump if true 
408:    LDC  3,0(6) 	False case 
409:     LD  4,-3(1) 	Load left into ac1 
410:    JGT  3,1(7) 	Op OR 
411:    LDA  3,0(4) 	 
412:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
414:    LDC  3,666(6) 	Load constant 
415:    LDC  4,0(6) 	Load 0 
416:    SUB  3,4,3 	Op unary - 
417:     ST  3,-2(1) 	Store variable shot
* EXPRESSION STMT
418:     ST  1,-3(1) 	Store old fp in ghost frame 
419:    LDA  1,-3(1) 	Load address of new frame 
420:    LDA  3,1(7) 	Return address in ac 
421:    LDA  7,-380(7) 	CALL NewLine
422:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
423:     ST  1,-3(1) 	Store old fp in ghost frame 
424:     LD  3,-2(1) 	Load variable shot
425:     ST  3,-5(1) 	Store parameter 
426:    LDA  1,-3(1) 	Load address of new frame 
427:    LDA  3,1(7) 	Return address in ac 
428:    LDA  7,-399(7) 	CALL Print
429:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
430:     ST  1,-3(1) 	Store old fp in ghost frame 
431:    LDA  1,-3(1) 	Load address of new frame 
432:    LDA  3,1(7) 	Return address in ac 
433:    LDA  7,-392(7) 	CALL NewLine
434:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
413:    LDA  7,21(7) 	Jump around the THEN 
* ENDIF
* END compound statement
435:    LDA  7,-62(7) 	go to beginning of loop 
385:    LDA  7,50(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
436:     ST  1,-3(1) 	Store old fp in ghost frame 
437:    LDA  1,-3(1) 	Load address of new frame 
438:    LDA  3,1(7) 	Return address in ac 
439:    LDA  7,-398(7) 	CALL NewLine
440:    LDA  3,0(2) 	Save the result in ac 
* RETURN
441:     LD  3,-2(1) 	Load variable shot
442:    LDA  2,0(3) 	Copy result to rt register 
443:     LD  3,-1(1) 	Load return address 
444:     LD  1,0(1) 	Adjust fp 
445:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
446:    LDC  2,0(6) 	Set return value to 0 
447:     LD  3,-1(1) 	Load return address 
448:     LD  1,0(1) 	Adjust fp 
449:    LDA  7,0(3) 	Return 
* END of function Aim
* BEGIN function RevealShip
450:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
451:    LDC  3,0(6) 	Load constant 
452:     ST  3,-4(1) 	Store variable r
* EXPRESSION STMT
453:     ST  1,-6(1) 	Store old fp in ghost frame 
454:    LDA  1,-6(1) 	Load address of new frame 
455:    LDA  3,1(7) 	Return address in ac 
456:    LDA  7,-415(7) 	CALL NewLine
457:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
458:     ST  1,-6(1) 	Store old fp in ghost frame 
459:    LDA  1,-6(1) 	Load address of new frame 
460:    LDA  3,1(7) 	Return address in ac 
461:    LDA  7,-420(7) 	CALL NewLine
462:    LDA  3,0(2) 	Save the result in ac 
* WHILE
463:     LD  3,-4(1) 	Load variable r
464:     ST  3,-6(1) 	Save left side 
465:     LD  3,-3(1) 	Load variable dimension
466:     LD  4,-6(1) 	Load left into ac1 
467:    SUB  4,4,3 	Op < 
468:    LDC  3,1(6) 	True case 
469:    JLT  4,1(7) 	Jump if true 
470:    LDC  3,0(6) 	False case 
471:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
473:    LDC  3,0(6) 	Load constant 
474:     ST  3,-5(1) 	Store variable c
* WHILE
475:     LD  3,-5(1) 	Load variable c
476:     ST  3,-6(1) 	Save left side 
477:     LD  3,-3(1) 	Load variable dimension
478:     LD  4,-6(1) 	Load left into ac1 
479:    SUB  4,4,3 	Op < 
480:    LDC  3,1(6) 	True case 
481:    JLT  4,1(7) 	Jump if true 
482:    LDC  3,0(6) 	False case 
483:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* IF
485:     LD  3,-4(1) 	Load variable r
486:     ST  3,-6(1) 	Save left side 
487:    LDC  3,10(6) 	Load constant 
488:     LD  4,-6(1) 	Load left into ac1 
489:    MUL  3,4,3 	Op * 
490:     ST  3,-6(1) 	Save left side 
491:     LD  3,-5(1) 	Load variable c
492:     LD  4,-6(1) 	Load left into ac1 
493:    ADD  3,4,3 	Op + 
494:     LD  4,-2(1) 	Load address of base of array arr
495:    SUB  3,4,3 	Compute offset of value 
496:     LD  3,0(3) 	Load the value 
497:     ST  3,-6(1) 	Save left side 
498:    LDC  3,4(6) 	Load constant 
499:     LD  4,-6(1) 	Load left into ac1 
500:    SUB  4,4,3 	Op == 
501:    LDC  3,1(6) 	True case 
502:    JEQ  4,1(7) 	Jump if true 
503:    LDC  3,0(6) 	False case 
504:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
506:     ST  1,-6(1) 	Store old fp in ghost frame 
507:    LDC  3,2(6) 	Load constant 
508:     ST  3,-8(1) 	Store parameter 
509:    LDA  1,-6(1) 	Load address of new frame 
510:    LDA  3,1(7) 	Return address in ac 
511:    LDA  7,-482(7) 	CALL Print
512:    LDA  3,0(2) 	Save the result in ac 
* ELSE
505:    LDA  7,8(7) 	Jump around the THEN 
* EXPRESSION STMT
514:     ST  1,-6(1) 	Store old fp in ghost frame 
515:     LD  3,-4(1) 	Load variable r
516:     ST  3,-8(1) 	Save left side 
517:    LDC  3,10(6) 	Load constant 
518:     LD  4,-8(1) 	Load left into ac1 
519:    MUL  3,4,3 	Op * 
520:     ST  3,-8(1) 	Save left side 
521:     LD  3,-5(1) 	Load variable c
522:     LD  4,-8(1) 	Load left into ac1 
523:    ADD  3,4,3 	Op + 
524:     LD  4,-2(1) 	Load address of base of array arr
525:    SUB  3,4,3 	Compute offset of value 
526:     LD  3,0(3) 	Load the value 
527:     ST  3,-8(1) 	Store parameter 
528:    LDA  1,-6(1) 	Load address of new frame 
529:    LDA  3,1(7) 	Return address in ac 
530:    LDA  7,-501(7) 	CALL Print
531:    LDA  3,0(2) 	Save the result in ac 
513:    LDA  7,18(7) 	Jump around the ELSE 
* ENDIF
* EXPRESSION STMT
532:     LD  3,-5(1) 	Load variable c
533:     ST  3,-6(1) 	Save left side 
534:    LDC  3,1(6) 	Load constant 
535:     LD  4,-6(1) 	Load left into ac1 
536:    ADD  3,4,3 	Op + 
537:     ST  3,-5(1) 	Store variable c
* END compound statement
538:    LDA  7,-64(7) 	go to beginning of loop 
484:    LDA  7,54(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
539:     ST  1,-6(1) 	Store old fp in ghost frame 
540:    LDA  1,-6(1) 	Load address of new frame 
541:    LDA  3,1(7) 	Return address in ac 
542:    LDA  7,-501(7) 	CALL NewLine
543:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
544:     LD  3,-4(1) 	load lhs variable r
545:    LDA  3,1(3) 	increment value of r
546:     ST  3,-4(1) 	Store variable r
* END compound statement
547:    LDA  7,-85(7) 	go to beginning of loop 
472:    LDA  7,75(7) 	No more loop 
* ENDWHILE
* END compound statement
* Add standard closing in case there is no return statement
548:    LDC  2,0(6) 	Set return value to 0 
549:     LD  3,-1(1) 	Load return address 
550:     LD  1,0(1) 	Adjust fp 
551:    LDA  7,0(3) 	Return 
* END of function RevealShip
* BEGIN function Fire
552:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* IF
553:     LD  3,-3(1) 	Load variable shot
554:     LD  4,-2(1) 	Load address of base of array arr
555:    SUB  3,4,3 	Compute offset of value 
556:     LD  3,0(3) 	Load the value 
557:     ST  3,-4(1) 	Save left side 
558:    LDC  3,7(6) 	Load constant 
559:     LD  4,-4(1) 	Load left into ac1 
560:    SUB  4,4,3 	Op == 
561:    LDC  3,1(6) 	True case 
562:    JEQ  4,1(7) 	Jump if true 
563:    LDC  3,0(6) 	False case 
564:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
566:     LD  3,-3(1) 	Load variable shot
567:     ST  3,-4(1) 	Save index 
568:    LDC  3,1(6) 	Load constant 
569:     LD  4,-4(1) 	Restore index 
570:     LD  5,-2(1) 	Load address of base of array arr
571:    SUB  5,5,4 	Compute offset of value 
572:     ST  3,0(5) 	Store variable arr
* EXPRESSION STMT
573:     LD  3,-2(0) 	load lhs variable NumHits
574:    LDA  3,1(3) 	increment value of NumHits
575:     ST  3,-2(0) 	Store variable NumHits
* IF
576:     LD  3,-1(0) 	Load variable NumShots
577:     ST  3,-4(1) 	Save left side 
578:    LDC  3,1(6) 	Load constant 
579:     LD  4,-4(1) 	Load left into ac1 
580:    SUB  4,4,3 	Op == 
581:    LDC  3,1(6) 	True case 
582:    JEQ  4,1(7) 	Jump if true 
583:    LDC  3,0(6) 	False case 
584:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
586:     LD  3,-1(0) 	Load variable NumShots
587:     ST  3,-4(1) 	Save left side 
588:    LDC  3,1(6) 	Load constant 
589:     LD  4,-4(1) 	Load left into ac1 
590:    ADD  3,4,3 	Op + 
591:     ST  3,-1(0) 	Store variable NumShots
585:    LDA  7,6(7) 	Jump around the THEN 
* ENDIF
* END compound statement
* ELSE
565:    LDA  7,27(7) 	Jump around the THEN 
* BEGIN compound statement
* EXPRESSION STMT
593:     LD  3,-3(1) 	Load variable shot
594:     ST  3,-4(1) 	Save index 
595:    LDC  3,0(6) 	Load constant 
596:     LD  4,-4(1) 	Restore index 
597:     LD  5,-2(1) 	Load address of base of array arr
598:    SUB  5,5,4 	Compute offset of value 
599:     ST  3,0(5) 	Store variable arr
* END compound statement
592:    LDA  7,7(7) 	Jump around the ELSE 
* ENDIF
* RETURN
600:     LD  3,-2(0) 	Load variable NumHits
601:    LDA  2,0(3) 	Copy result to rt register 
602:     LD  3,-1(1) 	Load return address 
603:     LD  1,0(1) 	Adjust fp 
604:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
605:    LDC  2,0(6) 	Set return value to 0 
606:     LD  3,-1(1) 	Load return address 
607:     LD  1,0(1) 	Adjust fp 
608:    LDA  7,0(3) 	Return 
* END of function Fire
* BEGIN function main
609:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
610:    LDC  3,100(6) 	load size of array Ocean
611:     ST  3,-2(1) 	save size of array Ocean
* EXPRESSION STMT
612:    LDC  3,4(6) 	Load constant 
613:     ST  3,0(0) 	Store variable shipsize
* EXPRESSION STMT
614:    LDC  3,0(6) 	Load constant 
615:     ST  3,-103(1) 	Store variable i
* WHILE
616:     LD  3,-103(1) 	Load variable i
617:     ST  3,-106(1) 	Save left side 
618:    LDC  3,100(6) 	Load constant 
619:     LD  4,-106(1) 	Load left into ac1 
620:    SUB  4,4,3 	Op < 
621:    LDC  3,1(6) 	True case 
622:    JLT  4,1(7) 	Jump if true 
623:    LDC  3,0(6) 	False case 
624:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
626:     LD  3,-103(1) 	Load variable i
627:     ST  3,-106(1) 	Save index 
628:    LDC  3,4(6) 	Load constant 
629:     LD  4,-106(1) 	Restore index 
630:    LDA  5,-3(1) 	Load address of base of array Ocean
631:    SUB  5,5,4 	Compute offset of value 
632:     ST  3,0(5) 	Store variable Ocean
* EXPRESSION STMT
633:     LD  3,-103(1) 	load lhs variable i
634:    LDA  3,1(3) 	increment value of i
635:     ST  3,-103(1) 	Store variable i
* END compound statement
636:    LDA  7,-21(7) 	go to beginning of loop 
625:    LDA  7,11(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
637:     ST  1,-106(1) 	Store old fp in ghost frame 
638:    LDA  3,-3(1) 	Load address of base of array Ocean
639:     ST  3,-108(1) 	Store parameter 
640:    LDC  3,10(6) 	Load constant 
641:     ST  3,-109(1) 	Store parameter 
642:    LDA  1,-106(1) 	Load address of new frame 
643:    LDA  3,1(7) 	Return address in ac 
644:    LDA  7,-428(7) 	CALL HideShip
645:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
646:    LDC  3,0(6) 	Load constant 
647:     ST  3,-105(1) 	Store variable bGotit
* EXPRESSION STMT
648:    LDC  3,10(6) 	Load constant 
649:     ST  3,-1(0) 	Store variable NumShots
* EXPRESSION STMT
650:    LDC  3,0(6) 	Load constant 
651:     ST  3,-2(0) 	Store variable NumHits
* WHILE
652:     LD  3,-1(0) 	Load variable NumShots
653:     ST  3,-106(1) 	Save left side 
654:    LDC  3,0(6) 	Load constant 
655:     LD  4,-106(1) 	Load left into ac1 
656:    SUB  4,4,3 	Op > 
657:    LDC  3,1(6) 	True case 
658:    JGT  4,1(7) 	Jump if true 
659:    LDC  3,0(6) 	False case 
660:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
662:     ST  1,-106(1) 	Store old fp in ghost frame 
663:    LDA  3,-3(1) 	Load address of base of array Ocean
664:     ST  3,-108(1) 	Store parameter 
665:    LDC  3,10(6) 	Load constant 
666:     ST  3,-109(1) 	Store parameter 
667:    LDA  1,-106(1) 	Load address of new frame 
668:    LDA  3,1(7) 	Return address in ac 
669:    LDA  7,-618(7) 	CALL Display
670:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
671:     ST  1,-106(1) 	Store old fp in ghost frame 
672:    LDA  1,-106(1) 	Load address of new frame 
673:    LDA  3,1(7) 	Return address in ac 
674:    LDA  7,-306(7) 	CALL Aim
675:    LDA  3,0(2) 	Save the result in ac 
676:     ST  3,-104(1) 	Store variable Shot
* IF
677:     ST  1,-106(1) 	Store old fp in ghost frame 
678:    LDA  3,-3(1) 	Load address of base of array Ocean
679:     ST  3,-108(1) 	Store parameter 
680:     LD  3,-104(1) 	Load variable Shot
681:     ST  3,-109(1) 	Store parameter 
682:    LDA  1,-106(1) 	Load address of new frame 
683:    LDA  3,1(7) 	Return address in ac 
684:    LDA  7,-133(7) 	CALL Fire
685:    LDA  3,0(2) 	Save the result in ac 
686:     ST  3,-106(1) 	Save left side 
687:     LD  3,0(0) 	Load variable shipsize
688:     LD  4,-106(1) 	Load left into ac1 
689:    SUB  4,4,3 	Op == 
690:    LDC  3,1(6) 	True case 
691:    JEQ  4,1(7) 	Jump if true 
692:    LDC  3,0(6) 	False case 
693:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
695:    LDC  3,1(6) 	Load constant 
696:     ST  3,-105(1) 	Store variable bGotit
* BREAK
697:    LDA  7,-37(7) 	break 
* END compound statement
694:    LDA  7,3(7) 	Jump around the THEN 
* ENDIF
* EXPRESSION STMT
698:    LDC  3,1(6) 	Load constant 
699:     LD  4,-1(0) 	load lhs variable NumShots
700:    SUB  3,4,3 	op -= 
701:     ST  3,-1(0) 	Store variable NumShots
* END compound statement
702:    LDA  7,-51(7) 	go to beginning of loop 
661:    LDA  7,41(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
703:     ST  1,-106(1) 	Store old fp in ghost frame 
704:    LDA  1,-106(1) 	Load address of new frame 
705:    LDA  3,1(7) 	Return address in ac 
706:    LDA  7,-665(7) 	CALL NewLine
707:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
708:     ST  1,-106(1) 	Store old fp in ghost frame 
709:    LDA  1,-106(1) 	Load address of new frame 
710:    LDA  3,1(7) 	Return address in ac 
711:    LDA  7,-670(7) 	CALL NewLine
712:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
713:    LDC  3,0(6) 	Load constant 
714:     ST  3,-103(1) 	Store variable i
* WHILE
715:     LD  3,-103(1) 	Load variable i
716:     ST  3,-106(1) 	Save left side 
717:    LDC  3,20(6) 	Load constant 
718:     LD  4,-106(1) 	Load left into ac1 
719:    SUB  4,4,3 	Op < 
720:    LDC  3,1(6) 	True case 
721:    JLT  4,1(7) 	Jump if true 
722:    LDC  3,0(6) 	False case 
723:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* IF
725:     LD  3,-105(1) 	Load variable bGotit
726:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
728:     ST  1,-106(1) 	Store old fp in ghost frame 
729:    LDC  3,1(6) 	Load constant 
730:     ST  3,-108(1) 	Store parameter 
731:    LDA  1,-106(1) 	Load address of new frame 
732:    LDA  3,1(7) 	Return address in ac 
733:    LDA  7,-704(7) 	CALL Print
734:    LDA  3,0(2) 	Save the result in ac 
* ELSE
727:    LDA  7,8(7) 	Jump around the THEN 
* EXPRESSION STMT
736:     ST  1,-106(1) 	Store old fp in ghost frame 
737:    LDC  3,0(6) 	Load constant 
738:     ST  3,-108(1) 	Store parameter 
739:    LDA  1,-106(1) 	Load address of new frame 
740:    LDA  3,1(7) 	Return address in ac 
741:    LDA  7,-712(7) 	CALL Print
742:    LDA  3,0(2) 	Save the result in ac 
735:    LDA  7,7(7) 	Jump around the ELSE 
* ENDIF
* EXPRESSION STMT
743:     LD  3,-103(1) 	load lhs variable i
744:    LDA  3,1(3) 	increment value of i
745:     ST  3,-103(1) 	Store variable i
* END compound statement
746:    LDA  7,-32(7) 	go to beginning of loop 
724:    LDA  7,22(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
747:     ST  1,-106(1) 	Store old fp in ghost frame 
748:    LDA  1,-106(1) 	Load address of new frame 
749:    LDA  3,1(7) 	Return address in ac 
750:    LDA  7,-709(7) 	CALL NewLine
751:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
752:     ST  1,-106(1) 	Store old fp in ghost frame 
753:    LDA  3,-3(1) 	Load address of base of array Ocean
754:     ST  3,-108(1) 	Store parameter 
755:    LDC  3,10(6) 	Load constant 
756:     ST  3,-109(1) 	Store parameter 
757:    LDA  1,-106(1) 	Load address of new frame 
758:    LDA  3,1(7) 	Return address in ac 
759:    LDA  7,-310(7) 	CALL RevealShip
760:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
761:    LDC  2,0(6) 	Set return value to 0 
762:     LD  3,-1(1) 	Load return address 
763:     LD  1,0(1) 	Adjust fp 
764:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,764(7) 	Jump to init 
* BEGIN Init
765:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
766:    LDA  1,-4(0) 	set first frame at end of globals 
767:     ST  1,0(1) 	store old fp (point to self) 
768:    LDA  3,1(7) 	Return address in ac 
769:    LDA  7,-161(7) 	Jump to main 
770:   HALT  0,0,0 	DONE! 
* END Init
