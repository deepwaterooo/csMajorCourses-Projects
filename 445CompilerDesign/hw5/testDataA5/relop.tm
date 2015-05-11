* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  relop.c-
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
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* WHILE
 31:     LD  3,-2(1) 	Load variable x
 32:     ST  3,-12(1) 	Save left side 
 33:     LD  3,-3(1) 	Load variable y
 34:     LD  4,-12(1) 	Load left into ac1 
 35:    SUB  4,4,3 	Op < 
 36:    LDC  3,1(6) 	True case 
 37:    JLT  4,1(7) 	Jump if true 
 38:    LDC  3,0(6) 	False case 
 39:    JGT  3,1(7) 	Jump to while part 
* DO
 41:    LDA  7,-11(7) 	go to beginning of loop 
 40:    LDA  7,1(7) 	No more loop 
* ENDWHILE
* WHILE
 42:     LD  3,-2(1) 	Load variable x
 43:     ST  3,-12(1) 	Save left side 
 44:     LD  3,-3(1) 	Load variable y
 45:     LD  4,-12(1) 	Load left into ac1 
 46:    SUB  4,4,3 	Op > 
 47:    LDC  3,1(6) 	True case 
 48:    JGT  4,1(7) 	Jump if true 
 49:    LDC  3,0(6) 	False case 
 50:    JGT  3,1(7) 	Jump to while part 
* DO
 52:    LDA  7,-11(7) 	go to beginning of loop 
 51:    LDA  7,1(7) 	No more loop 
* ENDWHILE
* WHILE
 53:     LD  3,-2(1) 	Load variable x
 54:     ST  3,-12(1) 	Save left side 
 55:     LD  3,-3(1) 	Load variable y
 56:     LD  4,-12(1) 	Load left into ac1 
 57:    SUB  4,4,3 	Op < 
 58:    LDC  3,1(6) 	True case 
 59:    JLT  4,1(7) 	Jump if true 
 60:    LDC  3,0(6) 	False case 
 61:    LDC  4,1(6) 	Load 1 
 62:    SUB  3,4,3 	Op NOT 
 63:    JGT  3,1(7) 	Jump to while part 
* DO
 65:    LDA  7,-13(7) 	go to beginning of loop 
 64:    LDA  7,1(7) 	No more loop 
* ENDWHILE
* WHILE
 66:     LD  3,-2(1) 	Load variable x
 67:     ST  3,-12(1) 	Save left side 
 68:     LD  3,-3(1) 	Load variable y
 69:     LD  4,-12(1) 	Load left into ac1 
 70:    SUB  4,4,3 	Op > 
 71:    LDC  3,1(6) 	True case 
 72:    JGT  4,1(7) 	Jump if true 
 73:    LDC  3,0(6) 	False case 
 74:    JGT  3,1(7) 	Jump to while part 
* DO
 76:    LDA  7,-11(7) 	go to beginning of loop 
 75:    LDA  7,1(7) 	No more loop 
* ENDWHILE
* WHILE
 77:     LD  3,-2(1) 	Load variable x
 78:     ST  3,-12(1) 	Save left side 
 79:     LD  3,-3(1) 	Load variable y
 80:     LD  4,-12(1) 	Load left into ac1 
 81:    SUB  4,4,3 	Op == 
 82:    LDC  3,1(6) 	True case 
 83:    JEQ  4,1(7) 	Jump if true 
 84:    LDC  3,0(6) 	False case 
 85:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* END compound statement
 87:    LDA  7,-11(7) 	go to beginning of loop 
 86:    LDA  7,1(7) 	No more loop 
* ENDWHILE
* WHILE
 88:     LD  3,-2(1) 	Load variable x
 89:     ST  3,-12(1) 	Save left side 
 90:     LD  3,-3(1) 	Load variable y
 91:     LD  4,-12(1) 	Load left into ac1 
 92:    SUB  4,4,3 	Op <= 
 93:    LDC  3,1(6) 	True case 
 94:    JLE  4,1(7) 	Jump if true 
 95:    LDC  3,0(6) 	False case 
 96:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* END compound statement
 98:    LDA  7,-11(7) 	go to beginning of loop 
 97:    LDA  7,1(7) 	No more loop 
* ENDWHILE
* WHILE
 99:     LD  3,-2(1) 	Load variable x
100:     ST  3,-12(1) 	Save left side 
101:     LD  3,-3(1) 	Load variable y
102:     LD  4,-12(1) 	Load left into ac1 
103:    SUB  4,4,3 	Op >= 
104:    LDC  3,1(6) 	True case 
105:    JGE  4,1(7) 	Jump if true 
106:    LDC  3,0(6) 	False case 
107:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
109:    LDC  3,4(6) 	Load constant 
110:     ST  3,-9(1) 	Store variable x
* END compound statement
111:    LDA  7,-13(7) 	go to beginning of loop 
108:    LDA  7,3(7) 	No more loop 
* ENDWHILE
* WHILE
112:     LD  3,-2(1) 	Load variable x
113:     ST  3,-12(1) 	Save left side 
114:     LD  3,-3(1) 	Load variable y
115:     LD  4,-12(1) 	Load left into ac1 
116:    SUB  3,4,3 	Op != 
117:    JEQ  3,1(7) 	Jump if true 
118:    LDC  3,1(6) 	True case 
119:    JGT  3,1(7) 	Jump to while part 
* DO
* WHILE
121:     LD  3,-2(1) 	Load variable x
122:     ST  3,-12(1) 	Save left side 
123:     LD  3,-3(1) 	Load variable y
124:     LD  4,-12(1) 	Load left into ac1 
125:    SUB  4,4,3 	Op == 
126:    LDC  3,1(6) 	True case 
127:    JEQ  4,1(7) 	Jump if true 
128:    LDC  3,0(6) 	False case 
129:    JGT  3,1(7) 	Jump to while part 
* DO
131:    LDA  7,-11(7) 	go to beginning of loop 
130:    LDA  7,1(7) 	No more loop 
* ENDWHILE
132:    LDA  7,-21(7) 	go to beginning of loop 
120:    LDA  7,12(7) 	No more loop 
* ENDWHILE
* IF
133:     LD  3,-2(1) 	Load variable x
134:     ST  3,-12(1) 	Save left side 
135:     LD  3,-3(1) 	Load variable y
136:     LD  4,-12(1) 	Load left into ac1 
137:    SUB  4,4,3 	Op > 
138:    LDC  3,1(6) 	True case 
139:    JGT  4,1(7) 	Jump if true 
140:    LDC  3,0(6) 	False case 
141:    JGT  3,1(7) 	Jump to then part 
* THEN
142:    LDA  7,0(7) 	Jump around the THEN 
* ENDIF
* IF
143:     LD  3,-2(1) 	Load variable x
144:     ST  3,-12(1) 	Save left side 
145:     LD  3,-3(1) 	Load variable y
146:     LD  4,-12(1) 	Load left into ac1 
147:    SUB  4,4,3 	Op == 
148:    LDC  3,1(6) 	True case 
149:    JEQ  4,1(7) 	Jump if true 
150:    LDC  3,0(6) 	False case 
151:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* END compound statement
152:    LDA  7,0(7) 	Jump around the THEN 
* ENDIF
* IF
153:     LD  3,-2(1) 	Load variable x
154:     ST  3,-12(1) 	Save left side 
155:     LD  3,-3(1) 	Load variable y
156:     LD  4,-12(1) 	Load left into ac1 
157:    SUB  4,4,3 	Op <= 
158:    LDC  3,1(6) 	True case 
159:    JLE  4,1(7) 	Jump if true 
160:    LDC  3,0(6) 	False case 
161:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* END compound statement
162:    LDA  7,0(7) 	Jump around the THEN 
* ENDIF
* IF
163:     LD  3,-2(1) 	Load variable x
164:     ST  3,-12(1) 	Save left side 
165:     LD  3,-3(1) 	Load variable y
166:     LD  4,-12(1) 	Load left into ac1 
167:    SUB  4,4,3 	Op >= 
168:    LDC  3,1(6) 	True case 
169:    JGE  4,1(7) 	Jump if true 
170:    LDC  3,0(6) 	False case 
171:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
173:    LDC  3,4(6) 	Load constant 
174:     ST  3,-11(1) 	Store variable x
* END compound statement
172:    LDA  7,2(7) 	Jump around the THEN 
* ENDIF
* IF
175:     LD  3,-2(1) 	Load variable x
176:     ST  3,-12(1) 	Save left side 
177:     LD  3,-3(1) 	Load variable y
178:     LD  4,-12(1) 	Load left into ac1 
179:    SUB  3,4,3 	Op != 
180:    JEQ  3,1(7) 	Jump if true 
181:    LDC  3,1(6) 	True case 
182:    JGT  3,1(7) 	Jump to then part 
* THEN
* WHILE
184:     LD  3,-2(1) 	Load variable x
185:     ST  3,-12(1) 	Save left side 
186:     LD  3,-3(1) 	Load variable y
187:     LD  4,-12(1) 	Load left into ac1 
188:    SUB  4,4,3 	Op == 
189:    LDC  3,1(6) 	True case 
190:    JEQ  4,1(7) 	Jump if true 
191:    LDC  3,0(6) 	False case 
192:    JGT  3,1(7) 	Jump to while part 
* DO
194:    LDA  7,-11(7) 	go to beginning of loop 
193:    LDA  7,1(7) 	No more loop 
* ENDWHILE
183:    LDA  7,11(7) 	Jump around the THEN 
* ENDIF
* IF
195:     LD  3,-2(1) 	Load variable x
196:     ST  3,-12(1) 	Save left side 
197:     LD  3,-3(1) 	Load variable y
198:     LD  4,-12(1) 	Load left into ac1 
199:    SUB  4,4,3 	Op > 
200:    LDC  3,1(6) 	True case 
201:    JGT  4,1(7) 	Jump if true 
202:    LDC  3,0(6) 	False case 
203:    JGT  3,1(7) 	Jump to then part 
* THEN
204:    LDA  7,0(7) 	Jump around the THEN 
* ENDIF
* IF
205:     LD  3,-2(1) 	Load variable x
206:     ST  3,-12(1) 	Save left side 
207:     LD  3,-3(1) 	Load variable y
208:     LD  4,-12(1) 	Load left into ac1 
209:    SUB  4,4,3 	Op > 
210:    LDC  3,1(6) 	True case 
211:    JGT  4,1(7) 	Jump if true 
212:    LDC  3,0(6) 	False case 
213:    JGT  3,1(7) 	Jump to then part 
* THEN
214:    LDA  7,0(7) 	Jump around the THEN 
* ENDIF
* IF
215:     LD  3,-2(1) 	Load variable x
216:     ST  3,-12(1) 	Save left side 
217:     LD  3,-3(1) 	Load variable y
218:     LD  4,-12(1) 	Load left into ac1 
219:    SUB  4,4,3 	Op == 
220:    LDC  3,1(6) 	True case 
221:    JEQ  4,1(7) 	Jump if true 
222:    LDC  3,0(6) 	False case 
223:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* END compound statement
* ELSE
224:    LDA  7,1(7) 	Jump around the THEN 
* BEGIN compound statement
* END compound statement
225:    LDA  7,0(7) 	Jump around the ELSE 
* ENDIF
* IF
226:     LD  3,-2(1) 	Load variable x
227:     ST  3,-12(1) 	Save left side 
228:     LD  3,-3(1) 	Load variable y
229:     LD  4,-12(1) 	Load left into ac1 
230:    SUB  4,4,3 	Op < 
231:    LDC  3,1(6) 	True case 
232:    JLT  4,1(7) 	Jump if true 
233:    LDC  3,0(6) 	False case 
234:    JGT  3,1(7) 	Jump to then part 
* THEN
* IF
236:     LD  3,-2(1) 	Load variable x
237:     ST  3,-12(1) 	Save left side 
238:     LD  3,-3(1) 	Load variable y
239:     LD  4,-12(1) 	Load left into ac1 
240:    SUB  4,4,3 	Op > 
241:    LDC  3,1(6) 	True case 
242:    JGT  4,1(7) 	Jump if true 
243:    LDC  3,0(6) 	False case 
244:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
246:    LDC  3,2(6) 	Load constant 
247:     ST  3,-2(1) 	Store variable x
* ELSE
245:    LDA  7,3(7) 	Jump around the THEN 
* EXPRESSION STMT
249:    LDC  3,3(6) 	Load constant 
250:     ST  3,-2(1) 	Store variable x
248:    LDA  7,2(7) 	Jump around the ELSE 
* ENDIF
235:    LDA  7,15(7) 	Jump around the THEN 
* ENDIF
* IF
251:     LD  3,-2(1) 	Load variable x
252:     ST  3,-12(1) 	Save left side 
253:     LD  3,-3(1) 	Load variable y
254:     LD  4,-12(1) 	Load left into ac1 
255:    SUB  4,4,3 	Op < 
256:    LDC  3,1(6) 	True case 
257:    JLT  4,1(7) 	Jump if true 
258:    LDC  3,0(6) 	False case 
259:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* IF
261:     LD  3,-2(1) 	Load variable x
262:     ST  3,-12(1) 	Save left side 
263:     LD  3,-3(1) 	Load variable y
264:     LD  4,-12(1) 	Load left into ac1 
265:    SUB  4,4,3 	Op > 
266:    LDC  3,1(6) 	True case 
267:    JGT  4,1(7) 	Jump if true 
268:    LDC  3,0(6) 	False case 
269:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
271:    LDC  3,2(6) 	Load constant 
272:     ST  3,-2(1) 	Store variable x
270:    LDA  7,2(7) 	Jump around the THEN 
* ENDIF
* END compound statement
* ELSE
260:    LDA  7,13(7) 	Jump around the THEN 
* EXPRESSION STMT
274:    LDC  3,3(6) 	Load constant 
275:     ST  3,-2(1) 	Store variable x
273:    LDA  7,2(7) 	Jump around the ELSE 
* ENDIF
* IF
276:     LD  3,-6(1) 	Load variable b
277:    JGT  3,1(7) 	Jump to then part 
* THEN
278:    LDA  7,0(7) 	Jump around the THEN 
* ENDIF
* IF
279:     LD  3,-6(1) 	Load variable b
280:    LDC  4,1(6) 	Load 1 
281:    SUB  3,4,3 	Op NOT 
282:    JGT  3,1(7) 	Jump to then part 
* THEN
283:    LDA  7,0(7) 	Jump around the THEN 
* ENDIF
* IF
284:     LD  3,-5(1) 	Load variable a
285:     ST  3,-12(1) 	Save left side 
286:     LD  3,-6(1) 	Load variable b
287:     LD  4,-12(1) 	Load left into ac1 
288:    JEQ  3,1(7) 	Op AND 
289:    LDA  3,0(4) 	 
290:    JGT  3,1(7) 	Jump to then part 
* THEN
291:    LDA  7,0(7) 	Jump around the THEN 
* ENDIF
* IF
292:     LD  3,-5(1) 	Load variable a
293:     ST  3,-12(1) 	Save left side 
294:     LD  3,-6(1) 	Load variable b
295:     LD  4,-12(1) 	Load left into ac1 
296:    JGT  3,1(7) 	Op OR 
297:    LDA  3,0(4) 	 
298:    JGT  3,1(7) 	Jump to then part 
* THEN
299:    LDA  7,0(7) 	Jump around the THEN 
* ENDIF
* IF
300:     LD  3,-5(1) 	Load variable a
301:     ST  3,-12(1) 	Save left side 
302:     LD  3,-6(1) 	Load variable b
303:     ST  3,-13(1) 	Save left side 
304:     LD  3,-7(1) 	Load variable c
305:     LD  4,-13(1) 	Load left into ac1 
306:    JEQ  3,1(7) 	Op AND 
307:    LDA  3,0(4) 	 
308:     LD  4,-12(1) 	Load left into ac1 
309:    JGT  3,1(7) 	Op OR 
310:    LDA  3,0(4) 	 
311:    JGT  3,1(7) 	Jump to then part 
* THEN
312:    LDA  7,0(7) 	Jump around the THEN 
* ENDIF
* IF
313:     LD  3,-5(1) 	Load variable a
314:    LDC  4,1(6) 	Load 1 
315:    SUB  3,4,3 	Op NOT 
316:     ST  3,-12(1) 	Save left side 
317:     LD  3,-6(1) 	Load variable b
318:     LD  4,-12(1) 	Load left into ac1 
319:    JGT  3,1(7) 	Op OR 
320:    LDA  3,0(4) 	 
321:    JGT  3,1(7) 	Jump to then part 
* THEN
322:    LDA  7,0(7) 	Jump around the THEN 
* ENDIF
* IF
323:     LD  3,-2(1) 	Load variable x
324:     ST  3,-12(1) 	Save left side 
325:     LD  3,-3(1) 	Load variable y
326:     LD  4,-12(1) 	Load left into ac1 
327:    SUB  4,4,3 	Op > 
328:    LDC  3,1(6) 	True case 
329:    JGT  4,1(7) 	Jump if true 
330:    LDC  3,0(6) 	False case 
331:     ST  3,-12(1) 	Save left side 
332:     LD  3,-3(1) 	Load variable y
333:     ST  3,-13(1) 	Save left side 
334:     LD  3,-4(1) 	Load variable z
335:     LD  4,-13(1) 	Load left into ac1 
336:    SUB  4,4,3 	Op > 
337:    LDC  3,1(6) 	True case 
338:    JGT  4,1(7) 	Jump if true 
339:    LDC  3,0(6) 	False case 
340:     LD  4,-12(1) 	Load left into ac1 
341:    JEQ  3,1(7) 	Op AND 
342:    LDA  3,0(4) 	 
343:    JGT  3,1(7) 	Jump to then part 
* THEN
344:    LDA  7,0(7) 	Jump around the THEN 
* ENDIF
* IF
345:     LD  3,-2(1) 	Load variable x
346:     ST  3,-12(1) 	Save left side 
347:     LD  3,-3(1) 	Load variable y
348:     LD  4,-12(1) 	Load left into ac1 
349:    SUB  4,4,3 	Op > 
350:    LDC  3,1(6) 	True case 
351:    JGT  4,1(7) 	Jump if true 
352:    LDC  3,0(6) 	False case 
353:     ST  3,-12(1) 	Save left side 
354:     LD  3,-3(1) 	Load variable y
355:     ST  3,-13(1) 	Save left side 
356:     LD  3,-4(1) 	Load variable z
357:     LD  4,-13(1) 	Load left into ac1 
358:    SUB  4,4,3 	Op > 
359:    LDC  3,1(6) 	True case 
360:    JGT  4,1(7) 	Jump if true 
361:    LDC  3,0(6) 	False case 
362:     LD  4,-12(1) 	Load left into ac1 
363:    JGT  3,1(7) 	Op OR 
364:    LDA  3,0(4) 	 
365:    JGT  3,1(7) 	Jump to then part 
* THEN
366:    LDA  7,0(7) 	Jump around the THEN 
* ENDIF
* EXPRESSION STMT
367:     LD  3,-2(1) 	Load variable x
368:     ST  3,-12(1) 	Save left side 
369:     LD  3,-3(1) 	Load variable y
370:     LD  4,-12(1) 	Load left into ac1 
371:    SUB  4,4,3 	Op > 
372:    LDC  3,1(6) 	True case 
373:    JGT  4,1(7) 	Jump if true 
374:    LDC  3,0(6) 	False case 
375:     ST  3,-12(1) 	Save left side 
376:     LD  3,-3(1) 	Load variable y
377:     ST  3,-13(1) 	Save left side 
378:     LD  3,-4(1) 	Load variable z
379:     LD  4,-13(1) 	Load left into ac1 
380:    SUB  4,4,3 	Op > 
381:    LDC  3,1(6) 	True case 
382:    JGT  4,1(7) 	Jump if true 
383:    LDC  3,0(6) 	False case 
384:     LD  4,-12(1) 	Load left into ac1 
385:    JEQ  3,1(7) 	Op AND 
386:    LDA  3,0(4) 	 
387:     ST  3,-7(1) 	Store variable c
* EXPRESSION STMT
388:     LD  3,-2(1) 	Load variable x
389:     ST  3,-12(1) 	Save left side 
390:     LD  3,-3(1) 	Load variable y
391:     LD  4,-12(1) 	Load left into ac1 
392:    SUB  4,4,3 	Op > 
393:    LDC  3,1(6) 	True case 
394:    JGT  4,1(7) 	Jump if true 
395:    LDC  3,0(6) 	False case 
396:     ST  3,-12(1) 	Save left side 
397:     LD  3,-3(1) 	Load variable y
398:     ST  3,-13(1) 	Save left side 
399:     LD  3,-4(1) 	Load variable z
400:     LD  4,-13(1) 	Load left into ac1 
401:    SUB  4,4,3 	Op > 
402:    LDC  3,1(6) 	True case 
403:    JGT  4,1(7) 	Jump if true 
404:    LDC  3,0(6) 	False case 
405:     LD  4,-12(1) 	Load left into ac1 
406:    JGT  3,1(7) 	Op OR 
407:    LDA  3,0(4) 	 
408:     ST  3,-7(1) 	Store variable c
* EXPRESSION STMT
409:     LD  3,-2(1) 	Load variable x
410:     ST  3,-12(1) 	Save left side 
411:     LD  3,-3(1) 	Load variable y
412:     LD  4,-12(1) 	Load left into ac1 
413:    SUB  4,4,3 	Op > 
414:    LDC  3,1(6) 	True case 
415:    JGT  4,1(7) 	Jump if true 
416:    LDC  3,0(6) 	False case 
417:    LDC  4,1(6) 	Load 1 
418:    SUB  3,4,3 	Op NOT 
419:     ST  3,-12(1) 	Save left side 
420:     LD  3,-3(1) 	Load variable y
421:     ST  3,-13(1) 	Save left side 
422:     LD  3,-4(1) 	Load variable z
423:     LD  4,-13(1) 	Load left into ac1 
424:    SUB  4,4,3 	Op > 
425:    LDC  3,1(6) 	True case 
426:    JGT  4,1(7) 	Jump if true 
427:    LDC  3,0(6) 	False case 
428:     LD  4,-12(1) 	Load left into ac1 
429:    JEQ  3,1(7) 	Op AND 
430:    LDA  3,0(4) 	 
431:     ST  3,-7(1) 	Store variable c
* EXPRESSION STMT
432:     LD  3,-2(1) 	Load variable x
433:     ST  3,-12(1) 	Save left side 
434:     LD  3,-3(1) 	Load variable y
435:     LD  4,-12(1) 	Load left into ac1 
436:    SUB  4,4,3 	Op > 
437:    LDC  3,1(6) 	True case 
438:    JGT  4,1(7) 	Jump if true 
439:    LDC  3,0(6) 	False case 
440:    LDC  4,1(6) 	Load 1 
441:    SUB  3,4,3 	Op NOT 
442:     ST  3,-12(1) 	Save left side 
443:     LD  3,-3(1) 	Load variable y
444:     ST  3,-13(1) 	Save left side 
445:     LD  3,-4(1) 	Load variable z
446:     LD  4,-13(1) 	Load left into ac1 
447:    SUB  4,4,3 	Op > 
448:    LDC  3,1(6) 	True case 
449:    JGT  4,1(7) 	Jump if true 
450:    LDC  3,0(6) 	False case 
451:     LD  4,-12(1) 	Load left into ac1 
452:    JGT  3,1(7) 	Op OR 
453:    LDA  3,0(4) 	 
454:     ST  3,-7(1) 	Store variable c
* EXPRESSION STMT
455:     LD  3,-3(1) 	Load variable y
456:     ST  3,-12(1) 	Save left side 
457:     LD  3,-2(1) 	Load variable x
458:     LD  4,-12(1) 	Load left into ac1 
459:    SUB  4,4,3 	Op == 
460:    LDC  3,1(6) 	True case 
461:    JEQ  4,1(7) 	Jump if true 
462:    LDC  3,0(6) 	False case 
463:     ST  3,-12(1) 	Save left side 
464:     LD  3,-2(1) 	Load variable x
465:     ST  3,-13(1) 	Save left side 
466:     LD  3,-3(1) 	Load variable y
467:     LD  4,-13(1) 	Load left into ac1 
468:    SUB  4,4,3 	Op > 
469:    LDC  3,1(6) 	True case 
470:    JGT  4,1(7) 	Jump if true 
471:    LDC  3,0(6) 	False case 
472:     ST  3,-13(1) 	Save left side 
473:     LD  3,-3(1) 	Load variable y
474:     ST  3,-14(1) 	Save left side 
475:     LD  3,-4(1) 	Load variable z
476:     LD  4,-14(1) 	Load left into ac1 
477:    SUB  4,4,3 	Op > 
478:    LDC  3,1(6) 	True case 
479:    JGT  4,1(7) 	Jump if true 
480:    LDC  3,0(6) 	False case 
481:     LD  4,-13(1) 	Load left into ac1 
482:    JEQ  3,1(7) 	Op AND 
483:    LDA  3,0(4) 	 
484:     LD  4,-12(1) 	Load left into ac1 
485:    JGT  3,1(7) 	Op OR 
486:    LDA  3,0(4) 	 
487:     ST  3,-7(1) 	Store variable c
* IF
488:     LD  3,-6(1) 	Load variable b
489:     ST  3,-12(1) 	Save left side 
490:     LD  3,-2(1) 	Load variable x
491:     ST  3,-13(1) 	Save left side 
492:     LD  3,-3(1) 	Load variable y
493:     LD  4,-13(1) 	Load left into ac1 
494:    SUB  4,4,3 	Op > 
495:    LDC  3,1(6) 	True case 
496:    JGT  4,1(7) 	Jump if true 
497:    LDC  3,0(6) 	False case 
498:     ST  3,-13(1) 	Save left side 
499:     LD  3,-3(1) 	Load variable y
500:     ST  3,-14(1) 	Save left side 
501:     LD  3,-4(1) 	Load variable z
502:     LD  4,-14(1) 	Load left into ac1 
503:    SUB  4,4,3 	Op > 
504:    LDC  3,1(6) 	True case 
505:    JGT  4,1(7) 	Jump if true 
506:    LDC  3,0(6) 	False case 
507:     LD  4,-13(1) 	Load left into ac1 
508:    JEQ  3,1(7) 	Op AND 
509:    LDA  3,0(4) 	 
510:     LD  4,-12(1) 	Load left into ac1 
511:    JGT  3,1(7) 	Op OR 
512:    LDA  3,0(4) 	 
513:    JGT  3,1(7) 	Jump to then part 
* THEN
514:    LDA  7,0(7) 	Jump around the THEN 
* ENDIF
* END compound statement
* Add standard closing in case there is no return statement
515:    LDC  2,0(6) 	Set return value to 0 
516:     LD  3,-1(1) 	Load return address 
517:     LD  1,0(1) 	Adjust fp 
518:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,518(7) 	Jump to init 
* BEGIN Init
519:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
520:    LDA  1,0(0) 	set first frame at end of globals 
521:     ST  1,0(1) 	store old fp (point to self) 
522:    LDA  3,1(7) 	Return address in ac 
523:    LDA  7,-494(7) 	Jump to main 
524:   HALT  0,0,0 	DONE! 
* END Init
