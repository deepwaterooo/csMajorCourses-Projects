* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  types2.tm
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
 31:    LDC  3,2(6) 	load size of array ia
 32:     ST  3,-4(1) 	save size of array ia
 33:    LDC  3,2(6) 	load size of array ba
 34:     ST  3,-7(1) 	save size of array ba
 35:     LD  3,-2(1) 	Load variable i
 36:     ST  3,-10(1) 	Save left side 
 37:     LD  3,-2(1) 	Load variable i
 38:     LD  4,-10(1) 	Load left into ac1 
 39:    ADD  3,4,3 	Op + 
 40:     LD  3,-2(1) 	Load variable i
 41:     ST  3,-10(1) 	Save left side 
 42:     LD  3,-3(1) 	Load variable b
 43:     LD  4,-10(1) 	Load left into ac1 
 44:    ADD  3,4,3 	Op + 
 45:     LD  3,-3(1) 	Load variable b
 46:     ST  3,-10(1) 	Save left side 
 47:     LD  3,-2(1) 	Load variable i
 48:     LD  4,-10(1) 	Load left into ac1 
 49:    ADD  3,4,3 	Op + 
 50:     LD  3,-3(1) 	Load variable b
 51:     ST  3,-10(1) 	Save left side 
 52:     LD  3,-3(1) 	Load variable b
 53:     LD  4,-10(1) 	Load left into ac1 
 54:    ADD  3,4,3 	Op + 
 55:     LD  3,-2(1) 	Load variable i
 56:     ST  3,-10(1) 	Save left side 
 57:     LD  3,-2(1) 	Load variable i
 58:     LD  4,-10(1) 	Load left into ac1 
 59:    JEQ  3,1(7) 	Op AND 
 60:    LDA  3,0(4) 	 
 61:     LD  3,-2(1) 	Load variable i
 62:     ST  3,-10(1) 	Save left side 
 63:     LD  3,-3(1) 	Load variable b
 64:     LD  4,-10(1) 	Load left into ac1 
 65:    JEQ  3,1(7) 	Op AND 
 66:    LDA  3,0(4) 	 
 67:     LD  3,-3(1) 	Load variable b
 68:     ST  3,-10(1) 	Save left side 
 69:     LD  3,-2(1) 	Load variable i
 70:     LD  4,-10(1) 	Load left into ac1 
 71:    JEQ  3,1(7) 	Op AND 
 72:    LDA  3,0(4) 	 
 73:     LD  3,-3(1) 	Load variable b
 74:     ST  3,-10(1) 	Save left side 
 75:     LD  3,-3(1) 	Load variable b
 76:     LD  4,-10(1) 	Load left into ac1 
 77:    JEQ  3,1(7) 	Op AND 
 78:    LDA  3,0(4) 	 
* EXPRESSION STMT
 79:     LD  3,-2(1) 	Load variable i
 80:     ST  3,-2(1) 	Store variable i
* EXPRESSION STMT
 81:     LD  3,-3(1) 	Load variable b
 82:     ST  3,-2(1) 	Store variable i
* EXPRESSION STMT
 83:     LD  3,-2(1) 	Load variable i
 84:     ST  3,-3(1) 	Store variable b
* EXPRESSION STMT
 85:     LD  3,-3(1) 	Load variable b
 86:     ST  3,-3(1) 	Store variable b
 87:     LD  3,-2(1) 	Load variable i
 88:     ST  3,-10(1) 	Save left side 
 89:     LD  3,-2(1) 	Load variable i
 90:     LD  4,-10(1) 	Load left into ac1 
 91:    SUB  3,4,3 	Op == 
 92:    JEQ  3,2(7) 	br if true 
 93:    LDC  3,0(3) 	false case 
 94:    LDA  7,1(7) 	unconditional jmp 
 95:    LDC  3,1(3) 	true case 
 96:     LD  3,-2(1) 	Load variable i
 97:     ST  3,-10(1) 	Save left side 
 98:     LD  3,-3(1) 	Load variable b
 99:     LD  4,-10(1) 	Load left into ac1 
100:    SUB  3,4,3 	Op == 
101:    JEQ  3,2(7) 	br if true 
102:    LDC  3,0(3) 	false case 
103:    LDA  7,1(7) 	unconditional jmp 
104:    LDC  3,1(3) 	true case 
105:     LD  3,-3(1) 	Load variable b
106:     ST  3,-10(1) 	Save left side 
107:     LD  3,-2(1) 	Load variable i
108:     LD  4,-10(1) 	Load left into ac1 
109:    SUB  3,4,3 	Op == 
110:    JEQ  3,2(7) 	br if true 
111:    LDC  3,0(3) 	false case 
112:    LDA  7,1(7) 	unconditional jmp 
113:    LDC  3,1(3) 	true case 
114:     LD  3,-3(1) 	Load variable b
115:     ST  3,-10(1) 	Save left side 
116:     LD  3,-3(1) 	Load variable b
117:     LD  4,-10(1) 	Load left into ac1 
118:    SUB  3,4,3 	Op == 
119:    JEQ  3,2(7) 	br if true 
120:    LDC  3,0(3) 	false case 
121:    LDA  7,1(7) 	unconditional jmp 
122:    LDC  3,1(3) 	true case 
123:     LD  3,-2(1) 	Load variable i
124:     ST  3,-10(1) 	Save left side 
125:     LD  3,-2(1) 	Load variable i
126:     LD  4,-10(1) 	Load left into ac1 
127:     LD  3,-2(1) 	Load variable i
128:     ST  3,-10(1) 	Save left side 
129:     LD  3,-3(1) 	Load variable b
130:     LD  4,-10(1) 	Load left into ac1 
131:     LD  3,-3(1) 	Load variable b
132:     ST  3,-10(1) 	Save left side 
133:     LD  3,-2(1) 	Load variable i
134:     LD  4,-10(1) 	Load left into ac1 
135:     LD  3,-3(1) 	Load variable b
136:     ST  3,-10(1) 	Save left side 
137:     LD  3,-3(1) 	Load variable b
138:     LD  4,-10(1) 	Load left into ac1 
139:     LD  3,-5(1) 	Load variable ia
140:     ST  3,-10(1) 	Save left side 
141:     LD  3,-5(1) 	Load variable ia
142:     LD  4,-10(1) 	Load left into ac1 
143:    ADD  3,4,3 	Op + 
144:     LD  3,-5(1) 	Load variable ia
145:     ST  3,-10(1) 	Save left side 
146:     LD  3,-8(1) 	Load variable ba
147:     LD  4,-10(1) 	Load left into ac1 
148:    ADD  3,4,3 	Op + 
149:     LD  3,-8(1) 	Load variable ba
150:     ST  3,-10(1) 	Save left side 
151:     LD  3,-5(1) 	Load variable ia
152:     LD  4,-10(1) 	Load left into ac1 
153:    ADD  3,4,3 	Op + 
154:     LD  3,-8(1) 	Load variable ba
155:     ST  3,-10(1) 	Save left side 
156:     LD  3,-8(1) 	Load variable ba
157:     LD  4,-10(1) 	Load left into ac1 
158:    ADD  3,4,3 	Op + 
159:     LD  3,-5(1) 	Load variable ia
160:     ST  3,-10(1) 	Save left side 
161:     LD  3,-5(1) 	Load variable ia
162:     LD  4,-10(1) 	Load left into ac1 
163:    JEQ  3,1(7) 	Op AND 
164:    LDA  3,0(4) 	 
165:     LD  3,-5(1) 	Load variable ia
166:     ST  3,-10(1) 	Save left side 
167:     LD  3,-8(1) 	Load variable ba
168:     LD  4,-10(1) 	Load left into ac1 
169:    JEQ  3,1(7) 	Op AND 
170:    LDA  3,0(4) 	 
171:     LD  3,-8(1) 	Load variable ba
172:     ST  3,-10(1) 	Save left side 
173:     LD  3,-5(1) 	Load variable ia
174:     LD  4,-10(1) 	Load left into ac1 
175:    JEQ  3,1(7) 	Op AND 
176:    LDA  3,0(4) 	 
177:     LD  3,-8(1) 	Load variable ba
178:     ST  3,-10(1) 	Save left side 
179:     LD  3,-8(1) 	Load variable ba
180:     LD  4,-10(1) 	Load left into ac1 
181:    JEQ  3,1(7) 	Op AND 
182:    LDA  3,0(4) 	 
* EXPRESSION STMT
183:     LD  3,-5(1) 	Load variable ia
184:     ST  3,-5(1) 	Store variable ia
* EXPRESSION STMT
185:     LD  3,-8(1) 	Load variable ba
186:     ST  3,-5(1) 	Store variable ia
* EXPRESSION STMT
187:     LD  3,-5(1) 	Load variable ia
188:     ST  3,-8(1) 	Store variable ba
* EXPRESSION STMT
189:     LD  3,-8(1) 	Load variable ba
190:     ST  3,-8(1) 	Store variable ba
191:     LD  3,-5(1) 	Load variable ia
192:     ST  3,-10(1) 	Save left side 
193:     LD  3,-5(1) 	Load variable ia
194:     LD  4,-10(1) 	Load left into ac1 
195:    SUB  3,4,3 	Op == 
196:    JEQ  3,2(7) 	br if true 
197:    LDC  3,0(3) 	false case 
198:    LDA  7,1(7) 	unconditional jmp 
199:    LDC  3,1(3) 	true case 
200:     LD  3,-5(1) 	Load variable ia
201:     ST  3,-10(1) 	Save left side 
202:     LD  3,-8(1) 	Load variable ba
203:     LD  4,-10(1) 	Load left into ac1 
204:    SUB  3,4,3 	Op == 
205:    JEQ  3,2(7) 	br if true 
206:    LDC  3,0(3) 	false case 
207:    LDA  7,1(7) 	unconditional jmp 
208:    LDC  3,1(3) 	true case 
209:     LD  3,-8(1) 	Load variable ba
210:     ST  3,-10(1) 	Save left side 
211:     LD  3,-5(1) 	Load variable ia
212:     LD  4,-10(1) 	Load left into ac1 
213:    SUB  3,4,3 	Op == 
214:    JEQ  3,2(7) 	br if true 
215:    LDC  3,0(3) 	false case 
216:    LDA  7,1(7) 	unconditional jmp 
217:    LDC  3,1(3) 	true case 
218:     LD  3,-8(1) 	Load variable ba
219:     ST  3,-10(1) 	Save left side 
220:     LD  3,-8(1) 	Load variable ba
221:     LD  4,-10(1) 	Load left into ac1 
222:    SUB  3,4,3 	Op == 
223:    JEQ  3,2(7) 	br if true 
224:    LDC  3,0(3) 	false case 
225:    LDA  7,1(7) 	unconditional jmp 
226:    LDC  3,1(3) 	true case 
227:     LD  3,-3(1) 	Load variable b
228:     ST  3,-10(1) 	Save left side 
229:     LD  3,-2(1) 	Load variable i
230:     LD  4,-10(1) 	Load left into ac1 
231:    ADD  3,4,3 	Op + 
232:     ST  3,-10(1) 	Save left side 
233:     LD  3,-2(1) 	Load variable i
234:     LD  4,-10(1) 	Load left into ac1 
235:    ADD  3,4,3 	Op + 
236:     LD  3,-2(1) 	Load variable i
237:     ST  3,-10(1) 	Save left side 
238:     LD  3,-3(1) 	Load variable b
239:     LD  4,-10(1) 	Load left into ac1 
240:    ADD  3,4,3 	Op + 
241:     ST  3,-10(1) 	Save left side 
242:     LD  3,-2(1) 	Load variable i
243:     LD  4,-10(1) 	Load left into ac1 
244:    ADD  3,4,3 	Op + 
245:     LD  3,-2(1) 	Load variable i
246:     ST  3,-10(1) 	Save left side 
247:     LD  3,-2(1) 	Load variable i
248:     LD  4,-10(1) 	Load left into ac1 
249:    ADD  3,4,3 	Op + 
250:     ST  3,-10(1) 	Save left side 
251:     LD  3,-3(1) 	Load variable b
252:     LD  4,-10(1) 	Load left into ac1 
253:    ADD  3,4,3 	Op + 
254:     LD  3,-2(1) 	Load variable i
255:     ST  3,-10(1) 	Save left side 
256:     LD  3,-3(1) 	Load variable b
257:     LD  4,-10(1) 	Load left into ac1 
258:     ST  3,-10(1) 	Save left side 
259:     LD  3,-3(1) 	Load variable b
260:     LD  4,-10(1) 	Load left into ac1 
261:     LD  3,-3(1) 	Load variable b
262:     ST  3,-10(1) 	Save left side 
263:     LD  3,-2(1) 	Load variable i
264:     LD  4,-10(1) 	Load left into ac1 
265:     ST  3,-10(1) 	Save left side 
266:     LD  3,-3(1) 	Load variable b
267:     LD  4,-10(1) 	Load left into ac1 
268:     LD  3,-3(1) 	Load variable b
269:     ST  3,-10(1) 	Save left side 
270:     LD  3,-3(1) 	Load variable b
271:     LD  4,-10(1) 	Load left into ac1 
272:     ST  3,-10(1) 	Save left side 
273:     LD  3,-2(1) 	Load variable i
274:     LD  4,-10(1) 	Load left into ac1 
275:     LD  3,-3(1) 	Load variable b
276:     LD  3,-2(1) 	Load variable i
277:     LD  3,-8(1) 	Load variable ba
278:     LD  3,-5(1) 	Load variable ia
279:     LD  3,-3(1) 	Load variable b
280:    LDC  4,0(6) 	Load 0 
281:    SUB  3,4,3 	Op unary - 
282:     LD  3,-2(1) 	Load variable i
283:    LDC  4,0(6) 	Load 0 
284:    SUB  3,4,3 	Op unary - 
285:     LD  3,-8(1) 	Load variable ba
286:    LDC  4,0(6) 	Load 0 
287:    SUB  3,4,3 	Op unary - 
288:     LD  3,-5(1) 	Load variable ia
289:    LDC  4,0(6) 	Load 0 
290:    SUB  3,4,3 	Op unary - 
291:     LD  3,-2(1) 	Load variable i
292:     ST  3,-10(1) 	Save left side 
293:     LD  3,-2(1) 	Load variable i
294:     LD  4,-10(1) 	Load left into ac1 
295:     ST  3,-10(1) 	Save left side 
296:     LD  3,-2(1) 	Load variable i
297:     ST  3,-11(1) 	Save left side 
298:     LD  3,-2(1) 	Load variable i
299:     LD  4,-11(1) 	Load left into ac1 
300:     LD  4,-10(1) 	Load left into ac1 
301:     LD  3,-3(1) 	Load variable b
302:     ST  3,-10(1) 	Save left side 
303:     LD  3,-2(1) 	Load variable i
304:     LD  4,-10(1) 	Load left into ac1 
305:     ST  3,-10(1) 	Save left side 
306:     LD  3,-2(1) 	Load variable i
307:     ST  3,-11(1) 	Save left side 
308:     LD  3,-2(1) 	Load variable i
309:     LD  4,-11(1) 	Load left into ac1 
310:     LD  4,-10(1) 	Load left into ac1 
311:     LD  3,-2(1) 	Load variable i
312:     ST  3,-10(1) 	Save left side 
313:     LD  3,-3(1) 	Load variable b
314:     LD  4,-10(1) 	Load left into ac1 
315:     ST  3,-10(1) 	Save left side 
316:     LD  3,-2(1) 	Load variable i
317:     ST  3,-11(1) 	Save left side 
318:     LD  3,-2(1) 	Load variable i
319:     LD  4,-11(1) 	Load left into ac1 
320:     LD  4,-10(1) 	Load left into ac1 
321:     LD  3,-2(1) 	Load variable i
322:     ST  3,-10(1) 	Save left side 
323:     LD  3,-2(1) 	Load variable i
324:     LD  4,-10(1) 	Load left into ac1 
325:     ST  3,-10(1) 	Save left side 
326:     LD  3,-3(1) 	Load variable b
327:     ST  3,-11(1) 	Save left side 
328:     LD  3,-2(1) 	Load variable i
329:     LD  4,-11(1) 	Load left into ac1 
330:     LD  4,-10(1) 	Load left into ac1 
331:     LD  3,-3(1) 	Load variable b
332:     ST  3,-10(1) 	Save left side 
333:     LD  3,-2(1) 	Load variable i
334:     LD  4,-10(1) 	Load left into ac1 
335:     ST  3,-10(1) 	Save left side 
336:     LD  3,-2(1) 	Load variable i
337:     ST  3,-11(1) 	Save left side 
338:     LD  3,-3(1) 	Load variable b
339:     LD  4,-11(1) 	Load left into ac1 
340:     LD  4,-10(1) 	Load left into ac1 
341:     LD  3,-3(1) 	Load variable b
342:     ST  3,-10(1) 	Save left side 
343:     LD  3,-3(1) 	Load variable b
344:     LD  4,-10(1) 	Load left into ac1 
345:     ST  3,-10(1) 	Save left side 
346:     LD  3,-3(1) 	Load variable b
347:     ST  3,-11(1) 	Save left side 
348:     LD  3,-3(1) 	Load variable b
349:     LD  4,-11(1) 	Load left into ac1 
350:     LD  4,-10(1) 	Load left into ac1 
351:    JEQ  3,1(7) 	Op AND 
352:    LDA  3,0(4) 	 
353:    LDC  3,1(6) 	Load constant 
* EXPRESSION STMT
355:     LD  3,-2(1) 	Load variable i
356:     ST  3,-2(1) 	Store variable i
354:    JEQ  3,3(7) 	if: jmp to else 
* EXPRESSION STMT
358:     LD  3,-3(1) 	Load variable b
359:     ST  3,-3(1) 	Store variable b
357:    LDA  7,2(7) 	jmp to end 
360:     LD  3,-8(1) 	Load variable ba
* EXPRESSION STMT
362:     LD  3,-2(1) 	Load variable i
363:     ST  3,-2(1) 	Store variable i
361:    JEQ  3,3(7) 	if: jmp to else 
* EXPRESSION STMT
365:     LD  3,-3(1) 	Load variable b
366:     ST  3,-3(1) 	Store variable b
364:    LDA  7,2(7) 	jmp to end 
367:     LD  3,-5(1) 	Load variable ia
* EXPRESSION STMT
369:     LD  3,-2(1) 	Load variable i
370:     ST  3,-2(1) 	Store variable i
368:    JEQ  3,3(7) 	if: jmp to else 
* EXPRESSION STMT
372:     LD  3,-3(1) 	Load variable b
373:     ST  3,-3(1) 	Store variable b
371:    LDA  7,2(7) 	jmp to end 
374:     LD  3,-3(1) 	Load variable b
* EXPRESSION STMT
376:     LD  3,-2(1) 	Load variable i
377:     ST  3,-2(1) 	Store variable i
375:    JEQ  3,3(7) 	if: jmp to else 
* EXPRESSION STMT
379:     LD  3,-3(1) 	Load variable b
380:     ST  3,-3(1) 	Store variable b
378:    LDA  7,2(7) 	jmp to end 
* WHILE
381:    LDC  3,1(6) 	Load constant 
382:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
384:     LD  3,-2(1) 	Load variable i
385:     ST  3,-2(1) 	Store variable i
386:    LDA  7,-4(7) 	go to beginning of loop 
383:    LDA  7,3(7) 	No more loop 
* end WHILE
* WHILE
387:     LD  3,-8(1) 	Load variable ba
388:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
390:     LD  3,-2(1) 	Load variable i
391:     ST  3,-2(1) 	Store variable i
392:    LDA  7,-4(7) 	go to beginning of loop 
389:    LDA  7,3(7) 	No more loop 
* end WHILE
* WHILE
393:     LD  3,-5(1) 	Load variable ia
394:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
396:     LD  3,-2(1) 	Load variable i
397:     ST  3,-2(1) 	Store variable i
398:    LDA  7,-4(7) 	go to beginning of loop 
395:    LDA  7,3(7) 	No more loop 
* end WHILE
* WHILE
399:     LD  3,-3(1) 	Load variable b
400:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
402:     LD  3,-2(1) 	Load variable i
403:     ST  3,-2(1) 	Store variable i
404:    LDA  7,-4(7) 	go to beginning of loop 
401:    LDA  7,3(7) 	No more loop 
* end WHILE
* END compound statement
* Add standard closing in case there is no return statement
405:    LDC  2,0(6) 	Set return value to 0 
406:     LD  3,-1(1) 	Load return address 
407:     LD  1,0(1) 	Adjust fp 
408:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,408(7) 	Jump to init 
* BEGIN Init
409:     LD  0,0(0) 	Set the global pointer 
410:    LDA  1,0(0) 	set first frame at end of globals 
411:     ST  1,0(1) 	store old fp (point to self) 
412:    LDA  3,1(7) 	Return address in ac 
413:    LDA  7,-384(7) 	Jump to main 
414:   HALT  0,0,0 	DONE! 
* END Init
