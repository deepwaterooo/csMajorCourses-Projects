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
 87:    SUB  4,4,3 	Op == 
 88:    LDC  3,1(6) 	True case 
 89:    JEQ  4,1(7) 	Jump if true 
 90:    LDC  3,0(6) 	False case 
 91:     LD  3,0(1) 	Load variable i
 92:     ST  3,-2(1) 	Save left side 
 93:     LD  3,0(1) 	Load variable b
 94:     LD  4,-2(1) 	Load left into ac1 
 95:    SUB  4,4,3 	Op == 
 96:    LDC  3,1(6) 	True case 
 97:    JEQ  4,1(7) 	Jump if true 
 98:    LDC  3,0(6) 	False case 
 99:     LD  3,0(1) 	Load variable b
100:     ST  3,-2(1) 	Save left side 
101:     LD  3,0(1) 	Load variable i
102:     LD  4,-2(1) 	Load left into ac1 
103:    SUB  4,4,3 	Op == 
104:    LDC  3,1(6) 	True case 
105:    JEQ  4,1(7) 	Jump if true 
106:    LDC  3,0(6) 	False case 
107:     LD  3,0(1) 	Load variable b
108:     ST  3,-2(1) 	Save left side 
109:     LD  3,0(1) 	Load variable b
110:     LD  4,-2(1) 	Load left into ac1 
111:    SUB  4,4,3 	Op == 
112:    LDC  3,1(6) 	True case 
113:    JEQ  4,1(7) 	Jump if true 
114:    LDC  3,0(6) 	False case 
115:     LD  3,0(1) 	Load variable i
116:     ST  3,-2(1) 	Save left side 
117:     LD  3,0(1) 	Load variable i
118:     LD  4,-2(1) 	Load left into ac1 
119:     LD  3,0(1) 	Load variable i
120:     ST  3,-2(1) 	Save left side 
121:     LD  3,0(1) 	Load variable b
122:     LD  4,-2(1) 	Load left into ac1 
123:     LD  3,0(1) 	Load variable b
124:     ST  3,-2(1) 	Save left side 
125:     LD  3,0(1) 	Load variable i
126:     LD  4,-2(1) 	Load left into ac1 
127:     LD  3,0(1) 	Load variable b
128:     ST  3,-2(1) 	Save left side 
129:     LD  3,0(1) 	Load variable b
130:     LD  4,-2(1) 	Load left into ac1 
131:     LD  3,0(1) 	Load variable ia
132:     ST  3,-2(1) 	Save left side 
133:     LD  3,0(1) 	Load variable ia
134:     LD  4,-2(1) 	Load left into ac1 
135:    ADD  3,4,3 	Op + 
136:     LD  3,0(1) 	Load variable ia
137:     ST  3,-2(1) 	Save left side 
138:     LD  3,0(1) 	Load variable ba
139:     LD  4,-2(1) 	Load left into ac1 
140:    ADD  3,4,3 	Op + 
141:     LD  3,0(1) 	Load variable ba
142:     ST  3,-2(1) 	Save left side 
143:     LD  3,0(1) 	Load variable ia
144:     LD  4,-2(1) 	Load left into ac1 
145:    ADD  3,4,3 	Op + 
146:     LD  3,0(1) 	Load variable ba
147:     ST  3,-2(1) 	Save left side 
148:     LD  3,0(1) 	Load variable ba
149:     LD  4,-2(1) 	Load left into ac1 
150:    ADD  3,4,3 	Op + 
151:     LD  3,0(1) 	Load variable ia
152:     ST  3,-2(1) 	Save left side 
153:     LD  3,0(1) 	Load variable ia
154:     LD  4,-2(1) 	Load left into ac1 
155:    JEQ  3,1(7) 	Op AND 
156:    LDA  3,0(4) 	 
157:     LD  3,0(1) 	Load variable ia
158:     ST  3,-2(1) 	Save left side 
159:     LD  3,0(1) 	Load variable ba
160:     LD  4,-2(1) 	Load left into ac1 
161:    JEQ  3,1(7) 	Op AND 
162:    LDA  3,0(4) 	 
163:     LD  3,0(1) 	Load variable ba
164:     ST  3,-2(1) 	Save left side 
165:     LD  3,0(1) 	Load variable ia
166:     LD  4,-2(1) 	Load left into ac1 
167:    JEQ  3,1(7) 	Op AND 
168:    LDA  3,0(4) 	 
169:     LD  3,0(1) 	Load variable ba
170:     ST  3,-2(1) 	Save left side 
171:     LD  3,0(1) 	Load variable ba
172:     LD  4,-2(1) 	Load left into ac1 
173:    JEQ  3,1(7) 	Op AND 
174:    LDA  3,0(4) 	 
* EXPRESSION STMT
175:     LD  3,0(1) 	Load variable ia
176:     ST  3,0(1) 	Store variable ia
* EXPRESSION STMT
177:     LD  3,0(1) 	Load variable ba
178:     ST  3,0(1) 	Store variable ia
* EXPRESSION STMT
179:     LD  3,0(1) 	Load variable ia
180:     ST  3,0(1) 	Store variable ba
* EXPRESSION STMT
181:     LD  3,0(1) 	Load variable ba
182:     ST  3,0(1) 	Store variable ba
183:     LD  3,0(1) 	Load variable ia
184:     ST  3,-2(1) 	Save left side 
185:     LD  3,0(1) 	Load variable ia
186:     LD  4,-2(1) 	Load left into ac1 
187:    SUB  4,4,3 	Op == 
188:    LDC  3,1(6) 	True case 
189:    JEQ  4,1(7) 	Jump if true 
190:    LDC  3,0(6) 	False case 
191:     LD  3,0(1) 	Load variable ia
192:     ST  3,-2(1) 	Save left side 
193:     LD  3,0(1) 	Load variable ba
194:     LD  4,-2(1) 	Load left into ac1 
195:    SUB  4,4,3 	Op == 
196:    LDC  3,1(6) 	True case 
197:    JEQ  4,1(7) 	Jump if true 
198:    LDC  3,0(6) 	False case 
199:     LD  3,0(1) 	Load variable ba
200:     ST  3,-2(1) 	Save left side 
201:     LD  3,0(1) 	Load variable ia
202:     LD  4,-2(1) 	Load left into ac1 
203:    SUB  4,4,3 	Op == 
204:    LDC  3,1(6) 	True case 
205:    JEQ  4,1(7) 	Jump if true 
206:    LDC  3,0(6) 	False case 
207:     LD  3,0(1) 	Load variable ba
208:     ST  3,-2(1) 	Save left side 
209:     LD  3,0(1) 	Load variable ba
210:     LD  4,-2(1) 	Load left into ac1 
211:    SUB  4,4,3 	Op == 
212:    LDC  3,1(6) 	True case 
213:    JEQ  4,1(7) 	Jump if true 
214:    LDC  3,0(6) 	False case 
215:     LD  3,0(1) 	Load variable b
216:     ST  3,-2(1) 	Save left side 
217:     LD  3,0(1) 	Load variable i
218:     LD  4,-2(1) 	Load left into ac1 
219:    ADD  3,4,3 	Op + 
220:     ST  3,-2(1) 	Save left side 
221:     LD  3,0(1) 	Load variable i
222:     LD  4,-2(1) 	Load left into ac1 
223:    ADD  3,4,3 	Op + 
224:     LD  3,0(1) 	Load variable i
225:     ST  3,-2(1) 	Save left side 
226:     LD  3,0(1) 	Load variable b
227:     LD  4,-2(1) 	Load left into ac1 
228:    ADD  3,4,3 	Op + 
229:     ST  3,-2(1) 	Save left side 
230:     LD  3,0(1) 	Load variable i
231:     LD  4,-2(1) 	Load left into ac1 
232:    ADD  3,4,3 	Op + 
233:     LD  3,0(1) 	Load variable i
234:     ST  3,-2(1) 	Save left side 
235:     LD  3,0(1) 	Load variable i
236:     LD  4,-2(1) 	Load left into ac1 
237:    ADD  3,4,3 	Op + 
238:     ST  3,-2(1) 	Save left side 
239:     LD  3,0(1) 	Load variable b
240:     LD  4,-2(1) 	Load left into ac1 
241:    ADD  3,4,3 	Op + 
242:     LD  3,0(1) 	Load variable i
243:     ST  3,-2(1) 	Save left side 
244:     LD  3,0(1) 	Load variable b
245:     LD  4,-2(1) 	Load left into ac1 
246:     ST  3,-2(1) 	Save left side 
247:     LD  3,0(1) 	Load variable b
248:     LD  4,-2(1) 	Load left into ac1 
249:     LD  3,0(1) 	Load variable b
250:     ST  3,-2(1) 	Save left side 
251:     LD  3,0(1) 	Load variable i
252:     LD  4,-2(1) 	Load left into ac1 
253:     ST  3,-2(1) 	Save left side 
254:     LD  3,0(1) 	Load variable b
255:     LD  4,-2(1) 	Load left into ac1 
256:     LD  3,0(1) 	Load variable b
257:     ST  3,-2(1) 	Save left side 
258:     LD  3,0(1) 	Load variable b
259:     LD  4,-2(1) 	Load left into ac1 
260:     ST  3,-2(1) 	Save left side 
261:     LD  3,0(1) 	Load variable i
262:     LD  4,-2(1) 	Load left into ac1 
263:     LD  3,0(1) 	Load variable b
264:     LD  3,0(1) 	Load variable i
265:     LD  3,0(1) 	Load variable ba
266:     LD  3,0(1) 	Load variable ia
267:     LD  3,0(1) 	Load variable b
268:    LDC  4,0(6) 	Load 0 
269:    SUB  3,4,3 	Op unary - 
270:     LD  3,0(1) 	Load variable i
271:    LDC  4,0(6) 	Load 0 
272:    SUB  3,4,3 	Op unary - 
273:     LD  3,0(1) 	Load variable ba
274:    LDC  4,0(6) 	Load 0 
275:    SUB  3,4,3 	Op unary - 
276:     LD  3,0(1) 	Load variable ia
277:    LDC  4,0(6) 	Load 0 
278:    SUB  3,4,3 	Op unary - 
279:     LD  3,0(1) 	Load variable i
280:     ST  3,-2(1) 	Save left side 
281:     LD  3,0(1) 	Load variable i
282:     LD  4,-2(1) 	Load left into ac1 
283:    SUB  4,4,3 	Op > 
284:    LDC  3,1(6) 	True case 
285:    JLT  4,1(7) 	Jump if true 
286:    LDC  3,0(6) 	False case 
287:     ST  3,-2(1) 	Save left side 
288:     LD  3,0(1) 	Load variable i
289:     ST  3,-3(1) 	Save left side 
290:     LD  3,0(1) 	Load variable i
291:     LD  4,-3(1) 	Load left into ac1 
292:    SUB  4,4,3 	Op > 
293:    LDC  3,1(6) 	True case 
294:    JLT  4,1(7) 	Jump if true 
295:    LDC  3,0(6) 	False case 
296:     LD  4,-2(1) 	Load left into ac1 
297:     LD  3,0(1) 	Load variable b
298:     ST  3,-2(1) 	Save left side 
299:     LD  3,0(1) 	Load variable i
300:     LD  4,-2(1) 	Load left into ac1 
301:    SUB  4,4,3 	Op > 
302:    LDC  3,1(6) 	True case 
303:    JLT  4,1(7) 	Jump if true 
304:    LDC  3,0(6) 	False case 
305:     ST  3,-2(1) 	Save left side 
306:     LD  3,0(1) 	Load variable i
307:     ST  3,-3(1) 	Save left side 
308:     LD  3,0(1) 	Load variable i
309:     LD  4,-3(1) 	Load left into ac1 
310:    SUB  4,4,3 	Op > 
311:    LDC  3,1(6) 	True case 
312:    JLT  4,1(7) 	Jump if true 
313:    LDC  3,0(6) 	False case 
314:     LD  4,-2(1) 	Load left into ac1 
315:     LD  3,0(1) 	Load variable i
316:     ST  3,-2(1) 	Save left side 
317:     LD  3,0(1) 	Load variable b
318:     LD  4,-2(1) 	Load left into ac1 
319:    SUB  4,4,3 	Op > 
320:    LDC  3,1(6) 	True case 
321:    JLT  4,1(7) 	Jump if true 
322:    LDC  3,0(6) 	False case 
323:     ST  3,-2(1) 	Save left side 
324:     LD  3,0(1) 	Load variable i
325:     ST  3,-3(1) 	Save left side 
326:     LD  3,0(1) 	Load variable i
327:     LD  4,-3(1) 	Load left into ac1 
328:    SUB  4,4,3 	Op > 
329:    LDC  3,1(6) 	True case 
330:    JLT  4,1(7) 	Jump if true 
331:    LDC  3,0(6) 	False case 
332:     LD  4,-2(1) 	Load left into ac1 
333:     LD  3,0(1) 	Load variable i
334:     ST  3,-2(1) 	Save left side 
335:     LD  3,0(1) 	Load variable i
336:     LD  4,-2(1) 	Load left into ac1 
337:    SUB  4,4,3 	Op > 
338:    LDC  3,1(6) 	True case 
339:    JLT  4,1(7) 	Jump if true 
340:    LDC  3,0(6) 	False case 
341:     ST  3,-2(1) 	Save left side 
342:     LD  3,0(1) 	Load variable b
343:     ST  3,-3(1) 	Save left side 
344:     LD  3,0(1) 	Load variable i
345:     LD  4,-3(1) 	Load left into ac1 
346:    SUB  4,4,3 	Op > 
347:    LDC  3,1(6) 	True case 
348:    JLT  4,1(7) 	Jump if true 
349:    LDC  3,0(6) 	False case 
350:     LD  4,-2(1) 	Load left into ac1 
351:     LD  3,0(1) 	Load variable b
352:     ST  3,-2(1) 	Save left side 
353:     LD  3,0(1) 	Load variable i
354:     LD  4,-2(1) 	Load left into ac1 
355:    SUB  4,4,3 	Op > 
356:    LDC  3,1(6) 	True case 
357:    JLT  4,1(7) 	Jump if true 
358:    LDC  3,0(6) 	False case 
359:     ST  3,-2(1) 	Save left side 
360:     LD  3,0(1) 	Load variable i
361:     ST  3,-3(1) 	Save left side 
362:     LD  3,0(1) 	Load variable b
363:     LD  4,-3(1) 	Load left into ac1 
364:    SUB  4,4,3 	Op > 
365:    LDC  3,1(6) 	True case 
366:    JLT  4,1(7) 	Jump if true 
367:    LDC  3,0(6) 	False case 
368:     LD  4,-2(1) 	Load left into ac1 
369:     LD  3,0(1) 	Load variable b
370:     ST  3,-2(1) 	Save left side 
371:     LD  3,0(1) 	Load variable b
372:     LD  4,-2(1) 	Load left into ac1 
373:     ST  3,-2(1) 	Save left side 
374:     LD  3,0(1) 	Load variable b
375:     ST  3,-3(1) 	Save left side 
376:     LD  3,0(1) 	Load variable b
377:     LD  4,-3(1) 	Load left into ac1 
378:     LD  4,-2(1) 	Load left into ac1 
379:    JEQ  3,1(7) 	Op AND 
380:    LDA  3,0(4) 	 
* IfK:
* IfK: t->child[0] condition
381:    LDC  3,1(6) 	Load constant 
* IfK: t->child[1] then part
* EXPRESSION STMT
383:     LD  3,0(1) 	Load variable i
384:     ST  3,0(1) 	Store variable i
382:    JEQ  3,3(7) 	if: jmp to else 
* IfK: t->child[2] else part
* EXPRESSION STMT
386:     LD  3,0(1) 	Load variable b
387:     ST  3,0(1) 	Store variable b
385:    LDA  7,2(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
388:     LD  3,0(1) 	Load variable ba
* IfK: t->child[1] then part
* EXPRESSION STMT
390:     LD  3,0(1) 	Load variable i
391:     ST  3,0(1) 	Store variable i
389:    JEQ  3,3(7) 	if: jmp to else 
* IfK: t->child[2] else part
* EXPRESSION STMT
393:     LD  3,0(1) 	Load variable b
394:     ST  3,0(1) 	Store variable b
392:    LDA  7,2(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
395:     LD  3,0(1) 	Load variable ia
* IfK: t->child[1] then part
* EXPRESSION STMT
397:     LD  3,0(1) 	Load variable i
398:     ST  3,0(1) 	Store variable i
396:    JEQ  3,3(7) 	if: jmp to else 
* IfK: t->child[2] else part
* EXPRESSION STMT
400:     LD  3,0(1) 	Load variable b
401:     ST  3,0(1) 	Store variable b
399:    LDA  7,2(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
402:     LD  3,0(1) 	Load variable b
* IfK: t->child[1] then part
* EXPRESSION STMT
404:     LD  3,0(1) 	Load variable i
405:     ST  3,0(1) 	Store variable i
403:    JEQ  3,3(7) 	if: jmp to else 
* IfK: t->child[2] else part
* EXPRESSION STMT
407:     LD  3,0(1) 	Load variable b
408:     ST  3,0(1) 	Store variable b
406:    LDA  7,2(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
409:     LD  3,0(1) 	Load variable i
* IfK: t->child[1] then part
* EXPRESSION STMT
411:     LD  3,0(1) 	Load variable i
412:     ST  3,0(1) 	Store variable i
410:    JEQ  3,3(7) 	if: jmp to else 
* IfK: t->child[2] else part
* EXPRESSION STMT
414:     LD  3,0(1) 	Load variable b
415:     ST  3,0(1) 	Store variable b
413:    LDA  7,2(7) 	jmp to end 
* ENDIF
* WHILE
416:    LDC  3,1(6) 	Load constant 
417:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
419:     LD  3,0(1) 	Load variable i
420:     ST  3,0(1) 	Store variable i
421:    LDA  7,-6(7) 	go to beginning of loop 
418:    LDA  7,3(7) 	No more loop 
* ENDWHILE
* WHILE
422:     LD  3,0(1) 	Load variable ba
423:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
425:     LD  3,0(1) 	Load variable i
426:     ST  3,0(1) 	Store variable i
427:    LDA  7,-6(7) 	go to beginning of loop 
424:    LDA  7,3(7) 	No more loop 
* ENDWHILE
* WHILE
428:     LD  3,0(1) 	Load variable ia
429:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
431:     LD  3,0(1) 	Load variable i
432:     ST  3,0(1) 	Store variable i
433:    LDA  7,-6(7) 	go to beginning of loop 
430:    LDA  7,3(7) 	No more loop 
* ENDWHILE
* WHILE
434:     LD  3,0(1) 	Load variable b
435:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
437:     LD  3,0(1) 	Load variable i
438:     ST  3,0(1) 	Store variable i
439:    LDA  7,-6(7) 	go to beginning of loop 
436:    LDA  7,3(7) 	No more loop 
* ENDWHILE
* WHILE
440:     LD  3,0(1) 	Load variable i
441:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
443:     LD  3,0(1) 	Load variable i
444:     ST  3,0(1) 	Store variable i
445:    LDA  7,-6(7) 	go to beginning of loop 
442:    LDA  7,3(7) 	No more loop 
* ENDWHILE
* END compound statement
* Add standard closing in case there is no return statement
446:    LDC  2,0(6) 	Set return value to 0 
447:     LD  3,-1(1) 	Load return address 
448:     LD  1,0(1) 	Adjust fp 
449:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,449(7) 	Jump to init 
* BEGIN Init
450:     LD  0,0(0) 	Set the global pointer 
451:    LDA  1,0(0) 	set first frame at end of globals 
452:     ST  1,0(1) 	store old fp (point to self) 
453:    LDA  3,1(7) 	Return address in ac 
454:    LDA  7,-425(7) 	Jump to main 
455:   HALT  0,0,0 	DONE! 
* END Init
