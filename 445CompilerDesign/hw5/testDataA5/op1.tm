* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  op1.c-
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
 31:     ST  1,-2(1) 	Store old fp in ghost frame 
 32:    LDC  3,111(6) 	Load constant 
 33:     ST  3,-4(1) 	Save left side 
 34:    LDC  3,222(6) 	Load constant 
 35:     LD  4,-4(1) 	Load left into ac1 
 36:    SUB  4,4,3 	Op <= 
 37:    LDC  3,1(6) 	True case 
 38:    JLE  4,1(7) 	Jump if true 
 39:    LDC  3,0(6) 	False case 
 40:     ST  3,-4(1) 	Store parameter 
 41:    LDA  1,-2(1) 	Load address of new frame 
 42:    LDA  3,1(7) 	Return address in ac 
 43:    LDA  7,-26(7) 	CALL outputb
 44:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 45:     ST  1,-2(1) 	Store old fp in ghost frame 
 46:    LDC  3,222(6) 	Load constant 
 47:     ST  3,-4(1) 	Save left side 
 48:    LDC  3,111(6) 	Load constant 
 49:     LD  4,-4(1) 	Load left into ac1 
 50:    SUB  4,4,3 	Op <= 
 51:    LDC  3,1(6) 	True case 
 52:    JLE  4,1(7) 	Jump if true 
 53:    LDC  3,0(6) 	False case 
 54:     ST  3,-4(1) 	Store parameter 
 55:    LDA  1,-2(1) 	Load address of new frame 
 56:    LDA  3,1(7) 	Return address in ac 
 57:    LDA  7,-40(7) 	CALL outputb
 58:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 59:     ST  1,-2(1) 	Store old fp in ghost frame 
 60:    LDC  3,111(6) 	Load constant 
 61:     ST  3,-4(1) 	Save left side 
 62:    LDC  3,111(6) 	Load constant 
 63:     LD  4,-4(1) 	Load left into ac1 
 64:    SUB  4,4,3 	Op <= 
 65:    LDC  3,1(6) 	True case 
 66:    JLE  4,1(7) 	Jump if true 
 67:    LDC  3,0(6) 	False case 
 68:     ST  3,-4(1) 	Store parameter 
 69:    LDA  1,-2(1) 	Load address of new frame 
 70:    LDA  3,1(7) 	Return address in ac 
 71:    LDA  7,-54(7) 	CALL outputb
 72:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 73:     ST  1,-2(1) 	Store old fp in ghost frame 
 74:    LDA  1,-2(1) 	Load address of new frame 
 75:    LDA  3,1(7) 	Return address in ac 
 76:    LDA  7,-52(7) 	CALL outnl
 77:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 78:     ST  1,-2(1) 	Store old fp in ghost frame 
 79:    LDC  3,111(6) 	Load constant 
 80:     ST  3,-4(1) 	Save left side 
 81:    LDC  3,222(6) 	Load constant 
 82:     LD  4,-4(1) 	Load left into ac1 
 83:    SUB  4,4,3 	Op < 
 84:    LDC  3,1(6) 	True case 
 85:    JLT  4,1(7) 	Jump if true 
 86:    LDC  3,0(6) 	False case 
 87:     ST  3,-4(1) 	Store parameter 
 88:    LDA  1,-2(1) 	Load address of new frame 
 89:    LDA  3,1(7) 	Return address in ac 
 90:    LDA  7,-73(7) 	CALL outputb
 91:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 92:     ST  1,-2(1) 	Store old fp in ghost frame 
 93:    LDC  3,222(6) 	Load constant 
 94:     ST  3,-4(1) 	Save left side 
 95:    LDC  3,111(6) 	Load constant 
 96:     LD  4,-4(1) 	Load left into ac1 
 97:    SUB  4,4,3 	Op < 
 98:    LDC  3,1(6) 	True case 
 99:    JLT  4,1(7) 	Jump if true 
100:    LDC  3,0(6) 	False case 
101:     ST  3,-4(1) 	Store parameter 
102:    LDA  1,-2(1) 	Load address of new frame 
103:    LDA  3,1(7) 	Return address in ac 
104:    LDA  7,-87(7) 	CALL outputb
105:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
106:     ST  1,-2(1) 	Store old fp in ghost frame 
107:    LDC  3,111(6) 	Load constant 
108:     ST  3,-4(1) 	Save left side 
109:    LDC  3,111(6) 	Load constant 
110:     LD  4,-4(1) 	Load left into ac1 
111:    SUB  4,4,3 	Op < 
112:    LDC  3,1(6) 	True case 
113:    JLT  4,1(7) 	Jump if true 
114:    LDC  3,0(6) 	False case 
115:     ST  3,-4(1) 	Store parameter 
116:    LDA  1,-2(1) 	Load address of new frame 
117:    LDA  3,1(7) 	Return address in ac 
118:    LDA  7,-101(7) 	CALL outputb
119:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
120:     ST  1,-2(1) 	Store old fp in ghost frame 
121:    LDA  1,-2(1) 	Load address of new frame 
122:    LDA  3,1(7) 	Return address in ac 
123:    LDA  7,-99(7) 	CALL outnl
124:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
125:     ST  1,-2(1) 	Store old fp in ghost frame 
126:    LDC  3,111(6) 	Load constant 
127:     ST  3,-4(1) 	Save left side 
128:    LDC  3,222(6) 	Load constant 
129:     LD  4,-4(1) 	Load left into ac1 
130:    SUB  4,4,3 	Op > 
131:    LDC  3,1(6) 	True case 
132:    JGT  4,1(7) 	Jump if true 
133:    LDC  3,0(6) 	False case 
134:     ST  3,-4(1) 	Store parameter 
135:    LDA  1,-2(1) 	Load address of new frame 
136:    LDA  3,1(7) 	Return address in ac 
137:    LDA  7,-120(7) 	CALL outputb
138:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
139:     ST  1,-2(1) 	Store old fp in ghost frame 
140:    LDC  3,222(6) 	Load constant 
141:     ST  3,-4(1) 	Save left side 
142:    LDC  3,111(6) 	Load constant 
143:     LD  4,-4(1) 	Load left into ac1 
144:    SUB  4,4,3 	Op > 
145:    LDC  3,1(6) 	True case 
146:    JGT  4,1(7) 	Jump if true 
147:    LDC  3,0(6) 	False case 
148:     ST  3,-4(1) 	Store parameter 
149:    LDA  1,-2(1) 	Load address of new frame 
150:    LDA  3,1(7) 	Return address in ac 
151:    LDA  7,-134(7) 	CALL outputb
152:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
153:     ST  1,-2(1) 	Store old fp in ghost frame 
154:    LDC  3,111(6) 	Load constant 
155:     ST  3,-4(1) 	Save left side 
156:    LDC  3,111(6) 	Load constant 
157:     LD  4,-4(1) 	Load left into ac1 
158:    SUB  4,4,3 	Op > 
159:    LDC  3,1(6) 	True case 
160:    JGT  4,1(7) 	Jump if true 
161:    LDC  3,0(6) 	False case 
162:     ST  3,-4(1) 	Store parameter 
163:    LDA  1,-2(1) 	Load address of new frame 
164:    LDA  3,1(7) 	Return address in ac 
165:    LDA  7,-148(7) 	CALL outputb
166:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
167:     ST  1,-2(1) 	Store old fp in ghost frame 
168:    LDA  1,-2(1) 	Load address of new frame 
169:    LDA  3,1(7) 	Return address in ac 
170:    LDA  7,-146(7) 	CALL outnl
171:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
172:     ST  1,-2(1) 	Store old fp in ghost frame 
173:    LDC  3,111(6) 	Load constant 
174:     ST  3,-4(1) 	Save left side 
175:    LDC  3,222(6) 	Load constant 
176:     LD  4,-4(1) 	Load left into ac1 
177:    SUB  4,4,3 	Op >= 
178:    LDC  3,1(6) 	True case 
179:    JGE  4,1(7) 	Jump if true 
180:    LDC  3,0(6) 	False case 
181:     ST  3,-4(1) 	Store parameter 
182:    LDA  1,-2(1) 	Load address of new frame 
183:    LDA  3,1(7) 	Return address in ac 
184:    LDA  7,-167(7) 	CALL outputb
185:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
186:     ST  1,-2(1) 	Store old fp in ghost frame 
187:    LDC  3,222(6) 	Load constant 
188:     ST  3,-4(1) 	Save left side 
189:    LDC  3,111(6) 	Load constant 
190:     LD  4,-4(1) 	Load left into ac1 
191:    SUB  4,4,3 	Op >= 
192:    LDC  3,1(6) 	True case 
193:    JGE  4,1(7) 	Jump if true 
194:    LDC  3,0(6) 	False case 
195:     ST  3,-4(1) 	Store parameter 
196:    LDA  1,-2(1) 	Load address of new frame 
197:    LDA  3,1(7) 	Return address in ac 
198:    LDA  7,-181(7) 	CALL outputb
199:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
200:     ST  1,-2(1) 	Store old fp in ghost frame 
201:    LDC  3,111(6) 	Load constant 
202:     ST  3,-4(1) 	Save left side 
203:    LDC  3,111(6) 	Load constant 
204:     LD  4,-4(1) 	Load left into ac1 
205:    SUB  4,4,3 	Op >= 
206:    LDC  3,1(6) 	True case 
207:    JGE  4,1(7) 	Jump if true 
208:    LDC  3,0(6) 	False case 
209:     ST  3,-4(1) 	Store parameter 
210:    LDA  1,-2(1) 	Load address of new frame 
211:    LDA  3,1(7) 	Return address in ac 
212:    LDA  7,-195(7) 	CALL outputb
213:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
214:     ST  1,-2(1) 	Store old fp in ghost frame 
215:    LDA  1,-2(1) 	Load address of new frame 
216:    LDA  3,1(7) 	Return address in ac 
217:    LDA  7,-193(7) 	CALL outnl
218:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
219:     ST  1,-2(1) 	Store old fp in ghost frame 
220:    LDC  3,111(6) 	Load constant 
221:     ST  3,-4(1) 	Save left side 
222:    LDC  3,222(6) 	Load constant 
223:     LD  4,-4(1) 	Load left into ac1 
224:    SUB  4,4,3 	Op == 
225:    LDC  3,1(6) 	True case 
226:    JEQ  4,1(7) 	Jump if true 
227:    LDC  3,0(6) 	False case 
228:     ST  3,-4(1) 	Store parameter 
229:    LDA  1,-2(1) 	Load address of new frame 
230:    LDA  3,1(7) 	Return address in ac 
231:    LDA  7,-214(7) 	CALL outputb
232:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
233:     ST  1,-2(1) 	Store old fp in ghost frame 
234:    LDC  3,222(6) 	Load constant 
235:     ST  3,-4(1) 	Save left side 
236:    LDC  3,111(6) 	Load constant 
237:     LD  4,-4(1) 	Load left into ac1 
238:    SUB  4,4,3 	Op == 
239:    LDC  3,1(6) 	True case 
240:    JEQ  4,1(7) 	Jump if true 
241:    LDC  3,0(6) 	False case 
242:     ST  3,-4(1) 	Store parameter 
243:    LDA  1,-2(1) 	Load address of new frame 
244:    LDA  3,1(7) 	Return address in ac 
245:    LDA  7,-228(7) 	CALL outputb
246:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
247:     ST  1,-2(1) 	Store old fp in ghost frame 
248:    LDC  3,111(6) 	Load constant 
249:     ST  3,-4(1) 	Save left side 
250:    LDC  3,111(6) 	Load constant 
251:     LD  4,-4(1) 	Load left into ac1 
252:    SUB  4,4,3 	Op == 
253:    LDC  3,1(6) 	True case 
254:    JEQ  4,1(7) 	Jump if true 
255:    LDC  3,0(6) 	False case 
256:     ST  3,-4(1) 	Store parameter 
257:    LDA  1,-2(1) 	Load address of new frame 
258:    LDA  3,1(7) 	Return address in ac 
259:    LDA  7,-242(7) 	CALL outputb
260:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
261:     ST  1,-2(1) 	Store old fp in ghost frame 
262:    LDA  1,-2(1) 	Load address of new frame 
263:    LDA  3,1(7) 	Return address in ac 
264:    LDA  7,-240(7) 	CALL outnl
265:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
266:     ST  1,-2(1) 	Store old fp in ghost frame 
267:    LDC  3,111(6) 	Load constant 
268:     ST  3,-4(1) 	Save left side 
269:    LDC  3,222(6) 	Load constant 
270:     LD  4,-4(1) 	Load left into ac1 
271:    SUB  3,4,3 	Op != 
272:    JEQ  3,1(7) 	Jump if true 
273:    LDC  3,1(6) 	True case 
274:     ST  3,-4(1) 	Store parameter 
275:    LDA  1,-2(1) 	Load address of new frame 
276:    LDA  3,1(7) 	Return address in ac 
277:    LDA  7,-260(7) 	CALL outputb
278:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
279:     ST  1,-2(1) 	Store old fp in ghost frame 
280:    LDC  3,222(6) 	Load constant 
281:     ST  3,-4(1) 	Save left side 
282:    LDC  3,111(6) 	Load constant 
283:     LD  4,-4(1) 	Load left into ac1 
284:    SUB  3,4,3 	Op != 
285:    JEQ  3,1(7) 	Jump if true 
286:    LDC  3,1(6) 	True case 
287:     ST  3,-4(1) 	Store parameter 
288:    LDA  1,-2(1) 	Load address of new frame 
289:    LDA  3,1(7) 	Return address in ac 
290:    LDA  7,-273(7) 	CALL outputb
291:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
292:     ST  1,-2(1) 	Store old fp in ghost frame 
293:    LDC  3,111(6) 	Load constant 
294:     ST  3,-4(1) 	Save left side 
295:    LDC  3,111(6) 	Load constant 
296:     LD  4,-4(1) 	Load left into ac1 
297:    SUB  3,4,3 	Op != 
298:    JEQ  3,1(7) 	Jump if true 
299:    LDC  3,1(6) 	True case 
300:     ST  3,-4(1) 	Store parameter 
301:    LDA  1,-2(1) 	Load address of new frame 
302:    LDA  3,1(7) 	Return address in ac 
303:    LDA  7,-286(7) 	CALL outputb
304:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
305:     ST  1,-2(1) 	Store old fp in ghost frame 
306:    LDA  1,-2(1) 	Load address of new frame 
307:    LDA  3,1(7) 	Return address in ac 
308:    LDA  7,-284(7) 	CALL outnl
309:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
310:     ST  1,-2(1) 	Store old fp in ghost frame 
311:    LDC  3,111(6) 	Load constant 
312:     ST  3,-4(1) 	Save left side 
313:    LDC  3,222(6) 	Load constant 
314:     LD  4,-4(1) 	Load left into ac1 
315:    SUB  3,4,3 	Op != 
316:    JEQ  3,1(7) 	Jump if true 
317:    LDC  3,1(6) 	True case 
318:     ST  3,-4(1) 	Store parameter 
319:    LDA  1,-2(1) 	Load address of new frame 
320:    LDA  3,1(7) 	Return address in ac 
321:    LDA  7,-304(7) 	CALL outputb
322:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
323:     ST  1,-2(1) 	Store old fp in ghost frame 
324:    LDC  3,222(6) 	Load constant 
325:     ST  3,-4(1) 	Save left side 
326:    LDC  3,111(6) 	Load constant 
327:     LD  4,-4(1) 	Load left into ac1 
328:    SUB  3,4,3 	Op != 
329:    JEQ  3,1(7) 	Jump if true 
330:    LDC  3,1(6) 	True case 
331:     ST  3,-4(1) 	Store parameter 
332:    LDA  1,-2(1) 	Load address of new frame 
333:    LDA  3,1(7) 	Return address in ac 
334:    LDA  7,-317(7) 	CALL outputb
335:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
336:     ST  1,-2(1) 	Store old fp in ghost frame 
337:    LDC  3,111(6) 	Load constant 
338:     ST  3,-4(1) 	Save left side 
339:    LDC  3,111(6) 	Load constant 
340:     LD  4,-4(1) 	Load left into ac1 
341:    SUB  3,4,3 	Op != 
342:    JEQ  3,1(7) 	Jump if true 
343:    LDC  3,1(6) 	True case 
344:     ST  3,-4(1) 	Store parameter 
345:    LDA  1,-2(1) 	Load address of new frame 
346:    LDA  3,1(7) 	Return address in ac 
347:    LDA  7,-330(7) 	CALL outputb
348:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
349:     ST  1,-2(1) 	Store old fp in ghost frame 
350:    LDA  1,-2(1) 	Load address of new frame 
351:    LDA  3,1(7) 	Return address in ac 
352:    LDA  7,-328(7) 	CALL outnl
353:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
354:     ST  1,-2(1) 	Store old fp in ghost frame 
355:    LDC  3,0(6) 	Load constant 
356:     ST  3,-4(1) 	Save left side 
357:    LDC  3,0(6) 	Load constant 
358:     LD  4,-4(1) 	Load left into ac1 
359:    JEQ  3,1(7) 	Op AND 
360:    LDA  3,0(4) 	 
361:     ST  3,-4(1) 	Store parameter 
362:    LDA  1,-2(1) 	Load address of new frame 
363:    LDA  3,1(7) 	Return address in ac 
364:    LDA  7,-347(7) 	CALL outputb
365:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
366:     ST  1,-2(1) 	Store old fp in ghost frame 
367:    LDC  3,0(6) 	Load constant 
368:     ST  3,-4(1) 	Save left side 
369:    LDC  3,1(6) 	Load constant 
370:     LD  4,-4(1) 	Load left into ac1 
371:    JEQ  3,1(7) 	Op AND 
372:    LDA  3,0(4) 	 
373:     ST  3,-4(1) 	Store parameter 
374:    LDA  1,-2(1) 	Load address of new frame 
375:    LDA  3,1(7) 	Return address in ac 
376:    LDA  7,-359(7) 	CALL outputb
377:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
378:     ST  1,-2(1) 	Store old fp in ghost frame 
379:    LDC  3,1(6) 	Load constant 
380:     ST  3,-4(1) 	Save left side 
381:    LDC  3,0(6) 	Load constant 
382:     LD  4,-4(1) 	Load left into ac1 
383:    JEQ  3,1(7) 	Op AND 
384:    LDA  3,0(4) 	 
385:     ST  3,-4(1) 	Store parameter 
386:    LDA  1,-2(1) 	Load address of new frame 
387:    LDA  3,1(7) 	Return address in ac 
388:    LDA  7,-371(7) 	CALL outputb
389:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
390:     ST  1,-2(1) 	Store old fp in ghost frame 
391:    LDC  3,1(6) 	Load constant 
392:     ST  3,-4(1) 	Save left side 
393:    LDC  3,1(6) 	Load constant 
394:     LD  4,-4(1) 	Load left into ac1 
395:    JEQ  3,1(7) 	Op AND 
396:    LDA  3,0(4) 	 
397:     ST  3,-4(1) 	Store parameter 
398:    LDA  1,-2(1) 	Load address of new frame 
399:    LDA  3,1(7) 	Return address in ac 
400:    LDA  7,-383(7) 	CALL outputb
401:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
402:     ST  1,-2(1) 	Store old fp in ghost frame 
403:    LDA  1,-2(1) 	Load address of new frame 
404:    LDA  3,1(7) 	Return address in ac 
405:    LDA  7,-381(7) 	CALL outnl
406:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
407:     ST  1,-2(1) 	Store old fp in ghost frame 
408:    LDC  3,0(6) 	Load constant 
409:     ST  3,-4(1) 	Save left side 
410:    LDC  3,0(6) 	Load constant 
411:     LD  4,-4(1) 	Load left into ac1 
412:    JGT  3,1(7) 	Op OR 
413:    LDA  3,0(4) 	 
414:     ST  3,-4(1) 	Store parameter 
415:    LDA  1,-2(1) 	Load address of new frame 
416:    LDA  3,1(7) 	Return address in ac 
417:    LDA  7,-400(7) 	CALL outputb
418:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
419:     ST  1,-2(1) 	Store old fp in ghost frame 
420:    LDC  3,0(6) 	Load constant 
421:     ST  3,-4(1) 	Save left side 
422:    LDC  3,1(6) 	Load constant 
423:     LD  4,-4(1) 	Load left into ac1 
424:    JGT  3,1(7) 	Op OR 
425:    LDA  3,0(4) 	 
426:     ST  3,-4(1) 	Store parameter 
427:    LDA  1,-2(1) 	Load address of new frame 
428:    LDA  3,1(7) 	Return address in ac 
429:    LDA  7,-412(7) 	CALL outputb
430:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
431:     ST  1,-2(1) 	Store old fp in ghost frame 
432:    LDC  3,1(6) 	Load constant 
433:     ST  3,-4(1) 	Save left side 
434:    LDC  3,0(6) 	Load constant 
435:     LD  4,-4(1) 	Load left into ac1 
436:    JGT  3,1(7) 	Op OR 
437:    LDA  3,0(4) 	 
438:     ST  3,-4(1) 	Store parameter 
439:    LDA  1,-2(1) 	Load address of new frame 
440:    LDA  3,1(7) 	Return address in ac 
441:    LDA  7,-424(7) 	CALL outputb
442:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
443:     ST  1,-2(1) 	Store old fp in ghost frame 
444:    LDC  3,1(6) 	Load constant 
445:     ST  3,-4(1) 	Save left side 
446:    LDC  3,1(6) 	Load constant 
447:     LD  4,-4(1) 	Load left into ac1 
448:    JGT  3,1(7) 	Op OR 
449:    LDA  3,0(4) 	 
450:     ST  3,-4(1) 	Store parameter 
451:    LDA  1,-2(1) 	Load address of new frame 
452:    LDA  3,1(7) 	Return address in ac 
453:    LDA  7,-436(7) 	CALL outputb
454:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
455:     ST  1,-2(1) 	Store old fp in ghost frame 
456:    LDA  1,-2(1) 	Load address of new frame 
457:    LDA  3,1(7) 	Return address in ac 
458:    LDA  7,-434(7) 	CALL outnl
459:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
460:     ST  1,-2(1) 	Store old fp in ghost frame 
461:    LDC  3,0(6) 	Load constant 
462:    LDC  4,1(6) 	Load 1 
463:    SUB  3,4,3 	Op NOT 
464:     ST  3,-4(1) 	Store parameter 
465:    LDA  1,-2(1) 	Load address of new frame 
466:    LDA  3,1(7) 	Return address in ac 
467:    LDA  7,-450(7) 	CALL outputb
468:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
469:     ST  1,-2(1) 	Store old fp in ghost frame 
470:    LDC  3,1(6) 	Load constant 
471:    LDC  4,1(6) 	Load 1 
472:    SUB  3,4,3 	Op NOT 
473:     ST  3,-4(1) 	Store parameter 
474:    LDA  1,-2(1) 	Load address of new frame 
475:    LDA  3,1(7) 	Return address in ac 
476:    LDA  7,-459(7) 	CALL outputb
477:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
478:     ST  1,-2(1) 	Store old fp in ghost frame 
479:    LDA  1,-2(1) 	Load address of new frame 
480:    LDA  3,1(7) 	Return address in ac 
481:    LDA  7,-457(7) 	CALL outnl
482:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
483:     ST  1,-2(1) 	Store old fp in ghost frame 
484:    LDC  3,333(6) 	Load constant 
485:     ST  3,-4(1) 	Save left side 
486:    LDC  3,444(6) 	Load constant 
487:     LD  4,-4(1) 	Load left into ac1 
488:    ADD  3,4,3 	Op + 
489:     ST  3,-4(1) 	Store parameter 
490:    LDA  1,-2(1) 	Load address of new frame 
491:    LDA  3,1(7) 	Return address in ac 
492:    LDA  7,-487(7) 	CALL output
493:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
494:     ST  1,-2(1) 	Store old fp in ghost frame 
495:    LDC  3,333(6) 	Load constant 
496:     ST  3,-4(1) 	Save left side 
497:    LDC  3,444(6) 	Load constant 
498:     LD  4,-4(1) 	Load left into ac1 
499:    SUB  3,4,3 	Op - 
500:     ST  3,-4(1) 	Store parameter 
501:    LDA  1,-2(1) 	Load address of new frame 
502:    LDA  3,1(7) 	Return address in ac 
503:    LDA  7,-498(7) 	CALL output
504:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
505:     ST  1,-2(1) 	Store old fp in ghost frame 
506:    LDC  3,333(6) 	Load constant 
507:     ST  3,-4(1) 	Save left side 
508:    LDC  3,444(6) 	Load constant 
509:     LD  4,-4(1) 	Load left into ac1 
510:    MUL  3,4,3 	Op * 
511:     ST  3,-4(1) 	Store parameter 
512:    LDA  1,-2(1) 	Load address of new frame 
513:    LDA  3,1(7) 	Return address in ac 
514:    LDA  7,-509(7) 	CALL output
515:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
516:     ST  1,-2(1) 	Store old fp in ghost frame 
517:    LDC  3,333(6) 	Load constant 
518:     ST  3,-4(1) 	Save left side 
519:    LDC  3,444(6) 	Load constant 
520:     LD  4,-4(1) 	Load left into ac1 
521:    DIV  3,4,3 	Op / 
522:     ST  3,-4(1) 	Store parameter 
523:    LDA  1,-2(1) 	Load address of new frame 
524:    LDA  3,1(7) 	Return address in ac 
525:    LDA  7,-520(7) 	CALL output
526:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
527:     ST  1,-2(1) 	Store old fp in ghost frame 
528:    LDC  3,3333(6) 	Load constant 
529:     ST  3,-4(1) 	Save left side 
530:    LDC  3,444(6) 	Load constant 
531:     LD  4,-4(1) 	Load left into ac1 
532:    DIV  5,4,3 	Op % 
533:    MUL  5,5,3 	 
534:    SUB  3,4,5 	 
535:     ST  3,-4(1) 	Store parameter 
536:    LDA  1,-2(1) 	Load address of new frame 
537:    LDA  3,1(7) 	Return address in ac 
538:    LDA  7,-533(7) 	CALL output
539:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
540:     ST  1,-2(1) 	Store old fp in ghost frame 
541:    LDC  3,444(6) 	Load constant 
542:    LDC  4,0(6) 	Load 0 
543:    SUB  3,4,3 	Op unary - 
544:     ST  3,-4(1) 	Store parameter 
545:    LDA  1,-2(1) 	Load address of new frame 
546:    LDA  3,1(7) 	Return address in ac 
547:    LDA  7,-542(7) 	CALL output
548:    LDA  3,0(2) 	Save the result in ac 
* RETURN
549:    LDA  2,0(3) 	Copy result to rt register 
550:     LD  3,-1(1) 	Load return address 
551:     LD  1,0(1) 	Adjust fp 
552:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
553:    LDC  2,0(6) 	Set return value to 0 
554:     LD  3,-1(1) 	Load return address 
555:     LD  1,0(1) 	Adjust fp 
556:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,556(7) 	Jump to init 
* BEGIN Init
557:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
558:    LDA  1,0(0) 	set first frame at end of globals 
559:     ST  1,0(1) 	store old fp (point to self) 
560:    LDA  3,1(7) 	Return address in ac 
561:    LDA  7,-532(7) 	Jump to main 
562:   HALT  0,0,0 	DONE! 
* END Init
