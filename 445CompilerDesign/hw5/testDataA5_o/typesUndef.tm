* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  typesUndef.tm
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
 31:     LD  3,0(1) 	Load variable i
 32:     ST  3,-2(1) 	Save left side 
 33:     LD  3,0(1) 	Load variable i
 34:     LD  4,-2(1) 	Load left into ac1 
 35:    ADD  3,4,3 	Op + 
 36:     LD  3,0(1) 	Load variable i
 37:     ST  3,-2(1) 	Save left side 
 38:     LD  3,0(1) 	Load variable b
 39:     LD  4,-2(1) 	Load left into ac1 
 40:    ADD  3,4,3 	Op + 
 41:     LD  3,0(1) 	Load variable b
 42:     ST  3,-2(1) 	Save left side 
 43:     LD  3,0(1) 	Load variable i
 44:     LD  4,-2(1) 	Load left into ac1 
 45:    ADD  3,4,3 	Op + 
 46:     LD  3,0(1) 	Load variable b
 47:     ST  3,-2(1) 	Save left side 
 48:     LD  3,0(1) 	Load variable b
 49:     LD  4,-2(1) 	Load left into ac1 
 50:    ADD  3,4,3 	Op + 
 51:     LD  3,0(1) 	Load variable i
 52:     ST  3,-2(1) 	Save left side 
 53:     LD  3,0(1) 	Load variable i
 54:     LD  4,-2(1) 	Load left into ac1 
 55:    JEQ  3,1(7) 	Op AND 
 56:    LDA  3,0(4) 	 
 57:     LD  3,0(1) 	Load variable i
 58:     ST  3,-2(1) 	Save left side 
 59:     LD  3,0(1) 	Load variable b
 60:     LD  4,-2(1) 	Load left into ac1 
 61:    JEQ  3,1(7) 	Op AND 
 62:    LDA  3,0(4) 	 
 63:     LD  3,0(1) 	Load variable b
 64:     ST  3,-2(1) 	Save left side 
 65:     LD  3,0(1) 	Load variable i
 66:     LD  4,-2(1) 	Load left into ac1 
 67:    JEQ  3,1(7) 	Op AND 
 68:    LDA  3,0(4) 	 
 69:     LD  3,0(1) 	Load variable b
 70:     ST  3,-2(1) 	Save left side 
 71:     LD  3,0(1) 	Load variable b
 72:     LD  4,-2(1) 	Load left into ac1 
 73:    JEQ  3,1(7) 	Op AND 
 74:    LDA  3,0(4) 	 
* EXPRESSION STMT
 75:     LD  3,0(1) 	Load variable i
 76:     ST  3,0(1) 	Store variable i
* EXPRESSION STMT
 77:     LD  3,0(1) 	Load variable b
 78:     ST  3,0(1) 	Store variable i
* EXPRESSION STMT
 79:     LD  3,0(1) 	Load variable i
 80:     ST  3,0(1) 	Store variable b
* EXPRESSION STMT
 81:     LD  3,0(1) 	Load variable b
 82:     ST  3,0(1) 	Store variable b
 83:     LD  3,0(1) 	Load variable i
 84:     ST  3,-2(1) 	Save left side 
 85:     LD  3,0(1) 	Load variable i
 86:     LD  4,-2(1) 	Load left into ac1 
 87:    SUB  3,4,3 	Op == 
 88:    JEQ  3,2(7) 	br if true 
 89:    LDC  3,0(3) 	false case 
 90:    LDA  7,1(7) 	unconditional jmp 
 91:    LDC  3,1(3) 	true case 
 92:     LD  3,0(1) 	Load variable i
 93:     ST  3,-2(1) 	Save left side 
 94:     LD  3,0(1) 	Load variable b
 95:     LD  4,-2(1) 	Load left into ac1 
 96:    SUB  3,4,3 	Op == 
 97:    JEQ  3,2(7) 	br if true 
 98:    LDC  3,0(3) 	false case 
 99:    LDA  7,1(7) 	unconditional jmp 
100:    LDC  3,1(3) 	true case 
101:     LD  3,0(1) 	Load variable b
102:     ST  3,-2(1) 	Save left side 
103:     LD  3,0(1) 	Load variable i
104:     LD  4,-2(1) 	Load left into ac1 
105:    SUB  3,4,3 	Op == 
106:    JEQ  3,2(7) 	br if true 
107:    LDC  3,0(3) 	false case 
108:    LDA  7,1(7) 	unconditional jmp 
109:    LDC  3,1(3) 	true case 
110:     LD  3,0(1) 	Load variable b
111:     ST  3,-2(1) 	Save left side 
112:     LD  3,0(1) 	Load variable b
113:     LD  4,-2(1) 	Load left into ac1 
114:    SUB  3,4,3 	Op == 
115:    JEQ  3,2(7) 	br if true 
116:    LDC  3,0(3) 	false case 
117:    LDA  7,1(7) 	unconditional jmp 
118:    LDC  3,1(3) 	true case 
119:     LD  3,0(1) 	Load variable i
120:     ST  3,-2(1) 	Save left side 
121:     LD  3,0(1) 	Load variable i
122:     LD  4,-2(1) 	Load left into ac1 
123:     LD  3,0(1) 	Load variable i
124:     ST  3,-2(1) 	Save left side 
125:     LD  3,0(1) 	Load variable b
126:     LD  4,-2(1) 	Load left into ac1 
127:     LD  3,0(1) 	Load variable b
128:     ST  3,-2(1) 	Save left side 
129:     LD  3,0(1) 	Load variable i
130:     LD  4,-2(1) 	Load left into ac1 
131:     LD  3,0(1) 	Load variable b
132:     ST  3,-2(1) 	Save left side 
133:     LD  3,0(1) 	Load variable b
134:     LD  4,-2(1) 	Load left into ac1 
135:     LD  3,0(1) 	Load variable ia
136:     ST  3,-2(1) 	Save left side 
137:     LD  3,0(1) 	Load variable ia
138:     LD  4,-2(1) 	Load left into ac1 
139:    ADD  3,4,3 	Op + 
140:     LD  3,0(1) 	Load variable ia
141:     ST  3,-2(1) 	Save left side 
142:     LD  3,0(1) 	Load variable ba
143:     LD  4,-2(1) 	Load left into ac1 
144:    ADD  3,4,3 	Op + 
145:     LD  3,0(1) 	Load variable ba
146:     ST  3,-2(1) 	Save left side 
147:     LD  3,0(1) 	Load variable ia
148:     LD  4,-2(1) 	Load left into ac1 
149:    ADD  3,4,3 	Op + 
150:     LD  3,0(1) 	Load variable ba
151:     ST  3,-2(1) 	Save left side 
152:     LD  3,0(1) 	Load variable ba
153:     LD  4,-2(1) 	Load left into ac1 
154:    ADD  3,4,3 	Op + 
155:     LD  3,0(1) 	Load variable ia
156:     ST  3,-2(1) 	Save left side 
157:     LD  3,0(1) 	Load variable ia
158:     LD  4,-2(1) 	Load left into ac1 
159:    JEQ  3,1(7) 	Op AND 
160:    LDA  3,0(4) 	 
161:     LD  3,0(1) 	Load variable ia
162:     ST  3,-2(1) 	Save left side 
163:     LD  3,0(1) 	Load variable ba
164:     LD  4,-2(1) 	Load left into ac1 
165:    JEQ  3,1(7) 	Op AND 
166:    LDA  3,0(4) 	 
167:     LD  3,0(1) 	Load variable ba
168:     ST  3,-2(1) 	Save left side 
169:     LD  3,0(1) 	Load variable ia
170:     LD  4,-2(1) 	Load left into ac1 
171:    JEQ  3,1(7) 	Op AND 
172:    LDA  3,0(4) 	 
173:     LD  3,0(1) 	Load variable ba
174:     ST  3,-2(1) 	Save left side 
175:     LD  3,0(1) 	Load variable ba
176:     LD  4,-2(1) 	Load left into ac1 
177:    JEQ  3,1(7) 	Op AND 
178:    LDA  3,0(4) 	 
* EXPRESSION STMT
179:     LD  3,0(1) 	Load variable ia
180:     ST  3,0(1) 	Store variable ia
* EXPRESSION STMT
181:     LD  3,0(1) 	Load variable ba
182:     ST  3,0(1) 	Store variable ia
* EXPRESSION STMT
183:     LD  3,0(1) 	Load variable ia
184:     ST  3,0(1) 	Store variable ba
* EXPRESSION STMT
185:     LD  3,0(1) 	Load variable ba
186:     ST  3,0(1) 	Store variable ba
187:     LD  3,0(1) 	Load variable ia
188:     ST  3,-2(1) 	Save left side 
189:     LD  3,0(1) 	Load variable ia
190:     LD  4,-2(1) 	Load left into ac1 
191:    SUB  3,4,3 	Op == 
192:    JEQ  3,2(7) 	br if true 
193:    LDC  3,0(3) 	false case 
194:    LDA  7,1(7) 	unconditional jmp 
195:    LDC  3,1(3) 	true case 
196:     LD  3,0(1) 	Load variable ia
197:     ST  3,-2(1) 	Save left side 
198:     LD  3,0(1) 	Load variable ba
199:     LD  4,-2(1) 	Load left into ac1 
200:    SUB  3,4,3 	Op == 
201:    JEQ  3,2(7) 	br if true 
202:    LDC  3,0(3) 	false case 
203:    LDA  7,1(7) 	unconditional jmp 
204:    LDC  3,1(3) 	true case 
205:     LD  3,0(1) 	Load variable ba
206:     ST  3,-2(1) 	Save left side 
207:     LD  3,0(1) 	Load variable ia
208:     LD  4,-2(1) 	Load left into ac1 
209:    SUB  3,4,3 	Op == 
210:    JEQ  3,2(7) 	br if true 
211:    LDC  3,0(3) 	false case 
212:    LDA  7,1(7) 	unconditional jmp 
213:    LDC  3,1(3) 	true case 
214:     LD  3,0(1) 	Load variable ba
215:     ST  3,-2(1) 	Save left side 
216:     LD  3,0(1) 	Load variable ba
217:     LD  4,-2(1) 	Load left into ac1 
218:    SUB  3,4,3 	Op == 
219:    JEQ  3,2(7) 	br if true 
220:    LDC  3,0(3) 	false case 
221:    LDA  7,1(7) 	unconditional jmp 
222:    LDC  3,1(3) 	true case 
223:     LD  3,0(1) 	Load variable b
224:     ST  3,-2(1) 	Save left side 
225:     LD  3,0(1) 	Load variable i
226:     LD  4,-2(1) 	Load left into ac1 
227:    ADD  3,4,3 	Op + 
228:     ST  3,-2(1) 	Save left side 
229:     LD  3,0(1) 	Load variable i
230:     LD  4,-2(1) 	Load left into ac1 
231:    ADD  3,4,3 	Op + 
232:     LD  3,0(1) 	Load variable i
233:     ST  3,-2(1) 	Save left side 
234:     LD  3,0(1) 	Load variable b
235:     LD  4,-2(1) 	Load left into ac1 
236:    ADD  3,4,3 	Op + 
237:     ST  3,-2(1) 	Save left side 
238:     LD  3,0(1) 	Load variable i
239:     LD  4,-2(1) 	Load left into ac1 
240:    ADD  3,4,3 	Op + 
241:     LD  3,0(1) 	Load variable i
242:     ST  3,-2(1) 	Save left side 
243:     LD  3,0(1) 	Load variable i
244:     LD  4,-2(1) 	Load left into ac1 
245:    ADD  3,4,3 	Op + 
246:     ST  3,-2(1) 	Save left side 
247:     LD  3,0(1) 	Load variable b
248:     LD  4,-2(1) 	Load left into ac1 
249:    ADD  3,4,3 	Op + 
250:     LD  3,0(1) 	Load variable i
251:     ST  3,-2(1) 	Save left side 
252:     LD  3,0(1) 	Load variable b
253:     LD  4,-2(1) 	Load left into ac1 
254:     ST  3,-2(1) 	Save left side 
255:     LD  3,0(1) 	Load variable b
256:     LD  4,-2(1) 	Load left into ac1 
257:     LD  3,0(1) 	Load variable b
258:     ST  3,-2(1) 	Save left side 
259:     LD  3,0(1) 	Load variable i
260:     LD  4,-2(1) 	Load left into ac1 
261:     ST  3,-2(1) 	Save left side 
262:     LD  3,0(1) 	Load variable b
263:     LD  4,-2(1) 	Load left into ac1 
264:     LD  3,0(1) 	Load variable b
265:     ST  3,-2(1) 	Save left side 
266:     LD  3,0(1) 	Load variable b
267:     LD  4,-2(1) 	Load left into ac1 
268:     ST  3,-2(1) 	Save left side 
269:     LD  3,0(1) 	Load variable i
270:     LD  4,-2(1) 	Load left into ac1 
271:     LD  3,0(1) 	Load variable b
272:     LD  3,0(1) 	Load variable i
273:     LD  3,0(1) 	Load variable ba
274:     LD  3,0(1) 	Load variable ia
275:     LD  3,0(1) 	Load variable b
276:    LDC  4,0(6) 	Load 0 
277:    SUB  3,4,3 	Op unary - 
278:     LD  3,0(1) 	Load variable i
279:    LDC  4,0(6) 	Load 0 
280:    SUB  3,4,3 	Op unary - 
281:     LD  3,0(1) 	Load variable ba
282:    LDC  4,0(6) 	Load 0 
283:    SUB  3,4,3 	Op unary - 
284:     LD  3,0(1) 	Load variable ia
285:    LDC  4,0(6) 	Load 0 
286:    SUB  3,4,3 	Op unary - 
287:     LD  3,0(1) 	Load variable i
288:     ST  3,-2(1) 	Save left side 
289:     LD  3,0(1) 	Load variable i
290:     LD  4,-2(1) 	Load left into ac1 
291:     ST  3,-2(1) 	Save left side 
292:     LD  3,0(1) 	Load variable i
293:     ST  3,-3(1) 	Save left side 
294:     LD  3,0(1) 	Load variable i
295:     LD  4,-3(1) 	Load left into ac1 
296:     LD  4,-2(1) 	Load left into ac1 
297:     LD  3,0(1) 	Load variable b
298:     ST  3,-2(1) 	Save left side 
299:     LD  3,0(1) 	Load variable i
300:     LD  4,-2(1) 	Load left into ac1 
301:     ST  3,-2(1) 	Save left side 
302:     LD  3,0(1) 	Load variable i
303:     ST  3,-3(1) 	Save left side 
304:     LD  3,0(1) 	Load variable i
305:     LD  4,-3(1) 	Load left into ac1 
306:     LD  4,-2(1) 	Load left into ac1 
307:     LD  3,0(1) 	Load variable i
308:     ST  3,-2(1) 	Save left side 
309:     LD  3,0(1) 	Load variable b
310:     LD  4,-2(1) 	Load left into ac1 
311:     ST  3,-2(1) 	Save left side 
312:     LD  3,0(1) 	Load variable i
313:     ST  3,-3(1) 	Save left side 
314:     LD  3,0(1) 	Load variable i
315:     LD  4,-3(1) 	Load left into ac1 
316:     LD  4,-2(1) 	Load left into ac1 
317:     LD  3,0(1) 	Load variable i
318:     ST  3,-2(1) 	Save left side 
319:     LD  3,0(1) 	Load variable i
320:     LD  4,-2(1) 	Load left into ac1 
321:     ST  3,-2(1) 	Save left side 
322:     LD  3,0(1) 	Load variable b
323:     ST  3,-3(1) 	Save left side 
324:     LD  3,0(1) 	Load variable i
325:     LD  4,-3(1) 	Load left into ac1 
326:     LD  4,-2(1) 	Load left into ac1 
327:     LD  3,0(1) 	Load variable b
328:     ST  3,-2(1) 	Save left side 
329:     LD  3,0(1) 	Load variable i
330:     LD  4,-2(1) 	Load left into ac1 
331:     ST  3,-2(1) 	Save left side 
332:     LD  3,0(1) 	Load variable i
333:     ST  3,-3(1) 	Save left side 
334:     LD  3,0(1) 	Load variable b
335:     LD  4,-3(1) 	Load left into ac1 
336:     LD  4,-2(1) 	Load left into ac1 
337:     LD  3,0(1) 	Load variable b
338:     ST  3,-2(1) 	Save left side 
339:     LD  3,0(1) 	Load variable b
340:     LD  4,-2(1) 	Load left into ac1 
341:     ST  3,-2(1) 	Save left side 
342:     LD  3,0(1) 	Load variable b
343:     ST  3,-3(1) 	Save left side 
344:     LD  3,0(1) 	Load variable b
345:     LD  4,-3(1) 	Load left into ac1 
346:     LD  4,-2(1) 	Load left into ac1 
347:    JEQ  3,1(7) 	Op AND 
348:    LDA  3,0(4) 	 
349:    LDC  3,1(6) 	Load constant 
* EXPRESSION STMT
351:     LD  3,0(1) 	Load variable i
352:     ST  3,0(1) 	Store variable i
350:    JEQ  3,3(7) 	if: jmp to else 
* EXPRESSION STMT
354:     LD  3,0(1) 	Load variable b
355:     ST  3,0(1) 	Store variable b
353:    LDA  7,2(7) 	jmp to end 
356:     LD  3,0(1) 	Load variable ba
* EXPRESSION STMT
358:     LD  3,0(1) 	Load variable i
359:     ST  3,0(1) 	Store variable i
357:    JEQ  3,3(7) 	if: jmp to else 
* EXPRESSION STMT
361:     LD  3,0(1) 	Load variable b
362:     ST  3,0(1) 	Store variable b
360:    LDA  7,2(7) 	jmp to end 
363:     LD  3,0(1) 	Load variable ia
* EXPRESSION STMT
365:     LD  3,0(1) 	Load variable i
366:     ST  3,0(1) 	Store variable i
364:    JEQ  3,3(7) 	if: jmp to else 
* EXPRESSION STMT
368:     LD  3,0(1) 	Load variable b
369:     ST  3,0(1) 	Store variable b
367:    LDA  7,2(7) 	jmp to end 
370:     LD  3,0(1) 	Load variable b
* EXPRESSION STMT
372:     LD  3,0(1) 	Load variable i
373:     ST  3,0(1) 	Store variable i
371:    JEQ  3,3(7) 	if: jmp to else 
* EXPRESSION STMT
375:     LD  3,0(1) 	Load variable b
376:     ST  3,0(1) 	Store variable b
374:    LDA  7,2(7) 	jmp to end 
377:     LD  3,0(1) 	Load variable i
* EXPRESSION STMT
379:     LD  3,0(1) 	Load variable i
380:     ST  3,0(1) 	Store variable i
378:    JEQ  3,3(7) 	if: jmp to else 
* EXPRESSION STMT
382:     LD  3,0(1) 	Load variable b
383:     ST  3,0(1) 	Store variable b
381:    LDA  7,2(7) 	jmp to end 
* WHILE
384:    LDC  3,1(6) 	Load constant 
385:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
387:     LD  3,0(1) 	Load variable i
388:     ST  3,0(1) 	Store variable i
389:    LDA  7,-4(7) 	go to beginning of loop 
386:    LDA  7,3(7) 	No more loop 
* end WHILE
* WHILE
390:     LD  3,0(1) 	Load variable ba
391:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
393:     LD  3,0(1) 	Load variable i
394:     ST  3,0(1) 	Store variable i
395:    LDA  7,-4(7) 	go to beginning of loop 
392:    LDA  7,3(7) 	No more loop 
* end WHILE
* WHILE
396:     LD  3,0(1) 	Load variable ia
397:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
399:     LD  3,0(1) 	Load variable i
400:     ST  3,0(1) 	Store variable i
401:    LDA  7,-4(7) 	go to beginning of loop 
398:    LDA  7,3(7) 	No more loop 
* end WHILE
* WHILE
402:     LD  3,0(1) 	Load variable b
403:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
405:     LD  3,0(1) 	Load variable i
406:     ST  3,0(1) 	Store variable i
407:    LDA  7,-4(7) 	go to beginning of loop 
404:    LDA  7,3(7) 	No more loop 
* end WHILE
* WHILE
408:     LD  3,0(1) 	Load variable i
409:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
411:     LD  3,0(1) 	Load variable i
412:     ST  3,0(1) 	Store variable i
413:    LDA  7,-4(7) 	go to beginning of loop 
410:    LDA  7,3(7) 	No more loop 
* end WHILE
* END compound statement
* Add standard closing in case there is no return statement
414:    LDC  2,0(6) 	Set return value to 0 
415:     LD  3,-1(1) 	Load return address 
416:     LD  1,0(1) 	Adjust fp 
417:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,417(7) 	Jump to init 
* BEGIN Init
418:     LD  0,0(0) 	Set the global pointer 
419:    LDA  1,0(0) 	set first frame at end of globals 
420:     ST  1,0(1) 	store old fp (point to self) 
421:    LDA  3,1(7) 	Return address in ac 
422:    LDA  7,-393(7) 	Jump to main 
423:   HALT  0,0,0 	DONE! 
* END Init
