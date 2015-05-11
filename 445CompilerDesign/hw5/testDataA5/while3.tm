* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  while3.c-
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
* IF
 31:     LD  3,-2(1) 	Load variable x
 32:     ST  3,-7(1) 	Save left side 
 33:    LDC  3,1(6) 	Load constant 
 34:     LD  4,-7(1) 	Load left into ac1 
 35:    SUB  4,4,3 	Op > 
 36:    LDC  3,1(6) 	True case 
 37:    JGT  4,1(7) 	Jump if true 
 38:    LDC  3,0(6) 	False case 
 39:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
 41:    LDC  3,1(6) 	Load constant 
 42:     ST  3,-4(1) 	Store variable z
 40:    LDA  7,2(7) 	Jump around the THEN 
* ENDIF
* IF
 43:     LD  3,-2(1) 	Load variable x
 44:     ST  3,-7(1) 	Save left side 
 45:    LDC  3,2(6) 	Load constant 
 46:     LD  4,-7(1) 	Load left into ac1 
 47:    SUB  4,4,3 	Op > 
 48:    LDC  3,1(6) 	True case 
 49:    JGT  4,1(7) 	Jump if true 
 50:    LDC  3,0(6) 	False case 
 51:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
 53:    LDC  3,1(6) 	Load constant 
 54:     ST  3,-4(1) 	Store variable z
* ELSE
 52:    LDA  7,3(7) 	Jump around the THEN 
* EXPRESSION STMT
 56:    LDC  3,2(6) 	Load constant 
 57:     ST  3,-4(1) 	Store variable z
 55:    LDA  7,2(7) 	Jump around the ELSE 
* ENDIF
* IF
 58:     LD  3,-2(1) 	Load variable x
 59:     ST  3,-7(1) 	Save left side 
 60:    LDC  3,3(6) 	Load constant 
 61:     LD  4,-7(1) 	Load left into ac1 
 62:    SUB  4,4,3 	Op > 
 63:    LDC  3,1(6) 	True case 
 64:    JGT  4,1(7) 	Jump if true 
 65:    LDC  3,0(6) 	False case 
 66:    JGT  3,1(7) 	Jump to then part 
* THEN
* IF
 68:     LD  3,-3(1) 	Load variable y
 69:     ST  3,-7(1) 	Save left side 
 70:    LDC  3,4(6) 	Load constant 
 71:     LD  4,-7(1) 	Load left into ac1 
 72:    SUB  4,4,3 	Op > 
 73:    LDC  3,1(6) 	True case 
 74:    JGT  4,1(7) 	Jump if true 
 75:    LDC  3,0(6) 	False case 
 76:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
 78:    LDC  3,3(6) 	Load constant 
 79:     ST  3,-4(1) 	Store variable z
 77:    LDA  7,2(7) 	Jump around the THEN 
* ENDIF
 67:    LDA  7,12(7) 	Jump around the THEN 
* ENDIF
* IF
 80:     LD  3,-2(1) 	Load variable x
 81:     ST  3,-7(1) 	Save left side 
 82:    LDC  3,5(6) 	Load constant 
 83:     LD  4,-7(1) 	Load left into ac1 
 84:    SUB  4,4,3 	Op > 
 85:    LDC  3,1(6) 	True case 
 86:    JGT  4,1(7) 	Jump if true 
 87:    LDC  3,0(6) 	False case 
 88:    JGT  3,1(7) 	Jump to then part 
* THEN
* IF
 90:     LD  3,-3(1) 	Load variable y
 91:     ST  3,-7(1) 	Save left side 
 92:    LDC  3,6(6) 	Load constant 
 93:     LD  4,-7(1) 	Load left into ac1 
 94:    SUB  4,4,3 	Op > 
 95:    LDC  3,1(6) 	True case 
 96:    JGT  4,1(7) 	Jump if true 
 97:    LDC  3,0(6) 	False case 
 98:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
100:    LDC  3,4(6) 	Load constant 
101:     ST  3,-4(1) 	Store variable z
* ELSE
 99:    LDA  7,3(7) 	Jump around the THEN 
* EXPRESSION STMT
103:    LDC  3,5(6) 	Load constant 
104:     ST  3,-4(1) 	Store variable z
102:    LDA  7,2(7) 	Jump around the ELSE 
* ENDIF
 89:    LDA  7,15(7) 	Jump around the THEN 
* ENDIF
* IF
105:     LD  3,-2(1) 	Load variable x
106:     ST  3,-7(1) 	Save left side 
107:    LDC  3,7(6) 	Load constant 
108:     LD  4,-7(1) 	Load left into ac1 
109:    SUB  4,4,3 	Op > 
110:    LDC  3,1(6) 	True case 
111:    JGT  4,1(7) 	Jump if true 
112:    LDC  3,0(6) 	False case 
113:    JGT  3,1(7) 	Jump to then part 
* THEN
* IF
115:     LD  3,-3(1) 	Load variable y
116:     ST  3,-7(1) 	Save left side 
117:    LDC  3,8(6) 	Load constant 
118:     LD  4,-7(1) 	Load left into ac1 
119:    SUB  4,4,3 	Op > 
120:    LDC  3,1(6) 	True case 
121:    JGT  4,1(7) 	Jump if true 
122:    LDC  3,0(6) 	False case 
123:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
125:    LDC  3,6(6) 	Load constant 
126:     ST  3,-4(1) 	Store variable z
* ELSE
124:    LDA  7,3(7) 	Jump around the THEN 
* EXPRESSION STMT
128:    LDC  3,7(6) 	Load constant 
129:     ST  3,-4(1) 	Store variable z
127:    LDA  7,2(7) 	Jump around the ELSE 
* ENDIF
* ELSE
114:    LDA  7,16(7) 	Jump around the THEN 
* EXPRESSION STMT
131:    LDC  3,8(6) 	Load constant 
132:     ST  3,-4(1) 	Store variable z
130:    LDA  7,2(7) 	Jump around the ELSE 
* ENDIF
* IF
133:     LD  3,-2(1) 	Load variable x
134:     ST  3,-7(1) 	Save left side 
135:    LDC  3,9(6) 	Load constant 
136:     LD  4,-7(1) 	Load left into ac1 
137:    SUB  4,4,3 	Op < 
138:    LDC  3,1(6) 	True case 
139:    JLT  4,1(7) 	Jump if true 
140:    LDC  3,0(6) 	False case 
141:    JGT  3,1(7) 	Jump to then part 
* THEN
* WHILE
143:     LD  3,-3(1) 	Load variable y
144:     ST  3,-7(1) 	Save left side 
145:    LDC  3,10(6) 	Load constant 
146:     LD  4,-7(1) 	Load left into ac1 
147:    SUB  4,4,3 	Op > 
148:    LDC  3,1(6) 	True case 
149:    JGT  4,1(7) 	Jump if true 
150:    LDC  3,0(6) 	False case 
151:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
153:    LDC  3,9(6) 	Load constant 
154:    LDA  7,-12(7) 	go to beginning of loop 
152:    LDA  7,2(7) 	No more loop 
* ENDWHILE
142:    LDA  7,12(7) 	Jump around the THEN 
* ENDIF
* IF
155:     LD  3,-2(1) 	Load variable x
156:     ST  3,-7(1) 	Save left side 
157:    LDC  3,9(6) 	Load constant 
158:     LD  4,-7(1) 	Load left into ac1 
159:    SUB  4,4,3 	Op < 
160:    LDC  3,1(6) 	True case 
161:    JLT  4,1(7) 	Jump if true 
162:    LDC  3,0(6) 	False case 
163:    JGT  3,1(7) 	Jump to then part 
* THEN
* WHILE
165:     LD  3,-3(1) 	Load variable y
166:     ST  3,-7(1) 	Save left side 
167:    LDC  3,10(6) 	Load constant 
168:     LD  4,-7(1) 	Load left into ac1 
169:    SUB  4,4,3 	Op > 
170:    LDC  3,1(6) 	True case 
171:    JGT  4,1(7) 	Jump if true 
172:    LDC  3,0(6) 	False case 
173:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
175:     LD  3,-2(1) 	Load variable x
176:     ST  3,-7(1) 	Save left side 
177:    LDC  3,3(6) 	Load constant 
178:     LD  4,-7(1) 	Load left into ac1 
179:    SUB  4,4,3 	Op < 
180:    LDC  3,1(6) 	True case 
181:    JLT  4,1(7) 	Jump if true 
182:    LDC  3,0(6) 	False case 
183:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
185:    LDC  3,3(6) 	Load constant 
* ELSE
184:    LDA  7,2(7) 	Jump around the THEN 
* EXPRESSION STMT
187:    LDC  3,9(6) 	Load constant 
186:    LDA  7,1(7) 	Jump around the ELSE 
* ENDIF
188:    LDA  7,-24(7) 	go to beginning of loop 
174:    LDA  7,14(7) 	No more loop 
* ENDWHILE
164:    LDA  7,24(7) 	Jump around the THEN 
* ENDIF
* WHILE
189:     LD  3,-3(1) 	Load variable y
190:     ST  3,-7(1) 	Save left side 
191:    LDC  3,11(6) 	Load constant 
192:     LD  4,-7(1) 	Load left into ac1 
193:    SUB  4,4,3 	Op < 
194:    LDC  3,1(6) 	True case 
195:    JLT  4,1(7) 	Jump if true 
196:    LDC  3,0(6) 	False case 
197:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
199:     LD  3,-2(1) 	Load variable x
200:     ST  3,-7(1) 	Save left side 
201:    LDC  3,12(6) 	Load constant 
202:     LD  4,-7(1) 	Load left into ac1 
203:    SUB  4,4,3 	Op < 
204:    LDC  3,1(6) 	True case 
205:    JLT  4,1(7) 	Jump if true 
206:    LDC  3,0(6) 	False case 
207:    JGT  3,1(7) 	Jump to then part 
* THEN
* WHILE
209:     LD  3,-3(1) 	Load variable y
210:     ST  3,-7(1) 	Save left side 
211:    LDC  3,13(6) 	Load constant 
212:     LD  4,-7(1) 	Load left into ac1 
213:    SUB  4,4,3 	Op > 
214:    LDC  3,1(6) 	True case 
215:    JGT  4,1(7) 	Jump if true 
216:    LDC  3,0(6) 	False case 
217:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
219:    LDC  3,10(6) 	Load constant 
220:    LDA  7,-12(7) 	go to beginning of loop 
218:    LDA  7,2(7) 	No more loop 
* ENDWHILE
208:    LDA  7,12(7) 	Jump around the THEN 
* ENDIF
221:    LDA  7,-33(7) 	go to beginning of loop 
198:    LDA  7,23(7) 	No more loop 
* ENDWHILE
* IF
222:     LD  3,-2(1) 	Load variable x
223:     ST  3,-7(1) 	Save left side 
224:    LDC  3,13(6) 	Load constant 
225:     LD  4,-7(1) 	Load left into ac1 
226:    SUB  4,4,3 	Op < 
227:    LDC  3,1(6) 	True case 
228:    JLT  4,1(7) 	Jump if true 
229:    LDC  3,0(6) 	False case 
230:    JGT  3,1(7) 	Jump to then part 
* THEN
* WHILE
232:     LD  3,-3(1) 	Load variable y
233:     ST  3,-7(1) 	Save left side 
234:    LDC  3,14(6) 	Load constant 
235:     LD  4,-7(1) 	Load left into ac1 
236:    SUB  4,4,3 	Op > 
237:    LDC  3,1(6) 	True case 
238:    JGT  4,1(7) 	Jump if true 
239:    LDC  3,0(6) 	False case 
240:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
242:    LDC  3,20(6) 	Load constant 
243:    LDA  7,-12(7) 	go to beginning of loop 
241:    LDA  7,2(7) 	No more loop 
* ENDWHILE
* ELSE
231:    LDA  7,13(7) 	Jump around the THEN 
* EXPRESSION STMT
245:    LDC  3,21(6) 	Load constant 
244:    LDA  7,1(7) 	Jump around the ELSE 
* ENDIF
* WHILE
246:     LD  3,-3(1) 	Load variable y
247:     ST  3,-7(1) 	Save left side 
248:    LDC  3,15(6) 	Load constant 
249:     LD  4,-7(1) 	Load left into ac1 
250:    SUB  4,4,3 	Op > 
251:    LDC  3,1(6) 	True case 
252:    JGT  4,1(7) 	Jump if true 
253:    LDC  3,0(6) 	False case 
254:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
256:     LD  3,-2(1) 	Load variable x
257:     ST  3,-7(1) 	Save left side 
258:    LDC  3,16(6) 	Load constant 
259:     LD  4,-7(1) 	Load left into ac1 
260:    SUB  4,4,3 	Op < 
261:    LDC  3,1(6) 	True case 
262:    JLT  4,1(7) 	Jump if true 
263:    LDC  3,0(6) 	False case 
264:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
266:    LDC  3,22(6) 	Load constant 
* ELSE
265:    LDA  7,2(7) 	Jump around the THEN 
* EXPRESSION STMT
268:    LDC  3,23(6) 	Load constant 
267:    LDA  7,1(7) 	Jump around the ELSE 
* ENDIF
269:    LDA  7,-24(7) 	go to beginning of loop 
255:    LDA  7,14(7) 	No more loop 
* ENDWHILE
* WHILE
270:     LD  3,-3(1) 	Load variable y
271:     ST  3,-7(1) 	Save left side 
272:    LDC  3,15(6) 	Load constant 
273:     LD  4,-7(1) 	Load left into ac1 
274:    SUB  4,4,3 	Op > 
275:    LDC  3,1(6) 	True case 
276:    JGT  4,1(7) 	Jump if true 
277:    LDC  3,0(6) 	False case 
278:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
280:     LD  3,-2(1) 	Load variable x
281:     ST  3,-7(1) 	Save left side 
282:    LDC  3,16(6) 	Load constant 
283:     LD  4,-7(1) 	Load left into ac1 
284:    SUB  4,4,3 	Op < 
285:    LDC  3,1(6) 	True case 
286:    JLT  4,1(7) 	Jump if true 
287:    LDC  3,0(6) 	False case 
288:    JGT  3,1(7) 	Jump to then part 
* THEN
* WHILE
290:     LD  3,-3(1) 	Load variable y
291:     ST  3,-7(1) 	Save left side 
292:    LDC  3,3(6) 	Load constant 
293:     LD  4,-7(1) 	Load left into ac1 
294:    SUB  4,4,3 	Op < 
295:    LDC  3,1(6) 	True case 
296:    JLT  4,1(7) 	Jump if true 
297:    LDC  3,0(6) 	False case 
298:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
300:    LDC  3,9(6) 	Load constant 
301:    LDA  7,-12(7) 	go to beginning of loop 
299:    LDA  7,2(7) 	No more loop 
* ENDWHILE
* ELSE
289:    LDA  7,13(7) 	Jump around the THEN 
* EXPRESSION STMT
303:    LDC  3,23(6) 	Load constant 
302:    LDA  7,1(7) 	Jump around the ELSE 
* ENDIF
304:    LDA  7,-35(7) 	go to beginning of loop 
279:    LDA  7,25(7) 	No more loop 
* ENDWHILE
* WHILE
305:     LD  3,-3(1) 	Load variable y
306:     ST  3,-7(1) 	Save left side 
307:    LDC  3,15(6) 	Load constant 
308:     LD  4,-7(1) 	Load left into ac1 
309:    SUB  4,4,3 	Op > 
310:    LDC  3,1(6) 	True case 
311:    JGT  4,1(7) 	Jump if true 
312:    LDC  3,0(6) 	False case 
313:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
315:     LD  3,-2(1) 	Load variable x
316:     ST  3,-7(1) 	Save left side 
317:    LDC  3,16(6) 	Load constant 
318:     LD  4,-7(1) 	Load left into ac1 
319:    SUB  4,4,3 	Op < 
320:    LDC  3,1(6) 	True case 
321:    JLT  4,1(7) 	Jump if true 
322:    LDC  3,0(6) 	False case 
323:    JGT  3,1(7) 	Jump to then part 
* THEN
* WHILE
325:     LD  3,-3(1) 	Load variable y
326:     ST  3,-7(1) 	Save left side 
327:    LDC  3,3(6) 	Load constant 
328:     LD  4,-7(1) 	Load left into ac1 
329:    SUB  4,4,3 	Op < 
330:    LDC  3,1(6) 	True case 
331:    JLT  4,1(7) 	Jump if true 
332:    LDC  3,0(6) 	False case 
333:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
335:    LDC  3,9(6) 	Load constant 
336:    LDA  7,-12(7) 	go to beginning of loop 
334:    LDA  7,2(7) 	No more loop 
* ENDWHILE
* ELSE
324:    LDA  7,13(7) 	Jump around the THEN 
* WHILE
338:     LD  3,-3(1) 	Load variable y
339:     ST  3,-7(1) 	Save left side 
340:    LDC  3,3(6) 	Load constant 
341:     LD  4,-7(1) 	Load left into ac1 
342:    SUB  4,4,3 	Op > 
343:    LDC  3,1(6) 	True case 
344:    JGT  4,1(7) 	Jump if true 
345:    LDC  3,0(6) 	False case 
346:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
348:    LDC  3,23(6) 	Load constant 
349:    LDA  7,-12(7) 	go to beginning of loop 
347:    LDA  7,2(7) 	No more loop 
* ENDWHILE
337:    LDA  7,12(7) 	Jump around the ELSE 
* ENDIF
350:    LDA  7,-46(7) 	go to beginning of loop 
314:    LDA  7,36(7) 	No more loop 
* ENDWHILE
* WHILE
351:     LD  3,-3(1) 	Load variable y
352:     ST  3,-7(1) 	Save left side 
353:    LDC  3,15(6) 	Load constant 
354:     LD  4,-7(1) 	Load left into ac1 
355:    SUB  4,4,3 	Op > 
356:    LDC  3,1(6) 	True case 
357:    JGT  4,1(7) 	Jump if true 
358:    LDC  3,0(6) 	False case 
359:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
361:     LD  3,-2(1) 	Load variable x
362:     ST  3,-7(1) 	Save left side 
363:    LDC  3,16(6) 	Load constant 
364:     LD  4,-7(1) 	Load left into ac1 
365:    SUB  4,4,3 	Op < 
366:    LDC  3,1(6) 	True case 
367:    JLT  4,1(7) 	Jump if true 
368:    LDC  3,0(6) 	False case 
369:    JGT  3,1(7) 	Jump to then part 
* THEN
* WHILE
371:     LD  3,-3(1) 	Load variable y
372:     ST  3,-7(1) 	Save left side 
373:    LDC  3,3(6) 	Load constant 
374:     LD  4,-7(1) 	Load left into ac1 
375:    SUB  4,4,3 	Op < 
376:    LDC  3,1(6) 	True case 
377:    JLT  4,1(7) 	Jump if true 
378:    LDC  3,0(6) 	False case 
379:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
381:     LD  3,-5(1) 	Load variable b
382:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
384:    LDC  3,34(6) 	Load constant 
* ELSE
383:    LDA  7,2(7) 	Jump around the THEN 
* EXPRESSION STMT
386:    LDC  3,34(6) 	Load constant 
385:    LDA  7,1(7) 	Jump around the ELSE 
* ENDIF
387:    LDA  7,-17(7) 	go to beginning of loop 
380:    LDA  7,7(7) 	No more loop 
* ENDWHILE
* ELSE
370:    LDA  7,18(7) 	Jump around the THEN 
* WHILE
389:     LD  3,-3(1) 	Load variable y
390:     ST  3,-7(1) 	Save left side 
391:    LDC  3,3(6) 	Load constant 
392:     LD  4,-7(1) 	Load left into ac1 
393:    SUB  4,4,3 	Op > 
394:    LDC  3,1(6) 	True case 
395:    JGT  4,1(7) 	Jump if true 
396:    LDC  3,0(6) 	False case 
397:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
399:    LDC  3,23(6) 	Load constant 
400:    LDA  7,-12(7) 	go to beginning of loop 
398:    LDA  7,2(7) 	No more loop 
* ENDWHILE
388:    LDA  7,12(7) 	Jump around the ELSE 
* ENDIF
401:    LDA  7,-51(7) 	go to beginning of loop 
360:    LDA  7,41(7) 	No more loop 
* ENDWHILE
* WHILE
402:     LD  3,-3(1) 	Load variable y
403:     ST  3,-7(1) 	Save left side 
404:    LDC  3,15(6) 	Load constant 
405:     LD  4,-7(1) 	Load left into ac1 
406:    SUB  4,4,3 	Op > 
407:    LDC  3,1(6) 	True case 
408:    JGT  4,1(7) 	Jump if true 
409:    LDC  3,0(6) 	False case 
410:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
412:     LD  3,-2(1) 	Load variable x
413:     ST  3,-7(1) 	Save left side 
414:    LDC  3,16(6) 	Load constant 
415:     LD  4,-7(1) 	Load left into ac1 
416:    SUB  4,4,3 	Op < 
417:    LDC  3,1(6) 	True case 
418:    JLT  4,1(7) 	Jump if true 
419:    LDC  3,0(6) 	False case 
420:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* WHILE
422:     LD  3,-3(1) 	Load variable y
423:     ST  3,-7(1) 	Save left side 
424:    LDC  3,3(6) 	Load constant 
425:     LD  4,-7(1) 	Load left into ac1 
426:    SUB  4,4,3 	Op < 
427:    LDC  3,1(6) 	True case 
428:    JLT  4,1(7) 	Jump if true 
429:    LDC  3,0(6) 	False case 
430:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
432:     LD  3,-5(1) 	Load variable b
433:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
435:    LDC  3,34(6) 	Load constant 
434:    LDA  7,1(7) 	Jump around the THEN 
* ENDIF
436:    LDA  7,-15(7) 	go to beginning of loop 
431:    LDA  7,5(7) 	No more loop 
* ENDWHILE
* END compound statement
* ELSE
421:    LDA  7,16(7) 	Jump around the THEN 
* WHILE
438:     LD  3,-3(1) 	Load variable y
439:     ST  3,-7(1) 	Save left side 
440:    LDC  3,3(6) 	Load constant 
441:     LD  4,-7(1) 	Load left into ac1 
442:    SUB  4,4,3 	Op > 
443:    LDC  3,1(6) 	True case 
444:    JGT  4,1(7) 	Jump if true 
445:    LDC  3,0(6) 	False case 
446:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
448:    LDC  3,23(6) 	Load constant 
449:    LDA  7,-12(7) 	go to beginning of loop 
447:    LDA  7,2(7) 	No more loop 
* ENDWHILE
437:    LDA  7,12(7) 	Jump around the ELSE 
* ENDIF
450:    LDA  7,-49(7) 	go to beginning of loop 
411:    LDA  7,39(7) 	No more loop 
* ENDWHILE
* IF
451:     LD  3,-2(1) 	Load variable x
452:     ST  3,-7(1) 	Save left side 
453:    LDC  3,2(6) 	Load constant 
454:     LD  4,-7(1) 	Load left into ac1 
455:    SUB  4,4,3 	Op > 
456:    LDC  3,1(6) 	True case 
457:    JGT  4,1(7) 	Jump if true 
458:    LDC  3,0(6) 	False case 
459:    JGT  3,1(7) 	Jump to then part 
* THEN
460:    LDA  7,0(7) 	Jump around the THEN 
* ENDIF
* WHILE
461:     LD  3,-5(1) 	Load variable b
462:    JGT  3,1(7) 	Jump to while part 
* DO
464:    LDA  7,-4(7) 	go to beginning of loop 
463:    LDA  7,1(7) 	No more loop 
* ENDWHILE
* WHILE
465:     LD  3,-5(1) 	Load variable b
466:    JGT  3,1(7) 	Jump to while part 
* DO
* WHILE
468:     LD  3,-5(1) 	Load variable b
469:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
471:     LD  3,-5(1) 	Load variable b
472:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
474:     LD  3,-2(1) 	Load variable x
* ELSE
473:    LDA  7,2(7) 	Jump around the THEN 
* EXPRESSION STMT
476:     LD  3,-3(1) 	Load variable y
475:    LDA  7,1(7) 	Jump around the ELSE 
* ENDIF
477:    LDA  7,-10(7) 	go to beginning of loop 
470:    LDA  7,7(7) 	No more loop 
* ENDWHILE
478:    LDA  7,-14(7) 	go to beginning of loop 
467:    LDA  7,11(7) 	No more loop 
* ENDWHILE
* WHILE
479:     LD  3,-5(1) 	Load variable b
480:    JGT  3,1(7) 	Jump to while part 
* DO
* WHILE
482:     LD  3,-5(1) 	Load variable b
483:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
485:     LD  3,-5(1) 	Load variable b
486:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
488:     LD  3,-2(1) 	Load variable x
487:    LDA  7,1(7) 	Jump around the THEN 
* ENDIF
489:    LDA  7,-8(7) 	go to beginning of loop 
484:    LDA  7,5(7) 	No more loop 
* ENDWHILE
490:    LDA  7,-12(7) 	go to beginning of loop 
481:    LDA  7,9(7) 	No more loop 
* ENDWHILE
* IF
491:     LD  3,-5(1) 	Load variable b
492:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
494:     LD  3,-3(1) 	Load variable y
* ELSE
493:    LDA  7,2(7) 	Jump around the THEN 
* EXPRESSION STMT
496:     LD  3,-4(1) 	Load variable z
495:    LDA  7,1(7) 	Jump around the ELSE 
* ENDIF
* WHILE
497:     LD  3,-5(1) 	Load variable b
498:    JGT  3,1(7) 	Jump to while part 
* DO
* WHILE
500:     LD  3,-5(1) 	Load variable b
501:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
503:     LD  3,-5(1) 	Load variable b
504:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
506:     LD  3,-2(1) 	Load variable x
505:    LDA  7,1(7) 	Jump around the THEN 
* ENDIF
507:    LDA  7,-8(7) 	go to beginning of loop 
502:    LDA  7,5(7) 	No more loop 
* ENDWHILE
508:    LDA  7,-12(7) 	go to beginning of loop 
499:    LDA  7,9(7) 	No more loop 
* ENDWHILE
* WHILE
509:     LD  3,-5(1) 	Load variable b
510:    JGT  3,1(7) 	Jump to while part 
* DO
* WHILE
512:     LD  3,-5(1) 	Load variable b
513:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
515:     LD  3,-5(1) 	Load variable b
516:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
518:     LD  3,-2(1) 	Load variable x
517:    LDA  7,1(7) 	Jump around the THEN 
* ENDIF
519:    LDA  7,-8(7) 	go to beginning of loop 
514:    LDA  7,5(7) 	No more loop 
* ENDWHILE
520:    LDA  7,-12(7) 	go to beginning of loop 
511:    LDA  7,9(7) 	No more loop 
* ENDWHILE
* IF
521:     LD  3,-5(1) 	Load variable b
522:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
524:     LD  3,-3(1) 	Load variable y
523:    LDA  7,1(7) 	Jump around the THEN 
* ENDIF
* WHILE
525:     LD  3,-5(1) 	Load variable b
526:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
528:     LD  3,-6(1) 	Load variable c
529:    JGT  3,1(7) 	Jump to then part 
* THEN
* WHILE
531:     LD  3,-5(1) 	Load variable b
532:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
534:     LD  3,-5(1) 	Load variable b
535:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
537:     LD  3,-2(1) 	Load variable x
* ELSE
536:    LDA  7,2(7) 	Jump around the THEN 
* EXPRESSION STMT
539:     LD  3,-3(1) 	Load variable y
538:    LDA  7,1(7) 	Jump around the ELSE 
* ENDIF
540:    LDA  7,-10(7) 	go to beginning of loop 
533:    LDA  7,7(7) 	No more loop 
* ENDWHILE
530:    LDA  7,10(7) 	Jump around the THEN 
* ENDIF
541:    LDA  7,-17(7) 	go to beginning of loop 
527:    LDA  7,14(7) 	No more loop 
* ENDWHILE
* WHILE
542:     LD  3,-5(1) 	Load variable b
543:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
545:     LD  3,-6(1) 	Load variable c
546:    JGT  3,1(7) 	Jump to then part 
* THEN
* WHILE
548:     LD  3,-5(1) 	Load variable b
549:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
551:     LD  3,-5(1) 	Load variable b
552:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
554:     LD  3,-2(1) 	Load variable x
553:    LDA  7,1(7) 	Jump around the THEN 
* ENDIF
555:    LDA  7,-8(7) 	go to beginning of loop 
550:    LDA  7,5(7) 	No more loop 
* ENDWHILE
547:    LDA  7,8(7) 	Jump around the THEN 
* ENDIF
556:    LDA  7,-15(7) 	go to beginning of loop 
544:    LDA  7,12(7) 	No more loop 
* ENDWHILE
* IF
557:     LD  3,-5(1) 	Load variable b
558:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
560:     LD  3,-3(1) 	Load variable y
* ELSE
559:    LDA  7,2(7) 	Jump around the THEN 
* EXPRESSION STMT
562:     LD  3,-4(1) 	Load variable z
561:    LDA  7,1(7) 	Jump around the ELSE 
* ENDIF
* IF
563:     LD  3,-6(1) 	Load variable c
564:    JGT  3,1(7) 	Jump to then part 
* THEN
* WHILE
566:     LD  3,-5(1) 	Load variable b
567:    JGT  3,1(7) 	Jump to while part 
* DO
* WHILE
569:     LD  3,-5(1) 	Load variable b
570:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
572:     LD  3,-5(1) 	Load variable b
573:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
575:     LD  3,-2(1) 	Load variable x
* ELSE
574:    LDA  7,2(7) 	Jump around the THEN 
* EXPRESSION STMT
577:     LD  3,-3(1) 	Load variable y
576:    LDA  7,1(7) 	Jump around the ELSE 
* ENDIF
578:    LDA  7,-10(7) 	go to beginning of loop 
571:    LDA  7,7(7) 	No more loop 
* ENDWHILE
579:    LDA  7,-14(7) 	go to beginning of loop 
568:    LDA  7,11(7) 	No more loop 
* ENDWHILE
565:    LDA  7,14(7) 	Jump around the THEN 
* ENDIF
* IF
580:     LD  3,-6(1) 	Load variable c
581:    JGT  3,1(7) 	Jump to then part 
* THEN
* WHILE
583:     LD  3,-5(1) 	Load variable b
584:    JGT  3,1(7) 	Jump to while part 
* DO
* WHILE
586:     LD  3,-5(1) 	Load variable b
587:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
589:     LD  3,-5(1) 	Load variable b
590:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
592:     LD  3,-2(1) 	Load variable x
591:    LDA  7,1(7) 	Jump around the THEN 
* ENDIF
593:    LDA  7,-8(7) 	go to beginning of loop 
588:    LDA  7,5(7) 	No more loop 
* ENDWHILE
594:    LDA  7,-12(7) 	go to beginning of loop 
585:    LDA  7,9(7) 	No more loop 
* ENDWHILE
582:    LDA  7,12(7) 	Jump around the THEN 
* ENDIF
* IF
595:     LD  3,-5(1) 	Load variable b
596:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
598:     LD  3,-3(1) 	Load variable y
* ELSE
597:    LDA  7,2(7) 	Jump around the THEN 
* EXPRESSION STMT
600:     LD  3,-4(1) 	Load variable z
599:    LDA  7,1(7) 	Jump around the ELSE 
* ENDIF
* IF
601:     LD  3,-6(1) 	Load variable c
602:    JGT  3,1(7) 	Jump to then part 
* THEN
* WHILE
604:     LD  3,-5(1) 	Load variable b
605:    JGT  3,1(7) 	Jump to while part 
* DO
* WHILE
607:     LD  3,-5(1) 	Load variable b
608:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
610:     LD  3,-5(1) 	Load variable b
611:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
613:     LD  3,-2(1) 	Load variable x
* ELSE
612:    LDA  7,2(7) 	Jump around the THEN 
* EXPRESSION STMT
615:     LD  3,-3(1) 	Load variable y
614:    LDA  7,1(7) 	Jump around the ELSE 
* ENDIF
616:    LDA  7,-10(7) 	go to beginning of loop 
609:    LDA  7,7(7) 	No more loop 
* ENDWHILE
617:    LDA  7,-14(7) 	go to beginning of loop 
606:    LDA  7,11(7) 	No more loop 
* ENDWHILE
* ELSE
603:    LDA  7,15(7) 	Jump around the THEN 
* EXPRESSION STMT
619:     LD  3,-4(1) 	Load variable z
618:    LDA  7,1(7) 	Jump around the ELSE 
* ENDIF
* RETURN
620:    LDC  3,4182(6) 	Load constant 
621:    LDA  2,0(3) 	Copy result to rt register 
622:     LD  3,-1(1) 	Load return address 
623:     LD  1,0(1) 	Adjust fp 
624:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
625:    LDC  2,0(6) 	Set return value to 0 
626:     LD  3,-1(1) 	Load return address 
627:     LD  1,0(1) 	Adjust fp 
628:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,628(7) 	Jump to init 
* BEGIN Init
629:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
630:    LDA  1,0(0) 	set first frame at end of globals 
631:     ST  1,0(1) 	store old fp (point to self) 
632:    LDA  3,1(7) 	Return address in ac 
633:    LDA  7,-604(7) 	Jump to main 
634:   HALT  0,0,0 	DONE! 
* END Init
