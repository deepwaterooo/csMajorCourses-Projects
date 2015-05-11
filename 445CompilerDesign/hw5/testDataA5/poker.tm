* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  poker.c-
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
* BEGIN function suit
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* RETURN
 31:     LD  3,-2(1) 	Load variable c
 32:     ST  3,-3(1) 	Save left side 
 33:     LD  3,0(0) 	Load variable numSuits
 34:     LD  4,-3(1) 	Load left into ac1 
 35:    DIV  5,4,3 	Op % 
 36:    MUL  5,5,3 	 
 37:    SUB  3,4,5 	 
 38:    LDA  2,0(3) 	Copy result to rt register 
 39:     LD  3,-1(1) 	Load return address 
 40:     LD  1,0(1) 	Adjust fp 
 41:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 42:    LDC  2,0(6) 	Set return value to 0 
 43:     LD  3,-1(1) 	Load return address 
 44:     LD  1,0(1) 	Adjust fp 
 45:    LDA  7,0(3) 	Return 
* END of function suit
* BEGIN function pips
 46:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* RETURN
 47:     LD  3,-2(1) 	Load variable c
 48:     ST  3,-3(1) 	Save left side 
 49:     LD  3,0(0) 	Load variable numSuits
 50:     LD  4,-3(1) 	Load left into ac1 
 51:    DIV  3,4,3 	Op / 
 52:    LDA  2,0(3) 	Copy result to rt register 
 53:     LD  3,-1(1) 	Load return address 
 54:     LD  1,0(1) 	Adjust fp 
 55:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 56:    LDC  2,0(6) 	Set return value to 0 
 57:     LD  3,-1(1) 	Load return address 
 58:     LD  1,0(1) 	Adjust fp 
 59:    LDA  7,0(3) 	Return 
* END of function pips
* BEGIN function p
 60:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* RETURN
 61:     ST  1,-4(1) 	Store old fp in ghost frame 
 62:     LD  3,-2(1) 	Load variable a
 63:     ST  3,-6(1) 	Store parameter 
 64:    LDA  1,-4(1) 	Load address of new frame 
 65:    LDA  3,1(7) 	Return address in ac 
 66:    LDA  7,-21(7) 	CALL pips
 67:    LDA  3,0(2) 	Save the result in ac 
 68:     ST  3,-4(1) 	Save left side 
 69:     ST  1,-5(1) 	Store old fp in ghost frame 
 70:     LD  3,-3(1) 	Load variable b
 71:     ST  3,-7(1) 	Store parameter 
 72:    LDA  1,-5(1) 	Load address of new frame 
 73:    LDA  3,1(7) 	Return address in ac 
 74:    LDA  7,-29(7) 	CALL pips
 75:    LDA  3,0(2) 	Save the result in ac 
 76:     LD  4,-4(1) 	Load left into ac1 
 77:    SUB  4,4,3 	Op == 
 78:    LDC  3,1(6) 	True case 
 79:    JEQ  4,1(7) 	Jump if true 
 80:    LDC  3,0(6) 	False case 
 81:    LDA  2,0(3) 	Copy result to rt register 
 82:     LD  3,-1(1) 	Load return address 
 83:     LD  1,0(1) 	Adjust fp 
 84:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 85:    LDC  2,0(6) 	Set return value to 0 
 86:     LD  3,-1(1) 	Load return address 
 87:     LD  1,0(1) 	Adjust fp 
 88:    LDA  7,0(3) 	Return 
* END of function p
* BEGIN function ppp
 89:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* RETURN
 90:     ST  1,-5(1) 	Store old fp in ghost frame 
 91:     LD  3,-2(1) 	Load variable a
 92:     ST  3,-7(1) 	Store parameter 
 93:     LD  3,-3(1) 	Load variable b
 94:     ST  3,-8(1) 	Store parameter 
 95:    LDA  1,-5(1) 	Load address of new frame 
 96:    LDA  3,1(7) 	Return address in ac 
 97:    LDA  7,-38(7) 	CALL p
 98:    LDA  3,0(2) 	Save the result in ac 
 99:     ST  3,-5(1) 	Save left side 
100:     ST  1,-6(1) 	Store old fp in ghost frame 
101:     LD  3,-3(1) 	Load variable b
102:     ST  3,-8(1) 	Store parameter 
103:     LD  3,-4(1) 	Load variable c
104:     ST  3,-9(1) 	Store parameter 
105:    LDA  1,-6(1) 	Load address of new frame 
106:    LDA  3,1(7) 	Return address in ac 
107:    LDA  7,-48(7) 	CALL p
108:    LDA  3,0(2) 	Save the result in ac 
109:     LD  4,-5(1) 	Load left into ac1 
110:    JEQ  3,1(7) 	Op AND 
111:    LDA  3,0(4) 	 
112:    LDA  2,0(3) 	Copy result to rt register 
113:     LD  3,-1(1) 	Load return address 
114:     LD  1,0(1) 	Adjust fp 
115:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
116:    LDC  2,0(6) 	Set return value to 0 
117:     LD  3,-1(1) 	Load return address 
118:     LD  1,0(1) 	Adjust fp 
119:    LDA  7,0(3) 	Return 
* END of function ppp
* BEGIN function pppp
120:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* RETURN
121:     ST  1,-6(1) 	Store old fp in ghost frame 
122:     LD  3,-2(1) 	Load variable a
123:     ST  3,-8(1) 	Store parameter 
124:     LD  3,-3(1) 	Load variable b
125:     ST  3,-9(1) 	Store parameter 
126:    LDA  1,-6(1) 	Load address of new frame 
127:    LDA  3,1(7) 	Return address in ac 
128:    LDA  7,-69(7) 	CALL p
129:    LDA  3,0(2) 	Save the result in ac 
130:     ST  3,-6(1) 	Save left side 
131:     ST  1,-7(1) 	Store old fp in ghost frame 
132:     LD  3,-3(1) 	Load variable b
133:     ST  3,-9(1) 	Store parameter 
134:     LD  3,-4(1) 	Load variable c
135:     ST  3,-10(1) 	Store parameter 
136:    LDA  1,-7(1) 	Load address of new frame 
137:    LDA  3,1(7) 	Return address in ac 
138:    LDA  7,-79(7) 	CALL p
139:    LDA  3,0(2) 	Save the result in ac 
140:     LD  4,-6(1) 	Load left into ac1 
141:    JEQ  3,1(7) 	Op AND 
142:    LDA  3,0(4) 	 
143:     ST  3,-6(1) 	Save left side 
144:     ST  1,-7(1) 	Store old fp in ghost frame 
145:     LD  3,-4(1) 	Load variable c
146:     ST  3,-9(1) 	Store parameter 
147:     LD  3,-5(1) 	Load variable d
148:     ST  3,-10(1) 	Store parameter 
149:    LDA  1,-7(1) 	Load address of new frame 
150:    LDA  3,1(7) 	Return address in ac 
151:    LDA  7,-92(7) 	CALL p
152:    LDA  3,0(2) 	Save the result in ac 
153:     LD  4,-6(1) 	Load left into ac1 
154:    JEQ  3,1(7) 	Op AND 
155:    LDA  3,0(4) 	 
156:    LDA  2,0(3) 	Copy result to rt register 
157:     LD  3,-1(1) 	Load return address 
158:     LD  1,0(1) 	Adjust fp 
159:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
160:    LDC  2,0(6) 	Set return value to 0 
161:     LD  3,-1(1) 	Load return address 
162:     LD  1,0(1) 	Adjust fp 
163:    LDA  7,0(3) 	Return 
* END of function pppp
* BEGIN function handtype
164:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
165:     ST  1,-8(1) 	Store old fp in ghost frame 
166:     LD  3,-2(1) 	Load variable a
167:     ST  3,-10(1) 	Store parameter 
168:    LDA  1,-8(1) 	Load address of new frame 
169:    LDA  3,1(7) 	Return address in ac 
170:    LDA  7,-141(7) 	CALL suit
171:    LDA  3,0(2) 	Save the result in ac 
172:     ST  3,-8(1) 	Save left side 
173:     ST  1,-9(1) 	Store old fp in ghost frame 
174:     LD  3,-3(1) 	Load variable b
175:     ST  3,-11(1) 	Store parameter 
176:    LDA  1,-9(1) 	Load address of new frame 
177:    LDA  3,1(7) 	Return address in ac 
178:    LDA  7,-149(7) 	CALL suit
179:    LDA  3,0(2) 	Save the result in ac 
180:     LD  4,-8(1) 	Load left into ac1 
181:    SUB  4,4,3 	Op == 
182:    LDC  3,1(6) 	True case 
183:    JEQ  4,1(7) 	Jump if true 
184:    LDC  3,0(6) 	False case 
185:     ST  3,-8(1) 	Save left side 
186:     ST  1,-9(1) 	Store old fp in ghost frame 
187:     LD  3,-2(1) 	Load variable a
188:     ST  3,-11(1) 	Store parameter 
189:    LDA  1,-9(1) 	Load address of new frame 
190:    LDA  3,1(7) 	Return address in ac 
191:    LDA  7,-162(7) 	CALL suit
192:    LDA  3,0(2) 	Save the result in ac 
193:     ST  3,-9(1) 	Save left side 
194:     ST  1,-10(1) 	Store old fp in ghost frame 
195:     LD  3,-4(1) 	Load variable c
196:     ST  3,-12(1) 	Store parameter 
197:    LDA  1,-10(1) 	Load address of new frame 
198:    LDA  3,1(7) 	Return address in ac 
199:    LDA  7,-170(7) 	CALL suit
200:    LDA  3,0(2) 	Save the result in ac 
201:     LD  4,-9(1) 	Load left into ac1 
202:    SUB  4,4,3 	Op == 
203:    LDC  3,1(6) 	True case 
204:    JEQ  4,1(7) 	Jump if true 
205:    LDC  3,0(6) 	False case 
206:     LD  4,-8(1) 	Load left into ac1 
207:    JEQ  3,1(7) 	Op AND 
208:    LDA  3,0(4) 	 
209:     ST  3,-8(1) 	Save left side 
210:     ST  1,-9(1) 	Store old fp in ghost frame 
211:     LD  3,-2(1) 	Load variable a
212:     ST  3,-11(1) 	Store parameter 
213:    LDA  1,-9(1) 	Load address of new frame 
214:    LDA  3,1(7) 	Return address in ac 
215:    LDA  7,-186(7) 	CALL suit
216:    LDA  3,0(2) 	Save the result in ac 
217:     ST  3,-9(1) 	Save left side 
218:     ST  1,-10(1) 	Store old fp in ghost frame 
219:     LD  3,-5(1) 	Load variable d
220:     ST  3,-12(1) 	Store parameter 
221:    LDA  1,-10(1) 	Load address of new frame 
222:    LDA  3,1(7) 	Return address in ac 
223:    LDA  7,-194(7) 	CALL suit
224:    LDA  3,0(2) 	Save the result in ac 
225:     LD  4,-9(1) 	Load left into ac1 
226:    SUB  4,4,3 	Op == 
227:    LDC  3,1(6) 	True case 
228:    JEQ  4,1(7) 	Jump if true 
229:    LDC  3,0(6) 	False case 
230:     LD  4,-8(1) 	Load left into ac1 
231:    JEQ  3,1(7) 	Op AND 
232:    LDA  3,0(4) 	 
233:     ST  3,-8(1) 	Save left side 
234:     ST  1,-9(1) 	Store old fp in ghost frame 
235:     LD  3,-2(1) 	Load variable a
236:     ST  3,-11(1) 	Store parameter 
237:    LDA  1,-9(1) 	Load address of new frame 
238:    LDA  3,1(7) 	Return address in ac 
239:    LDA  7,-210(7) 	CALL suit
240:    LDA  3,0(2) 	Save the result in ac 
241:     ST  3,-9(1) 	Save left side 
242:     ST  1,-10(1) 	Store old fp in ghost frame 
243:     LD  3,-6(1) 	Load variable e
244:     ST  3,-12(1) 	Store parameter 
245:    LDA  1,-10(1) 	Load address of new frame 
246:    LDA  3,1(7) 	Return address in ac 
247:    LDA  7,-218(7) 	CALL suit
248:    LDA  3,0(2) 	Save the result in ac 
249:     LD  4,-9(1) 	Load left into ac1 
250:    SUB  4,4,3 	Op == 
251:    LDC  3,1(6) 	True case 
252:    JEQ  4,1(7) 	Jump if true 
253:    LDC  3,0(6) 	False case 
254:     LD  4,-8(1) 	Load left into ac1 
255:    JEQ  3,1(7) 	Op AND 
256:    LDA  3,0(4) 	 
257:     ST  3,-7(1) 	Store variable isflush
* IF
258:     LD  3,-7(1) 	Load variable isflush
259:     ST  3,-8(1) 	Save left side 
260:     ST  1,-9(1) 	Store old fp in ghost frame 
261:     LD  3,-2(1) 	Load variable a
262:     ST  3,-11(1) 	Store parameter 
263:    LDA  1,-9(1) 	Load address of new frame 
264:    LDA  3,1(7) 	Return address in ac 
265:    LDA  7,-220(7) 	CALL pips
266:    LDA  3,0(2) 	Save the result in ac 
267:     ST  3,-9(1) 	Save left side 
268:    LDC  3,0(6) 	Load constant 
269:     LD  4,-9(1) 	Load left into ac1 
270:    SUB  4,4,3 	Op == 
271:    LDC  3,1(6) 	True case 
272:    JEQ  4,1(7) 	Jump if true 
273:    LDC  3,0(6) 	False case 
274:     LD  4,-8(1) 	Load left into ac1 
275:    JEQ  3,1(7) 	Op AND 
276:    LDA  3,0(4) 	 
277:     ST  3,-8(1) 	Save left side 
278:     ST  1,-9(1) 	Store old fp in ghost frame 
279:     LD  3,-3(1) 	Load variable b
280:     ST  3,-11(1) 	Store parameter 
281:    LDA  1,-9(1) 	Load address of new frame 
282:    LDA  3,1(7) 	Return address in ac 
283:    LDA  7,-238(7) 	CALL pips
284:    LDA  3,0(2) 	Save the result in ac 
285:     ST  3,-9(1) 	Save left side 
286:     LD  3,-1(0) 	Load variable numPips
287:     ST  3,-10(1) 	Save left side 
288:    LDC  3,4(6) 	Load constant 
289:     LD  4,-10(1) 	Load left into ac1 
290:    SUB  3,4,3 	Op - 
291:     LD  4,-9(1) 	Load left into ac1 
292:    SUB  4,4,3 	Op == 
293:    LDC  3,1(6) 	True case 
294:    JEQ  4,1(7) 	Jump if true 
295:    LDC  3,0(6) 	False case 
296:     LD  4,-8(1) 	Load left into ac1 
297:    JEQ  3,1(7) 	Op AND 
298:    LDA  3,0(4) 	 
299:     ST  3,-8(1) 	Save left side 
300:     ST  1,-9(1) 	Store old fp in ghost frame 
301:     LD  3,-6(1) 	Load variable e
302:     ST  3,-11(1) 	Store parameter 
303:    LDA  1,-9(1) 	Load address of new frame 
304:    LDA  3,1(7) 	Return address in ac 
305:    LDA  7,-260(7) 	CALL pips
306:    LDA  3,0(2) 	Save the result in ac 
307:     ST  3,-9(1) 	Save left side 
308:     LD  3,-1(0) 	Load variable numPips
309:     ST  3,-10(1) 	Save left side 
310:    LDC  3,1(6) 	Load constant 
311:     LD  4,-10(1) 	Load left into ac1 
312:    SUB  3,4,3 	Op - 
313:     LD  4,-9(1) 	Load left into ac1 
314:    SUB  4,4,3 	Op == 
315:    LDC  3,1(6) 	True case 
316:    JEQ  4,1(7) 	Jump if true 
317:    LDC  3,0(6) 	False case 
318:     LD  4,-8(1) 	Load left into ac1 
319:    JEQ  3,1(7) 	Op AND 
320:    LDA  3,0(4) 	 
321:    JGT  3,1(7) 	Jump to then part 
* THEN
* RETURN
323:    LDC  3,0(6) 	Load constant 
324:    LDA  2,0(3) 	Copy result to rt register 
325:     LD  3,-1(1) 	Load return address 
326:     LD  1,0(1) 	Adjust fp 
327:    LDA  7,0(3) 	Return 
* ELSE
322:    LDA  7,6(7) 	Jump around the THEN 
* IF
329:     LD  3,-7(1) 	Load variable isflush
330:     ST  3,-8(1) 	Save left side 
331:     ST  1,-9(1) 	Store old fp in ghost frame 
332:     LD  3,-2(1) 	Load variable a
333:     ST  3,-11(1) 	Store parameter 
334:    LDA  1,-9(1) 	Load address of new frame 
335:    LDA  3,1(7) 	Return address in ac 
336:    LDA  7,-291(7) 	CALL pips
337:    LDA  3,0(2) 	Save the result in ac 
338:     ST  3,-9(1) 	Save left side 
339:     ST  1,-10(1) 	Store old fp in ghost frame 
340:     LD  3,-6(1) 	Load variable e
341:     ST  3,-12(1) 	Store parameter 
342:    LDA  1,-10(1) 	Load address of new frame 
343:    LDA  3,1(7) 	Return address in ac 
344:    LDA  7,-299(7) 	CALL pips
345:    LDA  3,0(2) 	Save the result in ac 
346:     ST  3,-10(1) 	Save left side 
347:    LDC  3,4(6) 	Load constant 
348:     LD  4,-10(1) 	Load left into ac1 
349:    SUB  3,4,3 	Op - 
350:     LD  4,-9(1) 	Load left into ac1 
351:    SUB  4,4,3 	Op == 
352:    LDC  3,1(6) 	True case 
353:    JEQ  4,1(7) 	Jump if true 
354:    LDC  3,0(6) 	False case 
355:     LD  4,-8(1) 	Load left into ac1 
356:    JEQ  3,1(7) 	Op AND 
357:    LDA  3,0(4) 	 
358:    JGT  3,1(7) 	Jump to then part 
* THEN
* RETURN
360:    LDC  3,1(6) 	Load constant 
361:    LDA  2,0(3) 	Copy result to rt register 
362:     LD  3,-1(1) 	Load return address 
363:     LD  1,0(1) 	Adjust fp 
364:    LDA  7,0(3) 	Return 
* ELSE
359:    LDA  7,6(7) 	Jump around the THEN 
* IF
366:     ST  1,-8(1) 	Store old fp in ghost frame 
367:     LD  3,-2(1) 	Load variable a
368:     ST  3,-10(1) 	Store parameter 
369:     LD  3,-3(1) 	Load variable b
370:     ST  3,-11(1) 	Store parameter 
371:     LD  3,-4(1) 	Load variable c
372:     ST  3,-12(1) 	Store parameter 
373:     LD  3,-5(1) 	Load variable d
374:     ST  3,-13(1) 	Store parameter 
375:    LDA  1,-8(1) 	Load address of new frame 
376:    LDA  3,1(7) 	Return address in ac 
377:    LDA  7,-258(7) 	CALL pppp
378:    LDA  3,0(2) 	Save the result in ac 
379:     ST  3,-8(1) 	Save left side 
380:     ST  1,-9(1) 	Store old fp in ghost frame 
381:     LD  3,-3(1) 	Load variable b
382:     ST  3,-11(1) 	Store parameter 
383:     LD  3,-4(1) 	Load variable c
384:     ST  3,-12(1) 	Store parameter 
385:     LD  3,-5(1) 	Load variable d
386:     ST  3,-13(1) 	Store parameter 
387:     LD  3,-6(1) 	Load variable e
388:     ST  3,-14(1) 	Store parameter 
389:    LDA  1,-9(1) 	Load address of new frame 
390:    LDA  3,1(7) 	Return address in ac 
391:    LDA  7,-272(7) 	CALL pppp
392:    LDA  3,0(2) 	Save the result in ac 
393:     LD  4,-8(1) 	Load left into ac1 
394:    JGT  3,1(7) 	Op OR 
395:    LDA  3,0(4) 	 
396:    JGT  3,1(7) 	Jump to then part 
* THEN
* RETURN
398:    LDC  3,2(6) 	Load constant 
399:    LDA  2,0(3) 	Copy result to rt register 
400:     LD  3,-1(1) 	Load return address 
401:     LD  1,0(1) 	Adjust fp 
402:    LDA  7,0(3) 	Return 
* ELSE
397:    LDA  7,6(7) 	Jump around the THEN 
* IF
404:     ST  1,-8(1) 	Store old fp in ghost frame 
405:     LD  3,-2(1) 	Load variable a
406:     ST  3,-10(1) 	Store parameter 
407:     LD  3,-3(1) 	Load variable b
408:     ST  3,-11(1) 	Store parameter 
409:     LD  3,-4(1) 	Load variable c
410:     ST  3,-12(1) 	Store parameter 
411:    LDA  1,-8(1) 	Load address of new frame 
412:    LDA  3,1(7) 	Return address in ac 
413:    LDA  7,-325(7) 	CALL ppp
414:    LDA  3,0(2) 	Save the result in ac 
415:     ST  3,-8(1) 	Save left side 
416:     ST  1,-9(1) 	Store old fp in ghost frame 
417:     LD  3,-5(1) 	Load variable d
418:     ST  3,-11(1) 	Store parameter 
419:     LD  3,-6(1) 	Load variable e
420:     ST  3,-12(1) 	Store parameter 
421:    LDA  1,-9(1) 	Load address of new frame 
422:    LDA  3,1(7) 	Return address in ac 
423:    LDA  7,-364(7) 	CALL p
424:    LDA  3,0(2) 	Save the result in ac 
425:     LD  4,-8(1) 	Load left into ac1 
426:    JEQ  3,1(7) 	Op AND 
427:    LDA  3,0(4) 	 
428:     ST  3,-8(1) 	Save left side 
429:     ST  1,-9(1) 	Store old fp in ghost frame 
430:     LD  3,-2(1) 	Load variable a
431:     ST  3,-11(1) 	Store parameter 
432:     LD  3,-3(1) 	Load variable b
433:     ST  3,-12(1) 	Store parameter 
434:    LDA  1,-9(1) 	Load address of new frame 
435:    LDA  3,1(7) 	Return address in ac 
436:    LDA  7,-377(7) 	CALL p
437:    LDA  3,0(2) 	Save the result in ac 
438:     ST  3,-9(1) 	Save left side 
439:     ST  1,-10(1) 	Store old fp in ghost frame 
440:     LD  3,-4(1) 	Load variable c
441:     ST  3,-12(1) 	Store parameter 
442:     LD  3,-5(1) 	Load variable d
443:     ST  3,-13(1) 	Store parameter 
444:     LD  3,-6(1) 	Load variable e
445:     ST  3,-14(1) 	Store parameter 
446:    LDA  1,-10(1) 	Load address of new frame 
447:    LDA  3,1(7) 	Return address in ac 
448:    LDA  7,-360(7) 	CALL ppp
449:    LDA  3,0(2) 	Save the result in ac 
450:     LD  4,-9(1) 	Load left into ac1 
451:    JEQ  3,1(7) 	Op AND 
452:    LDA  3,0(4) 	 
453:     LD  4,-8(1) 	Load left into ac1 
454:    JGT  3,1(7) 	Op OR 
455:    LDA  3,0(4) 	 
456:    JGT  3,1(7) 	Jump to then part 
* THEN
* RETURN
458:    LDC  3,3(6) 	Load constant 
459:    LDA  2,0(3) 	Copy result to rt register 
460:     LD  3,-1(1) 	Load return address 
461:     LD  1,0(1) 	Adjust fp 
462:    LDA  7,0(3) 	Return 
* ELSE
457:    LDA  7,6(7) 	Jump around the THEN 
* IF
464:     LD  3,-7(1) 	Load variable isflush
465:    JGT  3,1(7) 	Jump to then part 
* THEN
* RETURN
467:    LDC  3,4(6) 	Load constant 
468:    LDA  2,0(3) 	Copy result to rt register 
469:     LD  3,-1(1) 	Load return address 
470:     LD  1,0(1) 	Adjust fp 
471:    LDA  7,0(3) 	Return 
* ELSE
466:    LDA  7,6(7) 	Jump around the THEN 
* IF
473:     ST  1,-8(1) 	Store old fp in ghost frame 
474:     LD  3,-2(1) 	Load variable a
475:     ST  3,-10(1) 	Store parameter 
476:    LDA  1,-8(1) 	Load address of new frame 
477:    LDA  3,1(7) 	Return address in ac 
478:    LDA  7,-433(7) 	CALL pips
479:    LDA  3,0(2) 	Save the result in ac 
480:     ST  3,-8(1) 	Save left side 
481:     ST  1,-9(1) 	Store old fp in ghost frame 
482:     LD  3,-3(1) 	Load variable b
483:     ST  3,-11(1) 	Store parameter 
484:    LDA  1,-9(1) 	Load address of new frame 
485:    LDA  3,1(7) 	Return address in ac 
486:    LDA  7,-441(7) 	CALL pips
487:    LDA  3,0(2) 	Save the result in ac 
488:     ST  3,-9(1) 	Save left side 
489:    LDC  3,1(6) 	Load constant 
490:     LD  4,-9(1) 	Load left into ac1 
491:    SUB  3,4,3 	Op - 
492:     LD  4,-8(1) 	Load left into ac1 
493:    SUB  4,4,3 	Op == 
494:    LDC  3,1(6) 	True case 
495:    JEQ  4,1(7) 	Jump if true 
496:    LDC  3,0(6) 	False case 
497:     ST  3,-8(1) 	Save left side 
498:     ST  1,-9(1) 	Store old fp in ghost frame 
499:     LD  3,-3(1) 	Load variable b
500:     ST  3,-11(1) 	Store parameter 
501:    LDA  1,-9(1) 	Load address of new frame 
502:    LDA  3,1(7) 	Return address in ac 
503:    LDA  7,-458(7) 	CALL pips
504:    LDA  3,0(2) 	Save the result in ac 
505:     ST  3,-9(1) 	Save left side 
506:     ST  1,-10(1) 	Store old fp in ghost frame 
507:     LD  3,-4(1) 	Load variable c
508:     ST  3,-12(1) 	Store parameter 
509:    LDA  1,-10(1) 	Load address of new frame 
510:    LDA  3,1(7) 	Return address in ac 
511:    LDA  7,-466(7) 	CALL pips
512:    LDA  3,0(2) 	Save the result in ac 
513:     ST  3,-10(1) 	Save left side 
514:    LDC  3,1(6) 	Load constant 
515:     LD  4,-10(1) 	Load left into ac1 
516:    SUB  3,4,3 	Op - 
517:     LD  4,-9(1) 	Load left into ac1 
518:    SUB  4,4,3 	Op == 
519:    LDC  3,1(6) 	True case 
520:    JEQ  4,1(7) 	Jump if true 
521:    LDC  3,0(6) 	False case 
522:     LD  4,-8(1) 	Load left into ac1 
523:    JEQ  3,1(7) 	Op AND 
524:    LDA  3,0(4) 	 
525:     ST  3,-8(1) 	Save left side 
526:     ST  1,-9(1) 	Store old fp in ghost frame 
527:     LD  3,-4(1) 	Load variable c
528:     ST  3,-11(1) 	Store parameter 
529:    LDA  1,-9(1) 	Load address of new frame 
530:    LDA  3,1(7) 	Return address in ac 
531:    LDA  7,-486(7) 	CALL pips
532:    LDA  3,0(2) 	Save the result in ac 
533:     ST  3,-9(1) 	Save left side 
534:     ST  1,-10(1) 	Store old fp in ghost frame 
535:     LD  3,-5(1) 	Load variable d
536:     ST  3,-12(1) 	Store parameter 
537:    LDA  1,-10(1) 	Load address of new frame 
538:    LDA  3,1(7) 	Return address in ac 
539:    LDA  7,-494(7) 	CALL pips
540:    LDA  3,0(2) 	Save the result in ac 
541:     ST  3,-10(1) 	Save left side 
542:    LDC  3,1(6) 	Load constant 
543:     LD  4,-10(1) 	Load left into ac1 
544:    SUB  3,4,3 	Op - 
545:     LD  4,-9(1) 	Load left into ac1 
546:    SUB  4,4,3 	Op == 
547:    LDC  3,1(6) 	True case 
548:    JEQ  4,1(7) 	Jump if true 
549:    LDC  3,0(6) 	False case 
550:     LD  4,-8(1) 	Load left into ac1 
551:    JEQ  3,1(7) 	Op AND 
552:    LDA  3,0(4) 	 
553:     ST  3,-8(1) 	Save left side 
554:     ST  1,-9(1) 	Store old fp in ghost frame 
555:     LD  3,-5(1) 	Load variable d
556:     ST  3,-11(1) 	Store parameter 
557:    LDA  1,-9(1) 	Load address of new frame 
558:    LDA  3,1(7) 	Return address in ac 
559:    LDA  7,-514(7) 	CALL pips
560:    LDA  3,0(2) 	Save the result in ac 
561:     ST  3,-9(1) 	Save left side 
562:     ST  1,-10(1) 	Store old fp in ghost frame 
563:     LD  3,-6(1) 	Load variable e
564:     ST  3,-12(1) 	Store parameter 
565:    LDA  1,-10(1) 	Load address of new frame 
566:    LDA  3,1(7) 	Return address in ac 
567:    LDA  7,-522(7) 	CALL pips
568:    LDA  3,0(2) 	Save the result in ac 
569:     ST  3,-10(1) 	Save left side 
570:    LDC  3,1(6) 	Load constant 
571:     LD  4,-10(1) 	Load left into ac1 
572:    SUB  3,4,3 	Op - 
573:     LD  4,-9(1) 	Load left into ac1 
574:    SUB  4,4,3 	Op == 
575:    LDC  3,1(6) 	True case 
576:    JEQ  4,1(7) 	Jump if true 
577:    LDC  3,0(6) 	False case 
578:     LD  4,-8(1) 	Load left into ac1 
579:    JEQ  3,1(7) 	Op AND 
580:    LDA  3,0(4) 	 
581:     ST  3,-8(1) 	Save left side 
582:     ST  1,-9(1) 	Store old fp in ghost frame 
583:     LD  3,-2(1) 	Load variable a
584:     ST  3,-11(1) 	Store parameter 
585:    LDA  1,-9(1) 	Load address of new frame 
586:    LDA  3,1(7) 	Return address in ac 
587:    LDA  7,-542(7) 	CALL pips
588:    LDA  3,0(2) 	Save the result in ac 
589:     ST  3,-9(1) 	Save left side 
590:    LDC  3,0(6) 	Load constant 
591:     LD  4,-9(1) 	Load left into ac1 
592:    SUB  4,4,3 	Op == 
593:    LDC  3,1(6) 	True case 
594:    JEQ  4,1(7) 	Jump if true 
595:    LDC  3,0(6) 	False case 
596:     ST  3,-9(1) 	Save left side 
597:     ST  1,-10(1) 	Store old fp in ghost frame 
598:     LD  3,-3(1) 	Load variable b
599:     ST  3,-12(1) 	Store parameter 
600:    LDA  1,-10(1) 	Load address of new frame 
601:    LDA  3,1(7) 	Return address in ac 
602:    LDA  7,-557(7) 	CALL pips
603:    LDA  3,0(2) 	Save the result in ac 
604:     ST  3,-10(1) 	Save left side 
605:     LD  3,-1(0) 	Load variable numPips
606:     ST  3,-11(1) 	Save left side 
607:    LDC  3,4(6) 	Load constant 
608:     LD  4,-11(1) 	Load left into ac1 
609:    SUB  3,4,3 	Op - 
610:     LD  4,-10(1) 	Load left into ac1 
611:    SUB  4,4,3 	Op == 
612:    LDC  3,1(6) 	True case 
613:    JEQ  4,1(7) 	Jump if true 
614:    LDC  3,0(6) 	False case 
615:     LD  4,-9(1) 	Load left into ac1 
616:    JEQ  3,1(7) 	Op AND 
617:    LDA  3,0(4) 	 
618:     ST  3,-9(1) 	Save left side 
619:     ST  1,-10(1) 	Store old fp in ghost frame 
620:     LD  3,-4(1) 	Load variable c
621:     ST  3,-12(1) 	Store parameter 
622:    LDA  1,-10(1) 	Load address of new frame 
623:    LDA  3,1(7) 	Return address in ac 
624:    LDA  7,-579(7) 	CALL pips
625:    LDA  3,0(2) 	Save the result in ac 
626:     ST  3,-10(1) 	Save left side 
627:     LD  3,-1(0) 	Load variable numPips
628:     ST  3,-11(1) 	Save left side 
629:    LDC  3,3(6) 	Load constant 
630:     LD  4,-11(1) 	Load left into ac1 
631:    SUB  3,4,3 	Op - 
632:     LD  4,-10(1) 	Load left into ac1 
633:    SUB  4,4,3 	Op == 
634:    LDC  3,1(6) 	True case 
635:    JEQ  4,1(7) 	Jump if true 
636:    LDC  3,0(6) 	False case 
637:     LD  4,-9(1) 	Load left into ac1 
638:    JEQ  3,1(7) 	Op AND 
639:    LDA  3,0(4) 	 
640:     ST  3,-9(1) 	Save left side 
641:     ST  1,-10(1) 	Store old fp in ghost frame 
642:     LD  3,-5(1) 	Load variable d
643:     ST  3,-12(1) 	Store parameter 
644:    LDA  1,-10(1) 	Load address of new frame 
645:    LDA  3,1(7) 	Return address in ac 
646:    LDA  7,-601(7) 	CALL pips
647:    LDA  3,0(2) 	Save the result in ac 
648:     ST  3,-10(1) 	Save left side 
649:     LD  3,-1(0) 	Load variable numPips
650:     ST  3,-11(1) 	Save left side 
651:    LDC  3,2(6) 	Load constant 
652:     LD  4,-11(1) 	Load left into ac1 
653:    SUB  3,4,3 	Op - 
654:     LD  4,-10(1) 	Load left into ac1 
655:    SUB  4,4,3 	Op == 
656:    LDC  3,1(6) 	True case 
657:    JEQ  4,1(7) 	Jump if true 
658:    LDC  3,0(6) 	False case 
659:     LD  4,-9(1) 	Load left into ac1 
660:    JEQ  3,1(7) 	Op AND 
661:    LDA  3,0(4) 	 
662:     ST  3,-9(1) 	Save left side 
663:     ST  1,-10(1) 	Store old fp in ghost frame 
664:     LD  3,-6(1) 	Load variable e
665:     ST  3,-12(1) 	Store parameter 
666:    LDA  1,-10(1) 	Load address of new frame 
667:    LDA  3,1(7) 	Return address in ac 
668:    LDA  7,-623(7) 	CALL pips
669:    LDA  3,0(2) 	Save the result in ac 
670:     ST  3,-10(1) 	Save left side 
671:     LD  3,-1(0) 	Load variable numPips
672:     ST  3,-11(1) 	Save left side 
673:    LDC  3,1(6) 	Load constant 
674:     LD  4,-11(1) 	Load left into ac1 
675:    SUB  3,4,3 	Op - 
676:     LD  4,-10(1) 	Load left into ac1 
677:    SUB  4,4,3 	Op == 
678:    LDC  3,1(6) 	True case 
679:    JEQ  4,1(7) 	Jump if true 
680:    LDC  3,0(6) 	False case 
681:     LD  4,-9(1) 	Load left into ac1 
682:    JEQ  3,1(7) 	Op AND 
683:    LDA  3,0(4) 	 
684:     LD  4,-8(1) 	Load left into ac1 
685:    JGT  3,1(7) 	Op OR 
686:    LDA  3,0(4) 	 
687:    JGT  3,1(7) 	Jump to then part 
* THEN
* RETURN
689:    LDC  3,5(6) 	Load constant 
690:    LDA  2,0(3) 	Copy result to rt register 
691:     LD  3,-1(1) 	Load return address 
692:     LD  1,0(1) 	Adjust fp 
693:    LDA  7,0(3) 	Return 
* ELSE
688:    LDA  7,6(7) 	Jump around the THEN 
* IF
695:     ST  1,-8(1) 	Store old fp in ghost frame 
696:     LD  3,-2(1) 	Load variable a
697:     ST  3,-10(1) 	Store parameter 
698:     LD  3,-3(1) 	Load variable b
699:     ST  3,-11(1) 	Store parameter 
700:     LD  3,-4(1) 	Load variable c
701:     ST  3,-12(1) 	Store parameter 
702:    LDA  1,-8(1) 	Load address of new frame 
703:    LDA  3,1(7) 	Return address in ac 
704:    LDA  7,-616(7) 	CALL ppp
705:    LDA  3,0(2) 	Save the result in ac 
706:     ST  3,-8(1) 	Save left side 
707:     ST  1,-9(1) 	Store old fp in ghost frame 
708:     LD  3,-3(1) 	Load variable b
709:     ST  3,-11(1) 	Store parameter 
710:     LD  3,-4(1) 	Load variable c
711:     ST  3,-12(1) 	Store parameter 
712:     LD  3,-5(1) 	Load variable d
713:     ST  3,-13(1) 	Store parameter 
714:    LDA  1,-9(1) 	Load address of new frame 
715:    LDA  3,1(7) 	Return address in ac 
716:    LDA  7,-628(7) 	CALL ppp
717:    LDA  3,0(2) 	Save the result in ac 
718:     LD  4,-8(1) 	Load left into ac1 
719:    JGT  3,1(7) 	Op OR 
720:    LDA  3,0(4) 	 
721:     ST  3,-8(1) 	Save left side 
722:     ST  1,-9(1) 	Store old fp in ghost frame 
723:     LD  3,-4(1) 	Load variable c
724:     ST  3,-11(1) 	Store parameter 
725:     LD  3,-5(1) 	Load variable d
726:     ST  3,-12(1) 	Store parameter 
727:     LD  3,-6(1) 	Load variable e
728:     ST  3,-13(1) 	Store parameter 
729:    LDA  1,-9(1) 	Load address of new frame 
730:    LDA  3,1(7) 	Return address in ac 
731:    LDA  7,-643(7) 	CALL ppp
732:    LDA  3,0(2) 	Save the result in ac 
733:     LD  4,-8(1) 	Load left into ac1 
734:    JGT  3,1(7) 	Op OR 
735:    LDA  3,0(4) 	 
736:    JGT  3,1(7) 	Jump to then part 
* THEN
* RETURN
738:    LDC  3,6(6) 	Load constant 
739:    LDA  2,0(3) 	Copy result to rt register 
740:     LD  3,-1(1) 	Load return address 
741:     LD  1,0(1) 	Adjust fp 
742:    LDA  7,0(3) 	Return 
* ELSE
737:    LDA  7,6(7) 	Jump around the THEN 
* IF
744:     ST  1,-8(1) 	Store old fp in ghost frame 
745:     LD  3,-2(1) 	Load variable a
746:     ST  3,-10(1) 	Store parameter 
747:     LD  3,-3(1) 	Load variable b
748:     ST  3,-11(1) 	Store parameter 
749:    LDA  1,-8(1) 	Load address of new frame 
750:    LDA  3,1(7) 	Return address in ac 
751:    LDA  7,-692(7) 	CALL p
752:    LDA  3,0(2) 	Save the result in ac 
753:     ST  3,-8(1) 	Save left side 
754:     ST  1,-9(1) 	Store old fp in ghost frame 
755:     LD  3,-4(1) 	Load variable c
756:     ST  3,-11(1) 	Store parameter 
757:     LD  3,-5(1) 	Load variable d
758:     ST  3,-12(1) 	Store parameter 
759:    LDA  1,-9(1) 	Load address of new frame 
760:    LDA  3,1(7) 	Return address in ac 
761:    LDA  7,-702(7) 	CALL p
762:    LDA  3,0(2) 	Save the result in ac 
763:     LD  4,-8(1) 	Load left into ac1 
764:    JEQ  3,1(7) 	Op AND 
765:    LDA  3,0(4) 	 
766:     ST  3,-8(1) 	Save left side 
767:     ST  1,-9(1) 	Store old fp in ghost frame 
768:     LD  3,-2(1) 	Load variable a
769:     ST  3,-11(1) 	Store parameter 
770:     LD  3,-3(1) 	Load variable b
771:     ST  3,-12(1) 	Store parameter 
772:    LDA  1,-9(1) 	Load address of new frame 
773:    LDA  3,1(7) 	Return address in ac 
774:    LDA  7,-715(7) 	CALL p
775:    LDA  3,0(2) 	Save the result in ac 
776:     ST  3,-9(1) 	Save left side 
777:     ST  1,-10(1) 	Store old fp in ghost frame 
778:     LD  3,-5(1) 	Load variable d
779:     ST  3,-12(1) 	Store parameter 
780:     LD  3,-6(1) 	Load variable e
781:     ST  3,-13(1) 	Store parameter 
782:    LDA  1,-10(1) 	Load address of new frame 
783:    LDA  3,1(7) 	Return address in ac 
784:    LDA  7,-725(7) 	CALL p
785:    LDA  3,0(2) 	Save the result in ac 
786:     LD  4,-9(1) 	Load left into ac1 
787:    JEQ  3,1(7) 	Op AND 
788:    LDA  3,0(4) 	 
789:     LD  4,-8(1) 	Load left into ac1 
790:    JGT  3,1(7) 	Op OR 
791:    LDA  3,0(4) 	 
792:     ST  3,-8(1) 	Save left side 
793:     ST  1,-9(1) 	Store old fp in ghost frame 
794:     LD  3,-3(1) 	Load variable b
795:     ST  3,-11(1) 	Store parameter 
796:     LD  3,-4(1) 	Load variable c
797:     ST  3,-12(1) 	Store parameter 
798:    LDA  1,-9(1) 	Load address of new frame 
799:    LDA  3,1(7) 	Return address in ac 
800:    LDA  7,-741(7) 	CALL p
801:    LDA  3,0(2) 	Save the result in ac 
802:     ST  3,-9(1) 	Save left side 
803:     ST  1,-10(1) 	Store old fp in ghost frame 
804:     LD  3,-5(1) 	Load variable d
805:     ST  3,-12(1) 	Store parameter 
806:     LD  3,-6(1) 	Load variable e
807:     ST  3,-13(1) 	Store parameter 
808:    LDA  1,-10(1) 	Load address of new frame 
809:    LDA  3,1(7) 	Return address in ac 
810:    LDA  7,-751(7) 	CALL p
811:    LDA  3,0(2) 	Save the result in ac 
812:     LD  4,-9(1) 	Load left into ac1 
813:    JEQ  3,1(7) 	Op AND 
814:    LDA  3,0(4) 	 
815:     LD  4,-8(1) 	Load left into ac1 
816:    JGT  3,1(7) 	Op OR 
817:    LDA  3,0(4) 	 
818:    JGT  3,1(7) 	Jump to then part 
* THEN
* RETURN
820:    LDC  3,7(6) 	Load constant 
821:    LDA  2,0(3) 	Copy result to rt register 
822:     LD  3,-1(1) 	Load return address 
823:     LD  1,0(1) 	Adjust fp 
824:    LDA  7,0(3) 	Return 
* ELSE
819:    LDA  7,6(7) 	Jump around the THEN 
* IF
826:     ST  1,-8(1) 	Store old fp in ghost frame 
827:     LD  3,-2(1) 	Load variable a
828:     ST  3,-10(1) 	Store parameter 
829:     LD  3,-3(1) 	Load variable b
830:     ST  3,-11(1) 	Store parameter 
831:    LDA  1,-8(1) 	Load address of new frame 
832:    LDA  3,1(7) 	Return address in ac 
833:    LDA  7,-774(7) 	CALL p
834:    LDA  3,0(2) 	Save the result in ac 
835:     ST  3,-8(1) 	Save left side 
836:     ST  1,-9(1) 	Store old fp in ghost frame 
837:     LD  3,-3(1) 	Load variable b
838:     ST  3,-11(1) 	Store parameter 
839:     LD  3,-4(1) 	Load variable c
840:     ST  3,-12(1) 	Store parameter 
841:    LDA  1,-9(1) 	Load address of new frame 
842:    LDA  3,1(7) 	Return address in ac 
843:    LDA  7,-784(7) 	CALL p
844:    LDA  3,0(2) 	Save the result in ac 
845:     LD  4,-8(1) 	Load left into ac1 
846:    JGT  3,1(7) 	Op OR 
847:    LDA  3,0(4) 	 
848:     ST  3,-8(1) 	Save left side 
849:     ST  1,-9(1) 	Store old fp in ghost frame 
850:     LD  3,-4(1) 	Load variable c
851:     ST  3,-11(1) 	Store parameter 
852:     LD  3,-5(1) 	Load variable d
853:     ST  3,-12(1) 	Store parameter 
854:    LDA  1,-9(1) 	Load address of new frame 
855:    LDA  3,1(7) 	Return address in ac 
856:    LDA  7,-797(7) 	CALL p
857:    LDA  3,0(2) 	Save the result in ac 
858:     LD  4,-8(1) 	Load left into ac1 
859:    JGT  3,1(7) 	Op OR 
860:    LDA  3,0(4) 	 
861:     ST  3,-8(1) 	Save left side 
862:     ST  1,-9(1) 	Store old fp in ghost frame 
863:     LD  3,-5(1) 	Load variable d
864:     ST  3,-11(1) 	Store parameter 
865:     LD  3,-6(1) 	Load variable e
866:     ST  3,-12(1) 	Store parameter 
867:    LDA  1,-9(1) 	Load address of new frame 
868:    LDA  3,1(7) 	Return address in ac 
869:    LDA  7,-810(7) 	CALL p
870:    LDA  3,0(2) 	Save the result in ac 
871:     LD  4,-8(1) 	Load left into ac1 
872:    JGT  3,1(7) 	Op OR 
873:    LDA  3,0(4) 	 
874:    JGT  3,1(7) 	Jump to then part 
* THEN
* RETURN
876:    LDC  3,8(6) 	Load constant 
877:    LDA  2,0(3) 	Copy result to rt register 
878:     LD  3,-1(1) 	Load return address 
879:     LD  1,0(1) 	Adjust fp 
880:    LDA  7,0(3) 	Return 
* ELSE
875:    LDA  7,6(7) 	Jump around the THEN 
* RETURN
882:    LDC  3,9(6) 	Load constant 
883:    LDA  2,0(3) 	Copy result to rt register 
884:     LD  3,-1(1) 	Load return address 
885:     LD  1,0(1) 	Adjust fp 
886:    LDA  7,0(3) 	Return 
881:    LDA  7,5(7) 	Jump around the ELSE 
* ENDIF
825:    LDA  7,61(7) 	Jump around the ELSE 
* ENDIF
743:    LDA  7,143(7) 	Jump around the ELSE 
* ENDIF
694:    LDA  7,192(7) 	Jump around the ELSE 
* ENDIF
472:    LDA  7,414(7) 	Jump around the ELSE 
* ENDIF
463:    LDA  7,423(7) 	Jump around the ELSE 
* ENDIF
403:    LDA  7,483(7) 	Jump around the ELSE 
* ENDIF
365:    LDA  7,521(7) 	Jump around the ELSE 
* ENDIF
328:    LDA  7,558(7) 	Jump around the ELSE 
* ENDIF
* END compound statement
* Add standard closing in case there is no return statement
887:    LDC  2,0(6) 	Set return value to 0 
888:     LD  3,-1(1) 	Load return address 
889:     LD  1,0(1) 	Adjust fp 
890:    LDA  7,0(3) 	Return 
* END of function handtype
* BEGIN function main
891:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
892:    LDC  3,10(6) 	load size of array hands
893:     ST  3,-2(1) 	save size of array hands
* EXPRESSION STMT
894:    LDC  3,0(6) 	Load constant 
895:     ST  3,-20(1) 	Store variable i
* WHILE
896:     LD  3,-20(1) 	Load variable i
897:     ST  3,-21(1) 	Save left side 
898:    LDC  3,10(6) 	Load constant 
899:     LD  4,-21(1) 	Load left into ac1 
900:    SUB  4,4,3 	Op < 
901:    LDC  3,1(6) 	True case 
902:    JLT  4,1(7) 	Jump if true 
903:    LDC  3,0(6) 	False case 
904:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
906:     LD  3,-20(1) 	Load variable i
907:     ST  3,-21(1) 	Save index 
908:    LDC  3,0(6) 	Load constant 
909:     LD  4,-21(1) 	Restore index 
910:    LDA  5,-3(1) 	Load address of base of array hands
911:    SUB  5,5,4 	Compute offset of value 
912:     ST  3,0(5) 	Store variable hands
* EXPRESSION STMT
913:     LD  3,-20(1) 	Load variable i
914:     ST  3,-21(1) 	Save left side 
915:    LDC  3,1(6) 	Load constant 
916:     LD  4,-21(1) 	Load left into ac1 
917:    ADD  3,4,3 	Op + 
918:     ST  3,-20(1) 	Store variable i
* END compound statement
919:    LDA  7,-24(7) 	go to beginning of loop 
905:    LDA  7,14(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
920:    LDC  3,4(6) 	Load constant 
921:     ST  3,0(0) 	Store variable numSuits
* EXPRESSION STMT
922:    LDC  3,5(6) 	Load constant 
923:     ST  3,-1(0) 	Store variable numPips
* EXPRESSION STMT
924:     LD  3,-1(0) 	Load variable numPips
925:     ST  3,-21(1) 	Save left side 
926:     LD  3,0(0) 	Load variable numSuits
927:     LD  4,-21(1) 	Load left into ac1 
928:    MUL  3,4,3 	Op * 
929:     ST  3,-21(1) 	Save left side 
930:    LDC  3,1(6) 	Load constant 
931:     LD  4,-21(1) 	Load left into ac1 
932:    SUB  3,4,3 	Op - 
933:     ST  3,-2(0) 	Store variable numCards
* EXPRESSION STMT
934:    LDC  3,0(6) 	Load constant 
935:     ST  3,-19(1) 	Store variable possible
* EXPRESSION STMT
936:    LDC  3,0(6) 	Load constant 
937:     ST  3,-13(1) 	Store variable a
* WHILE
938:     LD  3,-13(1) 	Load variable a
939:     ST  3,-21(1) 	Save left side 
940:     LD  3,-2(0) 	Load variable numCards
941:     LD  4,-21(1) 	Load left into ac1 
942:    SUB  4,4,3 	Op <= 
943:    LDC  3,1(6) 	True case 
944:    JLE  4,1(7) 	Jump if true 
945:    LDC  3,0(6) 	False case 
946:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
948:     ST  1,-21(1) 	Store old fp in ghost frame 
949:     LD  3,-13(1) 	Load variable a
950:     ST  3,-23(1) 	Store parameter 
951:    LDA  1,-21(1) 	Load address of new frame 
952:    LDA  3,1(7) 	Return address in ac 
953:    LDA  7,-948(7) 	CALL output
954:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
955:     ST  1,-21(1) 	Store old fp in ghost frame 
956:    LDA  1,-21(1) 	Load address of new frame 
957:    LDA  3,1(7) 	Return address in ac 
958:    LDA  7,-934(7) 	CALL outnl
959:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
960:     LD  3,-13(1) 	Load variable a
961:     ST  3,-21(1) 	Save left side 
962:    LDC  3,1(6) 	Load constant 
963:     LD  4,-21(1) 	Load left into ac1 
964:    ADD  3,4,3 	Op + 
965:     ST  3,-14(1) 	Store variable b
* WHILE
966:     LD  3,-14(1) 	Load variable b
967:     ST  3,-21(1) 	Save left side 
968:     LD  3,-2(0) 	Load variable numCards
969:     LD  4,-21(1) 	Load left into ac1 
970:    SUB  4,4,3 	Op <= 
971:    LDC  3,1(6) 	True case 
972:    JLE  4,1(7) 	Jump if true 
973:    LDC  3,0(6) 	False case 
974:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
976:     LD  3,-14(1) 	Load variable b
977:     ST  3,-21(1) 	Save left side 
978:    LDC  3,1(6) 	Load constant 
979:     LD  4,-21(1) 	Load left into ac1 
980:    ADD  3,4,3 	Op + 
981:     ST  3,-15(1) 	Store variable c
* WHILE
982:     LD  3,-15(1) 	Load variable c
983:     ST  3,-21(1) 	Save left side 
984:     LD  3,-2(0) 	Load variable numCards
985:     LD  4,-21(1) 	Load left into ac1 
986:    SUB  4,4,3 	Op <= 
987:    LDC  3,1(6) 	True case 
988:    JLE  4,1(7) 	Jump if true 
989:    LDC  3,0(6) 	False case 
990:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
992:     LD  3,-15(1) 	Load variable c
993:     ST  3,-21(1) 	Save left side 
994:    LDC  3,1(6) 	Load constant 
995:     LD  4,-21(1) 	Load left into ac1 
996:    ADD  3,4,3 	Op + 
997:     ST  3,-16(1) 	Store variable d
* WHILE
998:     LD  3,-16(1) 	Load variable d
999:     ST  3,-21(1) 	Save left side 
1000:     LD  3,-2(0) 	Load variable numCards
1001:     LD  4,-21(1) 	Load left into ac1 
1002:    SUB  4,4,3 	Op <= 
1003:    LDC  3,1(6) 	True case 
1004:    JLE  4,1(7) 	Jump if true 
1005:    LDC  3,0(6) 	False case 
1006:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
1008:     LD  3,-16(1) 	Load variable d
1009:     ST  3,-21(1) 	Save left side 
1010:    LDC  3,1(6) 	Load constant 
1011:     LD  4,-21(1) 	Load left into ac1 
1012:    ADD  3,4,3 	Op + 
1013:     ST  3,-17(1) 	Store variable e
* WHILE
1014:     LD  3,-17(1) 	Load variable e
1015:     ST  3,-21(1) 	Save left side 
1016:     LD  3,-2(0) 	Load variable numCards
1017:     LD  4,-21(1) 	Load left into ac1 
1018:    SUB  4,4,3 	Op <= 
1019:    LDC  3,1(6) 	True case 
1020:    JLE  4,1(7) 	Jump if true 
1021:    LDC  3,0(6) 	False case 
1022:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
1024:     LD  3,-19(1) 	Load variable possible
1025:     ST  3,-21(1) 	Save left side 
1026:    LDC  3,1(6) 	Load constant 
1027:     LD  4,-21(1) 	Load left into ac1 
1028:    ADD  3,4,3 	Op + 
1029:     ST  3,-19(1) 	Store variable possible
* EXPRESSION STMT
1030:     ST  1,-21(1) 	Store old fp in ghost frame 
1031:     LD  3,-13(1) 	Load variable a
1032:     ST  3,-23(1) 	Store parameter 
1033:     LD  3,-14(1) 	Load variable b
1034:     ST  3,-24(1) 	Store parameter 
1035:     LD  3,-15(1) 	Load variable c
1036:     ST  3,-25(1) 	Store parameter 
1037:     LD  3,-16(1) 	Load variable d
1038:     ST  3,-26(1) 	Store parameter 
1039:     LD  3,-17(1) 	Load variable e
1040:     ST  3,-27(1) 	Store parameter 
1041:    LDA  1,-21(1) 	Load address of new frame 
1042:    LDA  3,1(7) 	Return address in ac 
1043:    LDA  7,-880(7) 	CALL handtype
1044:    LDA  3,0(2) 	Save the result in ac 
1045:     ST  3,-18(1) 	Store variable h
* EXPRESSION STMT
1046:     LD  3,-18(1) 	Load variable h
1047:     ST  3,-21(1) 	Save index 
1048:     LD  3,-18(1) 	Load variable h
1049:    LDA  4,-3(1) 	Load address of base of array hands
1050:    SUB  3,4,3 	Compute offset of value 
1051:     LD  3,0(3) 	Load the value 
1052:     ST  3,-22(1) 	Save left side 
1053:    LDC  3,1(6) 	Load constant 
1054:     LD  4,-22(1) 	Load left into ac1 
1055:    ADD  3,4,3 	Op + 
1056:     LD  4,-21(1) 	Restore index 
1057:    LDA  5,-3(1) 	Load address of base of array hands
1058:    SUB  5,5,4 	Compute offset of value 
1059:     ST  3,0(5) 	Store variable hands
* EXPRESSION STMT
1060:     LD  3,-17(1) 	load lhs variable e
1061:    LDA  3,1(3) 	increment value of e
1062:     ST  3,-17(1) 	Store variable e
* END compound statement
1063:    LDA  7,-50(7) 	go to beginning of loop 
1023:    LDA  7,40(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
1064:     LD  3,-16(1) 	load lhs variable d
1065:    LDA  3,1(3) 	increment value of d
1066:     ST  3,-16(1) 	Store variable d
* END compound statement
1067:    LDA  7,-70(7) 	go to beginning of loop 
1007:    LDA  7,60(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
1068:     LD  3,-15(1) 	load lhs variable c
1069:    LDA  3,1(3) 	increment value of c
1070:     ST  3,-15(1) 	Store variable c
* END compound statement
1071:    LDA  7,-90(7) 	go to beginning of loop 
991:    LDA  7,80(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
1072:     LD  3,-14(1) 	load lhs variable b
1073:    LDA  3,1(3) 	increment value of b
1074:     ST  3,-14(1) 	Store variable b
* END compound statement
1075:    LDA  7,-110(7) 	go to beginning of loop 
975:    LDA  7,100(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
1076:     LD  3,-13(1) 	load lhs variable a
1077:    LDA  3,1(3) 	increment value of a
1078:     ST  3,-13(1) 	Store variable a
* END compound statement
1079:    LDA  7,-142(7) 	go to beginning of loop 
947:    LDA  7,132(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
1080:    LDC  3,0(6) 	Load constant 
1081:     ST  3,-18(1) 	Store variable h
* WHILE
1082:     LD  3,-18(1) 	Load variable h
1083:     ST  3,-21(1) 	Save left side 
1084:    LDC  3,10(6) 	Load constant 
1085:     LD  4,-21(1) 	Load left into ac1 
1086:    SUB  4,4,3 	Op < 
1087:    LDC  3,1(6) 	True case 
1088:    JLT  4,1(7) 	Jump if true 
1089:    LDC  3,0(6) 	False case 
1090:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
1092:     ST  1,-21(1) 	Store old fp in ghost frame 
1093:     LD  3,-18(1) 	Load variable h
1094:     ST  3,-23(1) 	Store parameter 
1095:    LDA  1,-21(1) 	Load address of new frame 
1096:    LDA  3,1(7) 	Return address in ac 
1097:    LDA  7,-1092(7) 	CALL output
1098:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
1099:     ST  1,-21(1) 	Store old fp in ghost frame 
1100:     LD  3,-18(1) 	Load variable h
1101:    LDA  4,-3(1) 	Load address of base of array hands
1102:    SUB  3,4,3 	Compute offset of value 
1103:     LD  3,0(3) 	Load the value 
1104:     ST  3,-23(1) 	Store parameter 
1105:    LDA  1,-21(1) 	Load address of new frame 
1106:    LDA  3,1(7) 	Return address in ac 
1107:    LDA  7,-1102(7) 	CALL output
1108:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
1109:     ST  1,-21(1) 	Store old fp in ghost frame 
1110:    LDA  1,-21(1) 	Load address of new frame 
1111:    LDA  3,1(7) 	Return address in ac 
1112:    LDA  7,-1088(7) 	CALL outnl
1113:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
1114:     LD  3,-18(1) 	Load variable h
1115:     ST  3,-21(1) 	Save left side 
1116:    LDC  3,1(6) 	Load constant 
1117:     LD  4,-21(1) 	Load left into ac1 
1118:    ADD  3,4,3 	Op + 
1119:     ST  3,-18(1) 	Store variable h
* END compound statement
1120:    LDA  7,-39(7) 	go to beginning of loop 
1091:    LDA  7,29(7) 	No more loop 
* ENDWHILE
* RETURN
1121:    LDC  3,0(6) 	Load constant 
1122:    LDA  2,0(3) 	Copy result to rt register 
1123:     LD  3,-1(1) 	Load return address 
1124:     LD  1,0(1) 	Adjust fp 
1125:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
1126:    LDC  2,0(6) 	Set return value to 0 
1127:     LD  3,-1(1) 	Load return address 
1128:     LD  1,0(1) 	Adjust fp 
1129:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,1129(7) 	Jump to init 
* BEGIN Init
1130:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
1131:    LDA  1,-3(0) 	set first frame at end of globals 
1132:     ST  1,0(1) 	store old fp (point to self) 
1133:    LDA  3,1(7) 	Return address in ac 
1134:    LDA  7,-244(7) 	Jump to main 
1135:   HALT  0,0,0 	DONE! 
* END Init
