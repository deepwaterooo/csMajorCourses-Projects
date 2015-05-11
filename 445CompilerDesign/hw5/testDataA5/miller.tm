* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  miller.c-
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
* BEGIN function showIntArray
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 31:    LDC  3,0(6) 	Load constant 
 32:     ST  3,-4(1) 	Store variable i
* WHILE
 33:     LD  3,-4(1) 	Load variable i
 34:     ST  3,-5(1) 	Save left side 
 35:     LD  3,-3(1) 	Load variable size
 36:     LD  4,-5(1) 	Load left into ac1 
 37:    SUB  4,4,3 	Op < 
 38:    LDC  3,1(6) 	True case 
 39:    JLT  4,1(7) 	Jump if true 
 40:    LDC  3,0(6) 	False case 
 41:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 43:     ST  1,-5(1) 	Store old fp in ghost frame 
 44:     LD  3,-4(1) 	Load variable i
 45:     LD  4,-2(1) 	Load address of base of array x
 46:    SUB  3,4,3 	Compute offset of value 
 47:     LD  3,0(3) 	Load the value 
 48:     ST  3,-7(1) 	Store parameter 
 49:    LDA  1,-5(1) 	Load address of new frame 
 50:    LDA  3,1(7) 	Return address in ac 
 51:    LDA  7,-46(7) 	CALL output
 52:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 53:     LD  3,-4(1) 	Load variable i
 54:     ST  3,-5(1) 	Save left side 
 55:    LDC  3,1(6) 	Load constant 
 56:     LD  4,-5(1) 	Load left into ac1 
 57:    ADD  3,4,3 	Op + 
 58:     ST  3,-4(1) 	Store variable i
* END compound statement
 59:    LDA  7,-27(7) 	go to beginning of loop 
 42:    LDA  7,17(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
 60:     ST  1,-5(1) 	Store old fp in ghost frame 
 61:    LDA  1,-5(1) 	Load address of new frame 
 62:    LDA  3,1(7) 	Return address in ac 
 63:    LDA  7,-39(7) 	CALL outnl
 64:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 65:    LDC  2,0(6) 	Set return value to 0 
 66:     LD  3,-1(1) 	Load return address 
 67:     LD  1,0(1) 	Adjust fp 
 68:    LDA  7,0(3) 	Return 
* END of function showIntArray
* BEGIN function dog
 69:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 70:     LD  3,-2(1) 	Load variable a
 71:     ST  3,-2(1) 	Store variable a
* EXPRESSION STMT
 72:    LDC  3,7(6) 	Load constant 
 73:     ST  3,-4(1) 	Save index 
 74:    LDC  3,9(6) 	Load constant 
 75:     LD  4,-3(1) 	Load address of base of array b
 76:    SUB  3,4,3 	Compute offset of value 
 77:     LD  3,0(3) 	Load the value 
 78:     LD  4,-4(1) 	Restore index 
 79:     LD  5,-3(1) 	Load address of base of array b
 80:    SUB  5,5,4 	Compute offset of value 
 81:     ST  3,0(5) 	Store variable b
* EXPRESSION STMT
 82:     ST  1,-4(1) 	Store old fp in ghost frame 
 83:     LD  3,-2(1) 	Load variable a
 84:     ST  3,-6(1) 	Store parameter 
 85:    LDA  1,-4(1) 	Load address of new frame 
 86:    LDA  3,1(7) 	Return address in ac 
 87:    LDA  7,-82(7) 	CALL output
 88:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 89:     ST  1,-4(1) 	Store old fp in ghost frame 
 90:    LDA  1,-4(1) 	Load address of new frame 
 91:    LDA  3,1(7) 	Return address in ac 
 92:    LDA  7,-68(7) 	CALL outnl
 93:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 94:     ST  1,-4(1) 	Store old fp in ghost frame 
 95:    LDC  3,7(6) 	Load constant 
 96:     LD  4,-3(1) 	Load address of base of array b
 97:    SUB  3,4,3 	Compute offset of value 
 98:     LD  3,0(3) 	Load the value 
 99:     ST  3,-6(1) 	Store parameter 
100:    LDA  1,-4(1) 	Load address of new frame 
101:    LDA  3,1(7) 	Return address in ac 
102:    LDA  7,-97(7) 	CALL output
103:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
104:     ST  1,-4(1) 	Store old fp in ghost frame 
105:    LDA  1,-4(1) 	Load address of new frame 
106:    LDA  3,1(7) 	Return address in ac 
107:    LDA  7,-83(7) 	CALL outnl
108:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
109:     ST  1,-4(1) 	Store old fp in ghost frame 
110:    LDA  1,-4(1) 	Load address of new frame 
111:    LDA  3,1(7) 	Return address in ac 
112:    LDA  7,-88(7) 	CALL outnl
113:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
114:    LDC  2,0(6) 	Set return value to 0 
115:     LD  3,-1(1) 	Load return address 
116:     LD  1,0(1) 	Adjust fp 
117:    LDA  7,0(3) 	Return 
* END of function dog
* BEGIN function getnxtindex
118:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* RETURN
119:     LD  3,-2(1) 	Load variable x
120:     ST  3,-3(1) 	Save left side 
121:    LDC  3,1(6) 	Load constant 
122:     LD  4,-3(1) 	Load left into ac1 
123:    ADD  3,4,3 	Op + 
124:    LDA  2,0(3) 	Copy result to rt register 
125:     LD  3,-1(1) 	Load return address 
126:     LD  1,0(1) 	Adjust fp 
127:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
128:    LDC  2,0(6) 	Set return value to 0 
129:     LD  3,-1(1) 	Load return address 
130:     LD  1,0(1) 	Adjust fp 
131:    LDA  7,0(3) 	Return 
* END of function getnxtindex
* BEGIN function main
132:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
133:    LDC  3,10(6) 	load size of array c
134:     ST  3,-3(1) 	save size of array c
135:    LDC  3,10(6) 	load size of array d
136:     ST  3,-14(1) 	save size of array d
137:    LDC  3,10(6) 	load size of array y
138:     ST  3,-25(1) 	save size of array y
139:    LDC  3,10(6) 	load size of array z
140:     ST  3,-36(1) 	save size of array z
141:    LDC  3,10(6) 	load size of array w
142:     ST  3,-47(1) 	save size of array w
* EXPRESSION STMT
143:    LDC  3,0(6) 	Load constant 
144:     ST  3,-60(1) 	Save index 
145:    LDC  3,3(6) 	Load constant 
146:     LD  4,-60(1) 	Restore index 
147:    LDA  5,-4(1) 	Load address of base of array c
148:    SUB  5,5,4 	Compute offset of value 
149:     ST  3,0(5) 	Store variable c
* EXPRESSION STMT
150:    LDC  3,3(6) 	Load constant 
151:     ST  3,-60(1) 	Save index 
152:    LDC  3,5(6) 	Load constant 
153:     LD  4,-60(1) 	Restore index 
154:    LDA  5,-15(1) 	Load address of base of array d
155:    SUB  5,5,4 	Compute offset of value 
156:     ST  3,0(5) 	Store variable d
* EXPRESSION STMT
157:    LDC  3,4(6) 	Load constant 
158:     ST  3,-60(1) 	Save index 
159:    LDC  3,9(6) 	Load constant 
160:     LD  4,-60(1) 	Restore index 
161:    LDA  5,-15(1) 	Load address of base of array d
162:    SUB  5,5,4 	Compute offset of value 
163:     ST  3,0(5) 	Store variable d
* EXPRESSION STMT
164:    LDC  3,5(6) 	Load constant 
165:     ST  3,-60(1) 	Save index 
166:    LDC  3,100(6) 	Load constant 
167:     LD  4,-60(1) 	Restore index 
168:    LDA  5,-26(1) 	Load address of base of array y
169:    SUB  5,5,4 	Compute offset of value 
170:     ST  3,0(5) 	Store variable y
* EXPRESSION STMT
171:    LDC  3,9(6) 	Load constant 
172:     ST  3,-60(1) 	Save index 
173:    LDC  3,50(6) 	Load constant 
174:     LD  4,-60(1) 	Restore index 
175:    LDA  5,-48(1) 	Load address of base of array w
176:    SUB  5,5,4 	Compute offset of value 
177:     ST  3,0(5) 	Store variable w
* EXPRESSION STMT
178:     ST  1,-60(1) 	Store old fp in ghost frame 
179:    LDC  3,5(6) 	Load constant 
180:    LDA  4,-26(1) 	Load address of base of array y
181:    SUB  3,4,3 	Compute offset of value 
182:     LD  3,0(3) 	Load the value 
183:     ST  3,-62(1) 	Store parameter 
184:    LDA  3,-48(1) 	Load address of base of array w
185:     ST  3,-63(1) 	Store parameter 
186:    LDA  1,-60(1) 	Load address of new frame 
187:    LDA  3,1(7) 	Return address in ac 
188:    LDA  7,-120(7) 	CALL dog
189:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
190:    LDC  3,9(6) 	Load constant 
191:     ST  3,-60(1) 	Save index 
192:    LDC  3,12(6) 	Load constant 
193:     LD  4,-60(1) 	Restore index 
194:    LDA  5,-48(1) 	Load address of base of array w
195:    SUB  5,5,4 	Compute offset of value 
196:     ST  3,0(5) 	Store variable w
* EXPRESSION STMT
197:     ST  1,-60(1) 	Store old fp in ghost frame 
198:    LDC  3,3(6) 	Load constant 
199:    LDA  4,-15(1) 	Load address of base of array d
200:    SUB  3,4,3 	Compute offset of value 
201:     LD  3,0(3) 	Load the value 
202:    LDA  4,-26(1) 	Load address of base of array y
203:    SUB  3,4,3 	Compute offset of value 
204:     LD  3,0(3) 	Load the value 
205:     ST  3,-62(1) 	Store parameter 
206:    LDA  3,-48(1) 	Load address of base of array w
207:     ST  3,-63(1) 	Store parameter 
208:    LDA  1,-60(1) 	Load address of new frame 
209:    LDA  3,1(7) 	Return address in ac 
210:    LDA  7,-142(7) 	CALL dog
211:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
212:    LDC  3,8(6) 	Load constant 
213:     ST  3,-60(1) 	Save index 
214:    LDC  3,4(6) 	Load constant 
215:     LD  4,-60(1) 	Restore index 
216:    LDA  5,-4(1) 	Load address of base of array c
217:    SUB  5,5,4 	Compute offset of value 
218:     ST  3,0(5) 	Store variable c
* EXPRESSION STMT
219:    LDC  3,9(6) 	Load constant 
220:     ST  3,-60(1) 	Save index 
221:    LDC  3,25(6) 	Load constant 
222:     LD  4,-60(1) 	Restore index 
223:    LDA  5,-4(1) 	Load address of base of array c
224:    SUB  5,5,4 	Compute offset of value 
225:     ST  3,0(5) 	Store variable c
* EXPRESSION STMT
226:    LDC  3,9(6) 	Load constant 
227:     ST  3,-60(1) 	Save index 
228:    LDC  3,66(6) 	Load constant 
229:     LD  4,-60(1) 	Restore index 
230:    LDA  5,-26(1) 	Load address of base of array y
231:    SUB  5,5,4 	Compute offset of value 
232:     ST  3,0(5) 	Store variable y
* EXPRESSION STMT
233:     ST  1,-60(1) 	Store old fp in ghost frame 
234:    LDC  3,8(6) 	Load constant 
235:    LDA  4,-4(1) 	Load address of base of array c
236:    SUB  3,4,3 	Compute offset of value 
237:     LD  3,0(3) 	Load the value 
238:    LDA  4,-15(1) 	Load address of base of array d
239:    SUB  3,4,3 	Compute offset of value 
240:     LD  3,0(3) 	Load the value 
241:    LDA  4,-26(1) 	Load address of base of array y
242:    SUB  3,4,3 	Compute offset of value 
243:     LD  3,0(3) 	Load the value 
244:     ST  3,-62(1) 	Store parameter 
245:    LDA  3,-4(1) 	Load address of base of array c
246:     ST  3,-63(1) 	Store parameter 
247:    LDA  1,-60(1) 	Load address of new frame 
248:    LDA  3,1(7) 	Return address in ac 
249:    LDA  7,-181(7) 	CALL dog
250:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
251:    LDC  3,777(6) 	Load constant 
252:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
253:    LDC  3,7(6) 	Load constant 
254:     ST  3,-60(1) 	Save index 
255:    LDC  3,123(6) 	Load constant 
256:     LD  4,-60(1) 	Restore index 
257:    LDA  5,-26(1) 	Load address of base of array y
258:    SUB  5,5,4 	Compute offset of value 
259:     ST  3,0(5) 	Store variable y
* EXPRESSION STMT
260:    LDC  3,9(6) 	Load constant 
261:     ST  3,-60(1) 	Save index 
262:    LDC  3,7(6) 	Load constant 
263:    LDA  4,-26(1) 	Load address of base of array y
264:    SUB  3,4,3 	Compute offset of value 
265:     LD  3,0(3) 	Load the value 
266:     LD  4,-60(1) 	Restore index 
267:    LDA  5,-26(1) 	Load address of base of array y
268:    SUB  5,5,4 	Compute offset of value 
269:     ST  3,0(5) 	Store variable y
* EXPRESSION STMT
270:     ST  1,-60(1) 	Store old fp in ghost frame 
271:     LD  3,-2(1) 	Load variable x
272:     ST  3,-62(1) 	Store parameter 
273:    LDA  3,-26(1) 	Load address of base of array y
274:     ST  3,-63(1) 	Store parameter 
275:    LDA  1,-60(1) 	Load address of new frame 
276:    LDA  3,1(7) 	Return address in ac 
277:    LDA  7,-209(7) 	CALL dog
278:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
279:     LD  3,-2(1) 	Load variable x
280:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
281:    LDC  3,9(6) 	Load constant 
282:     ST  3,-60(1) 	Save index 
283:     LD  3,-2(1) 	Load variable x
284:     LD  4,-60(1) 	Restore index 
285:    LDA  5,-4(1) 	Load address of base of array c
286:    SUB  5,5,4 	Compute offset of value 
287:     ST  3,0(5) 	Store variable c
* EXPRESSION STMT
288:    LDC  3,888(6) 	Load constant 
289:     ST  3,-11(0) 	Store variable glx
* EXPRESSION STMT
290:    LDC  3,7(6) 	Load constant 
291:     ST  3,-60(1) 	Save index 
292:     LD  3,-11(0) 	Load variable glx
293:     LD  4,-60(1) 	Restore index 
294:    LDA  5,-26(1) 	Load address of base of array y
295:    SUB  5,5,4 	Compute offset of value 
296:     ST  3,0(5) 	Store variable y
* EXPRESSION STMT
297:    LDC  3,6(6) 	Load constant 
298:     ST  3,-60(1) 	Save index 
299:    LDC  3,2(6) 	Load constant 
300:     LD  4,-60(1) 	Restore index 
301:    LDA  5,-15(1) 	Load address of base of array d
302:    SUB  5,5,4 	Compute offset of value 
303:     ST  3,0(5) 	Store variable d
* EXPRESSION STMT
304:    LDC  3,2(6) 	Load constant 
305:     ST  3,-60(1) 	Save index 
306:    LDC  3,4(6) 	Load constant 
307:     LD  4,-60(1) 	Restore index 
308:    LDA  5,-4(1) 	Load address of base of array c
309:    SUB  5,5,4 	Compute offset of value 
310:     ST  3,0(5) 	Store variable c
* EXPRESSION STMT
311:    LDC  3,4(6) 	Load constant 
312:     ST  3,-60(1) 	Save index 
313:    LDC  3,7(6) 	Load constant 
314:     LD  4,-60(1) 	Restore index 
315:    LDA  5,-15(1) 	Load address of base of array d
316:    SUB  5,5,4 	Compute offset of value 
317:     ST  3,0(5) 	Store variable d
* EXPRESSION STMT
318:    LDC  3,2(6) 	Load constant 
319:     ST  3,-60(1) 	Save index 
320:    LDC  3,6(6) 	Load constant 
321:    LDA  4,-15(1) 	Load address of base of array d
322:    SUB  3,4,3 	Compute offset of value 
323:     LD  3,0(3) 	Load the value 
324:    LDA  4,-4(1) 	Load address of base of array c
325:    SUB  3,4,3 	Compute offset of value 
326:     LD  3,0(3) 	Load the value 
327:    LDA  4,-15(1) 	Load address of base of array d
328:    SUB  3,4,3 	Compute offset of value 
329:     LD  3,0(3) 	Load the value 
330:    LDA  4,-26(1) 	Load address of base of array y
331:    SUB  3,4,3 	Compute offset of value 
332:     LD  3,0(3) 	Load the value 
333:     LD  4,-60(1) 	Restore index 
334:    LDA  5,-15(1) 	Load address of base of array d
335:    SUB  5,5,4 	Compute offset of value 
336:     ST  3,0(5) 	Store variable d
* EXPRESSION STMT
337:     ST  1,-60(1) 	Store old fp in ghost frame 
338:    LDC  3,8(6) 	Load constant 
339:    LDA  4,-4(1) 	Load address of base of array c
340:    SUB  3,4,3 	Compute offset of value 
341:     LD  3,0(3) 	Load the value 
342:    LDA  4,-15(1) 	Load address of base of array d
343:    SUB  3,4,3 	Compute offset of value 
344:     LD  3,0(3) 	Load the value 
345:    LDA  4,-26(1) 	Load address of base of array y
346:    SUB  3,4,3 	Compute offset of value 
347:     LD  3,0(3) 	Load the value 
348:     ST  3,-62(1) 	Store parameter 
349:    LDA  3,-4(1) 	Load address of base of array c
350:     ST  3,-63(1) 	Store parameter 
351:    LDA  1,-60(1) 	Load address of new frame 
352:    LDA  3,1(7) 	Return address in ac 
353:    LDA  7,-285(7) 	CALL dog
354:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
355:    LDC  3,2(6) 	Load constant 
356:     ST  3,-60(1) 	Save index 
357:    LDC  3,3(6) 	Load constant 
358:    LDA  4,-4(1) 	Load address of base of array c
359:    SUB  3,4,3 	Compute offset of value 
360:     LD  3,0(3) 	Load the value 
361:     LD  4,-60(1) 	Restore index 
362:    LDA  5,-15(1) 	Load address of base of array d
363:    SUB  5,5,4 	Compute offset of value 
364:     ST  3,0(5) 	Store variable d
* EXPRESSION STMT
365:    LDC  3,7(6) 	Load constant 
366:     ST  3,-60(1) 	Save index 
367:    LDC  3,9(6) 	Load constant 
368:    LDA  4,-26(1) 	Load address of base of array y
369:    SUB  3,4,3 	Compute offset of value 
370:     LD  3,0(3) 	Load the value 
371:     LD  4,-60(1) 	Restore index 
372:    LDA  5,-26(1) 	Load address of base of array y
373:    SUB  5,5,4 	Compute offset of value 
374:     ST  3,0(5) 	Store variable y
* EXPRESSION STMT
375:    LDC  3,2(6) 	Load constant 
376:     ST  3,-60(1) 	Save index 
377:    LDC  3,3(6) 	Load constant 
378:     LD  4,-60(1) 	Restore index 
379:    LDA  5,-1(0) 	Load address of base of array gl
380:    SUB  5,5,4 	Compute offset of value 
381:     ST  3,0(5) 	Store variable gl
* EXPRESSION STMT
382:    LDC  3,2(6) 	Load constant 
383:    LDA  4,-1(0) 	Load address of base of array gl
384:    SUB  3,4,3 	Compute offset of value 
385:     LD  3,0(3) 	Load the value 
386:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
387:    LDC  3,7(6) 	Load constant 
388:     ST  3,-60(1) 	Save index 
389:    LDC  3,9(6) 	Load constant 
390:    LDA  4,-1(0) 	Load address of base of array gl
391:    SUB  3,4,3 	Compute offset of value 
392:     LD  3,0(3) 	Load the value 
393:     LD  4,-60(1) 	Restore index 
394:    LDA  5,-26(1) 	Load address of base of array y
395:    SUB  5,5,4 	Compute offset of value 
396:     ST  3,0(5) 	Store variable y
* EXPRESSION STMT
397:    LDC  3,7(6) 	Load constant 
398:     ST  3,-60(1) 	Save index 
399:    LDC  3,9(6) 	Load constant 
400:    LDA  4,-26(1) 	Load address of base of array y
401:    SUB  3,4,3 	Compute offset of value 
402:     LD  3,0(3) 	Load the value 
403:     LD  4,-60(1) 	Restore index 
404:    LDA  5,-1(0) 	Load address of base of array gl
405:    SUB  5,5,4 	Compute offset of value 
406:     ST  3,0(5) 	Store variable gl
* EXPRESSION STMT
407:    LDC  3,0(6) 	Load constant 
408:     ST  3,-60(1) 	Save index 
409:    LDC  3,5(6) 	Load constant 
410:     LD  4,-60(1) 	Restore index 
411:    LDA  5,-26(1) 	Load address of base of array y
412:    SUB  5,5,4 	Compute offset of value 
413:     ST  3,0(5) 	Store variable y
* EXPRESSION STMT
414:    LDC  3,5(6) 	Load constant 
415:     ST  3,-60(1) 	Save index 
416:    LDC  3,3(6) 	Load constant 
417:     LD  4,-60(1) 	Restore index 
418:    LDA  5,-15(1) 	Load address of base of array d
419:    SUB  5,5,4 	Compute offset of value 
420:     ST  3,0(5) 	Store variable d
* EXPRESSION STMT
421:    LDC  3,8(6) 	Load constant 
422:     ST  3,-60(1) 	Save index 
423:    LDC  3,0(6) 	Load constant 
424:    LDA  4,-26(1) 	Load address of base of array y
425:    SUB  3,4,3 	Compute offset of value 
426:     LD  3,0(3) 	Load the value 
427:    LDA  4,-15(1) 	Load address of base of array d
428:    SUB  3,4,3 	Compute offset of value 
429:     LD  3,0(3) 	Load the value 
430:     LD  4,-60(1) 	Restore index 
431:    LDA  5,-4(1) 	Load address of base of array c
432:    SUB  5,5,4 	Compute offset of value 
433:     ST  3,0(5) 	Store variable c
* EXPRESSION STMT
434:     ST  1,-60(1) 	Store old fp in ghost frame 
435:    LDC  3,8(6) 	Load constant 
436:    LDA  4,-4(1) 	Load address of base of array c
437:    SUB  3,4,3 	Compute offset of value 
438:     LD  3,0(3) 	Load the value 
439:     ST  3,-62(1) 	Store parameter 
440:    LDA  1,-60(1) 	Load address of new frame 
441:    LDA  3,1(7) 	Return address in ac 
442:    LDA  7,-437(7) 	CALL output
443:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
444:     ST  1,-60(1) 	Store old fp in ghost frame 
445:    LDA  1,-60(1) 	Load address of new frame 
446:    LDA  3,1(7) 	Return address in ac 
447:    LDA  7,-423(7) 	CALL outnl
448:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
449:    LDC  3,3(6) 	Load constant 
450:     ST  3,-60(1) 	Save index 
451:    LDC  3,4(6) 	Load constant 
452:     LD  4,-60(1) 	Restore index 
453:    LDA  5,-15(1) 	Load address of base of array d
454:    SUB  5,5,4 	Compute offset of value 
455:     ST  3,0(5) 	Store variable d
* EXPRESSION STMT
456:    LDC  3,4(6) 	Load constant 
457:     ST  3,-60(1) 	Save index 
458:    LDC  3,987(6) 	Load constant 
459:     LD  4,-60(1) 	Restore index 
460:    LDA  5,-26(1) 	Load address of base of array y
461:    SUB  5,5,4 	Compute offset of value 
462:     ST  3,0(5) 	Store variable y
* EXPRESSION STMT
463:    LDC  3,9(6) 	Load constant 
464:     ST  3,-60(1) 	Save index 
465:    LDC  3,3(6) 	Load constant 
466:     LD  4,-60(1) 	Restore index 
467:    LDA  5,-4(1) 	Load address of base of array c
468:    SUB  5,5,4 	Compute offset of value 
469:     LD  4,0(5) 	load lhs variable c
470:    SUB  3,4,3 	op -= 
471:     ST  3,0(5) 	Store variable c
* EXPRESSION STMT
472:     ST  1,-60(1) 	Store old fp in ghost frame 
473:    LDC  3,8(6) 	Load constant 
474:    LDA  4,-4(1) 	Load address of base of array c
475:    SUB  3,4,3 	Compute offset of value 
476:     LD  3,0(3) 	Load the value 
477:    LDA  4,-15(1) 	Load address of base of array d
478:    SUB  3,4,3 	Compute offset of value 
479:     LD  3,0(3) 	Load the value 
480:    LDA  4,-26(1) 	Load address of base of array y
481:    SUB  3,4,3 	Compute offset of value 
482:     LD  3,0(3) 	Load the value 
483:     ST  3,-62(1) 	Store parameter 
484:    LDA  3,-4(1) 	Load address of base of array c
485:     ST  3,-63(1) 	Store parameter 
486:    LDA  1,-60(1) 	Load address of new frame 
487:    LDA  3,1(7) 	Return address in ac 
488:    LDA  7,-420(7) 	CALL dog
489:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
490:    LDC  3,9(6) 	Load constant 
491:    LDA  4,-4(1) 	Load address of base of array c
492:    SUB  3,4,3 	Compute offset of value 
493:     LD  3,0(3) 	Load the value 
494:     LD  4,-2(1) 	load lhs variable x
495:    ADD  3,4,3 	op += 
496:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
497:    LDC  3,9(6) 	Load constant 
498:    LDA  4,-4(1) 	Load address of base of array c
499:    SUB  3,4,3 	Compute offset of value 
500:     LD  3,0(3) 	Load the value 
501:     LD  4,-2(1) 	load lhs variable x
502:    SUB  3,4,3 	op -= 
503:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
504:    LDC  3,8(6) 	Load constant 
505:     ST  3,-60(1) 	Save index 
506:    LDC  3,8(6) 	Load constant 
507:     LD  4,-60(1) 	Restore index 
508:    LDA  5,-26(1) 	Load address of base of array y
509:    SUB  5,5,4 	Compute offset of value 
510:     ST  3,0(5) 	Store variable y
* EXPRESSION STMT
511:    LDC  3,9(6) 	Load constant 
512:     ST  3,-60(1) 	Save index 
513:     ST  1,-61(1) 	Store old fp in ghost frame 
514:    LDC  3,7(6) 	Load constant 
515:     ST  3,-63(1) 	Store parameter 
516:    LDA  1,-61(1) 	Load address of new frame 
517:    LDA  3,1(7) 	Return address in ac 
518:    LDA  7,-401(7) 	CALL getnxtindex
519:    LDA  3,0(2) 	Save the result in ac 
520:    LDA  4,-26(1) 	Load address of base of array y
521:    SUB  3,4,3 	Compute offset of value 
522:     LD  3,0(3) 	Load the value 
523:     ST  3,-61(1) 	Save left side 
524:    LDC  3,1(6) 	Load constant 
525:     LD  4,-61(1) 	Load left into ac1 
526:    ADD  3,4,3 	Op + 
527:     LD  4,-60(1) 	Restore index 
528:    LDA  5,-26(1) 	Load address of base of array y
529:    SUB  5,5,4 	Compute offset of value 
530:     ST  3,0(5) 	Store variable y
* EXPRESSION STMT
531:     ST  1,-60(1) 	Store old fp in ghost frame 
532:    LDC  3,4(6) 	Load constant 
533:    LDA  4,-26(1) 	Load address of base of array y
534:    SUB  3,4,3 	Compute offset of value 
535:     LD  3,0(3) 	Load the value 
536:     ST  3,-62(1) 	Store parameter 
537:    LDA  3,-26(1) 	Load address of base of array y
538:     ST  3,-63(1) 	Store parameter 
539:    LDA  1,-60(1) 	Load address of new frame 
540:    LDA  3,1(7) 	Return address in ac 
541:    LDA  7,-473(7) 	CALL dog
542:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
543:    LDC  3,5(6) 	Load constant 
544:     ST  3,-60(1) 	Save index 
545:    LDC  3,0(6) 	Load constant 
546:     LD  4,-60(1) 	Restore index 
547:    LDA  5,-4(1) 	Load address of base of array c
548:    SUB  5,5,4 	Compute offset of value 
549:     ST  3,0(5) 	Store variable c
* EXPRESSION STMT
550:    LDC  3,0(6) 	Load constant 
551:     ST  3,-60(1) 	Save index 
552:    LDC  3,3(6) 	Load constant 
553:     LD  4,-60(1) 	Restore index 
554:    LDA  5,-48(1) 	Load address of base of array w
555:    SUB  5,5,4 	Compute offset of value 
556:     ST  3,0(5) 	Store variable w
* EXPRESSION STMT
557:    LDC  3,3(6) 	Load constant 
558:     ST  3,-60(1) 	Save index 
559:    LDC  3,9(6) 	Load constant 
560:     LD  4,-60(1) 	Restore index 
561:    LDA  5,-37(1) 	Load address of base of array z
562:    SUB  5,5,4 	Compute offset of value 
563:     ST  3,0(5) 	Store variable z
* EXPRESSION STMT
564:    LDC  3,9(6) 	Load constant 
565:     ST  3,-60(1) 	Save index 
566:    LDC  3,1(6) 	Load constant 
567:     LD  4,-60(1) 	Restore index 
568:    LDA  5,-26(1) 	Load address of base of array y
569:    SUB  5,5,4 	Compute offset of value 
570:     ST  3,0(5) 	Store variable y
* EXPRESSION STMT
571:    LDC  3,5(6) 	Load constant 
572:    LDA  4,-4(1) 	Load address of base of array c
573:    SUB  3,4,3 	Compute offset of value 
574:     LD  3,0(3) 	Load the value 
575:    LDA  4,-48(1) 	Load address of base of array w
576:    SUB  3,4,3 	Compute offset of value 
577:     LD  3,0(3) 	Load the value 
578:    LDA  4,-37(1) 	Load address of base of array z
579:    SUB  3,4,3 	Compute offset of value 
580:     LD  3,0(3) 	Load the value 
581:    LDA  4,-26(1) 	Load address of base of array y
582:    SUB  3,4,3 	Compute offset of value 
583:     LD  3,0(3) 	Load the value 
584:     ST  3,-60(1) 	Save index 
585:    LDC  3,77(6) 	Load constant 
586:     LD  4,-60(1) 	Restore index 
587:    LDA  5,-15(1) 	Load address of base of array d
588:    SUB  5,5,4 	Compute offset of value 
589:     ST  3,0(5) 	Store variable d
* EXPRESSION STMT
590:    LDC  3,9(6) 	Load constant 
591:     ST  3,-60(1) 	Save index 
592:    LDC  3,1(6) 	Load constant 
593:    LDA  4,-15(1) 	Load address of base of array d
594:    SUB  3,4,3 	Compute offset of value 
595:     LD  3,0(3) 	Load the value 
596:     LD  4,-60(1) 	Restore index 
597:    LDA  5,-4(1) 	Load address of base of array c
598:    SUB  5,5,4 	Compute offset of value 
599:     ST  3,0(5) 	Store variable c
* EXPRESSION STMT
600:     ST  1,-60(1) 	Store old fp in ghost frame 
601:    LDC  3,66(6) 	Load constant 
602:     ST  3,-62(1) 	Store parameter 
603:    LDA  3,-4(1) 	Load address of base of array c
604:     ST  3,-63(1) 	Store parameter 
605:    LDA  1,-60(1) 	Load address of new frame 
606:    LDA  3,1(7) 	Return address in ac 
607:    LDA  7,-539(7) 	CALL dog
608:    LDA  3,0(2) 	Save the result in ac 
* BEGIN compound statement
* EXPRESSION STMT
609:    LDC  3,0(6) 	Load constant 
610:     ST  3,-58(1) 	Store variable p
* WHILE
611:     LD  3,-58(1) 	Load variable p
612:     ST  3,-60(1) 	Save left side 
613:    LDC  3,10(6) 	Load constant 
614:     LD  4,-60(1) 	Load left into ac1 
615:    SUB  4,4,3 	Op < 
616:    LDC  3,1(6) 	True case 
617:    JLT  4,1(7) 	Jump if true 
618:    LDC  3,0(6) 	False case 
619:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
621:     LD  3,-58(1) 	Load variable p
622:     ST  3,-59(1) 	Store variable q
* EXPRESSION STMT
623:    LDC  3,9(6) 	Load constant 
624:     ST  3,-60(1) 	Save left side 
625:     LD  3,-59(1) 	Load variable q
626:     LD  4,-60(1) 	Load left into ac1 
627:    SUB  3,4,3 	Op - 
628:     ST  3,-60(1) 	Save index 
629:    LDC  3,1(6) 	Load constant 
630:     LD  4,-58(1) 	load lhs variable p
631:    ADD  3,4,3 	op += 
632:     ST  3,-58(1) 	Store variable p
633:     LD  4,-60(1) 	Restore index 
634:    LDA  5,-4(1) 	Load address of base of array c
635:    SUB  5,5,4 	Compute offset of value 
636:     ST  3,0(5) 	Store variable c
* END compound statement
637:    LDA  7,-27(7) 	go to beginning of loop 
620:    LDA  7,17(7) 	No more loop 
* ENDWHILE
* END compound statement
* EXPRESSION STMT
638:     ST  1,-60(1) 	Store old fp in ghost frame 
639:    LDA  3,-4(1) 	Load address of base of array c
640:     ST  3,-62(1) 	Store parameter 
641:    LDC  3,10(6) 	Load constant 
642:     ST  3,-63(1) 	Store parameter 
643:    LDA  1,-60(1) 	Load address of new frame 
644:    LDA  3,1(7) 	Return address in ac 
645:    LDA  7,-616(7) 	CALL showIntArray
646:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
647:    LDC  2,0(6) 	Set return value to 0 
648:     LD  3,-1(1) 	Load return address 
649:     LD  1,0(1) 	Adjust fp 
650:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,650(7) 	Jump to init 
* BEGIN Init
651:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
652:    LDC  3,10(6) 	load size of array gl
653:     ST  3,0(0) 	save size of array gl
* END init of global array sizes
654:    LDA  1,-12(0) 	set first frame at end of globals 
655:     ST  1,0(1) 	store old fp (point to self) 
656:    LDA  3,1(7) 	Return address in ac 
657:    LDA  7,-526(7) 	Jump to main 
658:   HALT  0,0,0 	DONE! 
* END Init
