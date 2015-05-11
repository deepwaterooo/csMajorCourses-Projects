* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  ops.c-
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
* EXPRESSION STMT
 31:    LDC  3,0(6) 	Load constant 
 32:     ST  3,-6(1) 	Save index 
 33:    LDC  3,50(6) 	Load constant 
 34:     LD  4,-6(1) 	Restore index 
 35:    LDA  5,-1(0) 	Load address of base of array y
 36:    SUB  5,5,4 	Compute offset of value 
 37:     ST  3,0(5) 	Store variable y
* EXPRESSION STMT
 38:    LDC  3,5(6) 	Load constant 
 39:     ST  3,-6(1) 	Save index 
 40:    LDC  3,1(6) 	Load constant 
 41:     LD  4,-6(1) 	Restore index 
 42:    LDA  5,-1(0) 	Load address of base of array y
 43:    SUB  5,5,4 	Compute offset of value 
 44:     ST  3,0(5) 	Store variable y
* EXPRESSION STMT
 45:    LDC  3,8(6) 	Load constant 
 46:     ST  3,-6(1) 	Save index 
 47:    LDC  3,2(6) 	Load constant 
 48:     LD  4,-6(1) 	Restore index 
 49:    LDA  5,-1(0) 	Load address of base of array y
 50:    SUB  5,5,4 	Compute offset of value 
 51:     ST  3,0(5) 	Store variable y
* EXPRESSION STMT
 52:    LDC  3,50(6) 	Load constant 
 53:     ST  3,-2(1) 	Store variable a
* EXPRESSION STMT
 54:    LDC  3,1(6) 	Load constant 
 55:     ST  3,-3(1) 	Store variable b
* EXPRESSION STMT
 56:    LDC  3,8(6) 	Load constant 
 57:     ST  3,-4(1) 	Store variable c
* EXPRESSION STMT
 58:    LDC  3,0(6) 	Load constant 
 59:     ST  3,-11(0) 	Store variable x
* EXPRESSION STMT
 60:    LDC  3,1(6) 	Load constant 
 61:     ST  3,-5(1) 	Store variable z
* EXPRESSION STMT
 62:     ST  1,-6(1) 	Store old fp in ghost frame 
 63:     LD  3,-2(1) 	Load variable a
 64:     ST  3,-8(1) 	Save left side 
 65:    LDC  3,1(6) 	Load constant 
 66:     LD  4,-8(1) 	Load left into ac1 
 67:    SUB  4,4,3 	Op <= 
 68:    LDC  3,1(6) 	True case 
 69:    JLE  4,1(7) 	Jump if true 
 70:    LDC  3,0(6) 	False case 
 71:     ST  3,-8(1) 	Store parameter 
 72:    LDA  1,-6(1) 	Load address of new frame 
 73:    LDA  3,1(7) 	Return address in ac 
 74:    LDA  7,-57(7) 	CALL outputb
 75:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 76:     ST  1,-6(1) 	Store old fp in ghost frame 
 77:     LD  3,-3(1) 	Load variable b
 78:     ST  3,-8(1) 	Save left side 
 79:    LDC  3,50(6) 	Load constant 
 80:     LD  4,-8(1) 	Load left into ac1 
 81:    SUB  4,4,3 	Op <= 
 82:    LDC  3,1(6) 	True case 
 83:    JLE  4,1(7) 	Jump if true 
 84:    LDC  3,0(6) 	False case 
 85:     ST  3,-8(1) 	Store parameter 
 86:    LDA  1,-6(1) 	Load address of new frame 
 87:    LDA  3,1(7) 	Return address in ac 
 88:    LDA  7,-71(7) 	CALL outputb
 89:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 90:     ST  1,-6(1) 	Store old fp in ghost frame 
 91:    LDC  3,50(6) 	Load constant 
 92:     ST  3,-8(1) 	Save left side 
 93:    LDC  3,50(6) 	Load constant 
 94:     LD  4,-8(1) 	Load left into ac1 
 95:    SUB  4,4,3 	Op <= 
 96:    LDC  3,1(6) 	True case 
 97:    JLE  4,1(7) 	Jump if true 
 98:    LDC  3,0(6) 	False case 
 99:     ST  3,-8(1) 	Store parameter 
100:    LDA  1,-6(1) 	Load address of new frame 
101:    LDA  3,1(7) 	Return address in ac 
102:    LDA  7,-85(7) 	CALL outputb
103:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
104:     ST  1,-6(1) 	Store old fp in ghost frame 
105:    LDA  1,-6(1) 	Load address of new frame 
106:    LDA  3,1(7) 	Return address in ac 
107:    LDA  7,-83(7) 	CALL outnl
108:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
109:     ST  1,-6(1) 	Store old fp in ghost frame 
110:    LDC  3,50(6) 	Load constant 
111:     ST  3,-8(1) 	Save left side 
112:    LDC  3,1(6) 	Load constant 
113:     LD  4,-8(1) 	Load left into ac1 
114:    SUB  4,4,3 	Op < 
115:    LDC  3,1(6) 	True case 
116:    JLT  4,1(7) 	Jump if true 
117:    LDC  3,0(6) 	False case 
118:     ST  3,-8(1) 	Store parameter 
119:    LDA  1,-6(1) 	Load address of new frame 
120:    LDA  3,1(7) 	Return address in ac 
121:    LDA  7,-104(7) 	CALL outputb
122:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
123:     ST  1,-6(1) 	Store old fp in ghost frame 
124:     LD  3,-3(1) 	Load variable b
125:     ST  3,-8(1) 	Save left side 
126:     LD  3,-2(1) 	Load variable a
127:     LD  4,-8(1) 	Load left into ac1 
128:    SUB  4,4,3 	Op < 
129:    LDC  3,1(6) 	True case 
130:    JLT  4,1(7) 	Jump if true 
131:    LDC  3,0(6) 	False case 
132:     ST  3,-8(1) 	Store parameter 
133:    LDA  1,-6(1) 	Load address of new frame 
134:    LDA  3,1(7) 	Return address in ac 
135:    LDA  7,-118(7) 	CALL outputb
136:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
137:     ST  1,-6(1) 	Store old fp in ghost frame 
138:     LD  3,-2(1) 	Load variable a
139:     ST  3,-8(1) 	Save left side 
140:     LD  3,-2(1) 	Load variable a
141:     LD  4,-8(1) 	Load left into ac1 
142:    SUB  4,4,3 	Op < 
143:    LDC  3,1(6) 	True case 
144:    JLT  4,1(7) 	Jump if true 
145:    LDC  3,0(6) 	False case 
146:     ST  3,-8(1) 	Store parameter 
147:    LDA  1,-6(1) 	Load address of new frame 
148:    LDA  3,1(7) 	Return address in ac 
149:    LDA  7,-132(7) 	CALL outputb
150:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
151:     ST  1,-6(1) 	Store old fp in ghost frame 
152:    LDA  1,-6(1) 	Load address of new frame 
153:    LDA  3,1(7) 	Return address in ac 
154:    LDA  7,-130(7) 	CALL outnl
155:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
156:     ST  1,-6(1) 	Store old fp in ghost frame 
157:    LDC  3,50(6) 	Load constant 
158:     ST  3,-8(1) 	Save left side 
159:    LDC  3,1(6) 	Load constant 
160:     LD  4,-8(1) 	Load left into ac1 
161:    SUB  4,4,3 	Op > 
162:    LDC  3,1(6) 	True case 
163:    JGT  4,1(7) 	Jump if true 
164:    LDC  3,0(6) 	False case 
165:     ST  3,-8(1) 	Store parameter 
166:    LDA  1,-6(1) 	Load address of new frame 
167:    LDA  3,1(7) 	Return address in ac 
168:    LDA  7,-151(7) 	CALL outputb
169:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
170:     ST  1,-6(1) 	Store old fp in ghost frame 
171:    LDC  3,1(6) 	Load constant 
172:     ST  3,-8(1) 	Save left side 
173:    LDC  3,50(6) 	Load constant 
174:     LD  4,-8(1) 	Load left into ac1 
175:    SUB  4,4,3 	Op > 
176:    LDC  3,1(6) 	True case 
177:    JGT  4,1(7) 	Jump if true 
178:    LDC  3,0(6) 	False case 
179:     ST  3,-8(1) 	Store parameter 
180:    LDA  1,-6(1) 	Load address of new frame 
181:    LDA  3,1(7) 	Return address in ac 
182:    LDA  7,-165(7) 	CALL outputb
183:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
184:     ST  1,-6(1) 	Store old fp in ghost frame 
185:    LDC  3,50(6) 	Load constant 
186:     ST  3,-8(1) 	Save left side 
187:    LDC  3,50(6) 	Load constant 
188:     LD  4,-8(1) 	Load left into ac1 
189:    SUB  4,4,3 	Op > 
190:    LDC  3,1(6) 	True case 
191:    JGT  4,1(7) 	Jump if true 
192:    LDC  3,0(6) 	False case 
193:     ST  3,-8(1) 	Store parameter 
194:    LDA  1,-6(1) 	Load address of new frame 
195:    LDA  3,1(7) 	Return address in ac 
196:    LDA  7,-179(7) 	CALL outputb
197:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
198:     ST  1,-6(1) 	Store old fp in ghost frame 
199:    LDA  1,-6(1) 	Load address of new frame 
200:    LDA  3,1(7) 	Return address in ac 
201:    LDA  7,-177(7) 	CALL outnl
202:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
203:     ST  1,-6(1) 	Store old fp in ghost frame 
204:    LDC  3,50(6) 	Load constant 
205:     ST  3,-8(1) 	Save left side 
206:    LDC  3,1(6) 	Load constant 
207:     LD  4,-8(1) 	Load left into ac1 
208:    SUB  4,4,3 	Op >= 
209:    LDC  3,1(6) 	True case 
210:    JGE  4,1(7) 	Jump if true 
211:    LDC  3,0(6) 	False case 
212:     ST  3,-8(1) 	Store parameter 
213:    LDA  1,-6(1) 	Load address of new frame 
214:    LDA  3,1(7) 	Return address in ac 
215:    LDA  7,-198(7) 	CALL outputb
216:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
217:     ST  1,-6(1) 	Store old fp in ghost frame 
218:    LDC  3,1(6) 	Load constant 
219:     ST  3,-8(1) 	Save left side 
220:    LDC  3,50(6) 	Load constant 
221:     LD  4,-8(1) 	Load left into ac1 
222:    SUB  4,4,3 	Op >= 
223:    LDC  3,1(6) 	True case 
224:    JGE  4,1(7) 	Jump if true 
225:    LDC  3,0(6) 	False case 
226:     ST  3,-8(1) 	Store parameter 
227:    LDA  1,-6(1) 	Load address of new frame 
228:    LDA  3,1(7) 	Return address in ac 
229:    LDA  7,-212(7) 	CALL outputb
230:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
231:     ST  1,-6(1) 	Store old fp in ghost frame 
232:    LDC  3,50(6) 	Load constant 
233:     ST  3,-8(1) 	Save left side 
234:    LDC  3,50(6) 	Load constant 
235:     LD  4,-8(1) 	Load left into ac1 
236:    SUB  4,4,3 	Op >= 
237:    LDC  3,1(6) 	True case 
238:    JGE  4,1(7) 	Jump if true 
239:    LDC  3,0(6) 	False case 
240:     ST  3,-8(1) 	Store parameter 
241:    LDA  1,-6(1) 	Load address of new frame 
242:    LDA  3,1(7) 	Return address in ac 
243:    LDA  7,-226(7) 	CALL outputb
244:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
245:     ST  1,-6(1) 	Store old fp in ghost frame 
246:    LDA  1,-6(1) 	Load address of new frame 
247:    LDA  3,1(7) 	Return address in ac 
248:    LDA  7,-224(7) 	CALL outnl
249:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
250:     ST  1,-6(1) 	Store old fp in ghost frame 
251:    LDC  3,0(6) 	Load constant 
252:    LDA  4,-1(0) 	Load address of base of array y
253:    SUB  3,4,3 	Compute offset of value 
254:     LD  3,0(3) 	Load the value 
255:     ST  3,-8(1) 	Save left side 
256:     LD  3,-3(1) 	Load variable b
257:     LD  4,-8(1) 	Load left into ac1 
258:    SUB  4,4,3 	Op == 
259:    LDC  3,1(6) 	True case 
260:    JEQ  4,1(7) 	Jump if true 
261:    LDC  3,0(6) 	False case 
262:     ST  3,-8(1) 	Store parameter 
263:    LDA  1,-6(1) 	Load address of new frame 
264:    LDA  3,1(7) 	Return address in ac 
265:    LDA  7,-248(7) 	CALL outputb
266:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
267:     ST  1,-6(1) 	Store old fp in ghost frame 
268:     LD  3,-2(1) 	Load variable a
269:     ST  3,-8(1) 	Save left side 
270:     LD  3,-3(1) 	Load variable b
271:     LD  4,-8(1) 	Load left into ac1 
272:    SUB  4,4,3 	Op == 
273:    LDC  3,1(6) 	True case 
274:    JEQ  4,1(7) 	Jump if true 
275:    LDC  3,0(6) 	False case 
276:     ST  3,-8(1) 	Store parameter 
277:    LDA  1,-6(1) 	Load address of new frame 
278:    LDA  3,1(7) 	Return address in ac 
279:    LDA  7,-262(7) 	CALL outputb
280:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
281:     ST  1,-6(1) 	Store old fp in ghost frame 
282:     LD  3,-3(1) 	Load variable b
283:     ST  3,-8(1) 	Save left side 
284:     LD  3,-3(1) 	Load variable b
285:     LD  4,-8(1) 	Load left into ac1 
286:    SUB  4,4,3 	Op == 
287:    LDC  3,1(6) 	True case 
288:    JEQ  4,1(7) 	Jump if true 
289:    LDC  3,0(6) 	False case 
290:     ST  3,-8(1) 	Store parameter 
291:    LDA  1,-6(1) 	Load address of new frame 
292:    LDA  3,1(7) 	Return address in ac 
293:    LDA  7,-276(7) 	CALL outputb
294:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
295:     ST  1,-6(1) 	Store old fp in ghost frame 
296:    LDA  1,-6(1) 	Load address of new frame 
297:    LDA  3,1(7) 	Return address in ac 
298:    LDA  7,-274(7) 	CALL outnl
299:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
300:     ST  1,-6(1) 	Store old fp in ghost frame 
301:    LDC  3,0(6) 	Load constant 
302:    LDA  4,-1(0) 	Load address of base of array y
303:    SUB  3,4,3 	Compute offset of value 
304:     LD  3,0(3) 	Load the value 
305:     ST  3,-8(1) 	Save left side 
306:     LD  3,-2(1) 	Load variable a
307:     LD  4,-8(1) 	Load left into ac1 
308:    SUB  3,4,3 	Op != 
309:    JEQ  3,1(7) 	Jump if true 
310:    LDC  3,1(6) 	True case 
311:     ST  3,-8(1) 	Store parameter 
312:    LDA  1,-6(1) 	Load address of new frame 
313:    LDA  3,1(7) 	Return address in ac 
314:    LDA  7,-297(7) 	CALL outputb
315:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
316:     ST  1,-6(1) 	Store old fp in ghost frame 
317:    LDC  3,0(6) 	Load constant 
318:    LDA  4,-1(0) 	Load address of base of array y
319:    SUB  3,4,3 	Compute offset of value 
320:     LD  3,0(3) 	Load the value 
321:     ST  3,-8(1) 	Save left side 
322:     LD  3,-3(1) 	Load variable b
323:     LD  4,-8(1) 	Load left into ac1 
324:    SUB  3,4,3 	Op != 
325:    JEQ  3,1(7) 	Jump if true 
326:    LDC  3,1(6) 	True case 
327:     ST  3,-8(1) 	Store parameter 
328:    LDA  1,-6(1) 	Load address of new frame 
329:    LDA  3,1(7) 	Return address in ac 
330:    LDA  7,-313(7) 	CALL outputb
331:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
332:     ST  1,-6(1) 	Store old fp in ghost frame 
333:     LD  3,-2(1) 	Load variable a
334:     ST  3,-8(1) 	Save left side 
335:     LD  3,-3(1) 	Load variable b
336:     LD  4,-8(1) 	Load left into ac1 
337:    SUB  3,4,3 	Op != 
338:    JEQ  3,1(7) 	Jump if true 
339:    LDC  3,1(6) 	True case 
340:     ST  3,-8(1) 	Store parameter 
341:    LDA  1,-6(1) 	Load address of new frame 
342:    LDA  3,1(7) 	Return address in ac 
343:    LDA  7,-326(7) 	CALL outputb
344:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
345:     ST  1,-6(1) 	Store old fp in ghost frame 
346:     LD  3,-3(1) 	Load variable b
347:     ST  3,-8(1) 	Save left side 
348:     LD  3,-3(1) 	Load variable b
349:     LD  4,-8(1) 	Load left into ac1 
350:    SUB  3,4,3 	Op != 
351:    JEQ  3,1(7) 	Jump if true 
352:    LDC  3,1(6) 	True case 
353:     ST  3,-8(1) 	Store parameter 
354:    LDA  1,-6(1) 	Load address of new frame 
355:    LDA  3,1(7) 	Return address in ac 
356:    LDA  7,-339(7) 	CALL outputb
357:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
358:     ST  1,-6(1) 	Store old fp in ghost frame 
359:    LDA  1,-6(1) 	Load address of new frame 
360:    LDA  3,1(7) 	Return address in ac 
361:    LDA  7,-337(7) 	CALL outnl
362:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
363:     ST  1,-6(1) 	Store old fp in ghost frame 
364:    LDC  3,1(6) 	Load constant 
365:     ST  3,-8(1) 	Save left side 
366:    LDC  3,1(6) 	Load constant 
367:     LD  4,-8(1) 	Load left into ac1 
368:    JEQ  3,1(7) 	Op AND 
369:    LDA  3,0(4) 	 
370:     ST  3,-8(1) 	Store parameter 
371:    LDA  1,-6(1) 	Load address of new frame 
372:    LDA  3,1(7) 	Return address in ac 
373:    LDA  7,-356(7) 	CALL outputb
374:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
375:     ST  1,-6(1) 	Store old fp in ghost frame 
376:    LDC  3,1(6) 	Load constant 
377:     ST  3,-8(1) 	Save left side 
378:    LDC  3,0(6) 	Load constant 
379:     LD  4,-8(1) 	Load left into ac1 
380:    JEQ  3,1(7) 	Op AND 
381:    LDA  3,0(4) 	 
382:     ST  3,-8(1) 	Store parameter 
383:    LDA  1,-6(1) 	Load address of new frame 
384:    LDA  3,1(7) 	Return address in ac 
385:    LDA  7,-368(7) 	CALL outputb
386:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
387:     ST  1,-6(1) 	Store old fp in ghost frame 
388:    LDC  3,0(6) 	Load constant 
389:     ST  3,-8(1) 	Save left side 
390:    LDC  3,1(6) 	Load constant 
391:     LD  4,-8(1) 	Load left into ac1 
392:    JEQ  3,1(7) 	Op AND 
393:    LDA  3,0(4) 	 
394:     ST  3,-8(1) 	Store parameter 
395:    LDA  1,-6(1) 	Load address of new frame 
396:    LDA  3,1(7) 	Return address in ac 
397:    LDA  7,-380(7) 	CALL outputb
398:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
399:     ST  1,-6(1) 	Store old fp in ghost frame 
400:    LDC  3,0(6) 	Load constant 
401:     ST  3,-8(1) 	Save left side 
402:    LDC  3,0(6) 	Load constant 
403:     LD  4,-8(1) 	Load left into ac1 
404:    JEQ  3,1(7) 	Op AND 
405:    LDA  3,0(4) 	 
406:     ST  3,-8(1) 	Store parameter 
407:    LDA  1,-6(1) 	Load address of new frame 
408:    LDA  3,1(7) 	Return address in ac 
409:    LDA  7,-392(7) 	CALL outputb
410:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
411:     ST  1,-6(1) 	Store old fp in ghost frame 
412:    LDA  1,-6(1) 	Load address of new frame 
413:    LDA  3,1(7) 	Return address in ac 
414:    LDA  7,-390(7) 	CALL outnl
415:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
416:     ST  1,-6(1) 	Store old fp in ghost frame 
417:    LDC  3,1(6) 	Load constant 
418:     ST  3,-8(1) 	Save left side 
419:    LDC  3,1(6) 	Load constant 
420:     LD  4,-8(1) 	Load left into ac1 
421:    JGT  3,1(7) 	Op OR 
422:    LDA  3,0(4) 	 
423:     ST  3,-8(1) 	Store parameter 
424:    LDA  1,-6(1) 	Load address of new frame 
425:    LDA  3,1(7) 	Return address in ac 
426:    LDA  7,-409(7) 	CALL outputb
427:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
428:     ST  1,-6(1) 	Store old fp in ghost frame 
429:     LD  3,-5(1) 	Load variable z
430:     ST  3,-8(1) 	Save left side 
431:    LDC  3,0(6) 	Load constant 
432:     LD  4,-8(1) 	Load left into ac1 
433:    JGT  3,1(7) 	Op OR 
434:    LDA  3,0(4) 	 
435:     ST  3,-8(1) 	Store parameter 
436:    LDA  1,-6(1) 	Load address of new frame 
437:    LDA  3,1(7) 	Return address in ac 
438:    LDA  7,-421(7) 	CALL outputb
439:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
440:     ST  1,-6(1) 	Store old fp in ghost frame 
441:    LDC  3,0(6) 	Load constant 
442:     ST  3,-8(1) 	Save left side 
443:    LDC  3,1(6) 	Load constant 
444:     LD  4,-8(1) 	Load left into ac1 
445:    JGT  3,1(7) 	Op OR 
446:    LDA  3,0(4) 	 
447:     ST  3,-8(1) 	Store parameter 
448:    LDA  1,-6(1) 	Load address of new frame 
449:    LDA  3,1(7) 	Return address in ac 
450:    LDA  7,-433(7) 	CALL outputb
451:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
452:     ST  1,-6(1) 	Store old fp in ghost frame 
453:    LDC  3,0(6) 	Load constant 
454:     ST  3,-8(1) 	Save left side 
455:    LDC  3,0(6) 	Load constant 
456:     LD  4,-8(1) 	Load left into ac1 
457:    JGT  3,1(7) 	Op OR 
458:    LDA  3,0(4) 	 
459:     ST  3,-8(1) 	Store parameter 
460:    LDA  1,-6(1) 	Load address of new frame 
461:    LDA  3,1(7) 	Return address in ac 
462:    LDA  7,-445(7) 	CALL outputb
463:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
464:     ST  1,-6(1) 	Store old fp in ghost frame 
465:    LDA  1,-6(1) 	Load address of new frame 
466:    LDA  3,1(7) 	Return address in ac 
467:    LDA  7,-443(7) 	CALL outnl
468:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
469:     ST  1,-6(1) 	Store old fp in ghost frame 
470:    LDC  3,1(6) 	Load constant 
471:    LDC  4,1(6) 	Load 1 
472:    SUB  3,4,3 	Op NOT 
473:     ST  3,-8(1) 	Store parameter 
474:    LDA  1,-6(1) 	Load address of new frame 
475:    LDA  3,1(7) 	Return address in ac 
476:    LDA  7,-459(7) 	CALL outputb
477:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
478:     ST  1,-6(1) 	Store old fp in ghost frame 
479:     LD  3,-11(0) 	Load variable x
480:    LDC  4,1(6) 	Load 1 
481:    SUB  3,4,3 	Op NOT 
482:     ST  3,-8(1) 	Store parameter 
483:    LDA  1,-6(1) 	Load address of new frame 
484:    LDA  3,1(7) 	Return address in ac 
485:    LDA  7,-468(7) 	CALL outputb
486:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
487:     ST  1,-6(1) 	Store old fp in ghost frame 
488:    LDA  1,-6(1) 	Load address of new frame 
489:    LDA  3,1(7) 	Return address in ac 
490:    LDA  7,-466(7) 	CALL outnl
491:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
492:     ST  1,-6(1) 	Store old fp in ghost frame 
493:    LDC  3,5(6) 	Load constant 
494:     ST  3,-8(1) 	Save left side 
495:    LDC  3,50(6) 	Load constant 
496:     LD  4,-8(1) 	Load left into ac1 
497:    ADD  3,4,3 	Op + 
498:     ST  3,-8(1) 	Store parameter 
499:    LDA  1,-6(1) 	Load address of new frame 
500:    LDA  3,1(7) 	Return address in ac 
501:    LDA  7,-496(7) 	CALL output
502:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
503:     ST  1,-6(1) 	Store old fp in ghost frame 
504:     LD  3,-4(1) 	Load variable c
505:    LDA  4,-1(0) 	Load address of base of array y
506:    SUB  3,4,3 	Compute offset of value 
507:     LD  3,0(3) 	Load the value 
508:     ST  3,-8(1) 	Save left side 
509:    LDC  3,50(6) 	Load constant 
510:     LD  4,-8(1) 	Load left into ac1 
511:    ADD  3,4,3 	Op + 
512:     ST  3,-8(1) 	Store parameter 
513:    LDA  1,-6(1) 	Load address of new frame 
514:    LDA  3,1(7) 	Return address in ac 
515:    LDA  7,-510(7) 	CALL output
516:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
517:     ST  1,-6(1) 	Store old fp in ghost frame 
518:    LDA  1,-6(1) 	Load address of new frame 
519:    LDA  3,1(7) 	Return address in ac 
520:    LDA  7,-496(7) 	CALL outnl
521:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
522:     ST  1,-6(1) 	Store old fp in ghost frame 
523:    LDC  3,5(6) 	Load constant 
524:     ST  3,-8(1) 	Save left side 
525:    LDC  3,50(6) 	Load constant 
526:     LD  4,-8(1) 	Load left into ac1 
527:    SUB  3,4,3 	Op - 
528:     ST  3,-8(1) 	Store parameter 
529:    LDA  1,-6(1) 	Load address of new frame 
530:    LDA  3,1(7) 	Return address in ac 
531:    LDA  7,-526(7) 	CALL output
532:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
533:     ST  1,-6(1) 	Store old fp in ghost frame 
534:    LDC  3,30(6) 	Load constant 
535:     ST  3,-8(1) 	Save left side 
536:    LDC  3,5(6) 	Load constant 
537:     LD  4,-8(1) 	Load left into ac1 
538:    SUB  3,4,3 	Op - 
539:     ST  3,-8(1) 	Save left side 
540:    LDC  3,50(6) 	Load constant 
541:     LD  4,-8(1) 	Load left into ac1 
542:    SUB  3,4,3 	Op - 
543:     ST  3,-8(1) 	Store parameter 
544:    LDA  1,-6(1) 	Load address of new frame 
545:    LDA  3,1(7) 	Return address in ac 
546:    LDA  7,-541(7) 	CALL output
547:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
548:     ST  1,-6(1) 	Store old fp in ghost frame 
549:    LDA  1,-6(1) 	Load address of new frame 
550:    LDA  3,1(7) 	Return address in ac 
551:    LDA  7,-527(7) 	CALL outnl
552:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
553:     ST  1,-6(1) 	Store old fp in ghost frame 
554:     LD  3,-2(1) 	Load variable a
555:    LDC  4,0(6) 	Load 0 
556:    SUB  3,4,3 	Op unary - 
557:     ST  3,-8(1) 	Store parameter 
558:    LDA  1,-6(1) 	Load address of new frame 
559:    LDA  3,1(7) 	Return address in ac 
560:    LDA  7,-555(7) 	CALL output
561:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
562:     ST  1,-6(1) 	Store old fp in ghost frame 
563:    LDC  3,0(6) 	Load constant 
564:    LDC  4,0(6) 	Load 0 
565:    SUB  3,4,3 	Op unary - 
566:     ST  3,-8(1) 	Store parameter 
567:    LDA  1,-6(1) 	Load address of new frame 
568:    LDA  3,1(7) 	Return address in ac 
569:    LDA  7,-564(7) 	CALL output
570:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
571:     ST  1,-6(1) 	Store old fp in ghost frame 
572:    LDC  3,1(6) 	Load constant 
573:    LDC  4,0(6) 	Load 0 
574:    SUB  3,4,3 	Op unary - 
575:     ST  3,-8(1) 	Store parameter 
576:    LDA  1,-6(1) 	Load address of new frame 
577:    LDA  3,1(7) 	Return address in ac 
578:    LDA  7,-573(7) 	CALL output
579:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
580:     ST  1,-6(1) 	Store old fp in ghost frame 
581:    LDA  1,-6(1) 	Load address of new frame 
582:    LDA  3,1(7) 	Return address in ac 
583:    LDA  7,-559(7) 	CALL outnl
584:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
585:     ST  1,-6(1) 	Store old fp in ghost frame 
586:    LDC  3,2(6) 	Load constant 
587:     ST  3,-8(1) 	Save left side 
588:    LDC  3,3(6) 	Load constant 
589:     LD  4,-8(1) 	Load left into ac1 
590:    MUL  3,4,3 	Op * 
591:     ST  3,-8(1) 	Save left side 
592:    LDC  3,5(6) 	Load constant 
593:     LD  4,-8(1) 	Load left into ac1 
594:    MUL  3,4,3 	Op * 
595:     ST  3,-8(1) 	Save left side 
596:    LDC  3,7(6) 	Load constant 
597:     LD  4,-8(1) 	Load left into ac1 
598:    MUL  3,4,3 	Op * 
599:     ST  3,-8(1) 	Save left side 
600:    LDC  3,11(6) 	Load constant 
601:     LD  4,-8(1) 	Load left into ac1 
602:    MUL  3,4,3 	Op * 
603:     ST  3,-8(1) 	Store parameter 
604:    LDA  1,-6(1) 	Load address of new frame 
605:    LDA  3,1(7) 	Return address in ac 
606:    LDA  7,-601(7) 	CALL output
607:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
608:     ST  1,-6(1) 	Store old fp in ghost frame 
609:    LDC  3,50(6) 	Load constant 
610:     ST  3,-8(1) 	Save left side 
611:    LDC  3,8(6) 	Load constant 
612:    LDA  4,-1(0) 	Load address of base of array y
613:    SUB  3,4,3 	Compute offset of value 
614:     LD  3,0(3) 	Load the value 
615:     LD  4,-8(1) 	Load left into ac1 
616:    MUL  3,4,3 	Op * 
617:     ST  3,-8(1) 	Store parameter 
618:    LDA  1,-6(1) 	Load address of new frame 
619:    LDA  3,1(7) 	Return address in ac 
620:    LDA  7,-615(7) 	CALL output
621:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
622:     ST  1,-6(1) 	Store old fp in ghost frame 
623:    LDC  3,8(6) 	Load constant 
624:    LDA  4,-1(0) 	Load address of base of array y
625:    SUB  3,4,3 	Compute offset of value 
626:     LD  3,0(3) 	Load the value 
627:     ST  3,-8(1) 	Save left side 
628:    LDC  3,50(6) 	Load constant 
629:     LD  4,-8(1) 	Load left into ac1 
630:    MUL  3,4,3 	Op * 
631:     ST  3,-8(1) 	Store parameter 
632:    LDA  1,-6(1) 	Load address of new frame 
633:    LDA  3,1(7) 	Return address in ac 
634:    LDA  7,-629(7) 	CALL output
635:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
636:     ST  1,-6(1) 	Store old fp in ghost frame 
637:    LDA  1,-6(1) 	Load address of new frame 
638:    LDA  3,1(7) 	Return address in ac 
639:    LDA  7,-615(7) 	CALL outnl
640:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
641:     ST  1,-6(1) 	Store old fp in ghost frame 
642:    LDC  3,50(6) 	Load constant 
643:     ST  3,-8(1) 	Save left side 
644:    LDC  3,8(6) 	Load constant 
645:    LDA  4,-1(0) 	Load address of base of array y
646:    SUB  3,4,3 	Compute offset of value 
647:     LD  3,0(3) 	Load the value 
648:     LD  4,-8(1) 	Load left into ac1 
649:    DIV  3,4,3 	Op / 
650:     ST  3,-8(1) 	Store parameter 
651:    LDA  1,-6(1) 	Load address of new frame 
652:    LDA  3,1(7) 	Return address in ac 
653:    LDA  7,-648(7) 	CALL output
654:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
655:     ST  1,-6(1) 	Store old fp in ghost frame 
656:    LDC  3,8(6) 	Load constant 
657:    LDA  4,-1(0) 	Load address of base of array y
658:    SUB  3,4,3 	Compute offset of value 
659:     LD  3,0(3) 	Load the value 
660:     ST  3,-8(1) 	Save left side 
661:    LDC  3,50(6) 	Load constant 
662:     LD  4,-8(1) 	Load left into ac1 
663:    DIV  3,4,3 	Op / 
664:     ST  3,-8(1) 	Store parameter 
665:    LDA  1,-6(1) 	Load address of new frame 
666:    LDA  3,1(7) 	Return address in ac 
667:    LDA  7,-662(7) 	CALL output
668:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
669:     ST  1,-6(1) 	Store old fp in ghost frame 
670:    LDC  3,8(6) 	Load constant 
671:    LDA  4,-1(0) 	Load address of base of array y
672:    SUB  3,4,3 	Compute offset of value 
673:     LD  3,0(3) 	Load the value 
674:     ST  3,-8(1) 	Save left side 
675:     LD  3,-3(1) 	Load variable b
676:     LD  4,-8(1) 	Load left into ac1 
677:    DIV  3,4,3 	Op / 
678:     ST  3,-8(1) 	Store parameter 
679:    LDA  1,-6(1) 	Load address of new frame 
680:    LDA  3,1(7) 	Return address in ac 
681:    LDA  7,-676(7) 	CALL output
682:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
683:     ST  1,-6(1) 	Store old fp in ghost frame 
684:    LDC  3,210(6) 	Load constant 
685:     ST  3,-8(1) 	Save left side 
686:    LDC  3,7(6) 	Load constant 
687:     LD  4,-8(1) 	Load left into ac1 
688:    DIV  3,4,3 	Op / 
689:     ST  3,-8(1) 	Save left side 
690:    LDC  3,3(6) 	Load constant 
691:     LD  4,-8(1) 	Load left into ac1 
692:    DIV  3,4,3 	Op / 
693:     ST  3,-8(1) 	Store parameter 
694:    LDA  1,-6(1) 	Load address of new frame 
695:    LDA  3,1(7) 	Return address in ac 
696:    LDA  7,-691(7) 	CALL output
697:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
698:     ST  1,-6(1) 	Store old fp in ghost frame 
699:    LDA  1,-6(1) 	Load address of new frame 
700:    LDA  3,1(7) 	Return address in ac 
701:    LDA  7,-677(7) 	CALL outnl
702:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
703:     ST  1,-6(1) 	Store old fp in ghost frame 
704:    LDC  3,211(6) 	Load constant 
705:     ST  3,-8(1) 	Save left side 
706:    LDC  3,7(6) 	Load constant 
707:     LD  4,-8(1) 	Load left into ac1 
708:    DIV  5,4,3 	Op % 
709:    MUL  5,5,3 	 
710:    SUB  3,4,5 	 
711:     ST  3,-8(1) 	Store parameter 
712:    LDA  1,-6(1) 	Load address of new frame 
713:    LDA  3,1(7) 	Return address in ac 
714:    LDA  7,-709(7) 	CALL output
715:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
716:     ST  1,-6(1) 	Store old fp in ghost frame 
717:    LDC  3,211(6) 	Load constant 
718:     ST  3,-8(1) 	Save left side 
719:    LDC  3,6(6) 	Load constant 
720:     LD  4,-8(1) 	Load left into ac1 
721:    DIV  5,4,3 	Op % 
722:    MUL  5,5,3 	 
723:    SUB  3,4,5 	 
724:     ST  3,-8(1) 	Store parameter 
725:    LDA  1,-6(1) 	Load address of new frame 
726:    LDA  3,1(7) 	Return address in ac 
727:    LDA  7,-722(7) 	CALL output
728:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
729:     ST  1,-6(1) 	Store old fp in ghost frame 
730:    LDC  3,211(6) 	Load constant 
731:     ST  3,-8(1) 	Save left side 
732:    LDC  3,5(6) 	Load constant 
733:     LD  4,-8(1) 	Load left into ac1 
734:    DIV  5,4,3 	Op % 
735:    MUL  5,5,3 	 
736:    SUB  3,4,5 	 
737:     ST  3,-8(1) 	Store parameter 
738:    LDA  1,-6(1) 	Load address of new frame 
739:    LDA  3,1(7) 	Return address in ac 
740:    LDA  7,-735(7) 	CALL output
741:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
742:     ST  1,-6(1) 	Store old fp in ghost frame 
743:    LDC  3,211(6) 	Load constant 
744:     ST  3,-8(1) 	Save left side 
745:    LDC  3,4(6) 	Load constant 
746:     LD  4,-8(1) 	Load left into ac1 
747:    DIV  5,4,3 	Op % 
748:    MUL  5,5,3 	 
749:    SUB  3,4,5 	 
750:     ST  3,-8(1) 	Store parameter 
751:    LDA  1,-6(1) 	Load address of new frame 
752:    LDA  3,1(7) 	Return address in ac 
753:    LDA  7,-748(7) 	CALL output
754:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
755:     ST  1,-6(1) 	Store old fp in ghost frame 
756:    LDC  3,211(6) 	Load constant 
757:     ST  3,-8(1) 	Save left side 
758:    LDC  3,100(6) 	Load constant 
759:     LD  4,-8(1) 	Load left into ac1 
760:    DIV  5,4,3 	Op % 
761:    MUL  5,5,3 	 
762:    SUB  3,4,5 	 
763:     ST  3,-8(1) 	Save left side 
764:    LDC  3,3(6) 	Load constant 
765:     LD  4,-8(1) 	Load left into ac1 
766:    DIV  5,4,3 	Op % 
767:    MUL  5,5,3 	 
768:    SUB  3,4,5 	 
769:     ST  3,-8(1) 	Store parameter 
770:    LDA  1,-6(1) 	Load address of new frame 
771:    LDA  3,1(7) 	Return address in ac 
772:    LDA  7,-767(7) 	CALL output
773:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
774:     ST  1,-6(1) 	Store old fp in ghost frame 
775:    LDA  1,-6(1) 	Load address of new frame 
776:    LDA  3,1(7) 	Return address in ac 
777:    LDA  7,-753(7) 	CALL outnl
778:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
779:     ST  1,-6(1) 	Store old fp in ghost frame 
780:    LDC  3,43(6) 	Load constant 
781:     ST  3,-4(1) 	Store variable c
782:     ST  3,-3(1) 	Store variable b
783:     ST  3,-2(1) 	Store variable a
784:     ST  3,-8(1) 	Store parameter 
785:    LDA  1,-6(1) 	Load address of new frame 
786:    LDA  3,1(7) 	Return address in ac 
787:    LDA  7,-782(7) 	CALL output
788:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
789:     ST  1,-6(1) 	Store old fp in ghost frame 
790:     LD  3,-2(1) 	Load variable a
791:     ST  3,-8(1) 	Store parameter 
792:    LDA  1,-6(1) 	Load address of new frame 
793:    LDA  3,1(7) 	Return address in ac 
794:    LDA  7,-789(7) 	CALL output
795:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
796:    LDC  3,3(6) 	Load constant 
797:     ST  3,-3(1) 	Store variable b
798:     ST  3,-6(1) 	Save left side 
799:    LDC  3,4(6) 	Load constant 
800:     ST  3,-4(1) 	Store variable c
801:     LD  4,-6(1) 	Load left into ac1 
802:    MUL  3,4,3 	Op * 
803:     ST  3,-2(1) 	Store variable a
* EXPRESSION STMT
804:     ST  1,-6(1) 	Store old fp in ghost frame 
805:     LD  3,-2(1) 	Load variable a
806:     ST  3,-8(1) 	Store parameter 
807:    LDA  1,-6(1) 	Load address of new frame 
808:    LDA  3,1(7) 	Return address in ac 
809:    LDA  7,-804(7) 	CALL output
810:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
811:     ST  1,-6(1) 	Store old fp in ghost frame 
812:    LDA  1,-6(1) 	Load address of new frame 
813:    LDA  3,1(7) 	Return address in ac 
814:    LDA  7,-790(7) 	CALL outnl
815:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
816:    LDC  3,44(6) 	Load constant 
817:     ST  3,-2(1) 	Store variable a
* EXPRESSION STMT
818:    LDC  3,2(6) 	Load constant 
819:     ST  3,-3(1) 	Store variable b
* EXPRESSION STMT
820:     ST  1,-6(1) 	Store old fp in ghost frame 
821:     LD  3,-3(1) 	Load variable b
822:     LD  4,-2(1) 	load lhs variable a
823:    ADD  3,4,3 	op += 
824:     ST  3,-2(1) 	Store variable a
825:     ST  3,-8(1) 	Store parameter 
826:    LDA  1,-6(1) 	Load address of new frame 
827:    LDA  3,1(7) 	Return address in ac 
828:    LDA  7,-823(7) 	CALL output
829:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
830:     ST  1,-6(1) 	Store old fp in ghost frame 
831:     LD  3,-3(1) 	Load variable b
832:     LD  4,-2(1) 	load lhs variable a
833:    SUB  3,4,3 	op -= 
834:     ST  3,-2(1) 	Store variable a
835:     ST  3,-8(1) 	Store parameter 
836:    LDA  1,-6(1) 	Load address of new frame 
837:    LDA  3,1(7) 	Return address in ac 
838:    LDA  7,-833(7) 	CALL output
839:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
840:     ST  1,-6(1) 	Store old fp in ghost frame 
841:     LD  3,-2(1) 	Load variable a
842:     LD  4,-2(1) 	load lhs variable a
843:    SUB  3,4,3 	op -= 
844:     ST  3,-2(1) 	Store variable a
845:     ST  3,-8(1) 	Store parameter 
846:    LDA  1,-6(1) 	Load address of new frame 
847:    LDA  3,1(7) 	Return address in ac 
848:    LDA  7,-843(7) 	CALL output
849:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
850:     ST  1,-6(1) 	Store old fp in ghost frame 
851:    LDC  3,10(6) 	Load constant 
852:     LD  4,-3(1) 	load lhs variable b
853:    ADD  3,4,3 	op += 
854:     ST  3,-3(1) 	Store variable b
855:     LD  4,-2(1) 	load lhs variable a
856:    ADD  3,4,3 	op += 
857:     ST  3,-2(1) 	Store variable a
858:     ST  3,-8(1) 	Store parameter 
859:    LDA  1,-6(1) 	Load address of new frame 
860:    LDA  3,1(7) 	Return address in ac 
861:    LDA  7,-856(7) 	CALL output
862:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
863:     ST  1,-6(1) 	Store old fp in ghost frame 
864:    LDA  1,-6(1) 	Load address of new frame 
865:    LDA  3,1(7) 	Return address in ac 
866:    LDA  7,-842(7) 	CALL outnl
867:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
868:     ST  1,-6(1) 	Store old fp in ghost frame 
869:    LDC  3,3(6) 	Load constant 
870:     ST  3,-8(1) 	Save left side 
871:    LDC  3,4(6) 	Load constant 
872:     LD  4,-8(1) 	Load left into ac1 
873:    SUB  3,4,3 	Op - 
874:     ST  3,-8(1) 	Save left side 
875:    LDC  3,5(6) 	Load constant 
876:     LD  4,-8(1) 	Load left into ac1 
877:    SUB  3,4,3 	Op - 
878:     ST  3,-8(1) 	Store parameter 
879:    LDA  1,-6(1) 	Load address of new frame 
880:    LDA  3,1(7) 	Return address in ac 
881:    LDA  7,-876(7) 	CALL output
882:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
883:     ST  1,-6(1) 	Store old fp in ghost frame 
884:    LDC  3,211(6) 	Load constant 
885:     ST  3,-8(1) 	Save left side 
886:    LDC  3,17(6) 	Load constant 
887:     LD  4,-8(1) 	Load left into ac1 
888:    DIV  3,4,3 	Op / 
889:     ST  3,-8(1) 	Save left side 
890:    LDC  3,5(6) 	Load constant 
891:     LD  4,-8(1) 	Load left into ac1 
892:    DIV  3,4,3 	Op / 
893:     ST  3,-8(1) 	Store parameter 
894:    LDA  1,-6(1) 	Load address of new frame 
895:    LDA  3,1(7) 	Return address in ac 
896:    LDA  7,-891(7) 	CALL output
897:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
898:     ST  1,-6(1) 	Store old fp in ghost frame 
899:    LDC  3,211(6) 	Load constant 
900:     ST  3,-8(1) 	Save left side 
901:    LDC  3,17(6) 	Load constant 
902:     ST  3,-9(1) 	Save left side 
903:    LDC  3,5(6) 	Load constant 
904:     LD  4,-9(1) 	Load left into ac1 
905:    DIV  3,4,3 	Op / 
906:     LD  4,-8(1) 	Load left into ac1 
907:    DIV  3,4,3 	Op / 
908:     ST  3,-8(1) 	Store parameter 
909:    LDA  1,-6(1) 	Load address of new frame 
910:    LDA  3,1(7) 	Return address in ac 
911:    LDA  7,-906(7) 	CALL output
912:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
913:     ST  1,-6(1) 	Store old fp in ghost frame 
914:    LDC  3,1(6) 	Load constant 
915:     ST  3,-8(1) 	Save left side 
916:    LDC  3,0(6) 	Load constant 
917:     LD  4,-8(1) 	Load left into ac1 
918:    JGT  3,1(7) 	Op OR 
919:    LDA  3,0(4) 	 
920:     ST  3,-8(1) 	Save left side 
921:    LDC  3,0(6) 	Load constant 
922:     LD  4,-8(1) 	Load left into ac1 
923:    JEQ  3,1(7) 	Op AND 
924:    LDA  3,0(4) 	 
925:     ST  3,-8(1) 	Store parameter 
926:    LDA  1,-6(1) 	Load address of new frame 
927:    LDA  3,1(7) 	Return address in ac 
928:    LDA  7,-911(7) 	CALL outputb
929:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
930:     ST  1,-6(1) 	Store old fp in ghost frame 
931:    LDC  3,1(6) 	Load constant 
932:     ST  3,-8(1) 	Save left side 
933:    LDC  3,0(6) 	Load constant 
934:     ST  3,-9(1) 	Save left side 
935:    LDC  3,0(6) 	Load constant 
936:     LD  4,-9(1) 	Load left into ac1 
937:    JEQ  3,1(7) 	Op AND 
938:    LDA  3,0(4) 	 
939:     LD  4,-8(1) 	Load left into ac1 
940:    JGT  3,1(7) 	Op OR 
941:    LDA  3,0(4) 	 
942:     ST  3,-8(1) 	Store parameter 
943:    LDA  1,-6(1) 	Load address of new frame 
944:    LDA  3,1(7) 	Return address in ac 
945:    LDA  7,-928(7) 	CALL outputb
946:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
947:     ST  1,-6(1) 	Store old fp in ghost frame 
948:    LDC  3,1(6) 	Load constant 
949:     ST  3,-8(1) 	Save left side 
950:    LDC  3,0(6) 	Load constant 
951:     ST  3,-9(1) 	Save left side 
952:    LDC  3,0(6) 	Load constant 
953:     LD  4,-9(1) 	Load left into ac1 
954:    JEQ  3,1(7) 	Op AND 
955:    LDA  3,0(4) 	 
956:     LD  4,-8(1) 	Load left into ac1 
957:    JGT  3,1(7) 	Op OR 
958:    LDA  3,0(4) 	 
959:     ST  3,-8(1) 	Store parameter 
960:    LDA  1,-6(1) 	Load address of new frame 
961:    LDA  3,1(7) 	Return address in ac 
962:    LDA  7,-945(7) 	CALL outputb
963:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
964:     ST  1,-6(1) 	Store old fp in ghost frame 
965:    LDA  1,-6(1) 	Load address of new frame 
966:    LDA  3,1(7) 	Return address in ac 
967:    LDA  7,-943(7) 	CALL outnl
968:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
969:    LDC  2,0(6) 	Set return value to 0 
970:     LD  3,-1(1) 	Load return address 
971:     LD  1,0(1) 	Adjust fp 
972:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,972(7) 	Jump to init 
* BEGIN Init
973:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
974:    LDC  3,10(6) 	load size of array y
975:     ST  3,0(0) 	save size of array y
* END init of global array sizes
976:    LDA  1,-12(0) 	set first frame at end of globals 
977:     ST  1,0(1) 	store old fp (point to self) 
978:    LDA  3,1(7) 	Return address in ac 
979:    LDA  7,-950(7) 	Jump to main 
980:   HALT  0,0,0 	DONE! 
* END Init
