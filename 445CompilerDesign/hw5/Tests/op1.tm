* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  op1.tm
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
 31:     ST  1,-2(1) 	Store old frame in ghost frame 
 32:    LDC  3,111(6) 	Load constant 
 33:     ST  3,-4(1) 	Save left side 
 34:    LDC  3,222(6) 	Load constant 
 35:     LD  4,-4(1) 	Load left into ac1 
 36:     ST  3,-4(1) 	Store parameter 
 37:    LDA  1,-2(1) 	Load address of new frame 
 38:    LDA  3,1(7) 	Return address in ac 
 39:    LDA  7,-22(7) 	CALL outputb
 40:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 41:     ST  1,-2(1) 	Store old frame in ghost frame 
 42:    LDC  3,222(6) 	Load constant 
 43:     ST  3,-4(1) 	Save left side 
 44:    LDC  3,111(6) 	Load constant 
 45:     LD  4,-4(1) 	Load left into ac1 
 46:     ST  3,-4(1) 	Store parameter 
 47:    LDA  1,-2(1) 	Load address of new frame 
 48:    LDA  3,1(7) 	Return address in ac 
 49:    LDA  7,-32(7) 	CALL outputb
 50:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 51:     ST  1,-2(1) 	Store old frame in ghost frame 
 52:    LDC  3,111(6) 	Load constant 
 53:     ST  3,-4(1) 	Save left side 
 54:    LDC  3,111(6) 	Load constant 
 55:     LD  4,-4(1) 	Load left into ac1 
 56:     ST  3,-4(1) 	Store parameter 
 57:    LDA  1,-2(1) 	Load address of new frame 
 58:    LDA  3,1(7) 	Return address in ac 
 59:    LDA  7,-42(7) 	CALL outputb
 60:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 61:     ST  1,-2(1) 	Store old frame in ghost frame 
 62:    LDA  1,-2(1) 	Load address of new frame 
 63:    LDA  3,1(7) 	Return address in ac 
 64:    LDA  7,-40(7) 	CALL outnl
 65:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 66:     ST  1,-2(1) 	Store old frame in ghost frame 
 67:    LDC  3,111(6) 	Load constant 
 68:     ST  3,-4(1) 	Save left side 
 69:    LDC  3,222(6) 	Load constant 
 70:     LD  4,-4(1) 	Load left into ac1 
 71:    SUB  4,4,3 	Op < 
 72:    LDC  3,1(6) 	True case 
 73:    JLT  4,1(7) 	Jump if true 
 74:    LDC  3,0(6) 	False case 
 75:     ST  3,-4(1) 	Store parameter 
 76:    LDA  1,-2(1) 	Load address of new frame 
 77:    LDA  3,1(7) 	Return address in ac 
 78:    LDA  7,-61(7) 	CALL outputb
 79:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 80:     ST  1,-2(1) 	Store old frame in ghost frame 
 81:    LDC  3,222(6) 	Load constant 
 82:     ST  3,-4(1) 	Save left side 
 83:    LDC  3,111(6) 	Load constant 
 84:     LD  4,-4(1) 	Load left into ac1 
 85:    SUB  4,4,3 	Op < 
 86:    LDC  3,1(6) 	True case 
 87:    JLT  4,1(7) 	Jump if true 
 88:    LDC  3,0(6) 	False case 
 89:     ST  3,-4(1) 	Store parameter 
 90:    LDA  1,-2(1) 	Load address of new frame 
 91:    LDA  3,1(7) 	Return address in ac 
 92:    LDA  7,-75(7) 	CALL outputb
 93:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 94:     ST  1,-2(1) 	Store old frame in ghost frame 
 95:    LDC  3,111(6) 	Load constant 
 96:     ST  3,-4(1) 	Save left side 
 97:    LDC  3,111(6) 	Load constant 
 98:     LD  4,-4(1) 	Load left into ac1 
 99:    SUB  4,4,3 	Op < 
100:    LDC  3,1(6) 	True case 
101:    JLT  4,1(7) 	Jump if true 
102:    LDC  3,0(6) 	False case 
103:     ST  3,-4(1) 	Store parameter 
104:    LDA  1,-2(1) 	Load address of new frame 
105:    LDA  3,1(7) 	Return address in ac 
106:    LDA  7,-89(7) 	CALL outputb
107:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
108:     ST  1,-2(1) 	Store old frame in ghost frame 
109:    LDA  1,-2(1) 	Load address of new frame 
110:    LDA  3,1(7) 	Return address in ac 
111:    LDA  7,-87(7) 	CALL outnl
112:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
113:     ST  1,-2(1) 	Store old frame in ghost frame 
114:    LDC  3,111(6) 	Load constant 
115:     ST  3,-4(1) 	Save left side 
116:    LDC  3,222(6) 	Load constant 
117:     LD  4,-4(1) 	Load left into ac1 
118:    SUB  4,4,3 	Op > 
119:    LDC  3,1(6) 	True case 
120:    JLT  4,1(7) 	Jump if true 
121:    LDC  3,0(6) 	False case 
122:     ST  3,-4(1) 	Store parameter 
123:    LDA  1,-2(1) 	Load address of new frame 
124:    LDA  3,1(7) 	Return address in ac 
125:    LDA  7,-108(7) 	CALL outputb
126:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
127:     ST  1,-2(1) 	Store old frame in ghost frame 
128:    LDC  3,222(6) 	Load constant 
129:     ST  3,-4(1) 	Save left side 
130:    LDC  3,111(6) 	Load constant 
131:     LD  4,-4(1) 	Load left into ac1 
132:    SUB  4,4,3 	Op > 
133:    LDC  3,1(6) 	True case 
134:    JLT  4,1(7) 	Jump if true 
135:    LDC  3,0(6) 	False case 
136:     ST  3,-4(1) 	Store parameter 
137:    LDA  1,-2(1) 	Load address of new frame 
138:    LDA  3,1(7) 	Return address in ac 
139:    LDA  7,-122(7) 	CALL outputb
140:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
141:     ST  1,-2(1) 	Store old frame in ghost frame 
142:    LDC  3,111(6) 	Load constant 
143:     ST  3,-4(1) 	Save left side 
144:    LDC  3,111(6) 	Load constant 
145:     LD  4,-4(1) 	Load left into ac1 
146:    SUB  4,4,3 	Op > 
147:    LDC  3,1(6) 	True case 
148:    JLT  4,1(7) 	Jump if true 
149:    LDC  3,0(6) 	False case 
150:     ST  3,-4(1) 	Store parameter 
151:    LDA  1,-2(1) 	Load address of new frame 
152:    LDA  3,1(7) 	Return address in ac 
153:    LDA  7,-136(7) 	CALL outputb
154:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
155:     ST  1,-2(1) 	Store old frame in ghost frame 
156:    LDA  1,-2(1) 	Load address of new frame 
157:    LDA  3,1(7) 	Return address in ac 
158:    LDA  7,-134(7) 	CALL outnl
159:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
160:     ST  1,-2(1) 	Store old frame in ghost frame 
161:    LDC  3,111(6) 	Load constant 
162:     ST  3,-4(1) 	Save left side 
163:    LDC  3,222(6) 	Load constant 
164:     LD  4,-4(1) 	Load left into ac1 
165:     ST  3,-4(1) 	Store parameter 
166:    LDA  1,-2(1) 	Load address of new frame 
167:    LDA  3,1(7) 	Return address in ac 
168:    LDA  7,-151(7) 	CALL outputb
169:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
170:     ST  1,-2(1) 	Store old frame in ghost frame 
171:    LDC  3,222(6) 	Load constant 
172:     ST  3,-4(1) 	Save left side 
173:    LDC  3,111(6) 	Load constant 
174:     LD  4,-4(1) 	Load left into ac1 
175:     ST  3,-4(1) 	Store parameter 
176:    LDA  1,-2(1) 	Load address of new frame 
177:    LDA  3,1(7) 	Return address in ac 
178:    LDA  7,-161(7) 	CALL outputb
179:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
180:     ST  1,-2(1) 	Store old frame in ghost frame 
181:    LDC  3,111(6) 	Load constant 
182:     ST  3,-4(1) 	Save left side 
183:    LDC  3,111(6) 	Load constant 
184:     LD  4,-4(1) 	Load left into ac1 
185:     ST  3,-4(1) 	Store parameter 
186:    LDA  1,-2(1) 	Load address of new frame 
187:    LDA  3,1(7) 	Return address in ac 
188:    LDA  7,-171(7) 	CALL outputb
189:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
190:     ST  1,-2(1) 	Store old frame in ghost frame 
191:    LDA  1,-2(1) 	Load address of new frame 
192:    LDA  3,1(7) 	Return address in ac 
193:    LDA  7,-169(7) 	CALL outnl
194:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
195:     ST  1,-2(1) 	Store old frame in ghost frame 
196:    LDC  3,111(6) 	Load constant 
197:     ST  3,-4(1) 	Save left side 
198:    LDC  3,222(6) 	Load constant 
199:     LD  4,-4(1) 	Load left into ac1 
200:    SUB  4,4,3 	Op == 
201:    LDC  3,1(6) 	True case 
202:    JEQ  4,1(7) 	Jump if true 
203:    LDC  3,0(6) 	False case 
204:     ST  3,-4(1) 	Store parameter 
205:    LDA  1,-2(1) 	Load address of new frame 
206:    LDA  3,1(7) 	Return address in ac 
207:    LDA  7,-190(7) 	CALL outputb
208:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
209:     ST  1,-2(1) 	Store old frame in ghost frame 
210:    LDC  3,222(6) 	Load constant 
211:     ST  3,-4(1) 	Save left side 
212:    LDC  3,111(6) 	Load constant 
213:     LD  4,-4(1) 	Load left into ac1 
214:    SUB  4,4,3 	Op == 
215:    LDC  3,1(6) 	True case 
216:    JEQ  4,1(7) 	Jump if true 
217:    LDC  3,0(6) 	False case 
218:     ST  3,-4(1) 	Store parameter 
219:    LDA  1,-2(1) 	Load address of new frame 
220:    LDA  3,1(7) 	Return address in ac 
221:    LDA  7,-204(7) 	CALL outputb
222:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
223:     ST  1,-2(1) 	Store old frame in ghost frame 
224:    LDC  3,111(6) 	Load constant 
225:     ST  3,-4(1) 	Save left side 
226:    LDC  3,111(6) 	Load constant 
227:     LD  4,-4(1) 	Load left into ac1 
228:    SUB  4,4,3 	Op == 
229:    LDC  3,1(6) 	True case 
230:    JEQ  4,1(7) 	Jump if true 
231:    LDC  3,0(6) 	False case 
232:     ST  3,-4(1) 	Store parameter 
233:    LDA  1,-2(1) 	Load address of new frame 
234:    LDA  3,1(7) 	Return address in ac 
235:    LDA  7,-218(7) 	CALL outputb
236:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
237:     ST  1,-2(1) 	Store old frame in ghost frame 
238:    LDA  1,-2(1) 	Load address of new frame 
239:    LDA  3,1(7) 	Return address in ac 
240:    LDA  7,-216(7) 	CALL outnl
241:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
242:     ST  1,-2(1) 	Store old frame in ghost frame 
243:    LDC  3,111(6) 	Load constant 
244:     ST  3,-4(1) 	Save left side 
245:    LDC  3,222(6) 	Load constant 
246:     LD  4,-4(1) 	Load left into ac1 
247:     ST  3,-4(1) 	Store parameter 
248:    LDA  1,-2(1) 	Load address of new frame 
249:    LDA  3,1(7) 	Return address in ac 
250:    LDA  7,-233(7) 	CALL outputb
251:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
252:     ST  1,-2(1) 	Store old frame in ghost frame 
253:    LDC  3,222(6) 	Load constant 
254:     ST  3,-4(1) 	Save left side 
255:    LDC  3,111(6) 	Load constant 
256:     LD  4,-4(1) 	Load left into ac1 
257:     ST  3,-4(1) 	Store parameter 
258:    LDA  1,-2(1) 	Load address of new frame 
259:    LDA  3,1(7) 	Return address in ac 
260:    LDA  7,-243(7) 	CALL outputb
261:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
262:     ST  1,-2(1) 	Store old frame in ghost frame 
263:    LDC  3,111(6) 	Load constant 
264:     ST  3,-4(1) 	Save left side 
265:    LDC  3,111(6) 	Load constant 
266:     LD  4,-4(1) 	Load left into ac1 
267:     ST  3,-4(1) 	Store parameter 
268:    LDA  1,-2(1) 	Load address of new frame 
269:    LDA  3,1(7) 	Return address in ac 
270:    LDA  7,-253(7) 	CALL outputb
271:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
272:     ST  1,-2(1) 	Store old frame in ghost frame 
273:    LDA  1,-2(1) 	Load address of new frame 
274:    LDA  3,1(7) 	Return address in ac 
275:    LDA  7,-251(7) 	CALL outnl
276:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
277:     ST  1,-2(1) 	Store old frame in ghost frame 
278:    LDC  3,111(6) 	Load constant 
279:     ST  3,-4(1) 	Save left side 
280:    LDC  3,222(6) 	Load constant 
281:     LD  4,-4(1) 	Load left into ac1 
282:     ST  3,-4(1) 	Store parameter 
283:    LDA  1,-2(1) 	Load address of new frame 
284:    LDA  3,1(7) 	Return address in ac 
285:    LDA  7,-268(7) 	CALL outputb
286:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
287:     ST  1,-2(1) 	Store old frame in ghost frame 
288:    LDC  3,222(6) 	Load constant 
289:     ST  3,-4(1) 	Save left side 
290:    LDC  3,111(6) 	Load constant 
291:     LD  4,-4(1) 	Load left into ac1 
292:     ST  3,-4(1) 	Store parameter 
293:    LDA  1,-2(1) 	Load address of new frame 
294:    LDA  3,1(7) 	Return address in ac 
295:    LDA  7,-278(7) 	CALL outputb
296:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
297:     ST  1,-2(1) 	Store old frame in ghost frame 
298:    LDC  3,111(6) 	Load constant 
299:     ST  3,-4(1) 	Save left side 
300:    LDC  3,111(6) 	Load constant 
301:     LD  4,-4(1) 	Load left into ac1 
302:     ST  3,-4(1) 	Store parameter 
303:    LDA  1,-2(1) 	Load address of new frame 
304:    LDA  3,1(7) 	Return address in ac 
305:    LDA  7,-288(7) 	CALL outputb
306:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
307:     ST  1,-2(1) 	Store old frame in ghost frame 
308:    LDA  1,-2(1) 	Load address of new frame 
309:    LDA  3,1(7) 	Return address in ac 
310:    LDA  7,-286(7) 	CALL outnl
311:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
312:     ST  1,-2(1) 	Store old frame in ghost frame 
313:    LDC  3,0(6) 	Load constant 
314:     ST  3,-4(1) 	Save left side 
315:    LDC  3,0(6) 	Load constant 
316:     LD  4,-4(1) 	Load left into ac1 
317:    JEQ  3,1(7) 	Op AND 
318:    LDA  3,0(4) 	 
319:     ST  3,-4(1) 	Store parameter 
320:    LDA  1,-2(1) 	Load address of new frame 
321:    LDA  3,1(7) 	Return address in ac 
322:    LDA  7,-305(7) 	CALL outputb
323:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
324:     ST  1,-2(1) 	Store old frame in ghost frame 
325:    LDC  3,0(6) 	Load constant 
326:     ST  3,-4(1) 	Save left side 
327:    LDC  3,0(6) 	Load constant 
328:     LD  4,-4(1) 	Load left into ac1 
329:    JEQ  3,1(7) 	Op AND 
330:    LDA  3,0(4) 	 
331:     ST  3,-4(1) 	Store parameter 
332:    LDA  1,-2(1) 	Load address of new frame 
333:    LDA  3,1(7) 	Return address in ac 
334:    LDA  7,-317(7) 	CALL outputb
335:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
336:     ST  1,-2(1) 	Store old frame in ghost frame 
337:    LDC  3,0(6) 	Load constant 
338:     ST  3,-4(1) 	Save left side 
339:    LDC  3,0(6) 	Load constant 
340:     LD  4,-4(1) 	Load left into ac1 
341:    JEQ  3,1(7) 	Op AND 
342:    LDA  3,0(4) 	 
343:     ST  3,-4(1) 	Store parameter 
344:    LDA  1,-2(1) 	Load address of new frame 
345:    LDA  3,1(7) 	Return address in ac 
346:    LDA  7,-329(7) 	CALL outputb
347:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
348:     ST  1,-2(1) 	Store old frame in ghost frame 
349:    LDC  3,0(6) 	Load constant 
350:     ST  3,-4(1) 	Save left side 
351:    LDC  3,0(6) 	Load constant 
352:     LD  4,-4(1) 	Load left into ac1 
353:    JEQ  3,1(7) 	Op AND 
354:    LDA  3,0(4) 	 
355:     ST  3,-4(1) 	Store parameter 
356:    LDA  1,-2(1) 	Load address of new frame 
357:    LDA  3,1(7) 	Return address in ac 
358:    LDA  7,-341(7) 	CALL outputb
359:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
360:     ST  1,-2(1) 	Store old frame in ghost frame 
361:    LDA  1,-2(1) 	Load address of new frame 
362:    LDA  3,1(7) 	Return address in ac 
363:    LDA  7,-339(7) 	CALL outnl
364:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
365:     ST  1,-2(1) 	Store old frame in ghost frame 
366:    LDC  3,0(6) 	Load constant 
367:     ST  3,-4(1) 	Save left side 
368:    LDC  3,0(6) 	Load constant 
369:     LD  4,-4(1) 	Load left into ac1 
370:     ST  3,-4(1) 	Store parameter 
371:    LDA  1,-2(1) 	Load address of new frame 
372:    LDA  3,1(7) 	Return address in ac 
373:    LDA  7,-356(7) 	CALL outputb
374:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
375:     ST  1,-2(1) 	Store old frame in ghost frame 
376:    LDC  3,0(6) 	Load constant 
377:     ST  3,-4(1) 	Save left side 
378:    LDC  3,0(6) 	Load constant 
379:     LD  4,-4(1) 	Load left into ac1 
380:     ST  3,-4(1) 	Store parameter 
381:    LDA  1,-2(1) 	Load address of new frame 
382:    LDA  3,1(7) 	Return address in ac 
383:    LDA  7,-366(7) 	CALL outputb
384:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
385:     ST  1,-2(1) 	Store old frame in ghost frame 
386:    LDC  3,0(6) 	Load constant 
387:     ST  3,-4(1) 	Save left side 
388:    LDC  3,0(6) 	Load constant 
389:     LD  4,-4(1) 	Load left into ac1 
390:     ST  3,-4(1) 	Store parameter 
391:    LDA  1,-2(1) 	Load address of new frame 
392:    LDA  3,1(7) 	Return address in ac 
393:    LDA  7,-376(7) 	CALL outputb
394:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
395:     ST  1,-2(1) 	Store old frame in ghost frame 
396:    LDC  3,0(6) 	Load constant 
397:     ST  3,-4(1) 	Save left side 
398:    LDC  3,0(6) 	Load constant 
399:     LD  4,-4(1) 	Load left into ac1 
400:     ST  3,-4(1) 	Store parameter 
401:    LDA  1,-2(1) 	Load address of new frame 
402:    LDA  3,1(7) 	Return address in ac 
403:    LDA  7,-386(7) 	CALL outputb
404:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
405:     ST  1,-2(1) 	Store old frame in ghost frame 
406:    LDA  1,-2(1) 	Load address of new frame 
407:    LDA  3,1(7) 	Return address in ac 
408:    LDA  7,-384(7) 	CALL outnl
409:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
410:     ST  1,-2(1) 	Store old frame in ghost frame 
411:    LDC  3,0(6) 	Load constant 
412:     ST  3,-4(1) 	Store parameter 
413:    LDA  1,-2(1) 	Load address of new frame 
414:    LDA  3,1(7) 	Return address in ac 
415:    LDA  7,-398(7) 	CALL outputb
416:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
417:     ST  1,-2(1) 	Store old frame in ghost frame 
418:    LDC  3,0(6) 	Load constant 
419:     ST  3,-4(1) 	Store parameter 
420:    LDA  1,-2(1) 	Load address of new frame 
421:    LDA  3,1(7) 	Return address in ac 
422:    LDA  7,-405(7) 	CALL outputb
423:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
424:     ST  1,-2(1) 	Store old frame in ghost frame 
425:    LDA  1,-2(1) 	Load address of new frame 
426:    LDA  3,1(7) 	Return address in ac 
427:    LDA  7,-403(7) 	CALL outnl
428:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
429:     ST  1,-2(1) 	Store old frame in ghost frame 
430:    LDC  3,333(6) 	Load constant 
431:     ST  3,-4(1) 	Save left side 
432:    LDC  3,444(6) 	Load constant 
433:     LD  4,-4(1) 	Load left into ac1 
434:    ADD  3,4,3 	Op + 
435:     ST  3,-4(1) 	Store parameter 
436:    LDA  1,-2(1) 	Load address of new frame 
437:    LDA  3,1(7) 	Return address in ac 
438:    LDA  7,-433(7) 	CALL output
439:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
440:     ST  1,-2(1) 	Store old frame in ghost frame 
441:    LDC  3,333(6) 	Load constant 
442:     ST  3,-4(1) 	Save left side 
443:    LDC  3,444(6) 	Load constant 
444:     LD  4,-4(1) 	Load left into ac1 
445:    SUB  3,4,3 	Op - 
446:     ST  3,-4(1) 	Store parameter 
447:    LDA  1,-2(1) 	Load address of new frame 
448:    LDA  3,1(7) 	Return address in ac 
449:    LDA  7,-444(7) 	CALL output
450:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
451:     ST  1,-2(1) 	Store old frame in ghost frame 
452:    LDC  3,333(6) 	Load constant 
453:     ST  3,-4(1) 	Save left side 
454:    LDC  3,444(6) 	Load constant 
455:     LD  4,-4(1) 	Load left into ac1 
456:    MUL  3,4,3 	Op * 
457:     ST  3,-4(1) 	Store parameter 
458:    LDA  1,-2(1) 	Load address of new frame 
459:    LDA  3,1(7) 	Return address in ac 
460:    LDA  7,-455(7) 	CALL output
461:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
462:     ST  1,-2(1) 	Store old frame in ghost frame 
463:    LDC  3,333(6) 	Load constant 
464:     ST  3,-4(1) 	Save left side 
465:    LDC  3,444(6) 	Load constant 
466:     LD  4,-4(1) 	Load left into ac1 
467:    DIV  3,4,3 	Op / 
468:     ST  3,-4(1) 	Store parameter 
469:    LDA  1,-2(1) 	Load address of new frame 
470:    LDA  3,1(7) 	Return address in ac 
471:    LDA  7,-466(7) 	CALL output
472:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
473:     ST  1,-2(1) 	Store old frame in ghost frame 
474:    LDC  3,3333(6) 	Load constant 
475:     ST  3,-4(1) 	Save left side 
476:    LDC  3,444(6) 	Load constant 
477:     LD  4,-4(1) 	Load left into ac1 
478:     ST  3,-4(1) 	Store parameter 
479:    LDA  1,-2(1) 	Load address of new frame 
480:    LDA  3,1(7) 	Return address in ac 
481:    LDA  7,-476(7) 	CALL output
482:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
483:     ST  1,-2(1) 	Store old frame in ghost frame 
484:    LDC  3,444(6) 	Load constant 
485:    LDC  4,0(6) 	Load 0 
486:    SUB  3,4,3 	Op unary - 
487:     ST  3,-4(1) 	Store parameter 
488:    LDA  1,-2(1) 	Load address of new frame 
489:    LDA  3,1(7) 	Return address in ac 
490:    LDA  7,-485(7) 	CALL output
491:    LDA  3,0(2) 	Save the result in ac 
* RETURN
492:    LDA  2,0(3) 	Copy result to rt register 
493:     LD  3,-1(1) 	Load return address 
494:     LD  1,0(1) 	Adjust fp 
495:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
496:    LDC  2,0(6) 	Set return value to 0 
497:     LD  3,-1(1) 	Load return address 
498:     LD  1,0(1) 	Adjust fp 
499:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,499(7) 	Jump to init 
* BEGIN Init
500:     LD  0,0(0) 	Set the global pointer 
501:    LDA  1,0(0) 	set first frame at end of globals 
502:     ST  1,0(1) 	store old fp (point to self) 
503:    LDA  3,1(7) 	Return address in ac 
504:    LDA  7,-475(7) 	Jump to main 
505:   HALT  0,0,0 	DONE! 
* END Init
