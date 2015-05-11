* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  tictactoe.c-
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
* BEGIN function move
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 31:    LDC  3,0(6) 	Load constant 
 32:     ST  3,-2(1) 	Store variable i
* WHILE
 33:     LD  3,-2(1) 	Load variable i
 34:     ST  3,-3(1) 	Save left side 
 35:    LDC  3,9(6) 	Load constant 
 36:     LD  4,-3(1) 	Load left into ac1 
 37:    SUB  4,4,3 	Op < 
 38:    LDC  3,1(6) 	True case 
 39:    JLT  4,1(7) 	Jump if true 
 40:    LDC  3,0(6) 	False case 
 41:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* IF
 43:     LD  3,-2(1) 	Load variable i
 44:    LDA  4,-1(0) 	Load address of base of array board
 45:    SUB  3,4,3 	Compute offset of value 
 46:     LD  3,0(3) 	Load the value 
 47:     ST  3,-3(1) 	Save left side 
 48:    LDC  3,1(6) 	Load constant 
 49:    LDC  4,0(6) 	Load 0 
 50:    SUB  3,4,3 	Op unary - 
 51:     LD  4,-3(1) 	Load left into ac1 
 52:    SUB  4,4,3 	Op == 
 53:    LDC  3,1(6) 	True case 
 54:    JEQ  4,1(7) 	Jump if true 
 55:    LDC  3,0(6) 	False case 
 56:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* BREAK
 58:    LDA  7,-17(7) 	break 
* END compound statement
 57:    LDA  7,1(7) 	Jump around the THEN 
* ENDIF
* EXPRESSION STMT
 59:     LD  3,-2(1) 	load lhs variable i
 60:    LDA  3,1(3) 	increment value of i
 61:     ST  3,-2(1) 	Store variable i
* END compound statement
 62:    LDA  7,-30(7) 	go to beginning of loop 
 42:    LDA  7,20(7) 	No more loop 
* ENDWHILE
* IF
 63:     LD  3,-2(1) 	Load variable i
 64:     ST  3,-3(1) 	Save left side 
 65:    LDC  3,9(6) 	Load constant 
 66:     LD  4,-3(1) 	Load left into ac1 
 67:    SUB  4,4,3 	Op < 
 68:    LDC  3,1(6) 	True case 
 69:    JLT  4,1(7) 	Jump if true 
 70:    LDC  3,0(6) 	False case 
 71:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
 73:     LD  3,-2(1) 	Load variable i
 74:     ST  3,-3(1) 	Save index 
 75:    LDC  3,2(6) 	Load constant 
 76:     LD  4,-3(1) 	Restore index 
 77:    LDA  5,-1(0) 	Load address of base of array board
 78:    SUB  5,5,4 	Compute offset of value 
 79:     ST  3,0(5) 	Store variable board
* EXPRESSION STMT
 80:    LDC  3,1(6) 	Load constant 
 81:     ST  3,-10(0) 	Store variable gamenotdone
* END compound statement
* ELSE
 72:    LDA  7,10(7) 	Jump around the THEN 
* BEGIN compound statement
* EXPRESSION STMT
 83:    LDC  3,0(6) 	Load constant 
 84:     ST  3,-10(0) 	Store variable gamenotdone
* END compound statement
 82:    LDA  7,2(7) 	Jump around the ELSE 
* ENDIF
* END compound statement
* Add standard closing in case there is no return statement
 85:    LDC  2,0(6) 	Set return value to 0 
 86:     LD  3,-1(1) 	Load return address 
 87:     LD  1,0(1) 	Adjust fp 
 88:    LDA  7,0(3) 	Return 
* END of function move
* BEGIN function win
 89:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* IF
 90:    LDC  3,0(6) 	Load constant 
 91:    LDA  4,-1(0) 	Load address of base of array board
 92:    SUB  3,4,3 	Compute offset of value 
 93:     LD  3,0(3) 	Load the value 
 94:     ST  3,-2(1) 	Save left side 
 95:    LDC  3,2(6) 	Load constant 
 96:     LD  4,-2(1) 	Load left into ac1 
 97:    SUB  4,4,3 	Op == 
 98:    LDC  3,1(6) 	True case 
 99:    JEQ  4,1(7) 	Jump if true 
100:    LDC  3,0(6) 	False case 
101:     ST  3,-2(1) 	Save left side 
102:    LDC  3,1(6) 	Load constant 
103:    LDA  4,-1(0) 	Load address of base of array board
104:    SUB  3,4,3 	Compute offset of value 
105:     LD  3,0(3) 	Load the value 
106:     ST  3,-3(1) 	Save left side 
107:    LDC  3,2(6) 	Load constant 
108:     LD  4,-3(1) 	Load left into ac1 
109:    SUB  4,4,3 	Op == 
110:    LDC  3,1(6) 	True case 
111:    JEQ  4,1(7) 	Jump if true 
112:    LDC  3,0(6) 	False case 
113:     LD  4,-2(1) 	Load left into ac1 
114:    JEQ  3,1(7) 	Op AND 
115:    LDA  3,0(4) 	 
116:     ST  3,-2(1) 	Save left side 
117:    LDC  3,6(6) 	Load constant 
118:    LDA  4,-1(0) 	Load address of base of array board
119:    SUB  3,4,3 	Compute offset of value 
120:     LD  3,0(3) 	Load the value 
121:     ST  3,-3(1) 	Save left side 
122:    LDC  3,2(6) 	Load constant 
123:     LD  4,-3(1) 	Load left into ac1 
124:    SUB  4,4,3 	Op == 
125:    LDC  3,1(6) 	True case 
126:    JEQ  4,1(7) 	Jump if true 
127:    LDC  3,0(6) 	False case 
128:     ST  3,-3(1) 	Save left side 
129:    LDC  3,4(6) 	Load constant 
130:    LDA  4,-1(0) 	Load address of base of array board
131:    SUB  3,4,3 	Compute offset of value 
132:     LD  3,0(3) 	Load the value 
133:     ST  3,-4(1) 	Save left side 
134:    LDC  3,2(6) 	Load constant 
135:     LD  4,-4(1) 	Load left into ac1 
136:    SUB  4,4,3 	Op == 
137:    LDC  3,1(6) 	True case 
138:    JEQ  4,1(7) 	Jump if true 
139:    LDC  3,0(6) 	False case 
140:     LD  4,-3(1) 	Load left into ac1 
141:    JEQ  3,1(7) 	Op AND 
142:    LDA  3,0(4) 	 
143:     LD  4,-2(1) 	Load left into ac1 
144:    JGT  3,1(7) 	Op OR 
145:    LDA  3,0(4) 	 
146:     ST  3,-2(1) 	Save left side 
147:    LDC  3,8(6) 	Load constant 
148:    LDA  4,-1(0) 	Load address of base of array board
149:    SUB  3,4,3 	Compute offset of value 
150:     LD  3,0(3) 	Load the value 
151:     ST  3,-3(1) 	Save left side 
152:    LDC  3,2(6) 	Load constant 
153:     LD  4,-3(1) 	Load left into ac1 
154:    SUB  4,4,3 	Op == 
155:    LDC  3,1(6) 	True case 
156:    JEQ  4,1(7) 	Jump if true 
157:    LDC  3,0(6) 	False case 
158:     ST  3,-3(1) 	Save left side 
159:    LDC  3,5(6) 	Load constant 
160:    LDA  4,-1(0) 	Load address of base of array board
161:    SUB  3,4,3 	Compute offset of value 
162:     LD  3,0(3) 	Load the value 
163:     ST  3,-4(1) 	Save left side 
164:    LDC  3,2(6) 	Load constant 
165:     LD  4,-4(1) 	Load left into ac1 
166:    SUB  4,4,3 	Op == 
167:    LDC  3,1(6) 	True case 
168:    JEQ  4,1(7) 	Jump if true 
169:    LDC  3,0(6) 	False case 
170:     LD  4,-3(1) 	Load left into ac1 
171:    JEQ  3,1(7) 	Op AND 
172:    LDA  3,0(4) 	 
173:     LD  4,-2(1) 	Load left into ac1 
174:    JGT  3,1(7) 	Op OR 
175:    LDA  3,0(4) 	 
176:     ST  3,-2(1) 	Save left side 
177:    LDC  3,2(6) 	Load constant 
178:    LDA  4,-1(0) 	Load address of base of array board
179:    SUB  3,4,3 	Compute offset of value 
180:     LD  3,0(3) 	Load the value 
181:     ST  3,-3(1) 	Save left side 
182:    LDC  3,1(6) 	Load constant 
183:    LDC  4,0(6) 	Load 0 
184:    SUB  3,4,3 	Op unary - 
185:     LD  4,-3(1) 	Load left into ac1 
186:    SUB  4,4,3 	Op == 
187:    LDC  3,1(6) 	True case 
188:    JEQ  4,1(7) 	Jump if true 
189:    LDC  3,0(6) 	False case 
190:     LD  4,-2(1) 	Load left into ac1 
191:    JEQ  3,1(7) 	Op AND 
192:    LDA  3,0(4) 	 
193:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
195:    LDC  3,2(6) 	Load constant 
196:     ST  3,-2(1) 	Save index 
197:    LDC  3,2(6) 	Load constant 
198:     LD  4,-2(1) 	Restore index 
199:    LDA  5,-1(0) 	Load address of base of array board
200:    SUB  5,5,4 	Compute offset of value 
201:     ST  3,0(5) 	Store variable board
* EXPRESSION STMT
202:    LDC  3,0(6) 	Load constant 
203:     ST  3,-10(0) 	Store variable gamenotdone
* END compound statement
* ELSE
194:    LDA  7,10(7) 	Jump around the THEN 
* BEGIN compound statement
* IF
205:    LDC  3,0(6) 	Load constant 
206:    LDA  4,-1(0) 	Load address of base of array board
207:    SUB  3,4,3 	Compute offset of value 
208:     LD  3,0(3) 	Load the value 
209:     ST  3,-2(1) 	Save left side 
210:    LDC  3,2(6) 	Load constant 
211:     LD  4,-2(1) 	Load left into ac1 
212:    SUB  4,4,3 	Op == 
213:    LDC  3,1(6) 	True case 
214:    JEQ  4,1(7) 	Jump if true 
215:    LDC  3,0(6) 	False case 
216:     ST  3,-2(1) 	Save left side 
217:    LDC  3,2(6) 	Load constant 
218:    LDA  4,-1(0) 	Load address of base of array board
219:    SUB  3,4,3 	Compute offset of value 
220:     LD  3,0(3) 	Load the value 
221:     ST  3,-3(1) 	Save left side 
222:    LDC  3,2(6) 	Load constant 
223:     LD  4,-3(1) 	Load left into ac1 
224:    SUB  4,4,3 	Op == 
225:    LDC  3,1(6) 	True case 
226:    JEQ  4,1(7) 	Jump if true 
227:    LDC  3,0(6) 	False case 
228:     LD  4,-2(1) 	Load left into ac1 
229:    JEQ  3,1(7) 	Op AND 
230:    LDA  3,0(4) 	 
231:     ST  3,-2(1) 	Save left side 
232:    LDC  3,4(6) 	Load constant 
233:    LDA  4,-1(0) 	Load address of base of array board
234:    SUB  3,4,3 	Compute offset of value 
235:     LD  3,0(3) 	Load the value 
236:     ST  3,-3(1) 	Save left side 
237:    LDC  3,2(6) 	Load constant 
238:     LD  4,-3(1) 	Load left into ac1 
239:    SUB  4,4,3 	Op == 
240:    LDC  3,1(6) 	True case 
241:    JEQ  4,1(7) 	Jump if true 
242:    LDC  3,0(6) 	False case 
243:     ST  3,-3(1) 	Save left side 
244:    LDC  3,7(6) 	Load constant 
245:    LDA  4,-1(0) 	Load address of base of array board
246:    SUB  3,4,3 	Compute offset of value 
247:     LD  3,0(3) 	Load the value 
248:     ST  3,-4(1) 	Save left side 
249:    LDC  3,2(6) 	Load constant 
250:     LD  4,-4(1) 	Load left into ac1 
251:    SUB  4,4,3 	Op == 
252:    LDC  3,1(6) 	True case 
253:    JEQ  4,1(7) 	Jump if true 
254:    LDC  3,0(6) 	False case 
255:     LD  4,-3(1) 	Load left into ac1 
256:    JEQ  3,1(7) 	Op AND 
257:    LDA  3,0(4) 	 
258:     LD  4,-2(1) 	Load left into ac1 
259:    JGT  3,1(7) 	Op OR 
260:    LDA  3,0(4) 	 
261:     ST  3,-2(1) 	Save left side 
262:    LDC  3,1(6) 	Load constant 
263:    LDA  4,-1(0) 	Load address of base of array board
264:    SUB  3,4,3 	Compute offset of value 
265:     LD  3,0(3) 	Load the value 
266:     ST  3,-3(1) 	Save left side 
267:    LDC  3,1(6) 	Load constant 
268:    LDC  4,0(6) 	Load 0 
269:    SUB  3,4,3 	Op unary - 
270:     LD  4,-3(1) 	Load left into ac1 
271:    SUB  4,4,3 	Op == 
272:    LDC  3,1(6) 	True case 
273:    JEQ  4,1(7) 	Jump if true 
274:    LDC  3,0(6) 	False case 
275:     LD  4,-2(1) 	Load left into ac1 
276:    JEQ  3,1(7) 	Op AND 
277:    LDA  3,0(4) 	 
278:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
280:    LDC  3,1(6) 	Load constant 
281:     ST  3,-2(1) 	Save index 
282:    LDC  3,2(6) 	Load constant 
283:     LD  4,-2(1) 	Restore index 
284:    LDA  5,-1(0) 	Load address of base of array board
285:    SUB  5,5,4 	Compute offset of value 
286:     ST  3,0(5) 	Store variable board
* EXPRESSION STMT
287:    LDC  3,0(6) 	Load constant 
288:     ST  3,-10(0) 	Store variable gamenotdone
* END compound statement
* ELSE
279:    LDA  7,10(7) 	Jump around the THEN 
* BEGIN compound statement
* IF
290:    LDC  3,2(6) 	Load constant 
291:    LDA  4,-1(0) 	Load address of base of array board
292:    SUB  3,4,3 	Compute offset of value 
293:     LD  3,0(3) 	Load the value 
294:     ST  3,-2(1) 	Save left side 
295:    LDC  3,2(6) 	Load constant 
296:     LD  4,-2(1) 	Load left into ac1 
297:    SUB  4,4,3 	Op == 
298:    LDC  3,1(6) 	True case 
299:    JEQ  4,1(7) 	Jump if true 
300:    LDC  3,0(6) 	False case 
301:     ST  3,-2(1) 	Save left side 
302:    LDC  3,1(6) 	Load constant 
303:    LDA  4,-1(0) 	Load address of base of array board
304:    SUB  3,4,3 	Compute offset of value 
305:     LD  3,0(3) 	Load the value 
306:     ST  3,-3(1) 	Save left side 
307:    LDC  3,2(6) 	Load constant 
308:     LD  4,-3(1) 	Load left into ac1 
309:    SUB  4,4,3 	Op == 
310:    LDC  3,1(6) 	True case 
311:    JEQ  4,1(7) 	Jump if true 
312:    LDC  3,0(6) 	False case 
313:     LD  4,-2(1) 	Load left into ac1 
314:    JEQ  3,1(7) 	Op AND 
315:    LDA  3,0(4) 	 
316:     ST  3,-2(1) 	Save left side 
317:    LDC  3,6(6) 	Load constant 
318:    LDA  4,-1(0) 	Load address of base of array board
319:    SUB  3,4,3 	Compute offset of value 
320:     LD  3,0(3) 	Load the value 
321:     ST  3,-3(1) 	Save left side 
322:    LDC  3,2(6) 	Load constant 
323:     LD  4,-3(1) 	Load left into ac1 
324:    SUB  4,4,3 	Op == 
325:    LDC  3,1(6) 	True case 
326:    JEQ  4,1(7) 	Jump if true 
327:    LDC  3,0(6) 	False case 
328:     ST  3,-3(1) 	Save left side 
329:    LDC  3,3(6) 	Load constant 
330:    LDA  4,-1(0) 	Load address of base of array board
331:    SUB  3,4,3 	Compute offset of value 
332:     LD  3,0(3) 	Load the value 
333:     ST  3,-4(1) 	Save left side 
334:    LDC  3,2(6) 	Load constant 
335:     LD  4,-4(1) 	Load left into ac1 
336:    SUB  4,4,3 	Op == 
337:    LDC  3,1(6) 	True case 
338:    JEQ  4,1(7) 	Jump if true 
339:    LDC  3,0(6) 	False case 
340:     LD  4,-3(1) 	Load left into ac1 
341:    JEQ  3,1(7) 	Op AND 
342:    LDA  3,0(4) 	 
343:     LD  4,-2(1) 	Load left into ac1 
344:    JGT  3,1(7) 	Op OR 
345:    LDA  3,0(4) 	 
346:     ST  3,-2(1) 	Save left side 
347:    LDC  3,4(6) 	Load constant 
348:    LDA  4,-1(0) 	Load address of base of array board
349:    SUB  3,4,3 	Compute offset of value 
350:     LD  3,0(3) 	Load the value 
351:     ST  3,-3(1) 	Save left side 
352:    LDC  3,2(6) 	Load constant 
353:     LD  4,-3(1) 	Load left into ac1 
354:    SUB  4,4,3 	Op == 
355:    LDC  3,1(6) 	True case 
356:    JEQ  4,1(7) 	Jump if true 
357:    LDC  3,0(6) 	False case 
358:     ST  3,-3(1) 	Save left side 
359:    LDC  3,8(6) 	Load constant 
360:    LDA  4,-1(0) 	Load address of base of array board
361:    SUB  3,4,3 	Compute offset of value 
362:     LD  3,0(3) 	Load the value 
363:     ST  3,-4(1) 	Save left side 
364:    LDC  3,2(6) 	Load constant 
365:     LD  4,-4(1) 	Load left into ac1 
366:    SUB  4,4,3 	Op == 
367:    LDC  3,1(6) 	True case 
368:    JEQ  4,1(7) 	Jump if true 
369:    LDC  3,0(6) 	False case 
370:     LD  4,-3(1) 	Load left into ac1 
371:    JEQ  3,1(7) 	Op AND 
372:    LDA  3,0(4) 	 
373:     LD  4,-2(1) 	Load left into ac1 
374:    JGT  3,1(7) 	Op OR 
375:    LDA  3,0(4) 	 
376:     ST  3,-2(1) 	Save left side 
377:    LDC  3,0(6) 	Load constant 
378:    LDA  4,-1(0) 	Load address of base of array board
379:    SUB  3,4,3 	Compute offset of value 
380:     LD  3,0(3) 	Load the value 
381:     ST  3,-3(1) 	Save left side 
382:    LDC  3,1(6) 	Load constant 
383:    LDC  4,0(6) 	Load 0 
384:    SUB  3,4,3 	Op unary - 
385:     LD  4,-3(1) 	Load left into ac1 
386:    SUB  4,4,3 	Op == 
387:    LDC  3,1(6) 	True case 
388:    JEQ  4,1(7) 	Jump if true 
389:    LDC  3,0(6) 	False case 
390:     LD  4,-2(1) 	Load left into ac1 
391:    JEQ  3,1(7) 	Op AND 
392:    LDA  3,0(4) 	 
393:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
395:    LDC  3,0(6) 	Load constant 
396:     ST  3,-2(1) 	Save index 
397:    LDC  3,2(6) 	Load constant 
398:     LD  4,-2(1) 	Restore index 
399:    LDA  5,-1(0) 	Load address of base of array board
400:    SUB  5,5,4 	Compute offset of value 
401:     ST  3,0(5) 	Store variable board
* EXPRESSION STMT
402:    LDC  3,0(6) 	Load constant 
403:     ST  3,-10(0) 	Store variable gamenotdone
* END compound statement
* ELSE
394:    LDA  7,10(7) 	Jump around the THEN 
* BEGIN compound statement
* IF
405:    LDC  3,3(6) 	Load constant 
406:    LDA  4,-1(0) 	Load address of base of array board
407:    SUB  3,4,3 	Compute offset of value 
408:     LD  3,0(3) 	Load the value 
409:     ST  3,-2(1) 	Save left side 
410:    LDC  3,2(6) 	Load constant 
411:     LD  4,-2(1) 	Load left into ac1 
412:    SUB  4,4,3 	Op == 
413:    LDC  3,1(6) 	True case 
414:    JEQ  4,1(7) 	Jump if true 
415:    LDC  3,0(6) 	False case 
416:     ST  3,-2(1) 	Save left side 
417:    LDC  3,4(6) 	Load constant 
418:    LDA  4,-1(0) 	Load address of base of array board
419:    SUB  3,4,3 	Compute offset of value 
420:     LD  3,0(3) 	Load the value 
421:     ST  3,-3(1) 	Save left side 
422:    LDC  3,2(6) 	Load constant 
423:     LD  4,-3(1) 	Load left into ac1 
424:    SUB  4,4,3 	Op == 
425:    LDC  3,1(6) 	True case 
426:    JEQ  4,1(7) 	Jump if true 
427:    LDC  3,0(6) 	False case 
428:     LD  4,-2(1) 	Load left into ac1 
429:    JEQ  3,1(7) 	Op AND 
430:    LDA  3,0(4) 	 
431:     ST  3,-2(1) 	Save left side 
432:    LDC  3,2(6) 	Load constant 
433:    LDA  4,-1(0) 	Load address of base of array board
434:    SUB  3,4,3 	Compute offset of value 
435:     LD  3,0(3) 	Load the value 
436:     ST  3,-3(1) 	Save left side 
437:    LDC  3,2(6) 	Load constant 
438:     LD  4,-3(1) 	Load left into ac1 
439:    SUB  4,4,3 	Op == 
440:    LDC  3,1(6) 	True case 
441:    JEQ  4,1(7) 	Jump if true 
442:    LDC  3,0(6) 	False case 
443:     ST  3,-3(1) 	Save left side 
444:    LDC  3,8(6) 	Load constant 
445:    LDA  4,-1(0) 	Load address of base of array board
446:    SUB  3,4,3 	Compute offset of value 
447:     LD  3,0(3) 	Load the value 
448:     ST  3,-4(1) 	Save left side 
449:    LDC  3,2(6) 	Load constant 
450:     LD  4,-4(1) 	Load left into ac1 
451:    SUB  4,4,3 	Op == 
452:    LDC  3,1(6) 	True case 
453:    JEQ  4,1(7) 	Jump if true 
454:    LDC  3,0(6) 	False case 
455:     LD  4,-3(1) 	Load left into ac1 
456:    JEQ  3,1(7) 	Op AND 
457:    LDA  3,0(4) 	 
458:     LD  4,-2(1) 	Load left into ac1 
459:    JGT  3,1(7) 	Op OR 
460:    LDA  3,0(4) 	 
461:     ST  3,-2(1) 	Save left side 
462:    LDC  3,5(6) 	Load constant 
463:    LDA  4,-1(0) 	Load address of base of array board
464:    SUB  3,4,3 	Compute offset of value 
465:     LD  3,0(3) 	Load the value 
466:     ST  3,-3(1) 	Save left side 
467:    LDC  3,1(6) 	Load constant 
468:    LDC  4,0(6) 	Load 0 
469:    SUB  3,4,3 	Op unary - 
470:     LD  4,-3(1) 	Load left into ac1 
471:    SUB  4,4,3 	Op == 
472:    LDC  3,1(6) 	True case 
473:    JEQ  4,1(7) 	Jump if true 
474:    LDC  3,0(6) 	False case 
475:     LD  4,-2(1) 	Load left into ac1 
476:    JEQ  3,1(7) 	Op AND 
477:    LDA  3,0(4) 	 
478:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
480:    LDC  3,5(6) 	Load constant 
481:     ST  3,-2(1) 	Save index 
482:    LDC  3,2(6) 	Load constant 
483:     LD  4,-2(1) 	Restore index 
484:    LDA  5,-1(0) 	Load address of base of array board
485:    SUB  5,5,4 	Compute offset of value 
486:     ST  3,0(5) 	Store variable board
* EXPRESSION STMT
487:    LDC  3,0(6) 	Load constant 
488:     ST  3,-10(0) 	Store variable gamenotdone
* END compound statement
* ELSE
479:    LDA  7,10(7) 	Jump around the THEN 
* BEGIN compound statement
* IF
490:    LDC  3,3(6) 	Load constant 
491:    LDA  4,-1(0) 	Load address of base of array board
492:    SUB  3,4,3 	Compute offset of value 
493:     LD  3,0(3) 	Load the value 
494:     ST  3,-2(1) 	Save left side 
495:    LDC  3,2(6) 	Load constant 
496:     LD  4,-2(1) 	Load left into ac1 
497:    SUB  4,4,3 	Op == 
498:    LDC  3,1(6) 	True case 
499:    JEQ  4,1(7) 	Jump if true 
500:    LDC  3,0(6) 	False case 
501:     ST  3,-2(1) 	Save left side 
502:    LDC  3,5(6) 	Load constant 
503:    LDA  4,-1(0) 	Load address of base of array board
504:    SUB  3,4,3 	Compute offset of value 
505:     LD  3,0(3) 	Load the value 
506:     ST  3,-3(1) 	Save left side 
507:    LDC  3,2(6) 	Load constant 
508:     LD  4,-3(1) 	Load left into ac1 
509:    SUB  4,4,3 	Op == 
510:    LDC  3,1(6) 	True case 
511:    JEQ  4,1(7) 	Jump if true 
512:    LDC  3,0(6) 	False case 
513:     LD  4,-2(1) 	Load left into ac1 
514:    JEQ  3,1(7) 	Op AND 
515:    LDA  3,0(4) 	 
516:     ST  3,-2(1) 	Save left side 
517:    LDC  3,0(6) 	Load constant 
518:    LDA  4,-1(0) 	Load address of base of array board
519:    SUB  3,4,3 	Compute offset of value 
520:     LD  3,0(3) 	Load the value 
521:     ST  3,-3(1) 	Save left side 
522:    LDC  3,2(6) 	Load constant 
523:     LD  4,-3(1) 	Load left into ac1 
524:    SUB  4,4,3 	Op == 
525:    LDC  3,1(6) 	True case 
526:    JEQ  4,1(7) 	Jump if true 
527:    LDC  3,0(6) 	False case 
528:     ST  3,-3(1) 	Save left side 
529:    LDC  3,8(6) 	Load constant 
530:    LDA  4,-1(0) 	Load address of base of array board
531:    SUB  3,4,3 	Compute offset of value 
532:     LD  3,0(3) 	Load the value 
533:     ST  3,-4(1) 	Save left side 
534:    LDC  3,2(6) 	Load constant 
535:     LD  4,-4(1) 	Load left into ac1 
536:    SUB  4,4,3 	Op == 
537:    LDC  3,1(6) 	True case 
538:    JEQ  4,1(7) 	Jump if true 
539:    LDC  3,0(6) 	False case 
540:     LD  4,-3(1) 	Load left into ac1 
541:    JEQ  3,1(7) 	Op AND 
542:    LDA  3,0(4) 	 
543:     LD  4,-2(1) 	Load left into ac1 
544:    JGT  3,1(7) 	Op OR 
545:    LDA  3,0(4) 	 
546:     ST  3,-2(1) 	Save left side 
547:    LDC  3,2(6) 	Load constant 
548:    LDA  4,-1(0) 	Load address of base of array board
549:    SUB  3,4,3 	Compute offset of value 
550:     LD  3,0(3) 	Load the value 
551:     ST  3,-3(1) 	Save left side 
552:    LDC  3,2(6) 	Load constant 
553:     LD  4,-3(1) 	Load left into ac1 
554:    SUB  4,4,3 	Op == 
555:    LDC  3,1(6) 	True case 
556:    JEQ  4,1(7) 	Jump if true 
557:    LDC  3,0(6) 	False case 
558:     ST  3,-3(1) 	Save left side 
559:    LDC  3,6(6) 	Load constant 
560:    LDA  4,-1(0) 	Load address of base of array board
561:    SUB  3,4,3 	Compute offset of value 
562:     LD  3,0(3) 	Load the value 
563:     ST  3,-4(1) 	Save left side 
564:    LDC  3,2(6) 	Load constant 
565:     LD  4,-4(1) 	Load left into ac1 
566:    SUB  4,4,3 	Op == 
567:    LDC  3,1(6) 	True case 
568:    JEQ  4,1(7) 	Jump if true 
569:    LDC  3,0(6) 	False case 
570:     LD  4,-3(1) 	Load left into ac1 
571:    JEQ  3,1(7) 	Op AND 
572:    LDA  3,0(4) 	 
573:     LD  4,-2(1) 	Load left into ac1 
574:    JGT  3,1(7) 	Op OR 
575:    LDA  3,0(4) 	 
576:     ST  3,-2(1) 	Save left side 
577:    LDC  3,1(6) 	Load constant 
578:    LDA  4,-1(0) 	Load address of base of array board
579:    SUB  3,4,3 	Compute offset of value 
580:     LD  3,0(3) 	Load the value 
581:     ST  3,-3(1) 	Save left side 
582:    LDC  3,2(6) 	Load constant 
583:     LD  4,-3(1) 	Load left into ac1 
584:    SUB  4,4,3 	Op == 
585:    LDC  3,1(6) 	True case 
586:    JEQ  4,1(7) 	Jump if true 
587:    LDC  3,0(6) 	False case 
588:     ST  3,-3(1) 	Save left side 
589:    LDC  3,7(6) 	Load constant 
590:    LDA  4,-1(0) 	Load address of base of array board
591:    SUB  3,4,3 	Compute offset of value 
592:     LD  3,0(3) 	Load the value 
593:     ST  3,-4(1) 	Save left side 
594:    LDC  3,2(6) 	Load constant 
595:     LD  4,-4(1) 	Load left into ac1 
596:    SUB  4,4,3 	Op == 
597:    LDC  3,1(6) 	True case 
598:    JEQ  4,1(7) 	Jump if true 
599:    LDC  3,0(6) 	False case 
600:     LD  4,-3(1) 	Load left into ac1 
601:    JEQ  3,1(7) 	Op AND 
602:    LDA  3,0(4) 	 
603:     LD  4,-2(1) 	Load left into ac1 
604:    JGT  3,1(7) 	Op OR 
605:    LDA  3,0(4) 	 
606:     ST  3,-2(1) 	Save left side 
607:    LDC  3,4(6) 	Load constant 
608:    LDA  4,-1(0) 	Load address of base of array board
609:    SUB  3,4,3 	Compute offset of value 
610:     LD  3,0(3) 	Load the value 
611:     ST  3,-3(1) 	Save left side 
612:    LDC  3,1(6) 	Load constant 
613:    LDC  4,0(6) 	Load 0 
614:    SUB  3,4,3 	Op unary - 
615:     LD  4,-3(1) 	Load left into ac1 
616:    SUB  4,4,3 	Op == 
617:    LDC  3,1(6) 	True case 
618:    JEQ  4,1(7) 	Jump if true 
619:    LDC  3,0(6) 	False case 
620:     LD  4,-2(1) 	Load left into ac1 
621:    JEQ  3,1(7) 	Op AND 
622:    LDA  3,0(4) 	 
623:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
625:    LDC  3,4(6) 	Load constant 
626:     ST  3,-2(1) 	Save index 
627:    LDC  3,2(6) 	Load constant 
628:     LD  4,-2(1) 	Restore index 
629:    LDA  5,-1(0) 	Load address of base of array board
630:    SUB  5,5,4 	Compute offset of value 
631:     ST  3,0(5) 	Store variable board
* EXPRESSION STMT
632:    LDC  3,0(6) 	Load constant 
633:     ST  3,-10(0) 	Store variable gamenotdone
* END compound statement
* ELSE
624:    LDA  7,10(7) 	Jump around the THEN 
* BEGIN compound statement
* IF
635:    LDC  3,4(6) 	Load constant 
636:    LDA  4,-1(0) 	Load address of base of array board
637:    SUB  3,4,3 	Compute offset of value 
638:     LD  3,0(3) 	Load the value 
639:     ST  3,-2(1) 	Save left side 
640:    LDC  3,2(6) 	Load constant 
641:     LD  4,-2(1) 	Load left into ac1 
642:    SUB  4,4,3 	Op == 
643:    LDC  3,1(6) 	True case 
644:    JEQ  4,1(7) 	Jump if true 
645:    LDC  3,0(6) 	False case 
646:     ST  3,-2(1) 	Save left side 
647:    LDC  3,5(6) 	Load constant 
648:    LDA  4,-1(0) 	Load address of base of array board
649:    SUB  3,4,3 	Compute offset of value 
650:     LD  3,0(3) 	Load the value 
651:     ST  3,-3(1) 	Save left side 
652:    LDC  3,2(6) 	Load constant 
653:     LD  4,-3(1) 	Load left into ac1 
654:    SUB  4,4,3 	Op == 
655:    LDC  3,1(6) 	True case 
656:    JEQ  4,1(7) 	Jump if true 
657:    LDC  3,0(6) 	False case 
658:     LD  4,-2(1) 	Load left into ac1 
659:    JEQ  3,1(7) 	Op AND 
660:    LDA  3,0(4) 	 
661:     ST  3,-2(1) 	Save left side 
662:    LDC  3,0(6) 	Load constant 
663:    LDA  4,-1(0) 	Load address of base of array board
664:    SUB  3,4,3 	Compute offset of value 
665:     LD  3,0(3) 	Load the value 
666:     ST  3,-3(1) 	Save left side 
667:    LDC  3,2(6) 	Load constant 
668:     LD  4,-3(1) 	Load left into ac1 
669:    SUB  4,4,3 	Op == 
670:    LDC  3,1(6) 	True case 
671:    JEQ  4,1(7) 	Jump if true 
672:    LDC  3,0(6) 	False case 
673:     ST  3,-3(1) 	Save left side 
674:    LDC  3,6(6) 	Load constant 
675:    LDA  4,-1(0) 	Load address of base of array board
676:    SUB  3,4,3 	Compute offset of value 
677:     LD  3,0(3) 	Load the value 
678:     ST  3,-4(1) 	Save left side 
679:    LDC  3,2(6) 	Load constant 
680:     LD  4,-4(1) 	Load left into ac1 
681:    SUB  4,4,3 	Op == 
682:    LDC  3,1(6) 	True case 
683:    JEQ  4,1(7) 	Jump if true 
684:    LDC  3,0(6) 	False case 
685:     LD  4,-3(1) 	Load left into ac1 
686:    JEQ  3,1(7) 	Op AND 
687:    LDA  3,0(4) 	 
688:     LD  4,-2(1) 	Load left into ac1 
689:    JGT  3,1(7) 	Op OR 
690:    LDA  3,0(4) 	 
691:     ST  3,-2(1) 	Save left side 
692:    LDC  3,3(6) 	Load constant 
693:    LDA  4,-1(0) 	Load address of base of array board
694:    SUB  3,4,3 	Compute offset of value 
695:     LD  3,0(3) 	Load the value 
696:     ST  3,-3(1) 	Save left side 
697:    LDC  3,1(6) 	Load constant 
698:    LDC  4,0(6) 	Load 0 
699:    SUB  3,4,3 	Op unary - 
700:     LD  4,-3(1) 	Load left into ac1 
701:    SUB  4,4,3 	Op == 
702:    LDC  3,1(6) 	True case 
703:    JEQ  4,1(7) 	Jump if true 
704:    LDC  3,0(6) 	False case 
705:     LD  4,-2(1) 	Load left into ac1 
706:    JEQ  3,1(7) 	Op AND 
707:    LDA  3,0(4) 	 
708:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
710:    LDC  3,3(6) 	Load constant 
711:     ST  3,-2(1) 	Save index 
712:    LDC  3,2(6) 	Load constant 
713:     LD  4,-2(1) 	Restore index 
714:    LDA  5,-1(0) 	Load address of base of array board
715:    SUB  5,5,4 	Compute offset of value 
716:     ST  3,0(5) 	Store variable board
* EXPRESSION STMT
717:    LDC  3,0(6) 	Load constant 
718:     ST  3,-10(0) 	Store variable gamenotdone
* END compound statement
* ELSE
709:    LDA  7,10(7) 	Jump around the THEN 
* BEGIN compound statement
* IF
720:    LDC  3,6(6) 	Load constant 
721:    LDA  4,-1(0) 	Load address of base of array board
722:    SUB  3,4,3 	Compute offset of value 
723:     LD  3,0(3) 	Load the value 
724:     ST  3,-2(1) 	Save left side 
725:    LDC  3,2(6) 	Load constant 
726:     LD  4,-2(1) 	Load left into ac1 
727:    SUB  4,4,3 	Op == 
728:    LDC  3,1(6) 	True case 
729:    JEQ  4,1(7) 	Jump if true 
730:    LDC  3,0(6) 	False case 
731:     ST  3,-2(1) 	Save left side 
732:    LDC  3,7(6) 	Load constant 
733:    LDA  4,-1(0) 	Load address of base of array board
734:    SUB  3,4,3 	Compute offset of value 
735:     LD  3,0(3) 	Load the value 
736:     ST  3,-3(1) 	Save left side 
737:    LDC  3,2(6) 	Load constant 
738:     LD  4,-3(1) 	Load left into ac1 
739:    SUB  4,4,3 	Op == 
740:    LDC  3,1(6) 	True case 
741:    JEQ  4,1(7) 	Jump if true 
742:    LDC  3,0(6) 	False case 
743:     LD  4,-2(1) 	Load left into ac1 
744:    JEQ  3,1(7) 	Op AND 
745:    LDA  3,0(4) 	 
746:     ST  3,-2(1) 	Save left side 
747:    LDC  3,0(6) 	Load constant 
748:    LDA  4,-1(0) 	Load address of base of array board
749:    SUB  3,4,3 	Compute offset of value 
750:     LD  3,0(3) 	Load the value 
751:     ST  3,-3(1) 	Save left side 
752:    LDC  3,2(6) 	Load constant 
753:     LD  4,-3(1) 	Load left into ac1 
754:    SUB  4,4,3 	Op == 
755:    LDC  3,1(6) 	True case 
756:    JEQ  4,1(7) 	Jump if true 
757:    LDC  3,0(6) 	False case 
758:     ST  3,-3(1) 	Save left side 
759:    LDC  3,4(6) 	Load constant 
760:    LDA  4,-1(0) 	Load address of base of array board
761:    SUB  3,4,3 	Compute offset of value 
762:     LD  3,0(3) 	Load the value 
763:     ST  3,-4(1) 	Save left side 
764:    LDC  3,2(6) 	Load constant 
765:     LD  4,-4(1) 	Load left into ac1 
766:    SUB  4,4,3 	Op == 
767:    LDC  3,1(6) 	True case 
768:    JEQ  4,1(7) 	Jump if true 
769:    LDC  3,0(6) 	False case 
770:     LD  4,-3(1) 	Load left into ac1 
771:    JEQ  3,1(7) 	Op AND 
772:    LDA  3,0(4) 	 
773:     LD  4,-2(1) 	Load left into ac1 
774:    JGT  3,1(7) 	Op OR 
775:    LDA  3,0(4) 	 
776:     ST  3,-2(1) 	Save left side 
777:    LDC  3,2(6) 	Load constant 
778:    LDA  4,-1(0) 	Load address of base of array board
779:    SUB  3,4,3 	Compute offset of value 
780:     LD  3,0(3) 	Load the value 
781:     ST  3,-3(1) 	Save left side 
782:    LDC  3,2(6) 	Load constant 
783:     LD  4,-3(1) 	Load left into ac1 
784:    SUB  4,4,3 	Op == 
785:    LDC  3,1(6) 	True case 
786:    JEQ  4,1(7) 	Jump if true 
787:    LDC  3,0(6) 	False case 
788:     ST  3,-3(1) 	Save left side 
789:    LDC  3,5(6) 	Load constant 
790:    LDA  4,-1(0) 	Load address of base of array board
791:    SUB  3,4,3 	Compute offset of value 
792:     LD  3,0(3) 	Load the value 
793:     ST  3,-4(1) 	Save left side 
794:    LDC  3,2(6) 	Load constant 
795:     LD  4,-4(1) 	Load left into ac1 
796:    SUB  4,4,3 	Op == 
797:    LDC  3,1(6) 	True case 
798:    JEQ  4,1(7) 	Jump if true 
799:    LDC  3,0(6) 	False case 
800:     LD  4,-3(1) 	Load left into ac1 
801:    JEQ  3,1(7) 	Op AND 
802:    LDA  3,0(4) 	 
803:     LD  4,-2(1) 	Load left into ac1 
804:    JGT  3,1(7) 	Op OR 
805:    LDA  3,0(4) 	 
806:     ST  3,-2(1) 	Save left side 
807:    LDC  3,8(6) 	Load constant 
808:    LDA  4,-1(0) 	Load address of base of array board
809:    SUB  3,4,3 	Compute offset of value 
810:     LD  3,0(3) 	Load the value 
811:     ST  3,-3(1) 	Save left side 
812:    LDC  3,1(6) 	Load constant 
813:    LDC  4,0(6) 	Load 0 
814:    SUB  3,4,3 	Op unary - 
815:     LD  4,-3(1) 	Load left into ac1 
816:    SUB  4,4,3 	Op == 
817:    LDC  3,1(6) 	True case 
818:    JEQ  4,1(7) 	Jump if true 
819:    LDC  3,0(6) 	False case 
820:     LD  4,-2(1) 	Load left into ac1 
821:    JEQ  3,1(7) 	Op AND 
822:    LDA  3,0(4) 	 
823:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
825:    LDC  3,8(6) 	Load constant 
826:     ST  3,-2(1) 	Save index 
827:    LDC  3,2(6) 	Load constant 
828:     LD  4,-2(1) 	Restore index 
829:    LDA  5,-1(0) 	Load address of base of array board
830:    SUB  5,5,4 	Compute offset of value 
831:     ST  3,0(5) 	Store variable board
* EXPRESSION STMT
832:    LDC  3,0(6) 	Load constant 
833:     ST  3,-10(0) 	Store variable gamenotdone
* END compound statement
* ELSE
824:    LDA  7,10(7) 	Jump around the THEN 
* BEGIN compound statement
* IF
835:    LDC  3,6(6) 	Load constant 
836:    LDA  4,-1(0) 	Load address of base of array board
837:    SUB  3,4,3 	Compute offset of value 
838:     LD  3,0(3) 	Load the value 
839:     ST  3,-2(1) 	Save left side 
840:    LDC  3,2(6) 	Load constant 
841:     LD  4,-2(1) 	Load left into ac1 
842:    SUB  4,4,3 	Op == 
843:    LDC  3,1(6) 	True case 
844:    JEQ  4,1(7) 	Jump if true 
845:    LDC  3,0(6) 	False case 
846:     ST  3,-2(1) 	Save left side 
847:    LDC  3,8(6) 	Load constant 
848:    LDA  4,-1(0) 	Load address of base of array board
849:    SUB  3,4,3 	Compute offset of value 
850:     LD  3,0(3) 	Load the value 
851:     ST  3,-3(1) 	Save left side 
852:    LDC  3,2(6) 	Load constant 
853:     LD  4,-3(1) 	Load left into ac1 
854:    SUB  4,4,3 	Op == 
855:    LDC  3,1(6) 	True case 
856:    JEQ  4,1(7) 	Jump if true 
857:    LDC  3,0(6) 	False case 
858:     LD  4,-2(1) 	Load left into ac1 
859:    JEQ  3,1(7) 	Op AND 
860:    LDA  3,0(4) 	 
861:     ST  3,-2(1) 	Save left side 
862:    LDC  3,4(6) 	Load constant 
863:    LDA  4,-1(0) 	Load address of base of array board
864:    SUB  3,4,3 	Compute offset of value 
865:     LD  3,0(3) 	Load the value 
866:     ST  3,-3(1) 	Save left side 
867:    LDC  3,2(6) 	Load constant 
868:     LD  4,-3(1) 	Load left into ac1 
869:    SUB  4,4,3 	Op == 
870:    LDC  3,1(6) 	True case 
871:    JEQ  4,1(7) 	Jump if true 
872:    LDC  3,0(6) 	False case 
873:     ST  3,-3(1) 	Save left side 
874:    LDC  3,1(6) 	Load constant 
875:    LDA  4,-1(0) 	Load address of base of array board
876:    SUB  3,4,3 	Compute offset of value 
877:     LD  3,0(3) 	Load the value 
878:     ST  3,-4(1) 	Save left side 
879:    LDC  3,2(6) 	Load constant 
880:     LD  4,-4(1) 	Load left into ac1 
881:    SUB  4,4,3 	Op == 
882:    LDC  3,1(6) 	True case 
883:    JEQ  4,1(7) 	Jump if true 
884:    LDC  3,0(6) 	False case 
885:     LD  4,-3(1) 	Load left into ac1 
886:    JEQ  3,1(7) 	Op AND 
887:    LDA  3,0(4) 	 
888:     LD  4,-2(1) 	Load left into ac1 
889:    JGT  3,1(7) 	Op OR 
890:    LDA  3,0(4) 	 
891:     ST  3,-2(1) 	Save left side 
892:    LDC  3,7(6) 	Load constant 
893:    LDA  4,-1(0) 	Load address of base of array board
894:    SUB  3,4,3 	Compute offset of value 
895:     LD  3,0(3) 	Load the value 
896:     ST  3,-3(1) 	Save left side 
897:    LDC  3,1(6) 	Load constant 
898:    LDC  4,0(6) 	Load 0 
899:    SUB  3,4,3 	Op unary - 
900:     LD  4,-3(1) 	Load left into ac1 
901:    SUB  4,4,3 	Op == 
902:    LDC  3,1(6) 	True case 
903:    JEQ  4,1(7) 	Jump if true 
904:    LDC  3,0(6) 	False case 
905:     LD  4,-2(1) 	Load left into ac1 
906:    JEQ  3,1(7) 	Op AND 
907:    LDA  3,0(4) 	 
908:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
910:    LDC  3,7(6) 	Load constant 
911:     ST  3,-2(1) 	Save index 
912:    LDC  3,2(6) 	Load constant 
913:     LD  4,-2(1) 	Restore index 
914:    LDA  5,-1(0) 	Load address of base of array board
915:    SUB  5,5,4 	Compute offset of value 
916:     ST  3,0(5) 	Store variable board
* EXPRESSION STMT
917:    LDC  3,0(6) 	Load constant 
918:     ST  3,-10(0) 	Store variable gamenotdone
* END compound statement
* ELSE
909:    LDA  7,10(7) 	Jump around the THEN 
* BEGIN compound statement
* IF
920:    LDC  3,7(6) 	Load constant 
921:    LDA  4,-1(0) 	Load address of base of array board
922:    SUB  3,4,3 	Compute offset of value 
923:     LD  3,0(3) 	Load the value 
924:     ST  3,-2(1) 	Save left side 
925:    LDC  3,2(6) 	Load constant 
926:     LD  4,-2(1) 	Load left into ac1 
927:    SUB  4,4,3 	Op == 
928:    LDC  3,1(6) 	True case 
929:    JEQ  4,1(7) 	Jump if true 
930:    LDC  3,0(6) 	False case 
931:     ST  3,-2(1) 	Save left side 
932:    LDC  3,8(6) 	Load constant 
933:    LDA  4,-1(0) 	Load address of base of array board
934:    SUB  3,4,3 	Compute offset of value 
935:     LD  3,0(3) 	Load the value 
936:     ST  3,-3(1) 	Save left side 
937:    LDC  3,2(6) 	Load constant 
938:     LD  4,-3(1) 	Load left into ac1 
939:    SUB  4,4,3 	Op == 
940:    LDC  3,1(6) 	True case 
941:    JEQ  4,1(7) 	Jump if true 
942:    LDC  3,0(6) 	False case 
943:     LD  4,-2(1) 	Load left into ac1 
944:    JEQ  3,1(7) 	Op AND 
945:    LDA  3,0(4) 	 
946:     ST  3,-2(1) 	Save left side 
947:    LDC  3,4(6) 	Load constant 
948:    LDA  4,-1(0) 	Load address of base of array board
949:    SUB  3,4,3 	Compute offset of value 
950:     LD  3,0(3) 	Load the value 
951:     ST  3,-3(1) 	Save left side 
952:    LDC  3,2(6) 	Load constant 
953:     LD  4,-3(1) 	Load left into ac1 
954:    SUB  4,4,3 	Op == 
955:    LDC  3,1(6) 	True case 
956:    JEQ  4,1(7) 	Jump if true 
957:    LDC  3,0(6) 	False case 
958:     ST  3,-3(1) 	Save left side 
959:    LDC  3,2(6) 	Load constant 
960:    LDA  4,-1(0) 	Load address of base of array board
961:    SUB  3,4,3 	Compute offset of value 
962:     LD  3,0(3) 	Load the value 
963:     ST  3,-4(1) 	Save left side 
964:    LDC  3,2(6) 	Load constant 
965:     LD  4,-4(1) 	Load left into ac1 
966:    SUB  4,4,3 	Op == 
967:    LDC  3,1(6) 	True case 
968:    JEQ  4,1(7) 	Jump if true 
969:    LDC  3,0(6) 	False case 
970:     LD  4,-3(1) 	Load left into ac1 
971:    JEQ  3,1(7) 	Op AND 
972:    LDA  3,0(4) 	 
973:     LD  4,-2(1) 	Load left into ac1 
974:    JGT  3,1(7) 	Op OR 
975:    LDA  3,0(4) 	 
976:     ST  3,-2(1) 	Save left side 
977:    LDC  3,0(6) 	Load constant 
978:    LDA  4,-1(0) 	Load address of base of array board
979:    SUB  3,4,3 	Compute offset of value 
980:     LD  3,0(3) 	Load the value 
981:     ST  3,-3(1) 	Save left side 
982:    LDC  3,2(6) 	Load constant 
983:     LD  4,-3(1) 	Load left into ac1 
984:    SUB  4,4,3 	Op == 
985:    LDC  3,1(6) 	True case 
986:    JEQ  4,1(7) 	Jump if true 
987:    LDC  3,0(6) 	False case 
988:     ST  3,-3(1) 	Save left side 
989:    LDC  3,3(6) 	Load constant 
990:    LDA  4,-1(0) 	Load address of base of array board
991:    SUB  3,4,3 	Compute offset of value 
992:     LD  3,0(3) 	Load the value 
993:     ST  3,-4(1) 	Save left side 
994:    LDC  3,2(6) 	Load constant 
995:     LD  4,-4(1) 	Load left into ac1 
996:    SUB  4,4,3 	Op == 
997:    LDC  3,1(6) 	True case 
998:    JEQ  4,1(7) 	Jump if true 
999:    LDC  3,0(6) 	False case 
1000:     LD  4,-3(1) 	Load left into ac1 
1001:    JEQ  3,1(7) 	Op AND 
1002:    LDA  3,0(4) 	 
1003:     LD  4,-2(1) 	Load left into ac1 
1004:    JGT  3,1(7) 	Op OR 
1005:    LDA  3,0(4) 	 
1006:     ST  3,-2(1) 	Save left side 
1007:    LDC  3,6(6) 	Load constant 
1008:    LDA  4,-1(0) 	Load address of base of array board
1009:    SUB  3,4,3 	Compute offset of value 
1010:     LD  3,0(3) 	Load the value 
1011:     ST  3,-3(1) 	Save left side 
1012:    LDC  3,1(6) 	Load constant 
1013:    LDC  4,0(6) 	Load 0 
1014:    SUB  3,4,3 	Op unary - 
1015:     LD  4,-3(1) 	Load left into ac1 
1016:    SUB  4,4,3 	Op == 
1017:    LDC  3,1(6) 	True case 
1018:    JEQ  4,1(7) 	Jump if true 
1019:    LDC  3,0(6) 	False case 
1020:     LD  4,-2(1) 	Load left into ac1 
1021:    JEQ  3,1(7) 	Op AND 
1022:    LDA  3,0(4) 	 
1023:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
1025:    LDC  3,6(6) 	Load constant 
1026:     ST  3,-2(1) 	Save index 
1027:    LDC  3,2(6) 	Load constant 
1028:     LD  4,-2(1) 	Restore index 
1029:    LDA  5,-1(0) 	Load address of base of array board
1030:    SUB  5,5,4 	Compute offset of value 
1031:     ST  3,0(5) 	Store variable board
* EXPRESSION STMT
1032:    LDC  3,0(6) 	Load constant 
1033:     ST  3,-10(0) 	Store variable gamenotdone
* END compound statement
1024:    LDA  7,9(7) 	Jump around the THEN 
* ENDIF
* END compound statement
919:    LDA  7,114(7) 	Jump around the ELSE 
* ENDIF
* END compound statement
834:    LDA  7,199(7) 	Jump around the ELSE 
* ENDIF
* END compound statement
719:    LDA  7,314(7) 	Jump around the ELSE 
* ENDIF
* END compound statement
634:    LDA  7,399(7) 	Jump around the ELSE 
* ENDIF
* END compound statement
489:    LDA  7,544(7) 	Jump around the ELSE 
* ENDIF
* END compound statement
404:    LDA  7,629(7) 	Jump around the ELSE 
* ENDIF
* END compound statement
289:    LDA  7,744(7) 	Jump around the ELSE 
* ENDIF
* END compound statement
204:    LDA  7,829(7) 	Jump around the ELSE 
* ENDIF
* IF
1034:     LD  3,-10(0) 	Load variable gamenotdone
1035:     ST  3,-2(1) 	Save left side 
1036:    LDC  3,0(6) 	Load constant 
1037:     LD  4,-2(1) 	Load left into ac1 
1038:    SUB  3,4,3 	Op != 
1039:    JEQ  3,1(7) 	Jump if true 
1040:    LDC  3,1(6) 	True case 
1041:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* RETURN
1043:    LDC  3,0(6) 	Load constant 
1044:    LDA  2,0(3) 	Copy result to rt register 
1045:     LD  3,-1(1) 	Load return address 
1046:     LD  1,0(1) 	Adjust fp 
1047:    LDA  7,0(3) 	Return 
* END compound statement
1042:    LDA  7,5(7) 	Jump around the THEN 
* ENDIF
* RETURN
1048:    LDC  3,1(6) 	Load constant 
1049:    LDA  2,0(3) 	Copy result to rt register 
1050:     LD  3,-1(1) 	Load return address 
1051:     LD  1,0(1) 	Adjust fp 
1052:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
1053:    LDC  2,0(6) 	Set return value to 0 
1054:     LD  3,-1(1) 	Load return address 
1055:     LD  1,0(1) 	Adjust fp 
1056:    LDA  7,0(3) 	Return 
* END of function win
* BEGIN function blockplayer
1057:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
1058:    LDC  3,0(6) 	Load constant 
1059:     ST  3,-2(1) 	Store variable blocked
* IF
1060:    LDC  3,0(6) 	Load constant 
1061:    LDA  4,-1(0) 	Load address of base of array board
1062:    SUB  3,4,3 	Compute offset of value 
1063:     LD  3,0(3) 	Load the value 
1064:     ST  3,-3(1) 	Save left side 
1065:    LDC  3,1(6) 	Load constant 
1066:     LD  4,-3(1) 	Load left into ac1 
1067:    SUB  4,4,3 	Op == 
1068:    LDC  3,1(6) 	True case 
1069:    JEQ  4,1(7) 	Jump if true 
1070:    LDC  3,0(6) 	False case 
1071:     ST  3,-3(1) 	Save left side 
1072:    LDC  3,1(6) 	Load constant 
1073:    LDA  4,-1(0) 	Load address of base of array board
1074:    SUB  3,4,3 	Compute offset of value 
1075:     LD  3,0(3) 	Load the value 
1076:     ST  3,-4(1) 	Save left side 
1077:    LDC  3,1(6) 	Load constant 
1078:     LD  4,-4(1) 	Load left into ac1 
1079:    SUB  4,4,3 	Op == 
1080:    LDC  3,1(6) 	True case 
1081:    JEQ  4,1(7) 	Jump if true 
1082:    LDC  3,0(6) 	False case 
1083:     LD  4,-3(1) 	Load left into ac1 
1084:    JEQ  3,1(7) 	Op AND 
1085:    LDA  3,0(4) 	 
1086:     ST  3,-3(1) 	Save left side 
1087:    LDC  3,6(6) 	Load constant 
1088:    LDA  4,-1(0) 	Load address of base of array board
1089:    SUB  3,4,3 	Compute offset of value 
1090:     LD  3,0(3) 	Load the value 
1091:     ST  3,-4(1) 	Save left side 
1092:    LDC  3,1(6) 	Load constant 
1093:     LD  4,-4(1) 	Load left into ac1 
1094:    SUB  4,4,3 	Op == 
1095:    LDC  3,1(6) 	True case 
1096:    JEQ  4,1(7) 	Jump if true 
1097:    LDC  3,0(6) 	False case 
1098:     ST  3,-4(1) 	Save left side 
1099:    LDC  3,4(6) 	Load constant 
1100:    LDA  4,-1(0) 	Load address of base of array board
1101:    SUB  3,4,3 	Compute offset of value 
1102:     LD  3,0(3) 	Load the value 
1103:     ST  3,-5(1) 	Save left side 
1104:    LDC  3,1(6) 	Load constant 
1105:     LD  4,-5(1) 	Load left into ac1 
1106:    SUB  4,4,3 	Op == 
1107:    LDC  3,1(6) 	True case 
1108:    JEQ  4,1(7) 	Jump if true 
1109:    LDC  3,0(6) 	False case 
1110:     LD  4,-4(1) 	Load left into ac1 
1111:    JEQ  3,1(7) 	Op AND 
1112:    LDA  3,0(4) 	 
1113:     LD  4,-3(1) 	Load left into ac1 
1114:    JGT  3,1(7) 	Op OR 
1115:    LDA  3,0(4) 	 
1116:     ST  3,-3(1) 	Save left side 
1117:    LDC  3,8(6) 	Load constant 
1118:    LDA  4,-1(0) 	Load address of base of array board
1119:    SUB  3,4,3 	Compute offset of value 
1120:     LD  3,0(3) 	Load the value 
1121:     ST  3,-4(1) 	Save left side 
1122:    LDC  3,1(6) 	Load constant 
1123:     LD  4,-4(1) 	Load left into ac1 
1124:    SUB  4,4,3 	Op == 
1125:    LDC  3,1(6) 	True case 
1126:    JEQ  4,1(7) 	Jump if true 
1127:    LDC  3,0(6) 	False case 
1128:     ST  3,-4(1) 	Save left side 
1129:    LDC  3,5(6) 	Load constant 
1130:    LDA  4,-1(0) 	Load address of base of array board
1131:    SUB  3,4,3 	Compute offset of value 
1132:     LD  3,0(3) 	Load the value 
1133:     ST  3,-5(1) 	Save left side 
1134:    LDC  3,1(6) 	Load constant 
1135:     LD  4,-5(1) 	Load left into ac1 
1136:    SUB  4,4,3 	Op == 
1137:    LDC  3,1(6) 	True case 
1138:    JEQ  4,1(7) 	Jump if true 
1139:    LDC  3,0(6) 	False case 
1140:     LD  4,-4(1) 	Load left into ac1 
1141:    JEQ  3,1(7) 	Op AND 
1142:    LDA  3,0(4) 	 
1143:     LD  4,-3(1) 	Load left into ac1 
1144:    JGT  3,1(7) 	Op OR 
1145:    LDA  3,0(4) 	 
1146:     ST  3,-3(1) 	Save left side 
1147:    LDC  3,2(6) 	Load constant 
1148:    LDA  4,-1(0) 	Load address of base of array board
1149:    SUB  3,4,3 	Compute offset of value 
1150:     LD  3,0(3) 	Load the value 
1151:     ST  3,-4(1) 	Save left side 
1152:    LDC  3,1(6) 	Load constant 
1153:    LDC  4,0(6) 	Load 0 
1154:    SUB  3,4,3 	Op unary - 
1155:     LD  4,-4(1) 	Load left into ac1 
1156:    SUB  4,4,3 	Op == 
1157:    LDC  3,1(6) 	True case 
1158:    JEQ  4,1(7) 	Jump if true 
1159:    LDC  3,0(6) 	False case 
1160:     LD  4,-3(1) 	Load left into ac1 
1161:    JEQ  3,1(7) 	Op AND 
1162:    LDA  3,0(4) 	 
1163:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
1165:    LDC  3,2(6) 	Load constant 
1166:     ST  3,-3(1) 	Save index 
1167:    LDC  3,2(6) 	Load constant 
1168:     LD  4,-3(1) 	Restore index 
1169:    LDA  5,-1(0) 	Load address of base of array board
1170:    SUB  5,5,4 	Compute offset of value 
1171:     ST  3,0(5) 	Store variable board
* EXPRESSION STMT
1172:    LDC  3,1(6) 	Load constant 
1173:     ST  3,-2(1) 	Store variable blocked
* END compound statement
* ELSE
1164:    LDA  7,10(7) 	Jump around the THEN 
* BEGIN compound statement
* IF
1175:    LDC  3,0(6) 	Load constant 
1176:    LDA  4,-1(0) 	Load address of base of array board
1177:    SUB  3,4,3 	Compute offset of value 
1178:     LD  3,0(3) 	Load the value 
1179:     ST  3,-3(1) 	Save left side 
1180:    LDC  3,1(6) 	Load constant 
1181:     LD  4,-3(1) 	Load left into ac1 
1182:    SUB  4,4,3 	Op == 
1183:    LDC  3,1(6) 	True case 
1184:    JEQ  4,1(7) 	Jump if true 
1185:    LDC  3,0(6) 	False case 
1186:     ST  3,-3(1) 	Save left side 
1187:    LDC  3,2(6) 	Load constant 
1188:    LDA  4,-1(0) 	Load address of base of array board
1189:    SUB  3,4,3 	Compute offset of value 
1190:     LD  3,0(3) 	Load the value 
1191:     ST  3,-4(1) 	Save left side 
1192:    LDC  3,1(6) 	Load constant 
1193:     LD  4,-4(1) 	Load left into ac1 
1194:    SUB  4,4,3 	Op == 
1195:    LDC  3,1(6) 	True case 
1196:    JEQ  4,1(7) 	Jump if true 
1197:    LDC  3,0(6) 	False case 
1198:     LD  4,-3(1) 	Load left into ac1 
1199:    JEQ  3,1(7) 	Op AND 
1200:    LDA  3,0(4) 	 
1201:     ST  3,-3(1) 	Save left side 
1202:    LDC  3,4(6) 	Load constant 
1203:    LDA  4,-1(0) 	Load address of base of array board
1204:    SUB  3,4,3 	Compute offset of value 
1205:     LD  3,0(3) 	Load the value 
1206:     ST  3,-4(1) 	Save left side 
1207:    LDC  3,1(6) 	Load constant 
1208:     LD  4,-4(1) 	Load left into ac1 
1209:    SUB  4,4,3 	Op == 
1210:    LDC  3,1(6) 	True case 
1211:    JEQ  4,1(7) 	Jump if true 
1212:    LDC  3,0(6) 	False case 
1213:     ST  3,-4(1) 	Save left side 
1214:    LDC  3,7(6) 	Load constant 
1215:    LDA  4,-1(0) 	Load address of base of array board
1216:    SUB  3,4,3 	Compute offset of value 
1217:     LD  3,0(3) 	Load the value 
1218:     ST  3,-5(1) 	Save left side 
1219:    LDC  3,1(6) 	Load constant 
1220:     LD  4,-5(1) 	Load left into ac1 
1221:    SUB  4,4,3 	Op == 
1222:    LDC  3,1(6) 	True case 
1223:    JEQ  4,1(7) 	Jump if true 
1224:    LDC  3,0(6) 	False case 
1225:     LD  4,-4(1) 	Load left into ac1 
1226:    JEQ  3,1(7) 	Op AND 
1227:    LDA  3,0(4) 	 
1228:     LD  4,-3(1) 	Load left into ac1 
1229:    JGT  3,1(7) 	Op OR 
1230:    LDA  3,0(4) 	 
1231:     ST  3,-3(1) 	Save left side 
1232:    LDC  3,1(6) 	Load constant 
1233:    LDA  4,-1(0) 	Load address of base of array board
1234:    SUB  3,4,3 	Compute offset of value 
1235:     LD  3,0(3) 	Load the value 
1236:     ST  3,-4(1) 	Save left side 
1237:    LDC  3,1(6) 	Load constant 
1238:    LDC  4,0(6) 	Load 0 
1239:    SUB  3,4,3 	Op unary - 
1240:     LD  4,-4(1) 	Load left into ac1 
1241:    SUB  4,4,3 	Op == 
1242:    LDC  3,1(6) 	True case 
1243:    JEQ  4,1(7) 	Jump if true 
1244:    LDC  3,0(6) 	False case 
1245:     LD  4,-3(1) 	Load left into ac1 
1246:    JEQ  3,1(7) 	Op AND 
1247:    LDA  3,0(4) 	 
1248:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
1250:    LDC  3,1(6) 	Load constant 
1251:     ST  3,-3(1) 	Save index 
1252:    LDC  3,2(6) 	Load constant 
1253:     LD  4,-3(1) 	Restore index 
1254:    LDA  5,-1(0) 	Load address of base of array board
1255:    SUB  5,5,4 	Compute offset of value 
1256:     ST  3,0(5) 	Store variable board
* EXPRESSION STMT
1257:    LDC  3,1(6) 	Load constant 
1258:     ST  3,-2(1) 	Store variable blocked
* END compound statement
* ELSE
1249:    LDA  7,10(7) 	Jump around the THEN 
* BEGIN compound statement
* IF
1260:    LDC  3,2(6) 	Load constant 
1261:    LDA  4,-1(0) 	Load address of base of array board
1262:    SUB  3,4,3 	Compute offset of value 
1263:     LD  3,0(3) 	Load the value 
1264:     ST  3,-3(1) 	Save left side 
1265:    LDC  3,1(6) 	Load constant 
1266:     LD  4,-3(1) 	Load left into ac1 
1267:    SUB  4,4,3 	Op == 
1268:    LDC  3,1(6) 	True case 
1269:    JEQ  4,1(7) 	Jump if true 
1270:    LDC  3,0(6) 	False case 
1271:     ST  3,-3(1) 	Save left side 
1272:    LDC  3,1(6) 	Load constant 
1273:    LDA  4,-1(0) 	Load address of base of array board
1274:    SUB  3,4,3 	Compute offset of value 
1275:     LD  3,0(3) 	Load the value 
1276:     ST  3,-4(1) 	Save left side 
1277:    LDC  3,1(6) 	Load constant 
1278:     LD  4,-4(1) 	Load left into ac1 
1279:    SUB  4,4,3 	Op == 
1280:    LDC  3,1(6) 	True case 
1281:    JEQ  4,1(7) 	Jump if true 
1282:    LDC  3,0(6) 	False case 
1283:     LD  4,-3(1) 	Load left into ac1 
1284:    JEQ  3,1(7) 	Op AND 
1285:    LDA  3,0(4) 	 
1286:     ST  3,-3(1) 	Save left side 
1287:    LDC  3,6(6) 	Load constant 
1288:    LDA  4,-1(0) 	Load address of base of array board
1289:    SUB  3,4,3 	Compute offset of value 
1290:     LD  3,0(3) 	Load the value 
1291:     ST  3,-4(1) 	Save left side 
1292:    LDC  3,1(6) 	Load constant 
1293:     LD  4,-4(1) 	Load left into ac1 
1294:    SUB  4,4,3 	Op == 
1295:    LDC  3,1(6) 	True case 
1296:    JEQ  4,1(7) 	Jump if true 
1297:    LDC  3,0(6) 	False case 
1298:     ST  3,-4(1) 	Save left side 
1299:    LDC  3,3(6) 	Load constant 
1300:    LDA  4,-1(0) 	Load address of base of array board
1301:    SUB  3,4,3 	Compute offset of value 
1302:     LD  3,0(3) 	Load the value 
1303:     ST  3,-5(1) 	Save left side 
1304:    LDC  3,1(6) 	Load constant 
1305:     LD  4,-5(1) 	Load left into ac1 
1306:    SUB  4,4,3 	Op == 
1307:    LDC  3,1(6) 	True case 
1308:    JEQ  4,1(7) 	Jump if true 
1309:    LDC  3,0(6) 	False case 
1310:     LD  4,-4(1) 	Load left into ac1 
1311:    JEQ  3,1(7) 	Op AND 
1312:    LDA  3,0(4) 	 
1313:     LD  4,-3(1) 	Load left into ac1 
1314:    JGT  3,1(7) 	Op OR 
1315:    LDA  3,0(4) 	 
1316:     ST  3,-3(1) 	Save left side 
1317:    LDC  3,4(6) 	Load constant 
1318:    LDA  4,-1(0) 	Load address of base of array board
1319:    SUB  3,4,3 	Compute offset of value 
1320:     LD  3,0(3) 	Load the value 
1321:     ST  3,-4(1) 	Save left side 
1322:    LDC  3,1(6) 	Load constant 
1323:     LD  4,-4(1) 	Load left into ac1 
1324:    SUB  4,4,3 	Op == 
1325:    LDC  3,1(6) 	True case 
1326:    JEQ  4,1(7) 	Jump if true 
1327:    LDC  3,0(6) 	False case 
1328:     ST  3,-4(1) 	Save left side 
1329:    LDC  3,8(6) 	Load constant 
1330:    LDA  4,-1(0) 	Load address of base of array board
1331:    SUB  3,4,3 	Compute offset of value 
1332:     LD  3,0(3) 	Load the value 
1333:     ST  3,-5(1) 	Save left side 
1334:    LDC  3,1(6) 	Load constant 
1335:     LD  4,-5(1) 	Load left into ac1 
1336:    SUB  4,4,3 	Op == 
1337:    LDC  3,1(6) 	True case 
1338:    JEQ  4,1(7) 	Jump if true 
1339:    LDC  3,0(6) 	False case 
1340:     LD  4,-4(1) 	Load left into ac1 
1341:    JEQ  3,1(7) 	Op AND 
1342:    LDA  3,0(4) 	 
1343:     LD  4,-3(1) 	Load left into ac1 
1344:    JGT  3,1(7) 	Op OR 
1345:    LDA  3,0(4) 	 
1346:     ST  3,-3(1) 	Save left side 
1347:    LDC  3,0(6) 	Load constant 
1348:    LDA  4,-1(0) 	Load address of base of array board
1349:    SUB  3,4,3 	Compute offset of value 
1350:     LD  3,0(3) 	Load the value 
1351:     ST  3,-4(1) 	Save left side 
1352:    LDC  3,1(6) 	Load constant 
1353:    LDC  4,0(6) 	Load 0 
1354:    SUB  3,4,3 	Op unary - 
1355:     LD  4,-4(1) 	Load left into ac1 
1356:    SUB  4,4,3 	Op == 
1357:    LDC  3,1(6) 	True case 
1358:    JEQ  4,1(7) 	Jump if true 
1359:    LDC  3,0(6) 	False case 
1360:     LD  4,-3(1) 	Load left into ac1 
1361:    JEQ  3,1(7) 	Op AND 
1362:    LDA  3,0(4) 	 
1363:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
1365:    LDC  3,0(6) 	Load constant 
1366:     ST  3,-3(1) 	Save index 
1367:    LDC  3,2(6) 	Load constant 
1368:     LD  4,-3(1) 	Restore index 
1369:    LDA  5,-1(0) 	Load address of base of array board
1370:    SUB  5,5,4 	Compute offset of value 
1371:     ST  3,0(5) 	Store variable board
* EXPRESSION STMT
1372:    LDC  3,1(6) 	Load constant 
1373:     ST  3,-2(1) 	Store variable blocked
* END compound statement
* ELSE
1364:    LDA  7,10(7) 	Jump around the THEN 
* BEGIN compound statement
* IF
1375:    LDC  3,3(6) 	Load constant 
1376:    LDA  4,-1(0) 	Load address of base of array board
1377:    SUB  3,4,3 	Compute offset of value 
1378:     LD  3,0(3) 	Load the value 
1379:     ST  3,-3(1) 	Save left side 
1380:    LDC  3,1(6) 	Load constant 
1381:     LD  4,-3(1) 	Load left into ac1 
1382:    SUB  4,4,3 	Op == 
1383:    LDC  3,1(6) 	True case 
1384:    JEQ  4,1(7) 	Jump if true 
1385:    LDC  3,0(6) 	False case 
1386:     ST  3,-3(1) 	Save left side 
1387:    LDC  3,4(6) 	Load constant 
1388:    LDA  4,-1(0) 	Load address of base of array board
1389:    SUB  3,4,3 	Compute offset of value 
1390:     LD  3,0(3) 	Load the value 
1391:     ST  3,-4(1) 	Save left side 
1392:    LDC  3,1(6) 	Load constant 
1393:     LD  4,-4(1) 	Load left into ac1 
1394:    SUB  4,4,3 	Op == 
1395:    LDC  3,1(6) 	True case 
1396:    JEQ  4,1(7) 	Jump if true 
1397:    LDC  3,0(6) 	False case 
1398:     LD  4,-3(1) 	Load left into ac1 
1399:    JEQ  3,1(7) 	Op AND 
1400:    LDA  3,0(4) 	 
1401:     ST  3,-3(1) 	Save left side 
1402:    LDC  3,2(6) 	Load constant 
1403:    LDA  4,-1(0) 	Load address of base of array board
1404:    SUB  3,4,3 	Compute offset of value 
1405:     LD  3,0(3) 	Load the value 
1406:     ST  3,-4(1) 	Save left side 
1407:    LDC  3,1(6) 	Load constant 
1408:     LD  4,-4(1) 	Load left into ac1 
1409:    SUB  4,4,3 	Op == 
1410:    LDC  3,1(6) 	True case 
1411:    JEQ  4,1(7) 	Jump if true 
1412:    LDC  3,0(6) 	False case 
1413:     ST  3,-4(1) 	Save left side 
1414:    LDC  3,8(6) 	Load constant 
1415:    LDA  4,-1(0) 	Load address of base of array board
1416:    SUB  3,4,3 	Compute offset of value 
1417:     LD  3,0(3) 	Load the value 
1418:     ST  3,-5(1) 	Save left side 
1419:    LDC  3,1(6) 	Load constant 
1420:     LD  4,-5(1) 	Load left into ac1 
1421:    SUB  4,4,3 	Op == 
1422:    LDC  3,1(6) 	True case 
1423:    JEQ  4,1(7) 	Jump if true 
1424:    LDC  3,0(6) 	False case 
1425:     LD  4,-4(1) 	Load left into ac1 
1426:    JEQ  3,1(7) 	Op AND 
1427:    LDA  3,0(4) 	 
1428:     LD  4,-3(1) 	Load left into ac1 
1429:    JGT  3,1(7) 	Op OR 
1430:    LDA  3,0(4) 	 
1431:     ST  3,-3(1) 	Save left side 
1432:    LDC  3,5(6) 	Load constant 
1433:    LDA  4,-1(0) 	Load address of base of array board
1434:    SUB  3,4,3 	Compute offset of value 
1435:     LD  3,0(3) 	Load the value 
1436:     ST  3,-4(1) 	Save left side 
1437:    LDC  3,1(6) 	Load constant 
1438:    LDC  4,0(6) 	Load 0 
1439:    SUB  3,4,3 	Op unary - 
1440:     LD  4,-4(1) 	Load left into ac1 
1441:    SUB  4,4,3 	Op == 
1442:    LDC  3,1(6) 	True case 
1443:    JEQ  4,1(7) 	Jump if true 
1444:    LDC  3,0(6) 	False case 
1445:     LD  4,-3(1) 	Load left into ac1 
1446:    JEQ  3,1(7) 	Op AND 
1447:    LDA  3,0(4) 	 
1448:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
1450:    LDC  3,5(6) 	Load constant 
1451:     ST  3,-3(1) 	Save index 
1452:    LDC  3,2(6) 	Load constant 
1453:     LD  4,-3(1) 	Restore index 
1454:    LDA  5,-1(0) 	Load address of base of array board
1455:    SUB  5,5,4 	Compute offset of value 
1456:     ST  3,0(5) 	Store variable board
* EXPRESSION STMT
1457:    LDC  3,1(6) 	Load constant 
1458:     ST  3,-2(1) 	Store variable blocked
* END compound statement
* ELSE
1449:    LDA  7,10(7) 	Jump around the THEN 
* BEGIN compound statement
* IF
1460:    LDC  3,3(6) 	Load constant 
1461:    LDA  4,-1(0) 	Load address of base of array board
1462:    SUB  3,4,3 	Compute offset of value 
1463:     LD  3,0(3) 	Load the value 
1464:     ST  3,-3(1) 	Save left side 
1465:    LDC  3,1(6) 	Load constant 
1466:     LD  4,-3(1) 	Load left into ac1 
1467:    SUB  4,4,3 	Op == 
1468:    LDC  3,1(6) 	True case 
1469:    JEQ  4,1(7) 	Jump if true 
1470:    LDC  3,0(6) 	False case 
1471:     ST  3,-3(1) 	Save left side 
1472:    LDC  3,5(6) 	Load constant 
1473:    LDA  4,-1(0) 	Load address of base of array board
1474:    SUB  3,4,3 	Compute offset of value 
1475:     LD  3,0(3) 	Load the value 
1476:     ST  3,-4(1) 	Save left side 
1477:    LDC  3,1(6) 	Load constant 
1478:     LD  4,-4(1) 	Load left into ac1 
1479:    SUB  4,4,3 	Op == 
1480:    LDC  3,1(6) 	True case 
1481:    JEQ  4,1(7) 	Jump if true 
1482:    LDC  3,0(6) 	False case 
1483:     LD  4,-3(1) 	Load left into ac1 
1484:    JEQ  3,1(7) 	Op AND 
1485:    LDA  3,0(4) 	 
1486:     ST  3,-3(1) 	Save left side 
1487:    LDC  3,0(6) 	Load constant 
1488:    LDA  4,-1(0) 	Load address of base of array board
1489:    SUB  3,4,3 	Compute offset of value 
1490:     LD  3,0(3) 	Load the value 
1491:     ST  3,-4(1) 	Save left side 
1492:    LDC  3,1(6) 	Load constant 
1493:     LD  4,-4(1) 	Load left into ac1 
1494:    SUB  4,4,3 	Op == 
1495:    LDC  3,1(6) 	True case 
1496:    JEQ  4,1(7) 	Jump if true 
1497:    LDC  3,0(6) 	False case 
1498:     ST  3,-4(1) 	Save left side 
1499:    LDC  3,8(6) 	Load constant 
1500:    LDA  4,-1(0) 	Load address of base of array board
1501:    SUB  3,4,3 	Compute offset of value 
1502:     LD  3,0(3) 	Load the value 
1503:     ST  3,-5(1) 	Save left side 
1504:    LDC  3,1(6) 	Load constant 
1505:     LD  4,-5(1) 	Load left into ac1 
1506:    SUB  4,4,3 	Op == 
1507:    LDC  3,1(6) 	True case 
1508:    JEQ  4,1(7) 	Jump if true 
1509:    LDC  3,0(6) 	False case 
1510:     LD  4,-4(1) 	Load left into ac1 
1511:    JEQ  3,1(7) 	Op AND 
1512:    LDA  3,0(4) 	 
1513:     LD  4,-3(1) 	Load left into ac1 
1514:    JGT  3,1(7) 	Op OR 
1515:    LDA  3,0(4) 	 
1516:     ST  3,-3(1) 	Save left side 
1517:    LDC  3,2(6) 	Load constant 
1518:    LDA  4,-1(0) 	Load address of base of array board
1519:    SUB  3,4,3 	Compute offset of value 
1520:     LD  3,0(3) 	Load the value 
1521:     ST  3,-4(1) 	Save left side 
1522:    LDC  3,1(6) 	Load constant 
1523:     LD  4,-4(1) 	Load left into ac1 
1524:    SUB  4,4,3 	Op == 
1525:    LDC  3,1(6) 	True case 
1526:    JEQ  4,1(7) 	Jump if true 
1527:    LDC  3,0(6) 	False case 
1528:     ST  3,-4(1) 	Save left side 
1529:    LDC  3,6(6) 	Load constant 
1530:    LDA  4,-1(0) 	Load address of base of array board
1531:    SUB  3,4,3 	Compute offset of value 
1532:     LD  3,0(3) 	Load the value 
1533:     ST  3,-5(1) 	Save left side 
1534:    LDC  3,1(6) 	Load constant 
1535:     LD  4,-5(1) 	Load left into ac1 
1536:    SUB  4,4,3 	Op == 
1537:    LDC  3,1(6) 	True case 
1538:    JEQ  4,1(7) 	Jump if true 
1539:    LDC  3,0(6) 	False case 
1540:     LD  4,-4(1) 	Load left into ac1 
1541:    JEQ  3,1(7) 	Op AND 
1542:    LDA  3,0(4) 	 
1543:     LD  4,-3(1) 	Load left into ac1 
1544:    JGT  3,1(7) 	Op OR 
1545:    LDA  3,0(4) 	 
1546:     ST  3,-3(1) 	Save left side 
1547:    LDC  3,1(6) 	Load constant 
1548:    LDA  4,-1(0) 	Load address of base of array board
1549:    SUB  3,4,3 	Compute offset of value 
1550:     LD  3,0(3) 	Load the value 
1551:     ST  3,-4(1) 	Save left side 
1552:    LDC  3,1(6) 	Load constant 
1553:     LD  4,-4(1) 	Load left into ac1 
1554:    SUB  4,4,3 	Op == 
1555:    LDC  3,1(6) 	True case 
1556:    JEQ  4,1(7) 	Jump if true 
1557:    LDC  3,0(6) 	False case 
1558:     ST  3,-4(1) 	Save left side 
1559:    LDC  3,7(6) 	Load constant 
1560:    LDA  4,-1(0) 	Load address of base of array board
1561:    SUB  3,4,3 	Compute offset of value 
1562:     LD  3,0(3) 	Load the value 
1563:     ST  3,-5(1) 	Save left side 
1564:    LDC  3,1(6) 	Load constant 
1565:     LD  4,-5(1) 	Load left into ac1 
1566:    SUB  4,4,3 	Op == 
1567:    LDC  3,1(6) 	True case 
1568:    JEQ  4,1(7) 	Jump if true 
1569:    LDC  3,0(6) 	False case 
1570:     LD  4,-4(1) 	Load left into ac1 
1571:    JEQ  3,1(7) 	Op AND 
1572:    LDA  3,0(4) 	 
1573:     LD  4,-3(1) 	Load left into ac1 
1574:    JGT  3,1(7) 	Op OR 
1575:    LDA  3,0(4) 	 
1576:     ST  3,-3(1) 	Save left side 
1577:    LDC  3,4(6) 	Load constant 
1578:    LDA  4,-1(0) 	Load address of base of array board
1579:    SUB  3,4,3 	Compute offset of value 
1580:     LD  3,0(3) 	Load the value 
1581:     ST  3,-4(1) 	Save left side 
1582:    LDC  3,1(6) 	Load constant 
1583:    LDC  4,0(6) 	Load 0 
1584:    SUB  3,4,3 	Op unary - 
1585:     LD  4,-4(1) 	Load left into ac1 
1586:    SUB  4,4,3 	Op == 
1587:    LDC  3,1(6) 	True case 
1588:    JEQ  4,1(7) 	Jump if true 
1589:    LDC  3,0(6) 	False case 
1590:     LD  4,-3(1) 	Load left into ac1 
1591:    JEQ  3,1(7) 	Op AND 
1592:    LDA  3,0(4) 	 
1593:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
1595:    LDC  3,4(6) 	Load constant 
1596:     ST  3,-3(1) 	Save index 
1597:    LDC  3,2(6) 	Load constant 
1598:     LD  4,-3(1) 	Restore index 
1599:    LDA  5,-1(0) 	Load address of base of array board
1600:    SUB  5,5,4 	Compute offset of value 
1601:     ST  3,0(5) 	Store variable board
* EXPRESSION STMT
1602:    LDC  3,1(6) 	Load constant 
1603:     ST  3,-2(1) 	Store variable blocked
* END compound statement
* ELSE
1594:    LDA  7,10(7) 	Jump around the THEN 
* BEGIN compound statement
* IF
1605:    LDC  3,4(6) 	Load constant 
1606:    LDA  4,-1(0) 	Load address of base of array board
1607:    SUB  3,4,3 	Compute offset of value 
1608:     LD  3,0(3) 	Load the value 
1609:     ST  3,-3(1) 	Save left side 
1610:    LDC  3,1(6) 	Load constant 
1611:     LD  4,-3(1) 	Load left into ac1 
1612:    SUB  4,4,3 	Op == 
1613:    LDC  3,1(6) 	True case 
1614:    JEQ  4,1(7) 	Jump if true 
1615:    LDC  3,0(6) 	False case 
1616:     ST  3,-3(1) 	Save left side 
1617:    LDC  3,5(6) 	Load constant 
1618:    LDA  4,-1(0) 	Load address of base of array board
1619:    SUB  3,4,3 	Compute offset of value 
1620:     LD  3,0(3) 	Load the value 
1621:     ST  3,-4(1) 	Save left side 
1622:    LDC  3,1(6) 	Load constant 
1623:     LD  4,-4(1) 	Load left into ac1 
1624:    SUB  4,4,3 	Op == 
1625:    LDC  3,1(6) 	True case 
1626:    JEQ  4,1(7) 	Jump if true 
1627:    LDC  3,0(6) 	False case 
1628:     LD  4,-3(1) 	Load left into ac1 
1629:    JEQ  3,1(7) 	Op AND 
1630:    LDA  3,0(4) 	 
1631:     ST  3,-3(1) 	Save left side 
1632:    LDC  3,0(6) 	Load constant 
1633:    LDA  4,-1(0) 	Load address of base of array board
1634:    SUB  3,4,3 	Compute offset of value 
1635:     LD  3,0(3) 	Load the value 
1636:     ST  3,-4(1) 	Save left side 
1637:    LDC  3,1(6) 	Load constant 
1638:     LD  4,-4(1) 	Load left into ac1 
1639:    SUB  4,4,3 	Op == 
1640:    LDC  3,1(6) 	True case 
1641:    JEQ  4,1(7) 	Jump if true 
1642:    LDC  3,0(6) 	False case 
1643:     ST  3,-4(1) 	Save left side 
1644:    LDC  3,6(6) 	Load constant 
1645:    LDA  4,-1(0) 	Load address of base of array board
1646:    SUB  3,4,3 	Compute offset of value 
1647:     LD  3,0(3) 	Load the value 
1648:     ST  3,-5(1) 	Save left side 
1649:    LDC  3,1(6) 	Load constant 
1650:     LD  4,-5(1) 	Load left into ac1 
1651:    SUB  4,4,3 	Op == 
1652:    LDC  3,1(6) 	True case 
1653:    JEQ  4,1(7) 	Jump if true 
1654:    LDC  3,0(6) 	False case 
1655:     LD  4,-4(1) 	Load left into ac1 
1656:    JEQ  3,1(7) 	Op AND 
1657:    LDA  3,0(4) 	 
1658:     LD  4,-3(1) 	Load left into ac1 
1659:    JGT  3,1(7) 	Op OR 
1660:    LDA  3,0(4) 	 
1661:     ST  3,-3(1) 	Save left side 
1662:    LDC  3,3(6) 	Load constant 
1663:    LDA  4,-1(0) 	Load address of base of array board
1664:    SUB  3,4,3 	Compute offset of value 
1665:     LD  3,0(3) 	Load the value 
1666:     ST  3,-4(1) 	Save left side 
1667:    LDC  3,1(6) 	Load constant 
1668:    LDC  4,0(6) 	Load 0 
1669:    SUB  3,4,3 	Op unary - 
1670:     LD  4,-4(1) 	Load left into ac1 
1671:    SUB  4,4,3 	Op == 
1672:    LDC  3,1(6) 	True case 
1673:    JEQ  4,1(7) 	Jump if true 
1674:    LDC  3,0(6) 	False case 
1675:     LD  4,-3(1) 	Load left into ac1 
1676:    JEQ  3,1(7) 	Op AND 
1677:    LDA  3,0(4) 	 
1678:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
1680:    LDC  3,3(6) 	Load constant 
1681:     ST  3,-3(1) 	Save index 
1682:    LDC  3,2(6) 	Load constant 
1683:     LD  4,-3(1) 	Restore index 
1684:    LDA  5,-1(0) 	Load address of base of array board
1685:    SUB  5,5,4 	Compute offset of value 
1686:     ST  3,0(5) 	Store variable board
* EXPRESSION STMT
1687:    LDC  3,1(6) 	Load constant 
1688:     ST  3,-2(1) 	Store variable blocked
* END compound statement
* ELSE
1679:    LDA  7,10(7) 	Jump around the THEN 
* BEGIN compound statement
* IF
1690:    LDC  3,6(6) 	Load constant 
1691:    LDA  4,-1(0) 	Load address of base of array board
1692:    SUB  3,4,3 	Compute offset of value 
1693:     LD  3,0(3) 	Load the value 
1694:     ST  3,-3(1) 	Save left side 
1695:    LDC  3,1(6) 	Load constant 
1696:     LD  4,-3(1) 	Load left into ac1 
1697:    SUB  4,4,3 	Op == 
1698:    LDC  3,1(6) 	True case 
1699:    JEQ  4,1(7) 	Jump if true 
1700:    LDC  3,0(6) 	False case 
1701:     ST  3,-3(1) 	Save left side 
1702:    LDC  3,7(6) 	Load constant 
1703:    LDA  4,-1(0) 	Load address of base of array board
1704:    SUB  3,4,3 	Compute offset of value 
1705:     LD  3,0(3) 	Load the value 
1706:     ST  3,-4(1) 	Save left side 
1707:    LDC  3,1(6) 	Load constant 
1708:     LD  4,-4(1) 	Load left into ac1 
1709:    SUB  4,4,3 	Op == 
1710:    LDC  3,1(6) 	True case 
1711:    JEQ  4,1(7) 	Jump if true 
1712:    LDC  3,0(6) 	False case 
1713:     LD  4,-3(1) 	Load left into ac1 
1714:    JEQ  3,1(7) 	Op AND 
1715:    LDA  3,0(4) 	 
1716:     ST  3,-3(1) 	Save left side 
1717:    LDC  3,0(6) 	Load constant 
1718:    LDA  4,-1(0) 	Load address of base of array board
1719:    SUB  3,4,3 	Compute offset of value 
1720:     LD  3,0(3) 	Load the value 
1721:     ST  3,-4(1) 	Save left side 
1722:    LDC  3,1(6) 	Load constant 
1723:     LD  4,-4(1) 	Load left into ac1 
1724:    SUB  4,4,3 	Op == 
1725:    LDC  3,1(6) 	True case 
1726:    JEQ  4,1(7) 	Jump if true 
1727:    LDC  3,0(6) 	False case 
1728:     ST  3,-4(1) 	Save left side 
1729:    LDC  3,4(6) 	Load constant 
1730:    LDA  4,-1(0) 	Load address of base of array board
1731:    SUB  3,4,3 	Compute offset of value 
1732:     LD  3,0(3) 	Load the value 
1733:     ST  3,-5(1) 	Save left side 
1734:    LDC  3,1(6) 	Load constant 
1735:     LD  4,-5(1) 	Load left into ac1 
1736:    SUB  4,4,3 	Op == 
1737:    LDC  3,1(6) 	True case 
1738:    JEQ  4,1(7) 	Jump if true 
1739:    LDC  3,0(6) 	False case 
1740:     LD  4,-4(1) 	Load left into ac1 
1741:    JEQ  3,1(7) 	Op AND 
1742:    LDA  3,0(4) 	 
1743:     LD  4,-3(1) 	Load left into ac1 
1744:    JGT  3,1(7) 	Op OR 
1745:    LDA  3,0(4) 	 
1746:     ST  3,-3(1) 	Save left side 
1747:    LDC  3,2(6) 	Load constant 
1748:    LDA  4,-1(0) 	Load address of base of array board
1749:    SUB  3,4,3 	Compute offset of value 
1750:     LD  3,0(3) 	Load the value 
1751:     ST  3,-4(1) 	Save left side 
1752:    LDC  3,1(6) 	Load constant 
1753:     LD  4,-4(1) 	Load left into ac1 
1754:    SUB  4,4,3 	Op == 
1755:    LDC  3,1(6) 	True case 
1756:    JEQ  4,1(7) 	Jump if true 
1757:    LDC  3,0(6) 	False case 
1758:     ST  3,-4(1) 	Save left side 
1759:    LDC  3,5(6) 	Load constant 
1760:    LDA  4,-1(0) 	Load address of base of array board
1761:    SUB  3,4,3 	Compute offset of value 
1762:     LD  3,0(3) 	Load the value 
1763:     ST  3,-5(1) 	Save left side 
1764:    LDC  3,1(6) 	Load constant 
1765:     LD  4,-5(1) 	Load left into ac1 
1766:    SUB  4,4,3 	Op == 
1767:    LDC  3,1(6) 	True case 
1768:    JEQ  4,1(7) 	Jump if true 
1769:    LDC  3,0(6) 	False case 
1770:     LD  4,-4(1) 	Load left into ac1 
1771:    JEQ  3,1(7) 	Op AND 
1772:    LDA  3,0(4) 	 
1773:     LD  4,-3(1) 	Load left into ac1 
1774:    JGT  3,1(7) 	Op OR 
1775:    LDA  3,0(4) 	 
1776:     ST  3,-3(1) 	Save left side 
1777:    LDC  3,8(6) 	Load constant 
1778:    LDA  4,-1(0) 	Load address of base of array board
1779:    SUB  3,4,3 	Compute offset of value 
1780:     LD  3,0(3) 	Load the value 
1781:     ST  3,-4(1) 	Save left side 
1782:    LDC  3,1(6) 	Load constant 
1783:    LDC  4,0(6) 	Load 0 
1784:    SUB  3,4,3 	Op unary - 
1785:     LD  4,-4(1) 	Load left into ac1 
1786:    SUB  4,4,3 	Op == 
1787:    LDC  3,1(6) 	True case 
1788:    JEQ  4,1(7) 	Jump if true 
1789:    LDC  3,0(6) 	False case 
1790:     LD  4,-3(1) 	Load left into ac1 
1791:    JEQ  3,1(7) 	Op AND 
1792:    LDA  3,0(4) 	 
1793:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
1795:    LDC  3,8(6) 	Load constant 
1796:     ST  3,-3(1) 	Save index 
1797:    LDC  3,2(6) 	Load constant 
1798:     LD  4,-3(1) 	Restore index 
1799:    LDA  5,-1(0) 	Load address of base of array board
1800:    SUB  5,5,4 	Compute offset of value 
1801:     ST  3,0(5) 	Store variable board
* EXPRESSION STMT
1802:    LDC  3,1(6) 	Load constant 
1803:     ST  3,-2(1) 	Store variable blocked
* END compound statement
* ELSE
1794:    LDA  7,10(7) 	Jump around the THEN 
* BEGIN compound statement
* IF
1805:    LDC  3,6(6) 	Load constant 
1806:    LDA  4,-1(0) 	Load address of base of array board
1807:    SUB  3,4,3 	Compute offset of value 
1808:     LD  3,0(3) 	Load the value 
1809:     ST  3,-3(1) 	Save left side 
1810:    LDC  3,1(6) 	Load constant 
1811:     LD  4,-3(1) 	Load left into ac1 
1812:    SUB  4,4,3 	Op == 
1813:    LDC  3,1(6) 	True case 
1814:    JEQ  4,1(7) 	Jump if true 
1815:    LDC  3,0(6) 	False case 
1816:     ST  3,-3(1) 	Save left side 
1817:    LDC  3,8(6) 	Load constant 
1818:    LDA  4,-1(0) 	Load address of base of array board
1819:    SUB  3,4,3 	Compute offset of value 
1820:     LD  3,0(3) 	Load the value 
1821:     ST  3,-4(1) 	Save left side 
1822:    LDC  3,1(6) 	Load constant 
1823:     LD  4,-4(1) 	Load left into ac1 
1824:    SUB  4,4,3 	Op == 
1825:    LDC  3,1(6) 	True case 
1826:    JEQ  4,1(7) 	Jump if true 
1827:    LDC  3,0(6) 	False case 
1828:     LD  4,-3(1) 	Load left into ac1 
1829:    JEQ  3,1(7) 	Op AND 
1830:    LDA  3,0(4) 	 
1831:     ST  3,-3(1) 	Save left side 
1832:    LDC  3,4(6) 	Load constant 
1833:    LDA  4,-1(0) 	Load address of base of array board
1834:    SUB  3,4,3 	Compute offset of value 
1835:     LD  3,0(3) 	Load the value 
1836:     ST  3,-4(1) 	Save left side 
1837:    LDC  3,1(6) 	Load constant 
1838:     LD  4,-4(1) 	Load left into ac1 
1839:    SUB  4,4,3 	Op == 
1840:    LDC  3,1(6) 	True case 
1841:    JEQ  4,1(7) 	Jump if true 
1842:    LDC  3,0(6) 	False case 
1843:     ST  3,-4(1) 	Save left side 
1844:    LDC  3,1(6) 	Load constant 
1845:    LDA  4,-1(0) 	Load address of base of array board
1846:    SUB  3,4,3 	Compute offset of value 
1847:     LD  3,0(3) 	Load the value 
1848:     ST  3,-5(1) 	Save left side 
1849:    LDC  3,1(6) 	Load constant 
1850:     LD  4,-5(1) 	Load left into ac1 
1851:    SUB  4,4,3 	Op == 
1852:    LDC  3,1(6) 	True case 
1853:    JEQ  4,1(7) 	Jump if true 
1854:    LDC  3,0(6) 	False case 
1855:     LD  4,-4(1) 	Load left into ac1 
1856:    JEQ  3,1(7) 	Op AND 
1857:    LDA  3,0(4) 	 
1858:     LD  4,-3(1) 	Load left into ac1 
1859:    JGT  3,1(7) 	Op OR 
1860:    LDA  3,0(4) 	 
1861:     ST  3,-3(1) 	Save left side 
1862:    LDC  3,7(6) 	Load constant 
1863:    LDA  4,-1(0) 	Load address of base of array board
1864:    SUB  3,4,3 	Compute offset of value 
1865:     LD  3,0(3) 	Load the value 
1866:     ST  3,-4(1) 	Save left side 
1867:    LDC  3,1(6) 	Load constant 
1868:    LDC  4,0(6) 	Load 0 
1869:    SUB  3,4,3 	Op unary - 
1870:     LD  4,-4(1) 	Load left into ac1 
1871:    SUB  4,4,3 	Op == 
1872:    LDC  3,1(6) 	True case 
1873:    JEQ  4,1(7) 	Jump if true 
1874:    LDC  3,0(6) 	False case 
1875:     LD  4,-3(1) 	Load left into ac1 
1876:    JEQ  3,1(7) 	Op AND 
1877:    LDA  3,0(4) 	 
1878:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
1880:    LDC  3,7(6) 	Load constant 
1881:     ST  3,-3(1) 	Save index 
1882:    LDC  3,2(6) 	Load constant 
1883:     LD  4,-3(1) 	Restore index 
1884:    LDA  5,-1(0) 	Load address of base of array board
1885:    SUB  5,5,4 	Compute offset of value 
1886:     ST  3,0(5) 	Store variable board
* EXPRESSION STMT
1887:    LDC  3,1(6) 	Load constant 
1888:     ST  3,-2(1) 	Store variable blocked
* END compound statement
* ELSE
1879:    LDA  7,10(7) 	Jump around the THEN 
* BEGIN compound statement
* IF
1890:    LDC  3,7(6) 	Load constant 
1891:    LDA  4,-1(0) 	Load address of base of array board
1892:    SUB  3,4,3 	Compute offset of value 
1893:     LD  3,0(3) 	Load the value 
1894:     ST  3,-3(1) 	Save left side 
1895:    LDC  3,1(6) 	Load constant 
1896:     LD  4,-3(1) 	Load left into ac1 
1897:    SUB  4,4,3 	Op == 
1898:    LDC  3,1(6) 	True case 
1899:    JEQ  4,1(7) 	Jump if true 
1900:    LDC  3,0(6) 	False case 
1901:     ST  3,-3(1) 	Save left side 
1902:    LDC  3,8(6) 	Load constant 
1903:    LDA  4,-1(0) 	Load address of base of array board
1904:    SUB  3,4,3 	Compute offset of value 
1905:     LD  3,0(3) 	Load the value 
1906:     ST  3,-4(1) 	Save left side 
1907:    LDC  3,1(6) 	Load constant 
1908:     LD  4,-4(1) 	Load left into ac1 
1909:    SUB  4,4,3 	Op == 
1910:    LDC  3,1(6) 	True case 
1911:    JEQ  4,1(7) 	Jump if true 
1912:    LDC  3,0(6) 	False case 
1913:     LD  4,-3(1) 	Load left into ac1 
1914:    JEQ  3,1(7) 	Op AND 
1915:    LDA  3,0(4) 	 
1916:     ST  3,-3(1) 	Save left side 
1917:    LDC  3,4(6) 	Load constant 
1918:    LDA  4,-1(0) 	Load address of base of array board
1919:    SUB  3,4,3 	Compute offset of value 
1920:     LD  3,0(3) 	Load the value 
1921:     ST  3,-4(1) 	Save left side 
1922:    LDC  3,1(6) 	Load constant 
1923:     LD  4,-4(1) 	Load left into ac1 
1924:    SUB  4,4,3 	Op == 
1925:    LDC  3,1(6) 	True case 
1926:    JEQ  4,1(7) 	Jump if true 
1927:    LDC  3,0(6) 	False case 
1928:     ST  3,-4(1) 	Save left side 
1929:    LDC  3,2(6) 	Load constant 
1930:    LDA  4,-1(0) 	Load address of base of array board
1931:    SUB  3,4,3 	Compute offset of value 
1932:     LD  3,0(3) 	Load the value 
1933:     ST  3,-5(1) 	Save left side 
1934:    LDC  3,1(6) 	Load constant 
1935:     LD  4,-5(1) 	Load left into ac1 
1936:    SUB  4,4,3 	Op == 
1937:    LDC  3,1(6) 	True case 
1938:    JEQ  4,1(7) 	Jump if true 
1939:    LDC  3,0(6) 	False case 
1940:     LD  4,-4(1) 	Load left into ac1 
1941:    JEQ  3,1(7) 	Op AND 
1942:    LDA  3,0(4) 	 
1943:     LD  4,-3(1) 	Load left into ac1 
1944:    JGT  3,1(7) 	Op OR 
1945:    LDA  3,0(4) 	 
1946:     ST  3,-3(1) 	Save left side 
1947:    LDC  3,0(6) 	Load constant 
1948:    LDA  4,-1(0) 	Load address of base of array board
1949:    SUB  3,4,3 	Compute offset of value 
1950:     LD  3,0(3) 	Load the value 
1951:     ST  3,-4(1) 	Save left side 
1952:    LDC  3,1(6) 	Load constant 
1953:     LD  4,-4(1) 	Load left into ac1 
1954:    SUB  4,4,3 	Op == 
1955:    LDC  3,1(6) 	True case 
1956:    JEQ  4,1(7) 	Jump if true 
1957:    LDC  3,0(6) 	False case 
1958:     ST  3,-4(1) 	Save left side 
1959:    LDC  3,3(6) 	Load constant 
1960:    LDA  4,-1(0) 	Load address of base of array board
1961:    SUB  3,4,3 	Compute offset of value 
1962:     LD  3,0(3) 	Load the value 
1963:     ST  3,-5(1) 	Save left side 
1964:    LDC  3,1(6) 	Load constant 
1965:     LD  4,-5(1) 	Load left into ac1 
1966:    SUB  4,4,3 	Op == 
1967:    LDC  3,1(6) 	True case 
1968:    JEQ  4,1(7) 	Jump if true 
1969:    LDC  3,0(6) 	False case 
1970:     LD  4,-4(1) 	Load left into ac1 
1971:    JEQ  3,1(7) 	Op AND 
1972:    LDA  3,0(4) 	 
1973:     LD  4,-3(1) 	Load left into ac1 
1974:    JGT  3,1(7) 	Op OR 
1975:    LDA  3,0(4) 	 
1976:     ST  3,-3(1) 	Save left side 
1977:    LDC  3,6(6) 	Load constant 
1978:    LDA  4,-1(0) 	Load address of base of array board
1979:    SUB  3,4,3 	Compute offset of value 
1980:     LD  3,0(3) 	Load the value 
1981:     ST  3,-4(1) 	Save left side 
1982:    LDC  3,1(6) 	Load constant 
1983:    LDC  4,0(6) 	Load 0 
1984:    SUB  3,4,3 	Op unary - 
1985:     LD  4,-4(1) 	Load left into ac1 
1986:    SUB  4,4,3 	Op == 
1987:    LDC  3,1(6) 	True case 
1988:    JEQ  4,1(7) 	Jump if true 
1989:    LDC  3,0(6) 	False case 
1990:     LD  4,-3(1) 	Load left into ac1 
1991:    JEQ  3,1(7) 	Op AND 
1992:    LDA  3,0(4) 	 
1993:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
1995:    LDC  3,6(6) 	Load constant 
1996:     ST  3,-3(1) 	Save index 
1997:    LDC  3,2(6) 	Load constant 
1998:     LD  4,-3(1) 	Restore index 
1999:    LDA  5,-1(0) 	Load address of base of array board
2000:    SUB  5,5,4 	Compute offset of value 
2001:     ST  3,0(5) 	Store variable board
* EXPRESSION STMT
2002:    LDC  3,1(6) 	Load constant 
2003:     ST  3,-2(1) 	Store variable blocked
* END compound statement
1994:    LDA  7,9(7) 	Jump around the THEN 
* ENDIF
* END compound statement
1889:    LDA  7,114(7) 	Jump around the ELSE 
* ENDIF
* END compound statement
1804:    LDA  7,199(7) 	Jump around the ELSE 
* ENDIF
* END compound statement
1689:    LDA  7,314(7) 	Jump around the ELSE 
* ENDIF
* END compound statement
1604:    LDA  7,399(7) 	Jump around the ELSE 
* ENDIF
* END compound statement
1459:    LDA  7,544(7) 	Jump around the ELSE 
* ENDIF
* END compound statement
1374:    LDA  7,629(7) 	Jump around the ELSE 
* ENDIF
* END compound statement
1259:    LDA  7,744(7) 	Jump around the ELSE 
* ENDIF
* END compound statement
1174:    LDA  7,829(7) 	Jump around the ELSE 
* ENDIF
* RETURN
2004:     LD  3,-2(1) 	Load variable blocked
2005:    LDA  2,0(3) 	Copy result to rt register 
2006:     LD  3,-1(1) 	Load return address 
2007:     LD  1,0(1) 	Adjust fp 
2008:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
2009:    LDC  2,0(6) 	Set return value to 0 
2010:     LD  3,-1(1) 	Load return address 
2011:     LD  1,0(1) 	Adjust fp 
2012:    LDA  7,0(3) 	Return 
* END of function blockplayer
* BEGIN function placey
2013:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* IF
2014:     ST  1,-2(1) 	Store old fp in ghost frame 
2015:    LDA  1,-2(1) 	Load address of new frame 
2016:    LDA  3,1(7) 	Return address in ac 
2017:    LDA  7,-1929(7) 	CALL win
2018:    LDA  3,0(2) 	Save the result in ac 
2019:    LDC  4,1(6) 	Load 1 
2020:    SUB  3,4,3 	Op NOT 
2021:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* IF
2023:     ST  1,-2(1) 	Store old fp in ghost frame 
2024:    LDA  1,-2(1) 	Load address of new frame 
2025:    LDA  3,1(7) 	Return address in ac 
2026:    LDA  7,-970(7) 	CALL blockplayer
2027:    LDA  3,0(2) 	Save the result in ac 
2028:    LDC  4,1(6) 	Load 1 
2029:    SUB  3,4,3 	Op NOT 
2030:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
2032:     ST  1,-2(1) 	Store old fp in ghost frame 
2033:    LDA  1,-2(1) 	Load address of new frame 
2034:    LDA  3,1(7) 	Return address in ac 
2035:    LDA  7,-2006(7) 	CALL move
2036:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
2031:    LDA  7,5(7) 	Jump around the THEN 
* ENDIF
* END compound statement
2022:    LDA  7,14(7) 	Jump around the THEN 
* ENDIF
* END compound statement
* Add standard closing in case there is no return statement
2037:    LDC  2,0(6) 	Set return value to 0 
2038:     LD  3,-1(1) 	Load return address 
2039:     LD  1,0(1) 	Adjust fp 
2040:    LDA  7,0(3) 	Return 
* END of function placey
* BEGIN function xingrid
2041:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
2042:    LDC  3,0(6) 	Load constant 
2043:     ST  3,-3(1) 	Store variable retval
* IF
2044:     LD  3,-2(1) 	Load variable x
2045:     ST  3,-4(1) 	Save left side 
2046:    LDC  3,0(6) 	Load constant 
2047:     LD  4,-4(1) 	Load left into ac1 
2048:    SUB  4,4,3 	Op >= 
2049:    LDC  3,1(6) 	True case 
2050:    JGE  4,1(7) 	Jump if true 
2051:    LDC  3,0(6) 	False case 
2052:     ST  3,-4(1) 	Save left side 
2053:     LD  3,-2(1) 	Load variable x
2054:     ST  3,-5(1) 	Save left side 
2055:    LDC  3,8(6) 	Load constant 
2056:     LD  4,-5(1) 	Load left into ac1 
2057:    SUB  4,4,3 	Op <= 
2058:    LDC  3,1(6) 	True case 
2059:    JLE  4,1(7) 	Jump if true 
2060:    LDC  3,0(6) 	False case 
2061:     LD  4,-4(1) 	Load left into ac1 
2062:    JEQ  3,1(7) 	Op AND 
2063:    LDA  3,0(4) 	 
2064:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* IF
2066:     LD  3,-2(1) 	Load variable x
2067:    LDA  4,-1(0) 	Load address of base of array board
2068:    SUB  3,4,3 	Compute offset of value 
2069:     LD  3,0(3) 	Load the value 
2070:     ST  3,-4(1) 	Save left side 
2071:    LDC  3,1(6) 	Load constant 
2072:     LD  4,-4(1) 	Load left into ac1 
2073:    SUB  3,4,3 	Op != 
2074:    JEQ  3,1(7) 	Jump if true 
2075:    LDC  3,1(6) 	True case 
2076:     ST  3,-4(1) 	Save left side 
2077:     LD  3,-2(1) 	Load variable x
2078:    LDA  4,-1(0) 	Load address of base of array board
2079:    SUB  3,4,3 	Compute offset of value 
2080:     LD  3,0(3) 	Load the value 
2081:     ST  3,-5(1) 	Save left side 
2082:    LDC  3,2(6) 	Load constant 
2083:     LD  4,-5(1) 	Load left into ac1 
2084:    SUB  3,4,3 	Op != 
2085:    JEQ  3,1(7) 	Jump if true 
2086:    LDC  3,1(6) 	True case 
2087:     LD  4,-4(1) 	Load left into ac1 
2088:    JEQ  3,1(7) 	Op AND 
2089:    LDA  3,0(4) 	 
2090:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
2092:     LD  3,-2(1) 	Load variable x
2093:     ST  3,-4(1) 	Save index 
2094:    LDC  3,1(6) 	Load constant 
2095:     LD  4,-4(1) 	Restore index 
2096:    LDA  5,-1(0) 	Load address of base of array board
2097:    SUB  5,5,4 	Compute offset of value 
2098:     ST  3,0(5) 	Store variable board
* EXPRESSION STMT
2099:    LDC  3,1(6) 	Load constant 
2100:     ST  3,-3(1) 	Store variable retval
* END compound statement
2091:    LDA  7,9(7) 	Jump around the THEN 
* ENDIF
* END compound statement
2065:    LDA  7,35(7) 	Jump around the THEN 
* ENDIF
* RETURN
2101:     LD  3,-3(1) 	Load variable retval
2102:    LDA  2,0(3) 	Copy result to rt register 
2103:     LD  3,-1(1) 	Load return address 
2104:     LD  1,0(1) 	Adjust fp 
2105:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
2106:    LDC  2,0(6) 	Set return value to 0 
2107:     LD  3,-1(1) 	Load return address 
2108:     LD  1,0(1) 	Adjust fp 
2109:    LDA  7,0(3) 	Return 
* END of function xingrid
* BEGIN function printboard
2110:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
2111:    LDC  3,0(6) 	Load constant 
2112:     ST  3,-2(1) 	Store variable i
* WHILE
2113:     LD  3,-2(1) 	Load variable i
2114:     ST  3,-3(1) 	Save left side 
2115:    LDC  3,9(6) 	Load constant 
2116:     LD  4,-3(1) 	Load left into ac1 
2117:    SUB  4,4,3 	Op < 
2118:    LDC  3,1(6) 	True case 
2119:    JLT  4,1(7) 	Jump if true 
2120:    LDC  3,0(6) 	False case 
2121:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* IF
2123:     LD  3,-2(1) 	Load variable i
2124:    LDA  4,-1(0) 	Load address of base of array board
2125:    SUB  3,4,3 	Compute offset of value 
2126:     LD  3,0(3) 	Load the value 
2127:     ST  3,-3(1) 	Save left side 
2128:    LDC  3,1(6) 	Load constant 
2129:     LD  4,-3(1) 	Load left into ac1 
2130:    SUB  4,4,3 	Op == 
2131:    LDC  3,1(6) 	True case 
2132:    JEQ  4,1(7) 	Jump if true 
2133:    LDC  3,0(6) 	False case 
2134:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
2136:     ST  1,-3(1) 	Store old fp in ghost frame 
2137:    LDC  3,1(6) 	Load constant 
2138:     ST  3,-5(1) 	Store parameter 
2139:    LDA  1,-3(1) 	Load address of new frame 
2140:    LDA  3,1(7) 	Return address in ac 
2141:    LDA  7,-2124(7) 	CALL outputb
2142:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* ELSE
2135:    LDA  7,8(7) 	Jump around the THEN 
* IF
2144:     LD  3,-2(1) 	Load variable i
2145:    LDA  4,-1(0) 	Load address of base of array board
2146:    SUB  3,4,3 	Compute offset of value 
2147:     LD  3,0(3) 	Load the value 
2148:     ST  3,-3(1) 	Save left side 
2149:    LDC  3,2(6) 	Load constant 
2150:     LD  4,-3(1) 	Load left into ac1 
2151:    SUB  4,4,3 	Op == 
2152:    LDC  3,1(6) 	True case 
2153:    JEQ  4,1(7) 	Jump if true 
2154:    LDC  3,0(6) 	False case 
2155:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
2157:     ST  1,-3(1) 	Store old fp in ghost frame 
2158:    LDC  3,0(6) 	Load constant 
2159:     ST  3,-5(1) 	Store parameter 
2160:    LDA  1,-3(1) 	Load address of new frame 
2161:    LDA  3,1(7) 	Return address in ac 
2162:    LDA  7,-2145(7) 	CALL outputb
2163:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* ELSE
2156:    LDA  7,8(7) 	Jump around the THEN 
* BEGIN compound statement
* EXPRESSION STMT
2165:     ST  1,-3(1) 	Store old fp in ghost frame 
2166:     LD  3,-2(1) 	Load variable i
2167:     ST  3,-5(1) 	Store parameter 
2168:    LDA  1,-3(1) 	Load address of new frame 
2169:    LDA  3,1(7) 	Return address in ac 
2170:    LDA  7,-2165(7) 	CALL output
2171:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
2164:    LDA  7,7(7) 	Jump around the ELSE 
* ENDIF
2143:    LDA  7,28(7) 	Jump around the ELSE 
* ENDIF
* IF
2172:     LD  3,-2(1) 	Load variable i
2173:     ST  3,-3(1) 	Save left side 
2174:    LDC  3,2(6) 	Load constant 
2175:     LD  4,-3(1) 	Load left into ac1 
2176:    SUB  4,4,3 	Op == 
2177:    LDC  3,1(6) 	True case 
2178:    JEQ  4,1(7) 	Jump if true 
2179:    LDC  3,0(6) 	False case 
2180:     ST  3,-3(1) 	Save left side 
2181:     LD  3,-2(1) 	Load variable i
2182:     ST  3,-4(1) 	Save left side 
2183:    LDC  3,5(6) 	Load constant 
2184:     LD  4,-4(1) 	Load left into ac1 
2185:    SUB  4,4,3 	Op == 
2186:    LDC  3,1(6) 	True case 
2187:    JEQ  4,1(7) 	Jump if true 
2188:    LDC  3,0(6) 	False case 
2189:     LD  4,-3(1) 	Load left into ac1 
2190:    JGT  3,1(7) 	Op OR 
2191:    LDA  3,0(4) 	 
2192:     ST  3,-3(1) 	Save left side 
2193:     LD  3,-2(1) 	Load variable i
2194:     ST  3,-4(1) 	Save left side 
2195:    LDC  3,8(6) 	Load constant 
2196:     LD  4,-4(1) 	Load left into ac1 
2197:    SUB  4,4,3 	Op == 
2198:    LDC  3,1(6) 	True case 
2199:    JEQ  4,1(7) 	Jump if true 
2200:    LDC  3,0(6) 	False case 
2201:     LD  4,-3(1) 	Load left into ac1 
2202:    JGT  3,1(7) 	Op OR 
2203:    LDA  3,0(4) 	 
2204:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
2206:     ST  1,-3(1) 	Store old fp in ghost frame 
2207:    LDA  1,-3(1) 	Load address of new frame 
2208:    LDA  3,1(7) 	Return address in ac 
2209:    LDA  7,-2185(7) 	CALL outnl
2210:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
2205:    LDA  7,5(7) 	Jump around the THEN 
* ENDIF
* EXPRESSION STMT
2211:     LD  3,-2(1) 	load lhs variable i
2212:    LDA  3,1(3) 	increment value of i
2213:     ST  3,-2(1) 	Store variable i
* END compound statement
2214:    LDA  7,-102(7) 	go to beginning of loop 
2122:    LDA  7,92(7) 	No more loop 
* ENDWHILE
* END compound statement
* Add standard closing in case there is no return statement
2215:    LDC  2,0(6) 	Set return value to 0 
2216:     LD  3,-1(1) 	Load return address 
2217:     LD  1,0(1) 	Adjust fp 
2218:    LDA  7,0(3) 	Return 
* END of function printboard
* BEGIN function finished
2219:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
2220:    LDC  3,0(6) 	Load constant 
2221:     ST  3,-2(1) 	Store variable i
* IF
2222:    LDC  3,0(6) 	Load constant 
2223:    LDA  4,-1(0) 	Load address of base of array board
2224:    SUB  3,4,3 	Compute offset of value 
2225:     LD  3,0(3) 	Load the value 
2226:     ST  3,-3(1) 	Save left side 
2227:    LDC  3,1(6) 	Load constant 
2228:    LDC  4,0(6) 	Load 0 
2229:    SUB  3,4,3 	Op unary - 
2230:     LD  4,-3(1) 	Load left into ac1 
2231:    SUB  3,4,3 	Op != 
2232:    JEQ  3,1(7) 	Jump if true 
2233:    LDC  3,1(6) 	True case 
2234:     ST  3,-3(1) 	Save left side 
2235:    LDC  3,0(6) 	Load constant 
2236:    LDA  4,-1(0) 	Load address of base of array board
2237:    SUB  3,4,3 	Compute offset of value 
2238:     LD  3,0(3) 	Load the value 
2239:     ST  3,-4(1) 	Save left side 
2240:    LDC  3,1(6) 	Load constant 
2241:    LDA  4,-1(0) 	Load address of base of array board
2242:    SUB  3,4,3 	Compute offset of value 
2243:     LD  3,0(3) 	Load the value 
2244:     LD  4,-4(1) 	Load left into ac1 
2245:    SUB  4,4,3 	Op == 
2246:    LDC  3,1(6) 	True case 
2247:    JEQ  4,1(7) 	Jump if true 
2248:    LDC  3,0(6) 	False case 
2249:     ST  3,-4(1) 	Save left side 
2250:    LDC  3,0(6) 	Load constant 
2251:    LDA  4,-1(0) 	Load address of base of array board
2252:    SUB  3,4,3 	Compute offset of value 
2253:     LD  3,0(3) 	Load the value 
2254:     ST  3,-5(1) 	Save left side 
2255:    LDC  3,2(6) 	Load constant 
2256:    LDA  4,-1(0) 	Load address of base of array board
2257:    SUB  3,4,3 	Compute offset of value 
2258:     LD  3,0(3) 	Load the value 
2259:     LD  4,-5(1) 	Load left into ac1 
2260:    SUB  4,4,3 	Op == 
2261:    LDC  3,1(6) 	True case 
2262:    JEQ  4,1(7) 	Jump if true 
2263:    LDC  3,0(6) 	False case 
2264:     LD  4,-4(1) 	Load left into ac1 
2265:    JEQ  3,1(7) 	Op AND 
2266:    LDA  3,0(4) 	 
2267:     ST  3,-4(1) 	Save left side 
2268:    LDC  3,0(6) 	Load constant 
2269:    LDA  4,-1(0) 	Load address of base of array board
2270:    SUB  3,4,3 	Compute offset of value 
2271:     LD  3,0(3) 	Load the value 
2272:     ST  3,-5(1) 	Save left side 
2273:    LDC  3,4(6) 	Load constant 
2274:    LDA  4,-1(0) 	Load address of base of array board
2275:    SUB  3,4,3 	Compute offset of value 
2276:     LD  3,0(3) 	Load the value 
2277:     LD  4,-5(1) 	Load left into ac1 
2278:    SUB  4,4,3 	Op == 
2279:    LDC  3,1(6) 	True case 
2280:    JEQ  4,1(7) 	Jump if true 
2281:    LDC  3,0(6) 	False case 
2282:     ST  3,-5(1) 	Save left side 
2283:    LDC  3,0(6) 	Load constant 
2284:    LDA  4,-1(0) 	Load address of base of array board
2285:    SUB  3,4,3 	Compute offset of value 
2286:     LD  3,0(3) 	Load the value 
2287:     ST  3,-6(1) 	Save left side 
2288:    LDC  3,8(6) 	Load constant 
2289:    LDA  4,-1(0) 	Load address of base of array board
2290:    SUB  3,4,3 	Compute offset of value 
2291:     LD  3,0(3) 	Load the value 
2292:     LD  4,-6(1) 	Load left into ac1 
2293:    SUB  4,4,3 	Op == 
2294:    LDC  3,1(6) 	True case 
2295:    JEQ  4,1(7) 	Jump if true 
2296:    LDC  3,0(6) 	False case 
2297:     LD  4,-5(1) 	Load left into ac1 
2298:    JEQ  3,1(7) 	Op AND 
2299:    LDA  3,0(4) 	 
2300:     LD  4,-4(1) 	Load left into ac1 
2301:    JGT  3,1(7) 	Op OR 
2302:    LDA  3,0(4) 	 
2303:     ST  3,-4(1) 	Save left side 
2304:    LDC  3,0(6) 	Load constant 
2305:    LDA  4,-1(0) 	Load address of base of array board
2306:    SUB  3,4,3 	Compute offset of value 
2307:     LD  3,0(3) 	Load the value 
2308:     ST  3,-5(1) 	Save left side 
2309:    LDC  3,3(6) 	Load constant 
2310:    LDA  4,-1(0) 	Load address of base of array board
2311:    SUB  3,4,3 	Compute offset of value 
2312:     LD  3,0(3) 	Load the value 
2313:     LD  4,-5(1) 	Load left into ac1 
2314:    SUB  4,4,3 	Op == 
2315:    LDC  3,1(6) 	True case 
2316:    JEQ  4,1(7) 	Jump if true 
2317:    LDC  3,0(6) 	False case 
2318:     ST  3,-5(1) 	Save left side 
2319:    LDC  3,0(6) 	Load constant 
2320:    LDA  4,-1(0) 	Load address of base of array board
2321:    SUB  3,4,3 	Compute offset of value 
2322:     LD  3,0(3) 	Load the value 
2323:     ST  3,-6(1) 	Save left side 
2324:    LDC  3,6(6) 	Load constant 
2325:    LDA  4,-1(0) 	Load address of base of array board
2326:    SUB  3,4,3 	Compute offset of value 
2327:     LD  3,0(3) 	Load the value 
2328:     LD  4,-6(1) 	Load left into ac1 
2329:    SUB  4,4,3 	Op == 
2330:    LDC  3,1(6) 	True case 
2331:    JEQ  4,1(7) 	Jump if true 
2332:    LDC  3,0(6) 	False case 
2333:     LD  4,-5(1) 	Load left into ac1 
2334:    JEQ  3,1(7) 	Op AND 
2335:    LDA  3,0(4) 	 
2336:     LD  4,-4(1) 	Load left into ac1 
2337:    JGT  3,1(7) 	Op OR 
2338:    LDA  3,0(4) 	 
2339:     LD  4,-3(1) 	Load left into ac1 
2340:    JEQ  3,1(7) 	Op AND 
2341:    LDA  3,0(4) 	 
2342:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* RETURN
2344:    LDC  3,1(6) 	Load constant 
2345:    LDA  2,0(3) 	Copy result to rt register 
2346:     LD  3,-1(1) 	Load return address 
2347:     LD  1,0(1) 	Adjust fp 
2348:    LDA  7,0(3) 	Return 
* END compound statement
2343:    LDA  7,5(7) 	Jump around the THEN 
* ENDIF
* IF
2349:    LDC  3,1(6) 	Load constant 
2350:    LDA  4,-1(0) 	Load address of base of array board
2351:    SUB  3,4,3 	Compute offset of value 
2352:     LD  3,0(3) 	Load the value 
2353:     ST  3,-3(1) 	Save left side 
2354:    LDC  3,1(6) 	Load constant 
2355:    LDC  4,0(6) 	Load 0 
2356:    SUB  3,4,3 	Op unary - 
2357:     LD  4,-3(1) 	Load left into ac1 
2358:    SUB  3,4,3 	Op != 
2359:    JEQ  3,1(7) 	Jump if true 
2360:    LDC  3,1(6) 	True case 
2361:     ST  3,-3(1) 	Save left side 
2362:    LDC  3,1(6) 	Load constant 
2363:    LDA  4,-1(0) 	Load address of base of array board
2364:    SUB  3,4,3 	Compute offset of value 
2365:     LD  3,0(3) 	Load the value 
2366:     ST  3,-4(1) 	Save left side 
2367:    LDC  3,4(6) 	Load constant 
2368:    LDA  4,-1(0) 	Load address of base of array board
2369:    SUB  3,4,3 	Compute offset of value 
2370:     LD  3,0(3) 	Load the value 
2371:     LD  4,-4(1) 	Load left into ac1 
2372:    SUB  4,4,3 	Op == 
2373:    LDC  3,1(6) 	True case 
2374:    JEQ  4,1(7) 	Jump if true 
2375:    LDC  3,0(6) 	False case 
2376:     ST  3,-4(1) 	Save left side 
2377:    LDC  3,1(6) 	Load constant 
2378:    LDA  4,-1(0) 	Load address of base of array board
2379:    SUB  3,4,3 	Compute offset of value 
2380:     LD  3,0(3) 	Load the value 
2381:     ST  3,-5(1) 	Save left side 
2382:    LDC  3,7(6) 	Load constant 
2383:    LDA  4,-1(0) 	Load address of base of array board
2384:    SUB  3,4,3 	Compute offset of value 
2385:     LD  3,0(3) 	Load the value 
2386:     LD  4,-5(1) 	Load left into ac1 
2387:    SUB  4,4,3 	Op == 
2388:    LDC  3,1(6) 	True case 
2389:    JEQ  4,1(7) 	Jump if true 
2390:    LDC  3,0(6) 	False case 
2391:     LD  4,-4(1) 	Load left into ac1 
2392:    JEQ  3,1(7) 	Op AND 
2393:    LDA  3,0(4) 	 
2394:     LD  4,-3(1) 	Load left into ac1 
2395:    JEQ  3,1(7) 	Op AND 
2396:    LDA  3,0(4) 	 
2397:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* RETURN
2399:    LDC  3,1(6) 	Load constant 
2400:    LDA  2,0(3) 	Copy result to rt register 
2401:     LD  3,-1(1) 	Load return address 
2402:     LD  1,0(1) 	Adjust fp 
2403:    LDA  7,0(3) 	Return 
* END compound statement
2398:    LDA  7,5(7) 	Jump around the THEN 
* ENDIF
* IF
2404:    LDC  3,2(6) 	Load constant 
2405:    LDA  4,-1(0) 	Load address of base of array board
2406:    SUB  3,4,3 	Compute offset of value 
2407:     LD  3,0(3) 	Load the value 
2408:     ST  3,-3(1) 	Save left side 
2409:    LDC  3,1(6) 	Load constant 
2410:    LDC  4,0(6) 	Load 0 
2411:    SUB  3,4,3 	Op unary - 
2412:     LD  4,-3(1) 	Load left into ac1 
2413:    SUB  3,4,3 	Op != 
2414:    JEQ  3,1(7) 	Jump if true 
2415:    LDC  3,1(6) 	True case 
2416:     ST  3,-3(1) 	Save left side 
2417:    LDC  3,2(6) 	Load constant 
2418:    LDA  4,-1(0) 	Load address of base of array board
2419:    SUB  3,4,3 	Compute offset of value 
2420:     LD  3,0(3) 	Load the value 
2421:     ST  3,-4(1) 	Save left side 
2422:    LDC  3,4(6) 	Load constant 
2423:    LDA  4,-1(0) 	Load address of base of array board
2424:    SUB  3,4,3 	Compute offset of value 
2425:     LD  3,0(3) 	Load the value 
2426:     LD  4,-4(1) 	Load left into ac1 
2427:    SUB  4,4,3 	Op == 
2428:    LDC  3,1(6) 	True case 
2429:    JEQ  4,1(7) 	Jump if true 
2430:    LDC  3,0(6) 	False case 
2431:     ST  3,-4(1) 	Save left side 
2432:    LDC  3,2(6) 	Load constant 
2433:    LDA  4,-1(0) 	Load address of base of array board
2434:    SUB  3,4,3 	Compute offset of value 
2435:     LD  3,0(3) 	Load the value 
2436:     ST  3,-5(1) 	Save left side 
2437:    LDC  3,6(6) 	Load constant 
2438:    LDA  4,-1(0) 	Load address of base of array board
2439:    SUB  3,4,3 	Compute offset of value 
2440:     LD  3,0(3) 	Load the value 
2441:     LD  4,-5(1) 	Load left into ac1 
2442:    SUB  4,4,3 	Op == 
2443:    LDC  3,1(6) 	True case 
2444:    JEQ  4,1(7) 	Jump if true 
2445:    LDC  3,0(6) 	False case 
2446:     LD  4,-4(1) 	Load left into ac1 
2447:    JEQ  3,1(7) 	Op AND 
2448:    LDA  3,0(4) 	 
2449:     ST  3,-4(1) 	Save left side 
2450:    LDC  3,2(6) 	Load constant 
2451:    LDA  4,-1(0) 	Load address of base of array board
2452:    SUB  3,4,3 	Compute offset of value 
2453:     LD  3,0(3) 	Load the value 
2454:     ST  3,-5(1) 	Save left side 
2455:    LDC  3,5(6) 	Load constant 
2456:    LDA  4,-1(0) 	Load address of base of array board
2457:    SUB  3,4,3 	Compute offset of value 
2458:     LD  3,0(3) 	Load the value 
2459:     LD  4,-5(1) 	Load left into ac1 
2460:    SUB  4,4,3 	Op == 
2461:    LDC  3,1(6) 	True case 
2462:    JEQ  4,1(7) 	Jump if true 
2463:    LDC  3,0(6) 	False case 
2464:     ST  3,-5(1) 	Save left side 
2465:    LDC  3,2(6) 	Load constant 
2466:    LDA  4,-1(0) 	Load address of base of array board
2467:    SUB  3,4,3 	Compute offset of value 
2468:     LD  3,0(3) 	Load the value 
2469:     ST  3,-6(1) 	Save left side 
2470:    LDC  3,8(6) 	Load constant 
2471:    LDA  4,-1(0) 	Load address of base of array board
2472:    SUB  3,4,3 	Compute offset of value 
2473:     LD  3,0(3) 	Load the value 
2474:     LD  4,-6(1) 	Load left into ac1 
2475:    SUB  4,4,3 	Op == 
2476:    LDC  3,1(6) 	True case 
2477:    JEQ  4,1(7) 	Jump if true 
2478:    LDC  3,0(6) 	False case 
2479:     LD  4,-5(1) 	Load left into ac1 
2480:    JEQ  3,1(7) 	Op AND 
2481:    LDA  3,0(4) 	 
2482:     LD  4,-4(1) 	Load left into ac1 
2483:    JGT  3,1(7) 	Op OR 
2484:    LDA  3,0(4) 	 
2485:     LD  4,-3(1) 	Load left into ac1 
2486:    JEQ  3,1(7) 	Op AND 
2487:    LDA  3,0(4) 	 
2488:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* RETURN
2490:    LDC  3,1(6) 	Load constant 
2491:    LDA  2,0(3) 	Copy result to rt register 
2492:     LD  3,-1(1) 	Load return address 
2493:     LD  1,0(1) 	Adjust fp 
2494:    LDA  7,0(3) 	Return 
* END compound statement
2489:    LDA  7,5(7) 	Jump around the THEN 
* ENDIF
* IF
2495:    LDC  3,3(6) 	Load constant 
2496:    LDA  4,-1(0) 	Load address of base of array board
2497:    SUB  3,4,3 	Compute offset of value 
2498:     LD  3,0(3) 	Load the value 
2499:     ST  3,-3(1) 	Save left side 
2500:    LDC  3,1(6) 	Load constant 
2501:    LDC  4,0(6) 	Load 0 
2502:    SUB  3,4,3 	Op unary - 
2503:     LD  4,-3(1) 	Load left into ac1 
2504:    SUB  3,4,3 	Op != 
2505:    JEQ  3,1(7) 	Jump if true 
2506:    LDC  3,1(6) 	True case 
2507:     ST  3,-3(1) 	Save left side 
2508:    LDC  3,3(6) 	Load constant 
2509:    LDA  4,-1(0) 	Load address of base of array board
2510:    SUB  3,4,3 	Compute offset of value 
2511:     LD  3,0(3) 	Load the value 
2512:     ST  3,-4(1) 	Save left side 
2513:    LDC  3,4(6) 	Load constant 
2514:    LDA  4,-1(0) 	Load address of base of array board
2515:    SUB  3,4,3 	Compute offset of value 
2516:     LD  3,0(3) 	Load the value 
2517:     LD  4,-4(1) 	Load left into ac1 
2518:    SUB  4,4,3 	Op == 
2519:    LDC  3,1(6) 	True case 
2520:    JEQ  4,1(7) 	Jump if true 
2521:    LDC  3,0(6) 	False case 
2522:     ST  3,-4(1) 	Save left side 
2523:    LDC  3,3(6) 	Load constant 
2524:    LDA  4,-1(0) 	Load address of base of array board
2525:    SUB  3,4,3 	Compute offset of value 
2526:     LD  3,0(3) 	Load the value 
2527:     ST  3,-5(1) 	Save left side 
2528:    LDC  3,5(6) 	Load constant 
2529:    LDA  4,-1(0) 	Load address of base of array board
2530:    SUB  3,4,3 	Compute offset of value 
2531:     LD  3,0(3) 	Load the value 
2532:     LD  4,-5(1) 	Load left into ac1 
2533:    SUB  4,4,3 	Op == 
2534:    LDC  3,1(6) 	True case 
2535:    JEQ  4,1(7) 	Jump if true 
2536:    LDC  3,0(6) 	False case 
2537:     LD  4,-4(1) 	Load left into ac1 
2538:    JEQ  3,1(7) 	Op AND 
2539:    LDA  3,0(4) 	 
2540:     LD  4,-3(1) 	Load left into ac1 
2541:    JEQ  3,1(7) 	Op AND 
2542:    LDA  3,0(4) 	 
2543:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* RETURN
2545:    LDC  3,1(6) 	Load constant 
2546:    LDA  2,0(3) 	Copy result to rt register 
2547:     LD  3,-1(1) 	Load return address 
2548:     LD  1,0(1) 	Adjust fp 
2549:    LDA  7,0(3) 	Return 
* END compound statement
2544:    LDA  7,5(7) 	Jump around the THEN 
* ENDIF
* IF
2550:    LDC  3,6(6) 	Load constant 
2551:    LDA  4,-1(0) 	Load address of base of array board
2552:    SUB  3,4,3 	Compute offset of value 
2553:     LD  3,0(3) 	Load the value 
2554:     ST  3,-3(1) 	Save left side 
2555:    LDC  3,1(6) 	Load constant 
2556:    LDC  4,0(6) 	Load 0 
2557:    SUB  3,4,3 	Op unary - 
2558:     LD  4,-3(1) 	Load left into ac1 
2559:    SUB  3,4,3 	Op != 
2560:    JEQ  3,1(7) 	Jump if true 
2561:    LDC  3,1(6) 	True case 
2562:     ST  3,-3(1) 	Save left side 
2563:    LDC  3,6(6) 	Load constant 
2564:    LDA  4,-1(0) 	Load address of base of array board
2565:    SUB  3,4,3 	Compute offset of value 
2566:     LD  3,0(3) 	Load the value 
2567:     ST  3,-4(1) 	Save left side 
2568:    LDC  3,7(6) 	Load constant 
2569:    LDA  4,-1(0) 	Load address of base of array board
2570:    SUB  3,4,3 	Compute offset of value 
2571:     LD  3,0(3) 	Load the value 
2572:     LD  4,-4(1) 	Load left into ac1 
2573:    SUB  4,4,3 	Op == 
2574:    LDC  3,1(6) 	True case 
2575:    JEQ  4,1(7) 	Jump if true 
2576:    LDC  3,0(6) 	False case 
2577:     ST  3,-4(1) 	Save left side 
2578:    LDC  3,6(6) 	Load constant 
2579:    LDA  4,-1(0) 	Load address of base of array board
2580:    SUB  3,4,3 	Compute offset of value 
2581:     LD  3,0(3) 	Load the value 
2582:     ST  3,-5(1) 	Save left side 
2583:    LDC  3,8(6) 	Load constant 
2584:    LDA  4,-1(0) 	Load address of base of array board
2585:    SUB  3,4,3 	Compute offset of value 
2586:     LD  3,0(3) 	Load the value 
2587:     LD  4,-5(1) 	Load left into ac1 
2588:    SUB  4,4,3 	Op == 
2589:    LDC  3,1(6) 	True case 
2590:    JEQ  4,1(7) 	Jump if true 
2591:    LDC  3,0(6) 	False case 
2592:     LD  4,-4(1) 	Load left into ac1 
2593:    JEQ  3,1(7) 	Op AND 
2594:    LDA  3,0(4) 	 
2595:     LD  4,-3(1) 	Load left into ac1 
2596:    JEQ  3,1(7) 	Op AND 
2597:    LDA  3,0(4) 	 
2598:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* RETURN
2600:    LDC  3,1(6) 	Load constant 
2601:    LDA  2,0(3) 	Copy result to rt register 
2602:     LD  3,-1(1) 	Load return address 
2603:     LD  1,0(1) 	Adjust fp 
2604:    LDA  7,0(3) 	Return 
* END compound statement
2599:    LDA  7,5(7) 	Jump around the THEN 
* ENDIF
* WHILE
2605:     LD  3,-2(1) 	Load variable i
2606:    LDA  4,-1(0) 	Load address of base of array board
2607:    SUB  3,4,3 	Compute offset of value 
2608:     LD  3,0(3) 	Load the value 
2609:     ST  3,-3(1) 	Save left side 
2610:    LDC  3,1(6) 	Load constant 
2611:    LDC  4,0(6) 	Load 0 
2612:    SUB  3,4,3 	Op unary - 
2613:     LD  4,-3(1) 	Load left into ac1 
2614:    SUB  3,4,3 	Op != 
2615:    JEQ  3,1(7) 	Jump if true 
2616:    LDC  3,1(6) 	True case 
2617:     ST  3,-3(1) 	Save left side 
2618:     LD  3,-2(1) 	Load variable i
2619:     ST  3,-4(1) 	Save left side 
2620:    LDC  3,9(6) 	Load constant 
2621:     LD  4,-4(1) 	Load left into ac1 
2622:    SUB  4,4,3 	Op < 
2623:    LDC  3,1(6) 	True case 
2624:    JLT  4,1(7) 	Jump if true 
2625:    LDC  3,0(6) 	False case 
2626:     LD  4,-3(1) 	Load left into ac1 
2627:    JEQ  3,1(7) 	Op AND 
2628:    LDA  3,0(4) 	 
2629:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
2631:     LD  3,-2(1) 	load lhs variable i
2632:    LDA  3,1(3) 	increment value of i
2633:     ST  3,-2(1) 	Store variable i
* END compound statement
2634:    LDA  7,-30(7) 	go to beginning of loop 
2630:    LDA  7,4(7) 	No more loop 
* ENDWHILE
* IF
2635:     LD  3,-2(1) 	Load variable i
2636:     ST  3,-3(1) 	Save left side 
2637:    LDC  3,9(6) 	Load constant 
2638:     LD  4,-3(1) 	Load left into ac1 
2639:    SUB  4,4,3 	Op == 
2640:    LDC  3,1(6) 	True case 
2641:    JEQ  4,1(7) 	Jump if true 
2642:    LDC  3,0(6) 	False case 
2643:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* RETURN
2645:    LDC  3,1(6) 	Load constant 
2646:    LDA  2,0(3) 	Copy result to rt register 
2647:     LD  3,-1(1) 	Load return address 
2648:     LD  1,0(1) 	Adjust fp 
2649:    LDA  7,0(3) 	Return 
* END compound statement
* ELSE
2644:    LDA  7,6(7) 	Jump around the THEN 
* BEGIN compound statement
* RETURN
2651:    LDC  3,0(6) 	Load constant 
2652:    LDA  2,0(3) 	Copy result to rt register 
2653:     LD  3,-1(1) 	Load return address 
2654:     LD  1,0(1) 	Adjust fp 
2655:    LDA  7,0(3) 	Return 
* END compound statement
2650:    LDA  7,5(7) 	Jump around the ELSE 
* ENDIF
* END compound statement
* Add standard closing in case there is no return statement
2656:    LDC  2,0(6) 	Set return value to 0 
2657:     LD  3,-1(1) 	Load return address 
2658:     LD  1,0(1) 	Adjust fp 
2659:    LDA  7,0(3) 	Return 
* END of function finished
* BEGIN function playgame
2660:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
2661:    LDC  3,9(6) 	Load constant 
2662:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
2663:     ST  1,-3(1) 	Store old fp in ghost frame 
2664:    LDA  1,-3(1) 	Load address of new frame 
2665:    LDA  3,1(7) 	Return address in ac 
2666:    LDA  7,-2642(7) 	CALL outnl
2667:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
2668:     ST  1,-3(1) 	Store old fp in ghost frame 
2669:    LDA  1,-3(1) 	Load address of new frame 
2670:    LDA  3,1(7) 	Return address in ac 
2671:    LDA  7,-562(7) 	CALL printboard
2672:    LDA  3,0(2) 	Save the result in ac 
* WHILE
2673:     ST  1,-3(1) 	Store old fp in ghost frame 
2674:    LDA  1,-3(1) 	Load address of new frame 
2675:    LDA  3,1(7) 	Return address in ac 
2676:    LDA  7,-458(7) 	CALL finished
2677:    LDA  3,0(2) 	Save the result in ac 
2678:    LDC  4,1(6) 	Load 1 
2679:    SUB  3,4,3 	Op NOT 
2680:     ST  3,-3(1) 	Save left side 
2681:     LD  3,-10(0) 	Load variable gamenotdone
2682:     ST  3,-4(1) 	Save left side 
2683:    LDC  3,1(6) 	Load constant 
2684:     LD  4,-4(1) 	Load left into ac1 
2685:    SUB  4,4,3 	Op == 
2686:    LDC  3,1(6) 	True case 
2687:    JEQ  4,1(7) 	Jump if true 
2688:    LDC  3,0(6) 	False case 
2689:     LD  4,-3(1) 	Load left into ac1 
2690:    JEQ  3,1(7) 	Op AND 
2691:    LDA  3,0(4) 	 
2692:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
2694:     ST  1,-3(1) 	Store old fp in ghost frame 
2695:    LDA  1,-3(1) 	Load address of new frame 
2696:    LDA  3,1(7) 	Return address in ac 
2697:    LDA  7,-2697(7) 	CALL input
2698:    LDA  3,0(2) 	Save the result in ac 
2699:     ST  3,-2(1) 	Store variable x
* IF
2700:     ST  1,-3(1) 	Store old fp in ghost frame 
2701:     LD  3,-2(1) 	Load variable x
2702:     ST  3,-5(1) 	Store parameter 
2703:    LDA  1,-3(1) 	Load address of new frame 
2704:    LDA  3,1(7) 	Return address in ac 
2705:    LDA  7,-665(7) 	CALL xingrid
2706:    LDA  3,0(2) 	Save the result in ac 
2707:     ST  3,-3(1) 	Save left side 
2708:     ST  1,-4(1) 	Store old fp in ghost frame 
2709:    LDA  1,-4(1) 	Load address of new frame 
2710:    LDA  3,1(7) 	Return address in ac 
2711:    LDA  7,-493(7) 	CALL finished
2712:    LDA  3,0(2) 	Save the result in ac 
2713:    LDC  4,1(6) 	Load 1 
2714:    SUB  3,4,3 	Op NOT 
2715:     LD  4,-3(1) 	Load left into ac1 
2716:    JEQ  3,1(7) 	Op AND 
2717:    LDA  3,0(4) 	 
2718:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
2720:     ST  1,-3(1) 	Store old fp in ghost frame 
2721:    LDA  1,-3(1) 	Load address of new frame 
2722:    LDA  3,1(7) 	Return address in ac 
2723:    LDA  7,-711(7) 	CALL placey
2724:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
2725:     ST  1,-3(1) 	Store old fp in ghost frame 
2726:    LDA  1,-3(1) 	Load address of new frame 
2727:    LDA  3,1(7) 	Return address in ac 
2728:    LDA  7,-2704(7) 	CALL outnl
2729:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
2730:     ST  1,-3(1) 	Store old fp in ghost frame 
2731:    LDA  1,-3(1) 	Load address of new frame 
2732:    LDA  3,1(7) 	Return address in ac 
2733:    LDA  7,-624(7) 	CALL printboard
2734:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
2735:     ST  1,-3(1) 	Store old fp in ghost frame 
2736:    LDA  1,-3(1) 	Load address of new frame 
2737:    LDA  3,1(7) 	Return address in ac 
2738:    LDA  7,-2714(7) 	CALL outnl
2739:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
2719:    LDA  7,20(7) 	Jump around the THEN 
* ENDIF
* END compound statement
2740:    LDA  7,-68(7) 	go to beginning of loop 
2693:    LDA  7,47(7) 	No more loop 
* ENDWHILE
* END compound statement
* Add standard closing in case there is no return statement
2741:    LDC  2,0(6) 	Set return value to 0 
2742:     LD  3,-1(1) 	Load return address 
2743:     LD  1,0(1) 	Adjust fp 
2744:    LDA  7,0(3) 	Return 
* END of function playgame
* BEGIN function main
2745:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
2746:    LDC  3,0(6) 	Load constant 
2747:     ST  3,-2(1) 	Store variable i
* WHILE
2748:     LD  3,-2(1) 	Load variable i
2749:     ST  3,-3(1) 	Save left side 
2750:    LDC  3,9(6) 	Load constant 
2751:     LD  4,-3(1) 	Load left into ac1 
2752:    SUB  4,4,3 	Op < 
2753:    LDC  3,1(6) 	True case 
2754:    JLT  4,1(7) 	Jump if true 
2755:    LDC  3,0(6) 	False case 
2756:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
2758:     LD  3,-2(1) 	Load variable i
2759:     ST  3,-3(1) 	Save index 
2760:    LDC  3,1(6) 	Load constant 
2761:    LDC  4,0(6) 	Load 0 
2762:    SUB  3,4,3 	Op unary - 
2763:     LD  4,-3(1) 	Restore index 
2764:    LDA  5,-1(0) 	Load address of base of array board
2765:    SUB  5,5,4 	Compute offset of value 
2766:     ST  3,0(5) 	Store variable board
* EXPRESSION STMT
2767:     LD  3,-2(1) 	load lhs variable i
2768:    LDA  3,1(3) 	increment value of i
2769:     ST  3,-2(1) 	Store variable i
* END compound statement
2770:    LDA  7,-23(7) 	go to beginning of loop 
2757:    LDA  7,13(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
2771:    LDC  3,1(6) 	Load constant 
2772:     ST  3,-10(0) 	Store variable gamenotdone
* EXPRESSION STMT
2773:     ST  1,-3(1) 	Store old fp in ghost frame 
2774:    LDA  1,-3(1) 	Load address of new frame 
2775:    LDA  3,1(7) 	Return address in ac 
2776:    LDA  7,-117(7) 	CALL playgame
2777:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
2778:     ST  1,-3(1) 	Store old fp in ghost frame 
2779:    LDA  1,-3(1) 	Load address of new frame 
2780:    LDA  3,1(7) 	Return address in ac 
2781:    LDA  7,-2757(7) 	CALL outnl
2782:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
2783:     ST  1,-3(1) 	Store old fp in ghost frame 
2784:    LDA  1,-3(1) 	Load address of new frame 
2785:    LDA  3,1(7) 	Return address in ac 
2786:    LDA  7,-677(7) 	CALL printboard
2787:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
2788:     ST  1,-3(1) 	Store old fp in ghost frame 
2789:    LDA  1,-3(1) 	Load address of new frame 
2790:    LDA  3,1(7) 	Return address in ac 
2791:    LDA  7,-2767(7) 	CALL outnl
2792:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
2793:    LDC  2,0(6) 	Set return value to 0 
2794:     LD  3,-1(1) 	Load return address 
2795:     LD  1,0(1) 	Adjust fp 
2796:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,2796(7) 	Jump to init 
* BEGIN Init
2797:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
2798:    LDC  3,9(6) 	load size of array board
2799:     ST  3,0(0) 	save size of array board
* END init of global array sizes
2800:    LDA  1,-11(0) 	set first frame at end of globals 
2801:     ST  1,0(1) 	store old fp (point to self) 
2802:    LDA  3,1(7) 	Return address in ac 
2803:    LDA  7,-59(7) 	Jump to main 
2804:   HALT  0,0,0 	DONE! 
* END Init
