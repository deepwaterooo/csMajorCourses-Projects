* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  types.tm
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
 31:    LDC  3,0(6) 	load size of array ia
 32:     ST  3,-3(1) 	save size of array ia
 33:    LDC  3,0(6) 	load size of array ba
 34:     ST  3,-4(1) 	save size of array ba
 35:     LD  3,0(1) 	Load variable i
 36:     ST  3,-5(1) 	Save left side 
 37:     LD  3,0(1) 	Load variable i
 38:     LD  4,-5(1) 	Load left into ac1 
 39:    ADD  3,4,3 	Op + 
 40:     LD  3,0(1) 	Load variable i
 41:     ST  3,-5(1) 	Save left side 
 42:     LD  3,-2(1) 	Load variable b
 43:     LD  4,-5(1) 	Load left into ac1 
 44:    ADD  3,4,3 	Op + 
 45:     LD  3,-2(1) 	Load variable b
 46:     ST  3,-5(1) 	Save left side 
 47:     LD  3,0(1) 	Load variable i
 48:     LD  4,-5(1) 	Load left into ac1 
 49:    ADD  3,4,3 	Op + 
 50:     LD  3,-2(1) 	Load variable b
 51:     ST  3,-5(1) 	Save left side 
 52:     LD  3,-2(1) 	Load variable b
 53:     LD  4,-5(1) 	Load left into ac1 
 54:    ADD  3,4,3 	Op + 
 55:     LD  3,0(1) 	Load variable i
 56:     ST  3,-5(1) 	Save left side 
 57:     LD  3,0(1) 	Load variable i
 58:     LD  4,-5(1) 	Load left into ac1 
 59:    JEQ  3,1(7) 	Op AND 
 60:    LDA  3,0(4) 	 
 61:     LD  3,0(1) 	Load variable i
 62:     ST  3,-5(1) 	Save left side 
 63:     LD  3,-2(1) 	Load variable b
 64:     LD  4,-5(1) 	Load left into ac1 
 65:    JEQ  3,1(7) 	Op AND 
 66:    LDA  3,0(4) 	 
 67:     LD  3,-2(1) 	Load variable b
 68:     ST  3,-5(1) 	Save left side 
 69:     LD  3,0(1) 	Load variable i
 70:     LD  4,-5(1) 	Load left into ac1 
 71:    JEQ  3,1(7) 	Op AND 
 72:    LDA  3,0(4) 	 
 73:     LD  3,-2(1) 	Load variable b
 74:     ST  3,-5(1) 	Save left side 
 75:     LD  3,-2(1) 	Load variable b
 76:     LD  4,-5(1) 	Load left into ac1 
 77:    JEQ  3,1(7) 	Op AND 
 78:    LDA  3,0(4) 	 
* EXPRESSION STMT
 79:     LD  3,0(1) 	Load variable i
 80:     ST  3,0(1) 	Store variable i
* EXPRESSION STMT
 81:     LD  3,-2(1) 	Load variable b
 82:     ST  3,0(1) 	Store variable i
* EXPRESSION STMT
 83:     LD  3,0(1) 	Load variable i
 84:     ST  3,-2(1) 	Store variable b
* EXPRESSION STMT
 85:     LD  3,-2(1) 	Load variable b
 86:     ST  3,-2(1) 	Store variable b
 87:     LD  3,0(1) 	Load variable i
 88:     ST  3,-5(1) 	Save left side 
 89:     LD  3,0(1) 	Load variable i
 90:     LD  4,-5(1) 	Load left into ac1 
 91:    SUB  4,4,3 	Op == 
 92:    LDC  3,1(6) 	True case 
 93:    JEQ  4,1(7) 	Jump if true 
 94:    LDC  3,0(6) 	False case 
 95:     LD  3,0(1) 	Load variable i
 96:     ST  3,-5(1) 	Save left side 
 97:     LD  3,-2(1) 	Load variable b
 98:     LD  4,-5(1) 	Load left into ac1 
 99:    SUB  4,4,3 	Op == 
100:    LDC  3,1(6) 	True case 
101:    JEQ  4,1(7) 	Jump if true 
102:    LDC  3,0(6) 	False case 
103:     LD  3,-2(1) 	Load variable b
104:     ST  3,-5(1) 	Save left side 
105:     LD  3,0(1) 	Load variable i
106:     LD  4,-5(1) 	Load left into ac1 
107:    SUB  4,4,3 	Op == 
108:    LDC  3,1(6) 	True case 
109:    JEQ  4,1(7) 	Jump if true 
110:    LDC  3,0(6) 	False case 
111:     LD  3,-2(1) 	Load variable b
112:     ST  3,-5(1) 	Save left side 
113:     LD  3,-2(1) 	Load variable b
114:     LD  4,-5(1) 	Load left into ac1 
115:    SUB  4,4,3 	Op == 
116:    LDC  3,1(6) 	True case 
117:    JEQ  4,1(7) 	Jump if true 
118:    LDC  3,0(6) 	False case 
119:     LD  3,0(1) 	Load variable i
120:     ST  3,-5(1) 	Save left side 
121:     LD  3,0(1) 	Load variable i
122:     LD  4,-5(1) 	Load left into ac1 
123:     LD  3,0(1) 	Load variable i
124:     ST  3,-5(1) 	Save left side 
125:     LD  3,-2(1) 	Load variable b
126:     LD  4,-5(1) 	Load left into ac1 
127:     LD  3,-2(1) 	Load variable b
128:     ST  3,-5(1) 	Save left side 
129:     LD  3,0(1) 	Load variable i
130:     LD  4,-5(1) 	Load left into ac1 
131:     LD  3,-2(1) 	Load variable b
132:     ST  3,-5(1) 	Save left side 
133:     LD  3,-2(1) 	Load variable b
134:     LD  4,-5(1) 	Load left into ac1 
135:     LD  3,-4(1) 	Load variable ia
136:     ST  3,-5(1) 	Save left side 
137:     LD  3,-4(1) 	Load variable ia
138:     LD  4,-5(1) 	Load left into ac1 
139:    ADD  3,4,3 	Op + 
140:     LD  3,-4(1) 	Load variable ia
141:     ST  3,-5(1) 	Save left side 
142:     LD  3,-5(1) 	Load variable ba
143:     LD  4,-5(1) 	Load left into ac1 
144:    ADD  3,4,3 	Op + 
145:     LD  3,-5(1) 	Load variable ba
146:     ST  3,-5(1) 	Save left side 
147:     LD  3,-4(1) 	Load variable ia
148:     LD  4,-5(1) 	Load left into ac1 
149:    ADD  3,4,3 	Op + 
150:     LD  3,-5(1) 	Load variable ba
151:     ST  3,-5(1) 	Save left side 
152:     LD  3,-5(1) 	Load variable ba
153:     LD  4,-5(1) 	Load left into ac1 
154:    ADD  3,4,3 	Op + 
155:     LD  3,-4(1) 	Load variable ia
156:     ST  3,-5(1) 	Save left side 
157:     LD  3,-4(1) 	Load variable ia
158:     LD  4,-5(1) 	Load left into ac1 
159:    JEQ  3,1(7) 	Op AND 
160:    LDA  3,0(4) 	 
161:     LD  3,-4(1) 	Load variable ia
162:     ST  3,-5(1) 	Save left side 
163:     LD  3,-5(1) 	Load variable ba
164:     LD  4,-5(1) 	Load left into ac1 
165:    JEQ  3,1(7) 	Op AND 
166:    LDA  3,0(4) 	 
167:     LD  3,-5(1) 	Load variable ba
168:     ST  3,-5(1) 	Save left side 
169:     LD  3,-4(1) 	Load variable ia
170:     LD  4,-5(1) 	Load left into ac1 
171:    JEQ  3,1(7) 	Op AND 
172:    LDA  3,0(4) 	 
173:     LD  3,-5(1) 	Load variable ba
174:     ST  3,-5(1) 	Save left side 
175:     LD  3,-5(1) 	Load variable ba
176:     LD  4,-5(1) 	Load left into ac1 
177:    JEQ  3,1(7) 	Op AND 
178:    LDA  3,0(4) 	 
* EXPRESSION STMT
179:     LD  3,-4(1) 	Load variable ia
180:     ST  3,-4(1) 	Store variable ia
* EXPRESSION STMT
181:     LD  3,-5(1) 	Load variable ba
182:     ST  3,-4(1) 	Store variable ia
* EXPRESSION STMT
183:     LD  3,-4(1) 	Load variable ia
184:     ST  3,-5(1) 	Store variable ba
* EXPRESSION STMT
185:     LD  3,-5(1) 	Load variable ba
186:     ST  3,-5(1) 	Store variable ba
187:     LD  3,-4(1) 	Load variable ia
188:     ST  3,-5(1) 	Save left side 
189:     LD  3,-4(1) 	Load variable ia
190:     LD  4,-5(1) 	Load left into ac1 
191:    SUB  4,4,3 	Op == 
192:    LDC  3,1(6) 	True case 
193:    JEQ  4,1(7) 	Jump if true 
194:    LDC  3,0(6) 	False case 
195:     LD  3,-4(1) 	Load variable ia
196:     ST  3,-5(1) 	Save left side 
197:     LD  3,-5(1) 	Load variable ba
198:     LD  4,-5(1) 	Load left into ac1 
199:    SUB  4,4,3 	Op == 
200:    LDC  3,1(6) 	True case 
201:    JEQ  4,1(7) 	Jump if true 
202:    LDC  3,0(6) 	False case 
203:     LD  3,-5(1) 	Load variable ba
204:     ST  3,-5(1) 	Save left side 
205:     LD  3,-4(1) 	Load variable ia
206:     LD  4,-5(1) 	Load left into ac1 
207:    SUB  4,4,3 	Op == 
208:    LDC  3,1(6) 	True case 
209:    JEQ  4,1(7) 	Jump if true 
210:    LDC  3,0(6) 	False case 
211:     LD  3,-5(1) 	Load variable ba
212:     ST  3,-5(1) 	Save left side 
213:     LD  3,-5(1) 	Load variable ba
214:     LD  4,-5(1) 	Load left into ac1 
215:    SUB  4,4,3 	Op == 
216:    LDC  3,1(6) 	True case 
217:    JEQ  4,1(7) 	Jump if true 
218:    LDC  3,0(6) 	False case 
219:     LD  3,-2(1) 	Load variable b
220:     ST  3,-5(1) 	Save left side 
221:     LD  3,0(1) 	Load variable i
222:     LD  4,-5(1) 	Load left into ac1 
223:    ADD  3,4,3 	Op + 
224:     ST  3,-5(1) 	Save left side 
225:     LD  3,0(1) 	Load variable i
226:     LD  4,-5(1) 	Load left into ac1 
227:    ADD  3,4,3 	Op + 
228:     LD  3,0(1) 	Load variable i
229:     ST  3,-5(1) 	Save left side 
230:     LD  3,-2(1) 	Load variable b
231:     LD  4,-5(1) 	Load left into ac1 
232:    ADD  3,4,3 	Op + 
233:     ST  3,-5(1) 	Save left side 
234:     LD  3,0(1) 	Load variable i
235:     LD  4,-5(1) 	Load left into ac1 
236:    ADD  3,4,3 	Op + 
237:     LD  3,0(1) 	Load variable i
238:     ST  3,-5(1) 	Save left side 
239:     LD  3,0(1) 	Load variable i
240:     LD  4,-5(1) 	Load left into ac1 
241:    ADD  3,4,3 	Op + 
242:     ST  3,-5(1) 	Save left side 
243:     LD  3,-2(1) 	Load variable b
244:     LD  4,-5(1) 	Load left into ac1 
245:    ADD  3,4,3 	Op + 
246:     LD  3,0(1) 	Load variable i
247:     ST  3,-5(1) 	Save left side 
248:     LD  3,-2(1) 	Load variable b
249:     LD  4,-5(1) 	Load left into ac1 
250:     ST  3,-5(1) 	Save left side 
251:     LD  3,-2(1) 	Load variable b
252:     LD  4,-5(1) 	Load left into ac1 
253:     LD  3,-2(1) 	Load variable b
254:     ST  3,-5(1) 	Save left side 
255:     LD  3,0(1) 	Load variable i
256:     LD  4,-5(1) 	Load left into ac1 
257:     ST  3,-5(1) 	Save left side 
258:     LD  3,-2(1) 	Load variable b
259:     LD  4,-5(1) 	Load left into ac1 
260:     LD  3,-2(1) 	Load variable b
261:     ST  3,-5(1) 	Save left side 
262:     LD  3,-2(1) 	Load variable b
263:     LD  4,-5(1) 	Load left into ac1 
264:     ST  3,-5(1) 	Save left side 
265:     LD  3,0(1) 	Load variable i
266:     LD  4,-5(1) 	Load left into ac1 
267:     LD  3,-2(1) 	Load variable b
268:     LD  3,0(1) 	Load variable i
269:     LD  3,-5(1) 	Load variable ba
270:     LD  3,-4(1) 	Load variable ia
271:     LD  3,-2(1) 	Load variable b
272:    LDC  4,0(6) 	Load 0 
273:    SUB  3,4,3 	Op unary - 
274:     LD  3,0(1) 	Load variable i
275:    LDC  4,0(6) 	Load 0 
276:    SUB  3,4,3 	Op unary - 
277:     LD  3,-5(1) 	Load variable ba
278:    LDC  4,0(6) 	Load 0 
279:    SUB  3,4,3 	Op unary - 
280:     LD  3,-4(1) 	Load variable ia
281:    LDC  4,0(6) 	Load 0 
282:    SUB  3,4,3 	Op unary - 
283:     LD  3,0(1) 	Load variable i
284:     ST  3,-5(1) 	Save left side 
285:     LD  3,0(1) 	Load variable i
286:     LD  4,-5(1) 	Load left into ac1 
287:    SUB  4,4,3 	Op > 
288:    LDC  3,1(6) 	True case 
289:    JLT  4,1(7) 	Jump if true 
290:    LDC  3,0(6) 	False case 
291:     ST  3,-5(1) 	Save left side 
292:     LD  3,0(1) 	Load variable i
293:     ST  3,-6(1) 	Save left side 
294:     LD  3,0(1) 	Load variable i
295:     LD  4,-6(1) 	Load left into ac1 
296:    SUB  4,4,3 	Op > 
297:    LDC  3,1(6) 	True case 
298:    JLT  4,1(7) 	Jump if true 
299:    LDC  3,0(6) 	False case 
300:     LD  4,-5(1) 	Load left into ac1 
301:     LD  3,-2(1) 	Load variable b
302:     ST  3,-5(1) 	Save left side 
303:     LD  3,0(1) 	Load variable i
304:     LD  4,-5(1) 	Load left into ac1 
305:    SUB  4,4,3 	Op > 
306:    LDC  3,1(6) 	True case 
307:    JLT  4,1(7) 	Jump if true 
308:    LDC  3,0(6) 	False case 
309:     ST  3,-5(1) 	Save left side 
310:     LD  3,0(1) 	Load variable i
311:     ST  3,-6(1) 	Save left side 
312:     LD  3,0(1) 	Load variable i
313:     LD  4,-6(1) 	Load left into ac1 
314:    SUB  4,4,3 	Op > 
315:    LDC  3,1(6) 	True case 
316:    JLT  4,1(7) 	Jump if true 
317:    LDC  3,0(6) 	False case 
318:     LD  4,-5(1) 	Load left into ac1 
319:     LD  3,0(1) 	Load variable i
320:     ST  3,-5(1) 	Save left side 
321:     LD  3,-2(1) 	Load variable b
322:     LD  4,-5(1) 	Load left into ac1 
323:    SUB  4,4,3 	Op > 
324:    LDC  3,1(6) 	True case 
325:    JLT  4,1(7) 	Jump if true 
326:    LDC  3,0(6) 	False case 
327:     ST  3,-5(1) 	Save left side 
328:     LD  3,0(1) 	Load variable i
329:     ST  3,-6(1) 	Save left side 
330:     LD  3,0(1) 	Load variable i
331:     LD  4,-6(1) 	Load left into ac1 
332:    SUB  4,4,3 	Op > 
333:    LDC  3,1(6) 	True case 
334:    JLT  4,1(7) 	Jump if true 
335:    LDC  3,0(6) 	False case 
336:     LD  4,-5(1) 	Load left into ac1 
337:     LD  3,0(1) 	Load variable i
338:     ST  3,-5(1) 	Save left side 
339:     LD  3,0(1) 	Load variable i
340:     LD  4,-5(1) 	Load left into ac1 
341:    SUB  4,4,3 	Op > 
342:    LDC  3,1(6) 	True case 
343:    JLT  4,1(7) 	Jump if true 
344:    LDC  3,0(6) 	False case 
345:     ST  3,-5(1) 	Save left side 
346:     LD  3,-2(1) 	Load variable b
347:     ST  3,-6(1) 	Save left side 
348:     LD  3,0(1) 	Load variable i
349:     LD  4,-6(1) 	Load left into ac1 
350:    SUB  4,4,3 	Op > 
351:    LDC  3,1(6) 	True case 
352:    JLT  4,1(7) 	Jump if true 
353:    LDC  3,0(6) 	False case 
354:     LD  4,-5(1) 	Load left into ac1 
355:     LD  3,-2(1) 	Load variable b
356:     ST  3,-5(1) 	Save left side 
357:     LD  3,0(1) 	Load variable i
358:     LD  4,-5(1) 	Load left into ac1 
359:    SUB  4,4,3 	Op > 
360:    LDC  3,1(6) 	True case 
361:    JLT  4,1(7) 	Jump if true 
362:    LDC  3,0(6) 	False case 
363:     ST  3,-5(1) 	Save left side 
364:     LD  3,0(1) 	Load variable i
365:     ST  3,-6(1) 	Save left side 
366:     LD  3,-2(1) 	Load variable b
367:     LD  4,-6(1) 	Load left into ac1 
368:    SUB  4,4,3 	Op > 
369:    LDC  3,1(6) 	True case 
370:    JLT  4,1(7) 	Jump if true 
371:    LDC  3,0(6) 	False case 
372:     LD  4,-5(1) 	Load left into ac1 
373:     LD  3,-2(1) 	Load variable b
374:     ST  3,-5(1) 	Save left side 
375:     LD  3,-2(1) 	Load variable b
376:     LD  4,-5(1) 	Load left into ac1 
377:     ST  3,-5(1) 	Save left side 
378:     LD  3,-2(1) 	Load variable b
379:     ST  3,-6(1) 	Save left side 
380:     LD  3,-2(1) 	Load variable b
381:     LD  4,-6(1) 	Load left into ac1 
382:     LD  4,-5(1) 	Load left into ac1 
383:    JEQ  3,1(7) 	Op AND 
384:    LDA  3,0(4) 	 
* IfK:
* IfK: t->child[0] condition
385:    LDC  3,1(6) 	Load constant 
* IfK: t->child[1] then part
* EXPRESSION STMT
387:     LD  3,0(1) 	Load variable i
388:     ST  3,0(1) 	Store variable i
386:    JEQ  3,3(7) 	if: jmp to else 
* IfK: t->child[2] else part
* EXPRESSION STMT
390:     LD  3,-2(1) 	Load variable b
391:     ST  3,-2(1) 	Store variable b
389:    LDA  7,2(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
392:     LD  3,-5(1) 	Load variable ba
* IfK: t->child[1] then part
* EXPRESSION STMT
394:     LD  3,0(1) 	Load variable i
395:     ST  3,0(1) 	Store variable i
393:    JEQ  3,3(7) 	if: jmp to else 
* IfK: t->child[2] else part
* EXPRESSION STMT
397:     LD  3,-2(1) 	Load variable b
398:     ST  3,-2(1) 	Store variable b
396:    LDA  7,2(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
399:     LD  3,-4(1) 	Load variable ia
* IfK: t->child[1] then part
* EXPRESSION STMT
401:     LD  3,0(1) 	Load variable i
402:     ST  3,0(1) 	Store variable i
400:    JEQ  3,3(7) 	if: jmp to else 
* IfK: t->child[2] else part
* EXPRESSION STMT
404:     LD  3,-2(1) 	Load variable b
405:     ST  3,-2(1) 	Store variable b
403:    LDA  7,2(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
406:     LD  3,-2(1) 	Load variable b
* IfK: t->child[1] then part
* EXPRESSION STMT
408:     LD  3,0(1) 	Load variable i
409:     ST  3,0(1) 	Store variable i
407:    JEQ  3,3(7) 	if: jmp to else 
* IfK: t->child[2] else part
* EXPRESSION STMT
411:     LD  3,-2(1) 	Load variable b
412:     ST  3,-2(1) 	Store variable b
410:    LDA  7,2(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
413:     LD  3,0(1) 	Load variable i
* IfK: t->child[1] then part
* EXPRESSION STMT
415:     LD  3,0(1) 	Load variable i
416:     ST  3,0(1) 	Store variable i
414:    JEQ  3,3(7) 	if: jmp to else 
* IfK: t->child[2] else part
* EXPRESSION STMT
418:     LD  3,-2(1) 	Load variable b
419:     ST  3,-2(1) 	Store variable b
417:    LDA  7,2(7) 	jmp to end 
* ENDIF
* WHILE
420:    LDC  3,1(6) 	Load constant 
421:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
423:     LD  3,0(1) 	Load variable i
424:     ST  3,0(1) 	Store variable i
425:    LDA  7,-6(7) 	go to beginning of loop 
422:    LDA  7,3(7) 	No more loop 
* ENDWHILE
* WHILE
426:     LD  3,-5(1) 	Load variable ba
427:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
429:     LD  3,0(1) 	Load variable i
430:     ST  3,0(1) 	Store variable i
431:    LDA  7,-6(7) 	go to beginning of loop 
428:    LDA  7,3(7) 	No more loop 
* ENDWHILE
* WHILE
432:     LD  3,-4(1) 	Load variable ia
433:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
435:     LD  3,0(1) 	Load variable i
436:     ST  3,0(1) 	Store variable i
437:    LDA  7,-6(7) 	go to beginning of loop 
434:    LDA  7,3(7) 	No more loop 
* ENDWHILE
* WHILE
438:     LD  3,-2(1) 	Load variable b
439:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
441:     LD  3,0(1) 	Load variable i
442:     ST  3,0(1) 	Store variable i
443:    LDA  7,-6(7) 	go to beginning of loop 
440:    LDA  7,3(7) 	No more loop 
* ENDWHILE
* WHILE
444:     LD  3,0(1) 	Load variable i
445:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
447:     LD  3,0(1) 	Load variable i
448:     ST  3,0(1) 	Store variable i
449:    LDA  7,-6(7) 	go to beginning of loop 
446:    LDA  7,3(7) 	No more loop 
* ENDWHILE
* END compound statement
* Add standard closing in case there is no return statement
450:    LDC  2,0(6) 	Set return value to 0 
451:     LD  3,-1(1) 	Load return address 
452:     LD  1,0(1) 	Adjust fp 
453:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,453(7) 	Jump to init 
* BEGIN Init
454:     LD  0,0(0) 	Set the global pointer 
455:    LDA  1,0(0) 	set first frame at end of globals 
456:     ST  1,0(1) 	store old fp (point to self) 
457:    LDA  3,1(7) 	Return address in ac 
458:    LDA  7,-429(7) 	Jump to main 
459:   HALT  0,0,0 	DONE! 
* END Init
