* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  d05.tm
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
* EXPRESSION STMT
 31:    LDC  3,213(6) 	Load constant 
 32:     ST  3,0(1) 	Store variable a
* EXPRESSION STMT
 33:    LDC  3,11(6) 	Load constant 
 34:     ST  3,-2(1) 	Store variable b
* EXPRESSION STMT
 35:    LDC  3,4133(6) 	Load constant 
 36:     ST  3,-3(1) 	Store variable c
* EXPRESSION STMT
 37:     ST  1,-4(1) 	Store old frame in ghost frame 
 38:     LD  3,0(1) 	Load variable a
 39:     ST  3,-6(1) 	Save left side 
 40:     LD  3,-2(1) 	Load variable b
 41:     LD  4,-6(1) 	Load left into ac1 
 42:    SUB  4,4,3 	Op > 
 43:    LDC  3,1(6) 	True case 
 44:    JLT  4,1(7) 	Jump if true 
 45:    LDC  3,0(6) 	False case 
 46:     ST  3,-6(1) 	Save left side 
 47:     LD  3,-2(1) 	Load variable b
 48:     ST  3,-7(1) 	Save left side 
 49:     LD  3,-3(1) 	Load variable c
 50:     LD  4,-7(1) 	Load left into ac1 
 51:     ST  3,-7(1) 	Save left side 
 52:     LD  3,-3(1) 	Load variable c
 53:     ST  3,-8(1) 	Save left side 
 54:     LD  3,0(1) 	Load variable a
 55:     LD  4,-8(1) 	Load left into ac1 
 56:     LD  4,-7(1) 	Load left into ac1 
 57:    JEQ  3,1(7) 	Op AND 
 58:    LDA  3,0(4) 	 
 59:     LD  4,-6(1) 	Load left into ac1 
 60:     ST  3,-6(1) 	Store parameter 
 61:    LDA  1,-4(1) 	Load address of new frame 
 62:    LDA  3,1(7) 	Return address in ac 
 63:    LDA  7,-46(7) 	CALL outputb
 64:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 65:     ST  1,-4(1) 	Store old frame in ghost frame 
 66:     LD  3,0(1) 	Load variable a
 67:     ST  3,-6(1) 	Save left side 
 68:     LD  3,-2(1) 	Load variable b
 69:     LD  4,-6(1) 	Load left into ac1 
 70:    SUB  4,4,3 	Op > 
 71:    LDC  3,1(6) 	True case 
 72:    JLT  4,1(7) 	Jump if true 
 73:    LDC  3,0(6) 	False case 
 74:     ST  3,-6(1) 	Save left side 
 75:     LD  3,-2(1) 	Load variable b
 76:     ST  3,-7(1) 	Save left side 
 77:     LD  3,-3(1) 	Load variable c
 78:     LD  4,-7(1) 	Load left into ac1 
 79:     LD  4,-6(1) 	Load left into ac1 
 80:    JEQ  3,1(7) 	Op AND 
 81:    LDA  3,0(4) 	 
 82:     ST  3,-6(1) 	Save left side 
 83:     LD  3,-3(1) 	Load variable c
 84:     ST  3,-7(1) 	Save left side 
 85:     LD  3,0(1) 	Load variable a
 86:     LD  4,-7(1) 	Load left into ac1 
 87:     LD  4,-6(1) 	Load left into ac1 
 88:     ST  3,-6(1) 	Store parameter 
 89:    LDA  1,-4(1) 	Load address of new frame 
 90:    LDA  3,1(7) 	Return address in ac 
 91:    LDA  7,-74(7) 	CALL outputb
 92:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 93:     ST  1,-4(1) 	Store old frame in ghost frame 
 94:     LD  3,0(1) 	Load variable a
 95:     ST  3,-6(1) 	Save left side 
 96:     LD  3,-2(1) 	Load variable b
 97:     LD  4,-6(1) 	Load left into ac1 
 98:    SUB  4,4,3 	Op > 
 99:    LDC  3,1(6) 	True case 
100:    JLT  4,1(7) 	Jump if true 
101:    LDC  3,0(6) 	False case 
102:     ST  3,-6(1) 	Save left side 
103:     LD  3,-2(1) 	Load variable b
104:     ST  3,-7(1) 	Save left side 
105:     LD  3,-3(1) 	Load variable c
106:     LD  4,-7(1) 	Load left into ac1 
107:     LD  4,-6(1) 	Load left into ac1 
108:    JEQ  3,1(7) 	Op AND 
109:    LDA  3,0(4) 	 
110:     ST  3,-6(1) 	Save left side 
111:     LD  3,-3(1) 	Load variable c
112:     ST  3,-7(1) 	Save left side 
113:     LD  3,0(1) 	Load variable a
114:     LD  4,-7(1) 	Load left into ac1 
115:     ST  3,-7(1) 	Save left side 
116:     LD  3,-3(1) 	Load variable c
117:     ST  3,-8(1) 	Save left side 
118:     LD  3,0(1) 	Load variable a
119:     LD  4,-8(1) 	Load left into ac1 
120:     LD  4,-7(1) 	Load left into ac1 
121:    JEQ  3,1(7) 	Op AND 
122:    LDA  3,0(4) 	 
123:     LD  4,-6(1) 	Load left into ac1 
124:     ST  3,-6(1) 	Store parameter 
125:    LDA  1,-4(1) 	Load address of new frame 
126:    LDA  3,1(7) 	Return address in ac 
127:    LDA  7,-110(7) 	CALL outputb
128:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
129:     ST  1,-4(1) 	Store old frame in ghost frame 
130:     LD  3,0(1) 	Load variable a
131:     ST  3,-6(1) 	Save left side 
132:     LD  3,-2(1) 	Load variable b
133:     LD  4,-6(1) 	Load left into ac1 
134:    SUB  4,4,3 	Op > 
135:    LDC  3,1(6) 	True case 
136:    JLT  4,1(7) 	Jump if true 
137:    LDC  3,0(6) 	False case 
138:     ST  3,-6(1) 	Save left side 
139:     LD  3,-2(1) 	Load variable b
140:     ST  3,-7(1) 	Save left side 
141:     LD  3,-3(1) 	Load variable c
142:     LD  4,-7(1) 	Load left into ac1 
143:     ST  3,-7(1) 	Save left side 
144:     LD  3,-3(1) 	Load variable c
145:     ST  3,-8(1) 	Save left side 
146:     LD  3,0(1) 	Load variable a
147:     LD  4,-8(1) 	Load left into ac1 
148:     LD  4,-7(1) 	Load left into ac1 
149:    JEQ  3,1(7) 	Op AND 
150:    LDA  3,0(4) 	 
151:     LD  4,-6(1) 	Load left into ac1 
152:     ST  3,-6(1) 	Store parameter 
153:    LDA  1,-4(1) 	Load address of new frame 
154:    LDA  3,1(7) 	Return address in ac 
155:    LDA  7,-138(7) 	CALL outputb
156:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
157:     ST  1,-4(1) 	Store old frame in ghost frame 
158:     LD  3,0(1) 	Load variable a
159:     ST  3,-6(1) 	Save left side 
160:     LD  3,-2(1) 	Load variable b
161:     LD  4,-6(1) 	Load left into ac1 
162:    SUB  4,4,3 	Op > 
163:    LDC  3,1(6) 	True case 
164:    JLT  4,1(7) 	Jump if true 
165:    LDC  3,0(6) 	False case 
166:     ST  3,-6(1) 	Save left side 
167:     LD  3,-2(1) 	Load variable b
168:     ST  3,-7(1) 	Save left side 
169:     LD  3,-3(1) 	Load variable c
170:     LD  4,-7(1) 	Load left into ac1 
171:     LD  4,-6(1) 	Load left into ac1 
172:    JEQ  3,1(7) 	Op AND 
173:    LDA  3,0(4) 	 
174:     ST  3,-6(1) 	Save left side 
175:     LD  3,-3(1) 	Load variable c
176:     ST  3,-7(1) 	Save left side 
177:     LD  3,0(1) 	Load variable a
178:     LD  4,-7(1) 	Load left into ac1 
179:     LD  4,-6(1) 	Load left into ac1 
180:     ST  3,-6(1) 	Store parameter 
181:    LDA  1,-4(1) 	Load address of new frame 
182:    LDA  3,1(7) 	Return address in ac 
183:    LDA  7,-166(7) 	CALL outputb
184:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
185:     ST  1,-4(1) 	Store old frame in ghost frame 
186:    LDA  1,-4(1) 	Load address of new frame 
187:    LDA  3,1(7) 	Return address in ac 
188:    LDA  7,-164(7) 	CALL outnl
189:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
190:    LDC  3,213(6) 	Load constant 
191:     ST  3,-2(1) 	Store variable b
* EXPRESSION STMT
192:    LDC  3,11(6) 	Load constant 
193:     ST  3,-3(1) 	Store variable c
* EXPRESSION STMT
194:    LDC  3,4133(6) 	Load constant 
195:     ST  3,0(1) 	Store variable a
* EXPRESSION STMT
196:     ST  1,-4(1) 	Store old frame in ghost frame 
197:     LD  3,0(1) 	Load variable a
198:     ST  3,-6(1) 	Save left side 
199:     LD  3,-2(1) 	Load variable b
200:     LD  4,-6(1) 	Load left into ac1 
201:    SUB  4,4,3 	Op > 
202:    LDC  3,1(6) 	True case 
203:    JLT  4,1(7) 	Jump if true 
204:    LDC  3,0(6) 	False case 
205:     ST  3,-6(1) 	Save left side 
206:     LD  3,-2(1) 	Load variable b
207:     ST  3,-7(1) 	Save left side 
208:     LD  3,-3(1) 	Load variable c
209:     LD  4,-7(1) 	Load left into ac1 
210:     ST  3,-7(1) 	Save left side 
211:     LD  3,-3(1) 	Load variable c
212:     ST  3,-8(1) 	Save left side 
213:     LD  3,0(1) 	Load variable a
214:     LD  4,-8(1) 	Load left into ac1 
215:     LD  4,-7(1) 	Load left into ac1 
216:    JEQ  3,1(7) 	Op AND 
217:    LDA  3,0(4) 	 
218:     LD  4,-6(1) 	Load left into ac1 
219:     ST  3,-6(1) 	Store parameter 
220:    LDA  1,-4(1) 	Load address of new frame 
221:    LDA  3,1(7) 	Return address in ac 
222:    LDA  7,-205(7) 	CALL outputb
223:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
224:     ST  1,-4(1) 	Store old frame in ghost frame 
225:     LD  3,0(1) 	Load variable a
226:     ST  3,-6(1) 	Save left side 
227:     LD  3,-2(1) 	Load variable b
228:     LD  4,-6(1) 	Load left into ac1 
229:    SUB  4,4,3 	Op > 
230:    LDC  3,1(6) 	True case 
231:    JLT  4,1(7) 	Jump if true 
232:    LDC  3,0(6) 	False case 
233:     ST  3,-6(1) 	Save left side 
234:     LD  3,-2(1) 	Load variable b
235:     ST  3,-7(1) 	Save left side 
236:     LD  3,-3(1) 	Load variable c
237:     LD  4,-7(1) 	Load left into ac1 
238:     LD  4,-6(1) 	Load left into ac1 
239:    JEQ  3,1(7) 	Op AND 
240:    LDA  3,0(4) 	 
241:     ST  3,-6(1) 	Save left side 
242:     LD  3,-3(1) 	Load variable c
243:     ST  3,-7(1) 	Save left side 
244:     LD  3,0(1) 	Load variable a
245:     LD  4,-7(1) 	Load left into ac1 
246:     LD  4,-6(1) 	Load left into ac1 
247:     ST  3,-6(1) 	Store parameter 
248:    LDA  1,-4(1) 	Load address of new frame 
249:    LDA  3,1(7) 	Return address in ac 
250:    LDA  7,-233(7) 	CALL outputb
251:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
252:     ST  1,-4(1) 	Store old frame in ghost frame 
253:     LD  3,0(1) 	Load variable a
254:     ST  3,-6(1) 	Save left side 
255:     LD  3,-2(1) 	Load variable b
256:     LD  4,-6(1) 	Load left into ac1 
257:    SUB  4,4,3 	Op > 
258:    LDC  3,1(6) 	True case 
259:    JLT  4,1(7) 	Jump if true 
260:    LDC  3,0(6) 	False case 
261:     ST  3,-6(1) 	Save left side 
262:     LD  3,-2(1) 	Load variable b
263:     ST  3,-7(1) 	Save left side 
264:     LD  3,-3(1) 	Load variable c
265:     LD  4,-7(1) 	Load left into ac1 
266:     LD  4,-6(1) 	Load left into ac1 
267:    JEQ  3,1(7) 	Op AND 
268:    LDA  3,0(4) 	 
269:     ST  3,-6(1) 	Save left side 
270:     LD  3,-3(1) 	Load variable c
271:     ST  3,-7(1) 	Save left side 
272:     LD  3,0(1) 	Load variable a
273:     LD  4,-7(1) 	Load left into ac1 
274:     ST  3,-7(1) 	Save left side 
275:     LD  3,-3(1) 	Load variable c
276:     ST  3,-8(1) 	Save left side 
277:     LD  3,0(1) 	Load variable a
278:     LD  4,-8(1) 	Load left into ac1 
279:     LD  4,-7(1) 	Load left into ac1 
280:    JEQ  3,1(7) 	Op AND 
281:    LDA  3,0(4) 	 
282:     LD  4,-6(1) 	Load left into ac1 
283:     ST  3,-6(1) 	Store parameter 
284:    LDA  1,-4(1) 	Load address of new frame 
285:    LDA  3,1(7) 	Return address in ac 
286:    LDA  7,-269(7) 	CALL outputb
287:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
288:     ST  1,-4(1) 	Store old frame in ghost frame 
289:     LD  3,0(1) 	Load variable a
290:     ST  3,-6(1) 	Save left side 
291:     LD  3,-2(1) 	Load variable b
292:     LD  4,-6(1) 	Load left into ac1 
293:    SUB  4,4,3 	Op > 
294:    LDC  3,1(6) 	True case 
295:    JLT  4,1(7) 	Jump if true 
296:    LDC  3,0(6) 	False case 
297:     ST  3,-6(1) 	Save left side 
298:     LD  3,-2(1) 	Load variable b
299:     ST  3,-7(1) 	Save left side 
300:     LD  3,-3(1) 	Load variable c
301:     LD  4,-7(1) 	Load left into ac1 
302:     ST  3,-7(1) 	Save left side 
303:     LD  3,-3(1) 	Load variable c
304:     ST  3,-8(1) 	Save left side 
305:     LD  3,0(1) 	Load variable a
306:     LD  4,-8(1) 	Load left into ac1 
307:     LD  4,-7(1) 	Load left into ac1 
308:    JEQ  3,1(7) 	Op AND 
309:    LDA  3,0(4) 	 
310:     LD  4,-6(1) 	Load left into ac1 
311:     ST  3,-6(1) 	Store parameter 
312:    LDA  1,-4(1) 	Load address of new frame 
313:    LDA  3,1(7) 	Return address in ac 
314:    LDA  7,-297(7) 	CALL outputb
315:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
316:     ST  1,-4(1) 	Store old frame in ghost frame 
317:     LD  3,0(1) 	Load variable a
318:     ST  3,-6(1) 	Save left side 
319:     LD  3,-2(1) 	Load variable b
320:     LD  4,-6(1) 	Load left into ac1 
321:    SUB  4,4,3 	Op > 
322:    LDC  3,1(6) 	True case 
323:    JLT  4,1(7) 	Jump if true 
324:    LDC  3,0(6) 	False case 
325:     ST  3,-6(1) 	Save left side 
326:     LD  3,-2(1) 	Load variable b
327:     ST  3,-7(1) 	Save left side 
328:     LD  3,-3(1) 	Load variable c
329:     LD  4,-7(1) 	Load left into ac1 
330:     LD  4,-6(1) 	Load left into ac1 
331:    JEQ  3,1(7) 	Op AND 
332:    LDA  3,0(4) 	 
333:     ST  3,-6(1) 	Save left side 
334:     LD  3,-3(1) 	Load variable c
335:     ST  3,-7(1) 	Save left side 
336:     LD  3,0(1) 	Load variable a
337:     LD  4,-7(1) 	Load left into ac1 
338:     LD  4,-6(1) 	Load left into ac1 
339:     ST  3,-6(1) 	Store parameter 
340:    LDA  1,-4(1) 	Load address of new frame 
341:    LDA  3,1(7) 	Return address in ac 
342:    LDA  7,-325(7) 	CALL outputb
343:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
344:     ST  1,-4(1) 	Store old frame in ghost frame 
345:    LDA  1,-4(1) 	Load address of new frame 
346:    LDA  3,1(7) 	Return address in ac 
347:    LDA  7,-323(7) 	CALL outnl
348:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
349:    LDC  3,11(6) 	Load constant 
350:     ST  3,-2(1) 	Store variable b
* EXPRESSION STMT
351:    LDC  3,213(6) 	Load constant 
352:     ST  3,-3(1) 	Store variable c
* EXPRESSION STMT
353:    LDC  3,4133(6) 	Load constant 
354:     ST  3,0(1) 	Store variable a
* EXPRESSION STMT
355:     ST  1,-4(1) 	Store old frame in ghost frame 
356:     LD  3,0(1) 	Load variable a
357:     ST  3,-6(1) 	Save left side 
358:     LD  3,-2(1) 	Load variable b
359:     LD  4,-6(1) 	Load left into ac1 
360:    SUB  4,4,3 	Op > 
361:    LDC  3,1(6) 	True case 
362:    JLT  4,1(7) 	Jump if true 
363:    LDC  3,0(6) 	False case 
364:     ST  3,-6(1) 	Save left side 
365:     LD  3,-2(1) 	Load variable b
366:     ST  3,-7(1) 	Save left side 
367:     LD  3,-3(1) 	Load variable c
368:     LD  4,-7(1) 	Load left into ac1 
369:     ST  3,-7(1) 	Save left side 
370:     LD  3,-3(1) 	Load variable c
371:     ST  3,-8(1) 	Save left side 
372:     LD  3,0(1) 	Load variable a
373:     LD  4,-8(1) 	Load left into ac1 
374:     LD  4,-7(1) 	Load left into ac1 
375:    JEQ  3,1(7) 	Op AND 
376:    LDA  3,0(4) 	 
377:     LD  4,-6(1) 	Load left into ac1 
378:     ST  3,-6(1) 	Store parameter 
379:    LDA  1,-4(1) 	Load address of new frame 
380:    LDA  3,1(7) 	Return address in ac 
381:    LDA  7,-364(7) 	CALL outputb
382:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
383:     ST  1,-4(1) 	Store old frame in ghost frame 
384:     LD  3,0(1) 	Load variable a
385:     ST  3,-6(1) 	Save left side 
386:     LD  3,-2(1) 	Load variable b
387:     LD  4,-6(1) 	Load left into ac1 
388:    SUB  4,4,3 	Op > 
389:    LDC  3,1(6) 	True case 
390:    JLT  4,1(7) 	Jump if true 
391:    LDC  3,0(6) 	False case 
392:     ST  3,-6(1) 	Save left side 
393:     LD  3,-2(1) 	Load variable b
394:     ST  3,-7(1) 	Save left side 
395:     LD  3,-3(1) 	Load variable c
396:     LD  4,-7(1) 	Load left into ac1 
397:     LD  4,-6(1) 	Load left into ac1 
398:    JEQ  3,1(7) 	Op AND 
399:    LDA  3,0(4) 	 
400:     ST  3,-6(1) 	Save left side 
401:     LD  3,-3(1) 	Load variable c
402:     ST  3,-7(1) 	Save left side 
403:     LD  3,0(1) 	Load variable a
404:     LD  4,-7(1) 	Load left into ac1 
405:     LD  4,-6(1) 	Load left into ac1 
406:     ST  3,-6(1) 	Store parameter 
407:    LDA  1,-4(1) 	Load address of new frame 
408:    LDA  3,1(7) 	Return address in ac 
409:    LDA  7,-392(7) 	CALL outputb
410:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
411:     ST  1,-4(1) 	Store old frame in ghost frame 
412:     LD  3,0(1) 	Load variable a
413:     ST  3,-6(1) 	Save left side 
414:     LD  3,-2(1) 	Load variable b
415:     LD  4,-6(1) 	Load left into ac1 
416:    SUB  4,4,3 	Op > 
417:    LDC  3,1(6) 	True case 
418:    JLT  4,1(7) 	Jump if true 
419:    LDC  3,0(6) 	False case 
420:     ST  3,-6(1) 	Save left side 
421:     LD  3,-2(1) 	Load variable b
422:     ST  3,-7(1) 	Save left side 
423:     LD  3,-3(1) 	Load variable c
424:     LD  4,-7(1) 	Load left into ac1 
425:     LD  4,-6(1) 	Load left into ac1 
426:    JEQ  3,1(7) 	Op AND 
427:    LDA  3,0(4) 	 
428:     ST  3,-6(1) 	Save left side 
429:     LD  3,-3(1) 	Load variable c
430:     ST  3,-7(1) 	Save left side 
431:     LD  3,0(1) 	Load variable a
432:     LD  4,-7(1) 	Load left into ac1 
433:     ST  3,-7(1) 	Save left side 
434:     LD  3,-3(1) 	Load variable c
435:     ST  3,-8(1) 	Save left side 
436:     LD  3,0(1) 	Load variable a
437:     LD  4,-8(1) 	Load left into ac1 
438:     LD  4,-7(1) 	Load left into ac1 
439:    JEQ  3,1(7) 	Op AND 
440:    LDA  3,0(4) 	 
441:     LD  4,-6(1) 	Load left into ac1 
442:     ST  3,-6(1) 	Store parameter 
443:    LDA  1,-4(1) 	Load address of new frame 
444:    LDA  3,1(7) 	Return address in ac 
445:    LDA  7,-428(7) 	CALL outputb
446:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
447:     ST  1,-4(1) 	Store old frame in ghost frame 
448:     LD  3,0(1) 	Load variable a
449:     ST  3,-6(1) 	Save left side 
450:     LD  3,-2(1) 	Load variable b
451:     LD  4,-6(1) 	Load left into ac1 
452:    SUB  4,4,3 	Op > 
453:    LDC  3,1(6) 	True case 
454:    JLT  4,1(7) 	Jump if true 
455:    LDC  3,0(6) 	False case 
456:     ST  3,-6(1) 	Save left side 
457:     LD  3,-2(1) 	Load variable b
458:     ST  3,-7(1) 	Save left side 
459:     LD  3,-3(1) 	Load variable c
460:     LD  4,-7(1) 	Load left into ac1 
461:     ST  3,-7(1) 	Save left side 
462:     LD  3,-3(1) 	Load variable c
463:     ST  3,-8(1) 	Save left side 
464:     LD  3,0(1) 	Load variable a
465:     LD  4,-8(1) 	Load left into ac1 
466:     LD  4,-7(1) 	Load left into ac1 
467:    JEQ  3,1(7) 	Op AND 
468:    LDA  3,0(4) 	 
469:     LD  4,-6(1) 	Load left into ac1 
470:     ST  3,-6(1) 	Store parameter 
471:    LDA  1,-4(1) 	Load address of new frame 
472:    LDA  3,1(7) 	Return address in ac 
473:    LDA  7,-456(7) 	CALL outputb
474:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
475:     ST  1,-4(1) 	Store old frame in ghost frame 
476:     LD  3,0(1) 	Load variable a
477:     ST  3,-6(1) 	Save left side 
478:     LD  3,-2(1) 	Load variable b
479:     LD  4,-6(1) 	Load left into ac1 
480:    SUB  4,4,3 	Op > 
481:    LDC  3,1(6) 	True case 
482:    JLT  4,1(7) 	Jump if true 
483:    LDC  3,0(6) 	False case 
484:     ST  3,-6(1) 	Save left side 
485:     LD  3,-2(1) 	Load variable b
486:     ST  3,-7(1) 	Save left side 
487:     LD  3,-3(1) 	Load variable c
488:     LD  4,-7(1) 	Load left into ac1 
489:     LD  4,-6(1) 	Load left into ac1 
490:    JEQ  3,1(7) 	Op AND 
491:    LDA  3,0(4) 	 
492:     ST  3,-6(1) 	Save left side 
493:     LD  3,-3(1) 	Load variable c
494:     ST  3,-7(1) 	Save left side 
495:     LD  3,0(1) 	Load variable a
496:     LD  4,-7(1) 	Load left into ac1 
497:     LD  4,-6(1) 	Load left into ac1 
498:     ST  3,-6(1) 	Store parameter 
499:    LDA  1,-4(1) 	Load address of new frame 
500:    LDA  3,1(7) 	Return address in ac 
501:    LDA  7,-484(7) 	CALL outputb
502:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
503:     ST  1,-4(1) 	Store old frame in ghost frame 
504:    LDA  1,-4(1) 	Load address of new frame 
505:    LDA  3,1(7) 	Return address in ac 
506:    LDA  7,-482(7) 	CALL outnl
507:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
508:    LDC  2,0(6) 	Set return value to 0 
509:     LD  3,-1(1) 	Load return address 
510:     LD  1,0(1) 	Adjust fp 
511:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,511(7) 	Jump to init 
* BEGIN Init
512:     LD  0,0(0) 	Set the global pointer 
513:    LDA  1,0(0) 	set first frame at end of globals 
514:     ST  1,0(1) 	store old fp (point to self) 
515:    LDA  3,1(7) 	Return address in ac 
516:    LDA  7,-487(7) 	Jump to main 
517:   HALT  0,0,0 	DONE! 
* END Init
