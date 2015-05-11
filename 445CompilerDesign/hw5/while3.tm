* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  while3.tm
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
 31:     LD  3,-2(1) 	Load variable x
 32:     ST  3,-7(1) 	Save left side 
 33:    LDC  3,1(6) 	Load constant 
 34:     LD  4,-7(1) 	Load left into ac1 
* EXPRESSION STMT
 36:    LDC  3,1(6) 	Load constant 
 37:     ST  3,-4(1) 	Store variable z
 35:    JEQ  3,3(7) 	if: jmp to else 
 38:    LDA  7,0(7) 	jmp to end 
 39:     LD  3,-2(1) 	Load variable x
 40:     ST  3,-7(1) 	Save left side 
 41:    LDC  3,2(6) 	Load constant 
 42:     LD  4,-7(1) 	Load left into ac1 
* EXPRESSION STMT
 44:    LDC  3,1(6) 	Load constant 
 45:     ST  3,-4(1) 	Store variable z
 43:    JEQ  3,3(7) 	if: jmp to else 
* EXPRESSION STMT
 47:    LDC  3,2(6) 	Load constant 
 48:     ST  3,-4(1) 	Store variable z
 46:    LDA  7,2(7) 	jmp to end 
 49:     LD  3,-2(1) 	Load variable x
 50:     ST  3,-7(1) 	Save left side 
 51:    LDC  3,3(6) 	Load constant 
 52:     LD  4,-7(1) 	Load left into ac1 
 54:     LD  3,-3(1) 	Load variable y
 55:     ST  3,-7(1) 	Save left side 
 56:    LDC  3,4(6) 	Load constant 
 57:     LD  4,-7(1) 	Load left into ac1 
* EXPRESSION STMT
 59:    LDC  3,3(6) 	Load constant 
 60:     ST  3,-4(1) 	Store variable z
 58:    JEQ  3,3(7) 	if: jmp to else 
 61:    LDA  7,0(7) 	jmp to end 
 53:    JEQ  3,9(7) 	if: jmp to else 
 62:    LDA  7,0(7) 	jmp to end 
 63:     LD  3,-2(1) 	Load variable x
 64:     ST  3,-7(1) 	Save left side 
 65:    LDC  3,5(6) 	Load constant 
 66:     LD  4,-7(1) 	Load left into ac1 
 68:     LD  3,-3(1) 	Load variable y
 69:     ST  3,-7(1) 	Save left side 
 70:    LDC  3,6(6) 	Load constant 
 71:     LD  4,-7(1) 	Load left into ac1 
* EXPRESSION STMT
 73:    LDC  3,4(6) 	Load constant 
 74:     ST  3,-4(1) 	Store variable z
 72:    JEQ  3,3(7) 	if: jmp to else 
* EXPRESSION STMT
 76:    LDC  3,5(6) 	Load constant 
 77:     ST  3,-4(1) 	Store variable z
 75:    LDA  7,2(7) 	jmp to end 
 67:    JEQ  3,11(7) 	if: jmp to else 
 78:    LDA  7,0(7) 	jmp to end 
 79:     LD  3,-2(1) 	Load variable x
 80:     ST  3,-7(1) 	Save left side 
 81:    LDC  3,7(6) 	Load constant 
 82:     LD  4,-7(1) 	Load left into ac1 
 84:     LD  3,-3(1) 	Load variable y
 85:     ST  3,-7(1) 	Save left side 
 86:    LDC  3,8(6) 	Load constant 
 87:     LD  4,-7(1) 	Load left into ac1 
* EXPRESSION STMT
 89:    LDC  3,6(6) 	Load constant 
 90:     ST  3,-4(1) 	Store variable z
 88:    JEQ  3,3(7) 	if: jmp to else 
* EXPRESSION STMT
 92:    LDC  3,7(6) 	Load constant 
 93:     ST  3,-4(1) 	Store variable z
 91:    LDA  7,2(7) 	jmp to end 
 83:    JEQ  3,11(7) 	if: jmp to else 
* EXPRESSION STMT
 95:    LDC  3,8(6) 	Load constant 
 96:     ST  3,0(1) 	Store variable z
 94:    LDA  7,2(7) 	jmp to end 
 97:     LD  3,-2(1) 	Load variable x
 98:     ST  3,-7(1) 	Save left side 
 99:    LDC  3,9(6) 	Load constant 
100:     LD  4,-7(1) 	Load left into ac1 
101:    SUB  3,4,3 	Op < 
102:    JLT  3,2(7) 	br if true 
103:    LDC  3,0(3) 	false case 
104:    LDA  7,1(7) 	unconditional jmp 
105:    LDC  3,1(3) 	true case 
* WHILE
107:     LD  3,-3(1) 	Load variable y
108:     ST  3,-7(1) 	Save left side 
109:    LDC  3,10(6) 	Load constant 
110:     LD  4,-7(1) 	Load left into ac1 
111:    JGT  3,1(7) 	Jump to while part 
* DO
113:    LDC  3,9(6) 	Load constant 
114:    LDA  7,-3(7) 	go to beginning of loop 
112:    LDA  7,2(7) 	No more loop 
* end WHILE
106:    JEQ  3,9(7) 	if: jmp to else 
115:    LDA  7,0(7) 	jmp to end 
116:     LD  3,-2(1) 	Load variable x
117:     ST  3,-7(1) 	Save left side 
118:    LDC  3,9(6) 	Load constant 
119:     LD  4,-7(1) 	Load left into ac1 
120:    SUB  3,4,3 	Op < 
121:    JLT  3,2(7) 	br if true 
122:    LDC  3,0(3) 	false case 
123:    LDA  7,1(7) 	unconditional jmp 
124:    LDC  3,1(3) 	true case 
* WHILE
126:     LD  3,-3(1) 	Load variable y
127:     ST  3,-7(1) 	Save left side 
128:    LDC  3,10(6) 	Load constant 
129:     LD  4,-7(1) 	Load left into ac1 
130:    JGT  3,1(7) 	Jump to while part 
* DO
132:     LD  3,-2(1) 	Load variable x
133:     ST  3,-7(1) 	Save left side 
134:    LDC  3,3(6) 	Load constant 
135:     LD  4,-7(1) 	Load left into ac1 
136:    SUB  3,4,3 	Op < 
137:    JLT  3,2(7) 	br if true 
138:    LDC  3,0(3) 	false case 
139:    LDA  7,1(7) 	unconditional jmp 
140:    LDC  3,1(3) 	true case 
142:    LDC  3,3(6) 	Load constant 
141:    JEQ  3,2(7) 	if: jmp to else 
144:    LDC  3,9(6) 	Load constant 
143:    LDA  7,1(7) 	jmp to end 
145:    LDA  7,-15(7) 	go to beginning of loop 
131:    LDA  7,14(7) 	No more loop 
* end WHILE
125:    JEQ  3,21(7) 	if: jmp to else 
146:    LDA  7,0(7) 	jmp to end 
* WHILE
147:     LD  3,-3(1) 	Load variable y
148:     ST  3,-7(1) 	Save left side 
149:    LDC  3,11(6) 	Load constant 
150:     LD  4,-7(1) 	Load left into ac1 
151:    SUB  3,4,3 	Op < 
152:    JLT  3,2(7) 	br if true 
153:    LDC  3,0(3) 	false case 
154:    LDA  7,1(7) 	unconditional jmp 
155:    LDC  3,1(3) 	true case 
156:    JGT  3,1(7) 	Jump to while part 
* DO
158:     LD  3,-2(1) 	Load variable x
159:     ST  3,-7(1) 	Save left side 
160:    LDC  3,12(6) 	Load constant 
161:     LD  4,-7(1) 	Load left into ac1 
162:    SUB  3,4,3 	Op < 
163:    JLT  3,2(7) 	br if true 
164:    LDC  3,0(3) 	false case 
165:    LDA  7,1(7) 	unconditional jmp 
166:    LDC  3,1(3) 	true case 
* WHILE
168:     LD  3,-3(1) 	Load variable y
169:     ST  3,-7(1) 	Save left side 
170:    LDC  3,13(6) 	Load constant 
171:     LD  4,-7(1) 	Load left into ac1 
172:    JGT  3,1(7) 	Jump to while part 
* DO
174:    LDC  3,10(6) 	Load constant 
175:    LDA  7,-3(7) 	go to beginning of loop 
173:    LDA  7,2(7) 	No more loop 
* end WHILE
167:    JEQ  3,9(7) 	if: jmp to else 
176:    LDA  7,0(7) 	jmp to end 
177:    LDA  7,-21(7) 	go to beginning of loop 
157:    LDA  7,20(7) 	No more loop 
* end WHILE
178:     LD  3,-2(1) 	Load variable x
179:     ST  3,-7(1) 	Save left side 
180:    LDC  3,13(6) 	Load constant 
181:     LD  4,-7(1) 	Load left into ac1 
182:    SUB  3,4,3 	Op < 
183:    JLT  3,2(7) 	br if true 
184:    LDC  3,0(3) 	false case 
185:    LDA  7,1(7) 	unconditional jmp 
186:    LDC  3,1(3) 	true case 
* WHILE
188:     LD  3,-3(1) 	Load variable y
189:     ST  3,-7(1) 	Save left side 
190:    LDC  3,14(6) 	Load constant 
191:     LD  4,-7(1) 	Load left into ac1 
192:    JGT  3,1(7) 	Jump to while part 
* DO
194:    LDC  3,20(6) 	Load constant 
195:    LDA  7,-3(7) 	go to beginning of loop 
193:    LDA  7,2(7) 	No more loop 
* end WHILE
187:    JEQ  3,9(7) 	if: jmp to else 
197:    LDC  3,21(6) 	Load constant 
196:    LDA  7,1(7) 	jmp to end 
* WHILE
198:     LD  3,-3(1) 	Load variable y
199:     ST  3,-7(1) 	Save left side 
200:    LDC  3,15(6) 	Load constant 
201:     LD  4,-7(1) 	Load left into ac1 
202:    JGT  3,1(7) 	Jump to while part 
* DO
204:     LD  3,-2(1) 	Load variable x
205:     ST  3,-7(1) 	Save left side 
206:    LDC  3,16(6) 	Load constant 
207:     LD  4,-7(1) 	Load left into ac1 
208:    SUB  3,4,3 	Op < 
209:    JLT  3,2(7) 	br if true 
210:    LDC  3,0(3) 	false case 
211:    LDA  7,1(7) 	unconditional jmp 
212:    LDC  3,1(3) 	true case 
214:    LDC  3,22(6) 	Load constant 
213:    JEQ  3,2(7) 	if: jmp to else 
216:    LDC  3,23(6) 	Load constant 
215:    LDA  7,1(7) 	jmp to end 
217:    LDA  7,-15(7) 	go to beginning of loop 
203:    LDA  7,14(7) 	No more loop 
* end WHILE
* WHILE
218:     LD  3,-3(1) 	Load variable y
219:     ST  3,-7(1) 	Save left side 
220:    LDC  3,15(6) 	Load constant 
221:     LD  4,-7(1) 	Load left into ac1 
222:    JGT  3,1(7) 	Jump to while part 
* DO
224:     LD  3,-2(1) 	Load variable x
225:     ST  3,-7(1) 	Save left side 
226:    LDC  3,16(6) 	Load constant 
227:     LD  4,-7(1) 	Load left into ac1 
228:    SUB  3,4,3 	Op < 
229:    JLT  3,2(7) 	br if true 
230:    LDC  3,0(3) 	false case 
231:    LDA  7,1(7) 	unconditional jmp 
232:    LDC  3,1(3) 	true case 
* WHILE
234:     LD  3,-3(1) 	Load variable y
235:     ST  3,-7(1) 	Save left side 
236:    LDC  3,3(6) 	Load constant 
237:     LD  4,-7(1) 	Load left into ac1 
238:    SUB  3,4,3 	Op < 
239:    JLT  3,2(7) 	br if true 
240:    LDC  3,0(3) 	false case 
241:    LDA  7,1(7) 	unconditional jmp 
242:    LDC  3,1(3) 	true case 
243:    JGT  3,1(7) 	Jump to while part 
* DO
245:    LDC  3,9(6) 	Load constant 
246:    LDA  7,-3(7) 	go to beginning of loop 
244:    LDA  7,2(7) 	No more loop 
* end WHILE
233:    JEQ  3,14(7) 	if: jmp to else 
248:    LDC  3,23(6) 	Load constant 
247:    LDA  7,1(7) 	jmp to end 
249:    LDA  7,-27(7) 	go to beginning of loop 
223:    LDA  7,26(7) 	No more loop 
* end WHILE
* WHILE
250:     LD  3,-3(1) 	Load variable y
251:     ST  3,-7(1) 	Save left side 
252:    LDC  3,15(6) 	Load constant 
253:     LD  4,-7(1) 	Load left into ac1 
254:    JGT  3,1(7) 	Jump to while part 
* DO
256:     LD  3,-2(1) 	Load variable x
257:     ST  3,-7(1) 	Save left side 
258:    LDC  3,16(6) 	Load constant 
259:     LD  4,-7(1) 	Load left into ac1 
260:    SUB  3,4,3 	Op < 
261:    JLT  3,2(7) 	br if true 
262:    LDC  3,0(3) 	false case 
263:    LDA  7,1(7) 	unconditional jmp 
264:    LDC  3,1(3) 	true case 
* WHILE
266:     LD  3,-3(1) 	Load variable y
267:     ST  3,-7(1) 	Save left side 
268:    LDC  3,3(6) 	Load constant 
269:     LD  4,-7(1) 	Load left into ac1 
270:    SUB  3,4,3 	Op < 
271:    JLT  3,2(7) 	br if true 
272:    LDC  3,0(3) 	false case 
273:    LDA  7,1(7) 	unconditional jmp 
274:    LDC  3,1(3) 	true case 
275:    JGT  3,1(7) 	Jump to while part 
* DO
277:    LDC  3,9(6) 	Load constant 
278:    LDA  7,-3(7) 	go to beginning of loop 
276:    LDA  7,2(7) 	No more loop 
* end WHILE
265:    JEQ  3,14(7) 	if: jmp to else 
* WHILE
280:     LD  3,0(1) 	Load variable y
281:     ST  3,-7(1) 	Save left side 
282:    LDC  3,3(6) 	Load constant 
283:     LD  4,-7(1) 	Load left into ac1 
284:    JGT  3,1(7) 	Jump to while part 
* DO
286:    LDC  3,23(6) 	Load constant 
287:    LDA  7,-3(7) 	go to beginning of loop 
285:    LDA  7,2(7) 	No more loop 
* end WHILE
279:    LDA  7,8(7) 	jmp to end 
288:    LDA  7,-34(7) 	go to beginning of loop 
255:    LDA  7,33(7) 	No more loop 
* end WHILE
* WHILE
289:     LD  3,-3(1) 	Load variable y
290:     ST  3,-7(1) 	Save left side 
291:    LDC  3,15(6) 	Load constant 
292:     LD  4,-7(1) 	Load left into ac1 
293:    JGT  3,1(7) 	Jump to while part 
* DO
295:     LD  3,-2(1) 	Load variable x
296:     ST  3,-7(1) 	Save left side 
297:    LDC  3,16(6) 	Load constant 
298:     LD  4,-7(1) 	Load left into ac1 
299:    SUB  3,4,3 	Op < 
300:    JLT  3,2(7) 	br if true 
301:    LDC  3,0(3) 	false case 
302:    LDA  7,1(7) 	unconditional jmp 
303:    LDC  3,1(3) 	true case 
* WHILE
305:     LD  3,-3(1) 	Load variable y
306:     ST  3,-7(1) 	Save left side 
307:    LDC  3,3(6) 	Load constant 
308:     LD  4,-7(1) 	Load left into ac1 
309:    SUB  3,4,3 	Op < 
310:    JLT  3,2(7) 	br if true 
311:    LDC  3,0(3) 	false case 
312:    LDA  7,1(7) 	unconditional jmp 
313:    LDC  3,1(3) 	true case 
314:    JGT  3,1(7) 	Jump to while part 
* DO
316:     LD  3,-5(1) 	Load variable b
318:    LDC  3,34(6) 	Load constant 
317:    JEQ  3,2(7) 	if: jmp to else 
320:    LDC  3,34(6) 	Load constant 
319:    LDA  7,1(7) 	jmp to end 
321:    LDA  7,-7(7) 	go to beginning of loop 
315:    LDA  7,6(7) 	No more loop 
* end WHILE
304:    JEQ  3,18(7) 	if: jmp to else 
* WHILE
323:     LD  3,0(1) 	Load variable y
324:     ST  3,-7(1) 	Save left side 
325:    LDC  3,3(6) 	Load constant 
326:     LD  4,-7(1) 	Load left into ac1 
327:    JGT  3,1(7) 	Jump to while part 
* DO
329:    LDC  3,23(6) 	Load constant 
330:    LDA  7,-3(7) 	go to beginning of loop 
328:    LDA  7,2(7) 	No more loop 
* end WHILE
322:    LDA  7,8(7) 	jmp to end 
331:    LDA  7,-38(7) 	go to beginning of loop 
294:    LDA  7,37(7) 	No more loop 
* end WHILE
* WHILE
332:     LD  3,-3(1) 	Load variable y
333:     ST  3,-7(1) 	Save left side 
334:    LDC  3,15(6) 	Load constant 
335:     LD  4,-7(1) 	Load left into ac1 
336:    JGT  3,1(7) 	Jump to while part 
* DO
338:     LD  3,-2(1) 	Load variable x
339:     ST  3,-7(1) 	Save left side 
340:    LDC  3,16(6) 	Load constant 
341:     LD  4,-7(1) 	Load left into ac1 
342:    SUB  3,4,3 	Op < 
343:    JLT  3,2(7) 	br if true 
344:    LDC  3,0(3) 	false case 
345:    LDA  7,1(7) 	unconditional jmp 
346:    LDC  3,1(3) 	true case 
* BEGIN compound statement
* WHILE
348:     LD  3,-3(1) 	Load variable y
349:     ST  3,-7(1) 	Save left side 
350:    LDC  3,3(6) 	Load constant 
351:     LD  4,-7(1) 	Load left into ac1 
352:    SUB  3,4,3 	Op < 
353:    JLT  3,2(7) 	br if true 
354:    LDC  3,0(3) 	false case 
355:    LDA  7,1(7) 	unconditional jmp 
356:    LDC  3,1(3) 	true case 
357:    JGT  3,1(7) 	Jump to while part 
* DO
359:     LD  3,-5(1) 	Load variable b
361:    LDC  3,34(6) 	Load constant 
360:    JEQ  3,2(7) 	if: jmp to else 
362:    LDA  7,0(7) 	jmp to end 
363:    LDA  7,-6(7) 	go to beginning of loop 
358:    LDA  7,5(7) 	No more loop 
* end WHILE
* END compound statement
347:    JEQ  3,17(7) 	if: jmp to else 
* WHILE
365:     LD  3,0(1) 	Load variable y
366:     ST  3,-7(1) 	Save left side 
367:    LDC  3,3(6) 	Load constant 
368:     LD  4,-7(1) 	Load left into ac1 
369:    JGT  3,1(7) 	Jump to while part 
* DO
371:    LDC  3,23(6) 	Load constant 
372:    LDA  7,-3(7) 	go to beginning of loop 
370:    LDA  7,2(7) 	No more loop 
* end WHILE
364:    LDA  7,8(7) 	jmp to end 
373:    LDA  7,-37(7) 	go to beginning of loop 
337:    LDA  7,36(7) 	No more loop 
* end WHILE
374:     LD  3,-2(1) 	Load variable x
375:     ST  3,-7(1) 	Save left side 
376:    LDC  3,2(6) 	Load constant 
377:     LD  4,-7(1) 	Load left into ac1 
378:    JEQ  3,1(7) 	if: jmp to else 
379:    LDA  7,0(7) 	jmp to end 
* WHILE
380:     LD  3,-5(1) 	Load variable b
381:    JGT  3,1(7) 	Jump to while part 
* DO
383:    LDA  7,-2(7) 	go to beginning of loop 
382:    LDA  7,1(7) 	No more loop 
* end WHILE
* WHILE
384:     LD  3,-5(1) 	Load variable b
385:    JGT  3,1(7) 	Jump to while part 
* DO
* WHILE
387:     LD  3,-5(1) 	Load variable b
388:    JGT  3,1(7) 	Jump to while part 
* DO
390:     LD  3,-5(1) 	Load variable b
392:     LD  3,-2(1) 	Load variable x
391:    JEQ  3,2(7) 	if: jmp to else 
394:     LD  3,-3(1) 	Load variable y
393:    LDA  7,1(7) 	jmp to end 
395:    LDA  7,-7(7) 	go to beginning of loop 
389:    LDA  7,6(7) 	No more loop 
* end WHILE
396:    LDA  7,-11(7) 	go to beginning of loop 
386:    LDA  7,10(7) 	No more loop 
* end WHILE
* WHILE
397:     LD  3,-5(1) 	Load variable b
398:    JGT  3,1(7) 	Jump to while part 
* DO
* WHILE
400:     LD  3,-5(1) 	Load variable b
401:    JGT  3,1(7) 	Jump to while part 
* DO
403:     LD  3,-5(1) 	Load variable b
405:     LD  3,-2(1) 	Load variable x
404:    JEQ  3,2(7) 	if: jmp to else 
406:    LDA  7,0(7) 	jmp to end 
407:    LDA  7,-6(7) 	go to beginning of loop 
402:    LDA  7,5(7) 	No more loop 
* end WHILE
408:    LDA  7,-10(7) 	go to beginning of loop 
399:    LDA  7,9(7) 	No more loop 
* end WHILE
409:     LD  3,-5(1) 	Load variable b
411:     LD  3,-3(1) 	Load variable y
410:    JEQ  3,2(7) 	if: jmp to else 
413:     LD  3,-4(1) 	Load variable z
412:    LDA  7,1(7) 	jmp to end 
* WHILE
414:     LD  3,-5(1) 	Load variable b
415:    JGT  3,1(7) 	Jump to while part 
* DO
* WHILE
417:     LD  3,-5(1) 	Load variable b
418:    JGT  3,1(7) 	Jump to while part 
* DO
420:     LD  3,-5(1) 	Load variable b
422:     LD  3,-2(1) 	Load variable x
421:    JEQ  3,2(7) 	if: jmp to else 
423:    LDA  7,0(7) 	jmp to end 
424:    LDA  7,-6(7) 	go to beginning of loop 
419:    LDA  7,5(7) 	No more loop 
* end WHILE
425:    LDA  7,-10(7) 	go to beginning of loop 
416:    LDA  7,9(7) 	No more loop 
* end WHILE
* WHILE
426:     LD  3,-5(1) 	Load variable b
427:    JGT  3,1(7) 	Jump to while part 
* DO
* WHILE
429:     LD  3,-5(1) 	Load variable b
430:    JGT  3,1(7) 	Jump to while part 
* DO
432:     LD  3,-5(1) 	Load variable b
434:     LD  3,-2(1) 	Load variable x
433:    JEQ  3,2(7) 	if: jmp to else 
435:    LDA  7,0(7) 	jmp to end 
436:    LDA  7,-6(7) 	go to beginning of loop 
431:    LDA  7,5(7) 	No more loop 
* end WHILE
437:    LDA  7,-10(7) 	go to beginning of loop 
428:    LDA  7,9(7) 	No more loop 
* end WHILE
438:     LD  3,-5(1) 	Load variable b
440:     LD  3,-3(1) 	Load variable y
439:    JEQ  3,2(7) 	if: jmp to else 
441:    LDA  7,0(7) 	jmp to end 
* WHILE
442:     LD  3,-5(1) 	Load variable b
443:    JGT  3,1(7) 	Jump to while part 
* DO
445:     LD  3,-6(1) 	Load variable c
* WHILE
447:     LD  3,-5(1) 	Load variable b
448:    JGT  3,1(7) 	Jump to while part 
* DO
450:     LD  3,-5(1) 	Load variable b
452:     LD  3,-2(1) 	Load variable x
451:    JEQ  3,2(7) 	if: jmp to else 
454:     LD  3,-3(1) 	Load variable y
453:    LDA  7,1(7) 	jmp to end 
455:    LDA  7,-7(7) 	go to beginning of loop 
449:    LDA  7,6(7) 	No more loop 
* end WHILE
446:    JEQ  3,10(7) 	if: jmp to else 
456:    LDA  7,0(7) 	jmp to end 
457:    LDA  7,-14(7) 	go to beginning of loop 
444:    LDA  7,13(7) 	No more loop 
* end WHILE
* WHILE
458:     LD  3,-5(1) 	Load variable b
459:    JGT  3,1(7) 	Jump to while part 
* DO
461:     LD  3,-6(1) 	Load variable c
* WHILE
463:     LD  3,-5(1) 	Load variable b
464:    JGT  3,1(7) 	Jump to while part 
* DO
466:     LD  3,-5(1) 	Load variable b
468:     LD  3,-2(1) 	Load variable x
467:    JEQ  3,2(7) 	if: jmp to else 
469:    LDA  7,0(7) 	jmp to end 
470:    LDA  7,-6(7) 	go to beginning of loop 
465:    LDA  7,5(7) 	No more loop 
* end WHILE
462:    JEQ  3,9(7) 	if: jmp to else 
471:    LDA  7,0(7) 	jmp to end 
472:    LDA  7,-13(7) 	go to beginning of loop 
460:    LDA  7,12(7) 	No more loop 
* end WHILE
473:     LD  3,-5(1) 	Load variable b
475:     LD  3,-3(1) 	Load variable y
474:    JEQ  3,2(7) 	if: jmp to else 
477:     LD  3,-4(1) 	Load variable z
476:    LDA  7,1(7) 	jmp to end 
478:     LD  3,-6(1) 	Load variable c
* WHILE
480:     LD  3,-5(1) 	Load variable b
481:    JGT  3,1(7) 	Jump to while part 
* DO
* WHILE
483:     LD  3,-5(1) 	Load variable b
484:    JGT  3,1(7) 	Jump to while part 
* DO
486:     LD  3,-5(1) 	Load variable b
488:     LD  3,-2(1) 	Load variable x
487:    JEQ  3,2(7) 	if: jmp to else 
490:     LD  3,-3(1) 	Load variable y
489:    LDA  7,1(7) 	jmp to end 
491:    LDA  7,-7(7) 	go to beginning of loop 
485:    LDA  7,6(7) 	No more loop 
* end WHILE
492:    LDA  7,-11(7) 	go to beginning of loop 
482:    LDA  7,10(7) 	No more loop 
* end WHILE
479:    JEQ  3,14(7) 	if: jmp to else 
493:    LDA  7,0(7) 	jmp to end 
494:     LD  3,-6(1) 	Load variable c
* WHILE
496:     LD  3,-5(1) 	Load variable b
497:    JGT  3,1(7) 	Jump to while part 
* DO
* WHILE
499:     LD  3,-5(1) 	Load variable b
500:    JGT  3,1(7) 	Jump to while part 
* DO
502:     LD  3,-5(1) 	Load variable b
504:     LD  3,-2(1) 	Load variable x
503:    JEQ  3,2(7) 	if: jmp to else 
505:    LDA  7,0(7) 	jmp to end 
506:    LDA  7,-6(7) 	go to beginning of loop 
501:    LDA  7,5(7) 	No more loop 
* end WHILE
507:    LDA  7,-10(7) 	go to beginning of loop 
498:    LDA  7,9(7) 	No more loop 
* end WHILE
495:    JEQ  3,13(7) 	if: jmp to else 
508:    LDA  7,0(7) 	jmp to end 
509:     LD  3,-5(1) 	Load variable b
511:     LD  3,-3(1) 	Load variable y
510:    JEQ  3,2(7) 	if: jmp to else 
513:     LD  3,-4(1) 	Load variable z
512:    LDA  7,1(7) 	jmp to end 
514:     LD  3,-6(1) 	Load variable c
* WHILE
516:     LD  3,-5(1) 	Load variable b
517:    JGT  3,1(7) 	Jump to while part 
* DO
* WHILE
519:     LD  3,-5(1) 	Load variable b
520:    JGT  3,1(7) 	Jump to while part 
* DO
522:     LD  3,-5(1) 	Load variable b
524:     LD  3,-2(1) 	Load variable x
523:    JEQ  3,2(7) 	if: jmp to else 
526:     LD  3,-3(1) 	Load variable y
525:    LDA  7,1(7) 	jmp to end 
527:    LDA  7,-7(7) 	go to beginning of loop 
521:    LDA  7,6(7) 	No more loop 
* end WHILE
528:    LDA  7,-11(7) 	go to beginning of loop 
518:    LDA  7,10(7) 	No more loop 
* end WHILE
515:    JEQ  3,14(7) 	if: jmp to else 
530:     LD  3,0(1) 	Load variable z
529:    LDA  7,1(7) 	jmp to end 
* RETURN
531:    LDC  3,4182(6) 	Load constant 
532:    LDA  2,0(3) 	Copy result to rt register 
533:     LD  3,-1(1) 	Load return address 
534:     LD  1,0(1) 	Adjust fp 
535:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
536:    LDC  2,0(6) 	Set return value to 0 
537:     LD  3,-1(1) 	Load return address 
538:     LD  1,0(1) 	Adjust fp 
539:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,539(7) 	Jump to init 
* BEGIN Init
540:     LD  0,0(0) 	Set the global pointer 
541:    LDA  1,0(0) 	set first frame at end of globals 
542:     ST  1,0(1) 	store old fp (point to self) 
543:    LDA  3,1(7) 	Return address in ac 
544:    LDA  7,-515(7) 	Jump to main 
545:   HALT  0,0,0 	DONE! 
* END Init
