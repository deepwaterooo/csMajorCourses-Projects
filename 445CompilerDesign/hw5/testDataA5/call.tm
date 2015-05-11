* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  call.c-
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
* BEGIN function showInt
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 31:     ST  1,-3(1) 	Store old fp in ghost frame 
 32:     LD  3,-2(1) 	Load variable x
 33:     ST  3,-5(1) 	Store parameter 
 34:    LDA  1,-3(1) 	Load address of new frame 
 35:    LDA  3,1(7) 	Return address in ac 
 36:    LDA  7,-31(7) 	CALL output
 37:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 38:     ST  1,-3(1) 	Store old fp in ghost frame 
 39:    LDA  1,-3(1) 	Load address of new frame 
 40:    LDA  3,1(7) 	Return address in ac 
 41:    LDA  7,-17(7) 	CALL outnl
 42:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 43:    LDC  2,0(6) 	Set return value to 0 
 44:     LD  3,-1(1) 	Load return address 
 45:     LD  1,0(1) 	Adjust fp 
 46:    LDA  7,0(3) 	Return 
* END of function showInt
* BEGIN function showIntArray
 47:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 48:    LDC  3,0(6) 	Load constant 
 49:     ST  3,-4(1) 	Store variable i
* WHILE
 50:     LD  3,-4(1) 	Load variable i
 51:     ST  3,-5(1) 	Save left side 
 52:     LD  3,-3(1) 	Load variable size
 53:     LD  4,-5(1) 	Load left into ac1 
 54:    SUB  4,4,3 	Op < 
 55:    LDC  3,1(6) 	True case 
 56:    JLT  4,1(7) 	Jump if true 
 57:    LDC  3,0(6) 	False case 
 58:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 60:     ST  1,-5(1) 	Store old fp in ghost frame 
 61:     LD  3,-4(1) 	Load variable i
 62:     LD  4,-2(1) 	Load address of base of array x
 63:    SUB  3,4,3 	Compute offset of value 
 64:     LD  3,0(3) 	Load the value 
 65:     ST  3,-7(1) 	Store parameter 
 66:    LDA  1,-5(1) 	Load address of new frame 
 67:    LDA  3,1(7) 	Return address in ac 
 68:    LDA  7,-63(7) 	CALL output
 69:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 70:     LD  3,-4(1) 	Load variable i
 71:     ST  3,-5(1) 	Save left side 
 72:    LDC  3,1(6) 	Load constant 
 73:     LD  4,-5(1) 	Load left into ac1 
 74:    ADD  3,4,3 	Op + 
 75:     ST  3,-4(1) 	Store variable i
* END compound statement
 76:    LDA  7,-27(7) 	go to beginning of loop 
 59:    LDA  7,17(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
 77:     ST  1,-5(1) 	Store old fp in ghost frame 
 78:    LDA  1,-5(1) 	Load address of new frame 
 79:    LDA  3,1(7) 	Return address in ac 
 80:    LDA  7,-56(7) 	CALL outnl
 81:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 82:    LDC  2,0(6) 	Set return value to 0 
 83:     LD  3,-1(1) 	Load return address 
 84:     LD  1,0(1) 	Adjust fp 
 85:    LDA  7,0(3) 	Return 
* END of function showIntArray
* BEGIN function showBool
 86:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 87:     ST  1,-3(1) 	Store old fp in ghost frame 
 88:     LD  3,-2(1) 	Load variable x
 89:     ST  3,-5(1) 	Store parameter 
 90:    LDA  1,-3(1) 	Load address of new frame 
 91:    LDA  3,1(7) 	Return address in ac 
 92:    LDA  7,-75(7) 	CALL outputb
 93:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 94:     ST  1,-3(1) 	Store old fp in ghost frame 
 95:    LDA  1,-3(1) 	Load address of new frame 
 96:    LDA  3,1(7) 	Return address in ac 
 97:    LDA  7,-73(7) 	CALL outnl
 98:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 99:    LDC  2,0(6) 	Set return value to 0 
100:     LD  3,-1(1) 	Load return address 
101:     LD  1,0(1) 	Adjust fp 
102:    LDA  7,0(3) 	Return 
* END of function showBool
* BEGIN function truth
103:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* RETURN
104:    LDC  3,1(6) 	Load constant 
105:    LDA  2,0(3) 	Copy result to rt register 
106:     LD  3,-1(1) 	Load return address 
107:     LD  1,0(1) 	Adjust fp 
108:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
109:    LDC  2,0(6) 	Set return value to 0 
110:     LD  3,-1(1) 	Load return address 
111:     LD  1,0(1) 	Adjust fp 
112:    LDA  7,0(3) 	Return 
* END of function truth
* BEGIN function magic
113:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* RETURN
114:    LDC  3,666(6) 	Load constant 
115:    LDA  2,0(3) 	Copy result to rt register 
116:     LD  3,-1(1) 	Load return address 
117:     LD  1,0(1) 	Adjust fp 
118:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
119:    LDC  2,0(6) 	Set return value to 0 
120:     LD  3,-1(1) 	Load return address 
121:     LD  1,0(1) 	Adjust fp 
122:    LDA  7,0(3) 	Return 
* END of function magic
* BEGIN function sqr
123:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* RETURN
124:     LD  3,-2(1) 	Load variable x
125:     ST  3,-3(1) 	Save left side 
126:     LD  3,-2(1) 	Load variable x
127:     LD  4,-3(1) 	Load left into ac1 
128:    MUL  3,4,3 	Op * 
129:    LDA  2,0(3) 	Copy result to rt register 
130:     LD  3,-1(1) 	Load return address 
131:     LD  1,0(1) 	Adjust fp 
132:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
133:    LDC  2,0(6) 	Set return value to 0 
134:     LD  3,-1(1) 	Load return address 
135:     LD  1,0(1) 	Adjust fp 
136:    LDA  7,0(3) 	Return 
* END of function sqr
* BEGIN function add
137:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* RETURN
138:     LD  3,-2(1) 	Load variable x
139:     ST  3,-4(1) 	Save left side 
140:     LD  3,-3(1) 	Load variable y
141:     LD  4,-4(1) 	Load left into ac1 
142:    ADD  3,4,3 	Op + 
143:    LDA  2,0(3) 	Copy result to rt register 
144:     LD  3,-1(1) 	Load return address 
145:     LD  1,0(1) 	Adjust fp 
146:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
147:    LDC  2,0(6) 	Set return value to 0 
148:     LD  3,-1(1) 	Load return address 
149:     LD  1,0(1) 	Adjust fp 
150:    LDA  7,0(3) 	Return 
* END of function add
* BEGIN function mul
151:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* RETURN
152:     LD  3,-2(1) 	Load variable x
153:     ST  3,-4(1) 	Save left side 
154:     LD  3,-3(1) 	Load variable y
155:     LD  4,-4(1) 	Load left into ac1 
156:    MUL  3,4,3 	Op * 
157:    LDA  2,0(3) 	Copy result to rt register 
158:     LD  3,-1(1) 	Load return address 
159:     LD  1,0(1) 	Adjust fp 
160:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
161:    LDC  2,0(6) 	Set return value to 0 
162:     LD  3,-1(1) 	Load return address 
163:     LD  1,0(1) 	Adjust fp 
164:    LDA  7,0(3) 	Return 
* END of function mul
* BEGIN function caller
165:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
166:    LDC  3,666(6) 	Load constant 
167:     ST  3,-5(1) 	Store variable a
* EXPRESSION STMT
168:    LDC  3,777(6) 	Load constant 
169:     ST  3,0(0) 	Store variable g
* EXPRESSION STMT
170:     ST  1,-6(1) 	Store old fp in ghost frame 
171:     LD  3,-2(1) 	Load variable x
172:     ST  3,-8(1) 	Store parameter 
173:    LDA  1,-6(1) 	Load address of new frame 
174:    LDA  3,1(7) 	Return address in ac 
175:    LDA  7,-53(7) 	CALL sqr
176:    LDA  3,0(2) 	Save the result in ac 
177:     ST  3,-4(1) 	Store variable z
* EXPRESSION STMT
178:     ST  1,-6(1) 	Store old fp in ghost frame 
179:     LD  3,-4(1) 	Load variable z
180:     ST  3,-8(1) 	Store parameter 
181:    LDA  1,-6(1) 	Load address of new frame 
182:    LDA  3,1(7) 	Return address in ac 
183:    LDA  7,-178(7) 	CALL output
184:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
185:     ST  1,-6(1) 	Store old fp in ghost frame 
186:    LDA  1,-6(1) 	Load address of new frame 
187:    LDA  3,1(7) 	Return address in ac 
188:    LDA  7,-164(7) 	CALL outnl
189:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
190:     ST  1,-6(1) 	Store old fp in ghost frame 
191:    LDC  3,7(6) 	Load constant 
192:     LD  4,-3(1) 	Load address of base of array y
193:    SUB  3,4,3 	Compute offset of value 
194:     LD  3,0(3) 	Load the value 
195:     ST  3,-8(1) 	Store parameter 
196:    LDA  1,-6(1) 	Load address of new frame 
197:    LDA  3,1(7) 	Return address in ac 
198:    LDA  7,-76(7) 	CALL sqr
199:    LDA  3,0(2) 	Save the result in ac 
200:     ST  3,-4(1) 	Store variable z
* EXPRESSION STMT
201:     ST  1,-6(1) 	Store old fp in ghost frame 
202:     LD  3,-4(1) 	Load variable z
203:     ST  3,-8(1) 	Store parameter 
204:    LDA  1,-6(1) 	Load address of new frame 
205:    LDA  3,1(7) 	Return address in ac 
206:    LDA  7,-201(7) 	CALL output
207:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
208:     ST  1,-6(1) 	Store old fp in ghost frame 
209:    LDA  1,-6(1) 	Load address of new frame 
210:    LDA  3,1(7) 	Return address in ac 
211:    LDA  7,-187(7) 	CALL outnl
212:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
213:     ST  1,-6(1) 	Store old fp in ghost frame 
214:     LD  3,-5(1) 	Load variable a
215:     ST  3,-8(1) 	Store parameter 
216:    LDA  1,-6(1) 	Load address of new frame 
217:    LDA  3,1(7) 	Return address in ac 
218:    LDA  7,-96(7) 	CALL sqr
219:    LDA  3,0(2) 	Save the result in ac 
220:     ST  3,-4(1) 	Store variable z
* EXPRESSION STMT
221:     ST  1,-6(1) 	Store old fp in ghost frame 
222:     LD  3,-4(1) 	Load variable z
223:     ST  3,-8(1) 	Store parameter 
224:    LDA  1,-6(1) 	Load address of new frame 
225:    LDA  3,1(7) 	Return address in ac 
226:    LDA  7,-221(7) 	CALL output
227:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
228:     ST  1,-6(1) 	Store old fp in ghost frame 
229:    LDA  1,-6(1) 	Load address of new frame 
230:    LDA  3,1(7) 	Return address in ac 
231:    LDA  7,-207(7) 	CALL outnl
232:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
233:     ST  1,-6(1) 	Store old fp in ghost frame 
234:     LD  3,0(0) 	Load variable g
235:     ST  3,-8(1) 	Store parameter 
236:    LDA  1,-6(1) 	Load address of new frame 
237:    LDA  3,1(7) 	Return address in ac 
238:    LDA  7,-116(7) 	CALL sqr
239:    LDA  3,0(2) 	Save the result in ac 
240:     ST  3,-4(1) 	Store variable z
* EXPRESSION STMT
241:     ST  1,-6(1) 	Store old fp in ghost frame 
242:     LD  3,-4(1) 	Load variable z
243:     ST  3,-8(1) 	Store parameter 
244:    LDA  1,-6(1) 	Load address of new frame 
245:    LDA  3,1(7) 	Return address in ac 
246:    LDA  7,-241(7) 	CALL output
247:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
248:     ST  1,-6(1) 	Store old fp in ghost frame 
249:    LDA  1,-6(1) 	Load address of new frame 
250:    LDA  3,1(7) 	Return address in ac 
251:    LDA  7,-227(7) 	CALL outnl
252:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
253:    LDC  2,0(6) 	Set return value to 0 
254:     LD  3,-1(1) 	Load return address 
255:     LD  1,0(1) 	Adjust fp 
256:    LDA  7,0(3) 	Return 
* END of function caller
* BEGIN function swap
257:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
258:     LD  3,-3(1) 	Load variable z1
259:     LD  4,-2(1) 	Load address of base of array x
260:    SUB  3,4,3 	Compute offset of value 
261:     LD  3,0(3) 	Load the value 
262:     ST  3,-5(1) 	Store variable tmp
* EXPRESSION STMT
263:     LD  3,-3(1) 	Load variable z1
264:     ST  3,-6(1) 	Save index 
265:     LD  3,-4(1) 	Load variable z2
266:     LD  4,-2(1) 	Load address of base of array x
267:    SUB  3,4,3 	Compute offset of value 
268:     LD  3,0(3) 	Load the value 
269:     LD  4,-6(1) 	Restore index 
270:     LD  5,-2(1) 	Load address of base of array x
271:    SUB  5,5,4 	Compute offset of value 
272:     ST  3,0(5) 	Store variable x
* EXPRESSION STMT
273:     LD  3,-4(1) 	Load variable z2
274:     ST  3,-6(1) 	Save index 
275:     LD  3,-5(1) 	Load variable tmp
276:     LD  4,-6(1) 	Restore index 
277:     LD  5,-2(1) 	Load address of base of array x
278:    SUB  5,5,4 	Compute offset of value 
279:     ST  3,0(5) 	Store variable x
* END compound statement
* Add standard closing in case there is no return statement
280:    LDC  2,0(6) 	Set return value to 0 
281:     LD  3,-1(1) 	Load return address 
282:     LD  1,0(1) 	Adjust fp 
283:    LDA  7,0(3) 	Return 
* END of function swap
* BEGIN function main
284:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
285:    LDC  3,10(6) 	load size of array r
286:     ST  3,-4(1) 	save size of array r
287:    LDC  3,10(6) 	load size of array s
288:     ST  3,-15(1) 	save size of array s
* EXPRESSION STMT
289:    LDC  3,0(6) 	Load constant 
290:     ST  3,-2(1) 	Store variable p
* WHILE
291:     LD  3,-2(1) 	Load variable p
292:     ST  3,-26(1) 	Save left side 
293:    LDC  3,10(6) 	Load constant 
294:     LD  4,-26(1) 	Load left into ac1 
295:    SUB  4,4,3 	Op < 
296:    LDC  3,1(6) 	True case 
297:    JLT  4,1(7) 	Jump if true 
298:    LDC  3,0(6) 	False case 
299:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
301:     LD  3,-2(1) 	Load variable p
302:     ST  3,-26(1) 	Save index 
303:     LD  3,-2(1) 	Load variable p
304:     LD  4,-26(1) 	Restore index 
305:    LDA  5,-5(1) 	Load address of base of array r
306:    SUB  5,5,4 	Compute offset of value 
307:     ST  3,0(5) 	Store variable r
* EXPRESSION STMT
308:     LD  3,-2(1) 	load lhs variable p
309:    LDA  3,1(3) 	increment value of p
310:     ST  3,-2(1) 	Store variable p
* END compound statement
311:    LDA  7,-21(7) 	go to beginning of loop 
300:    LDA  7,11(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
312:    LDC  3,111(6) 	Load constant 
313:     ST  3,-2(1) 	Store variable p
* EXPRESSION STMT
314:    LDC  3,222(6) 	Load constant 
315:     ST  3,-3(1) 	Store variable q
* EXPRESSION STMT
316:    LDC  3,7(6) 	Load constant 
317:     ST  3,-26(1) 	Save index 
318:    LDC  3,333(6) 	Load constant 
319:     LD  4,-26(1) 	Restore index 
320:    LDA  5,-5(1) 	Load address of base of array r
321:    SUB  5,5,4 	Compute offset of value 
322:     ST  3,0(5) 	Store variable r
* EXPRESSION STMT
323:    LDC  3,7(6) 	Load constant 
324:     ST  3,-26(1) 	Save index 
325:    LDC  3,444(6) 	Load constant 
326:     LD  4,-26(1) 	Restore index 
327:    LDA  5,-16(1) 	Load address of base of array s
328:    SUB  5,5,4 	Compute offset of value 
329:     ST  3,0(5) 	Store variable s
* EXPRESSION STMT
330:     ST  1,-26(1) 	Store old fp in ghost frame 
331:     LD  3,-2(1) 	Load variable p
332:     ST  3,-28(1) 	Store parameter 
333:    LDA  1,-26(1) 	Load address of new frame 
334:    LDA  3,1(7) 	Return address in ac 
335:    LDA  7,-306(7) 	CALL showInt
336:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
337:     ST  1,-26(1) 	Store old fp in ghost frame 
338:    LDA  3,-5(1) 	Load address of base of array r
339:     ST  3,-28(1) 	Store parameter 
340:    LDC  3,10(6) 	Load constant 
341:     ST  3,-29(1) 	Store parameter 
342:    LDA  1,-26(1) 	Load address of new frame 
343:    LDA  3,1(7) 	Return address in ac 
344:    LDA  7,-298(7) 	CALL showIntArray
345:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
346:     ST  1,-26(1) 	Store old fp in ghost frame 
347:     ST  1,-28(1) 	Store old fp in ghost frame 
348:    LDA  1,-28(1) 	Load address of new frame 
349:    LDA  3,1(7) 	Return address in ac 
350:    LDA  7,-248(7) 	CALL truth
351:    LDA  3,0(2) 	Save the result in ac 
352:     ST  3,-28(1) 	Store parameter 
353:    LDA  1,-26(1) 	Load address of new frame 
354:    LDA  3,1(7) 	Return address in ac 
355:    LDA  7,-270(7) 	CALL showBool
356:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
357:     ST  1,-26(1) 	Store old fp in ghost frame 
358:     ST  1,-28(1) 	Store old fp in ghost frame 
359:     LD  3,-2(1) 	Load variable p
360:     ST  3,-30(1) 	Store parameter 
361:    LDA  1,-28(1) 	Load address of new frame 
362:    LDA  3,1(7) 	Return address in ac 
363:    LDA  7,-334(7) 	CALL showInt
364:    LDA  3,0(2) 	Save the result in ac 
365:     ST  3,-28(1) 	Store parameter 
366:    LDA  1,-26(1) 	Load address of new frame 
367:    LDA  3,1(7) 	Return address in ac 
368:    LDA  7,-363(7) 	CALL output
369:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
370:     ST  1,-26(1) 	Store old fp in ghost frame 
371:     ST  1,-28(1) 	Store old fp in ghost frame 
372:     ST  1,-30(1) 	Store old fp in ghost frame 
373:    LDA  1,-30(1) 	Load address of new frame 
374:    LDA  3,1(7) 	Return address in ac 
375:    LDA  7,-273(7) 	CALL truth
376:    LDA  3,0(2) 	Save the result in ac 
377:     ST  3,-30(1) 	Store parameter 
378:    LDA  1,-28(1) 	Load address of new frame 
379:    LDA  3,1(7) 	Return address in ac 
380:    LDA  7,-295(7) 	CALL showBool
381:    LDA  3,0(2) 	Save the result in ac 
382:     ST  3,-28(1) 	Store parameter 
383:    LDA  1,-26(1) 	Load address of new frame 
384:    LDA  3,1(7) 	Return address in ac 
385:    LDA  7,-380(7) 	CALL output
386:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
387:     ST  1,-26(1) 	Store old fp in ghost frame 
388:     LD  3,-2(1) 	Load variable p
389:     ST  3,-28(1) 	Store parameter 
390:    LDA  3,-5(1) 	Load address of base of array r
391:     ST  3,-29(1) 	Store parameter 
392:    LDA  1,-26(1) 	Load address of new frame 
393:    LDA  3,1(7) 	Return address in ac 
394:    LDA  7,-230(7) 	CALL caller
395:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
396:     ST  1,-26(1) 	Store old fp in ghost frame 
397:     ST  1,-28(1) 	Store old fp in ghost frame 
398:     ST  1,-30(1) 	Store old fp in ghost frame 
399:     LD  3,-2(1) 	Load variable p
400:     ST  3,-32(1) 	Store parameter 
401:     LD  3,-3(1) 	Load variable q
402:     ST  3,-33(1) 	Store parameter 
403:    LDA  1,-30(1) 	Load address of new frame 
404:    LDA  3,1(7) 	Return address in ac 
405:    LDA  7,-269(7) 	CALL add
406:    LDA  3,0(2) 	Save the result in ac 
407:     ST  3,-30(1) 	Store parameter 
408:     ST  1,-31(1) 	Store old fp in ghost frame 
409:     LD  3,-2(1) 	Load variable p
410:     ST  3,-33(1) 	Store parameter 
411:     LD  3,-3(1) 	Load variable q
412:     ST  3,-34(1) 	Store parameter 
413:    LDA  1,-31(1) 	Load address of new frame 
414:    LDA  3,1(7) 	Return address in ac 
415:    LDA  7,-265(7) 	CALL mul
416:    LDA  3,0(2) 	Save the result in ac 
417:     ST  3,-31(1) 	Store parameter 
418:    LDA  1,-28(1) 	Load address of new frame 
419:    LDA  3,1(7) 	Return address in ac 
420:    LDA  7,-284(7) 	CALL add
421:    LDA  3,0(2) 	Save the result in ac 
422:     ST  3,-28(1) 	Store parameter 
423:    LDA  1,-26(1) 	Load address of new frame 
424:    LDA  3,1(7) 	Return address in ac 
425:    LDA  7,-420(7) 	CALL output
426:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
427:     ST  1,-26(1) 	Store old fp in ghost frame 
428:    LDA  1,-26(1) 	Load address of new frame 
429:    LDA  3,1(7) 	Return address in ac 
430:    LDA  7,-406(7) 	CALL outnl
431:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
432:    LDC  3,9(6) 	Load constant 
433:     ST  3,-26(1) 	Save index 
434:    LDC  3,555(6) 	Load constant 
435:     LD  4,-26(1) 	Restore index 
436:    LDA  5,-5(1) 	Load address of base of array r
437:    SUB  5,5,4 	Compute offset of value 
438:     ST  3,0(5) 	Store variable r
* EXPRESSION STMT
439:     ST  1,-26(1) 	Store old fp in ghost frame 
440:    LDA  3,-5(1) 	Load address of base of array r
441:     ST  3,-28(1) 	Store parameter 
442:    LDC  3,7(6) 	Load constant 
443:     ST  3,-29(1) 	Store parameter 
444:    LDC  3,9(6) 	Load constant 
445:     ST  3,-30(1) 	Store parameter 
446:    LDA  1,-26(1) 	Load address of new frame 
447:    LDA  3,1(7) 	Return address in ac 
448:    LDA  7,-192(7) 	CALL swap
449:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
450:     ST  1,-26(1) 	Store old fp in ghost frame 
451:    LDC  3,9(6) 	Load constant 
452:    LDA  4,-5(1) 	Load address of base of array r
453:    SUB  3,4,3 	Compute offset of value 
454:     LD  3,0(3) 	Load the value 
455:     ST  3,-28(1) 	Store parameter 
456:    LDA  1,-26(1) 	Load address of new frame 
457:    LDA  3,1(7) 	Return address in ac 
458:    LDA  7,-453(7) 	CALL output
459:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
460:     ST  1,-26(1) 	Store old fp in ghost frame 
461:    LDA  1,-26(1) 	Load address of new frame 
462:    LDA  3,1(7) 	Return address in ac 
463:    LDA  7,-439(7) 	CALL outnl
464:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
465:     ST  1,-26(1) 	Store old fp in ghost frame 
466:    LDC  3,2(6) 	Load constant 
467:     ST  3,-28(1) 	Save left side 
468:     ST  1,-29(1) 	Store old fp in ghost frame 
469:     ST  1,-31(1) 	Store old fp in ghost frame 
470:    LDC  3,3(6) 	Load constant 
471:     ST  3,-33(1) 	Save left side 
472:    LDC  3,4(6) 	Load constant 
473:     LD  4,-33(1) 	Load left into ac1 
474:    MUL  3,4,3 	Op * 
475:     ST  3,-33(1) 	Store parameter 
476:    LDC  3,5(6) 	Load constant 
477:     ST  3,-34(1) 	Save left side 
478:    LDC  3,6(6) 	Load constant 
479:     LD  4,-34(1) 	Load left into ac1 
480:    MUL  3,4,3 	Op * 
481:     ST  3,-34(1) 	Store parameter 
482:    LDA  1,-31(1) 	Load address of new frame 
483:    LDA  3,1(7) 	Return address in ac 
484:    LDA  7,-348(7) 	CALL add
485:    LDA  3,0(2) 	Save the result in ac 
486:     ST  3,-31(1) 	Save left side 
487:    LDC  3,7(6) 	Load constant 
488:     LD  4,-31(1) 	Load left into ac1 
489:    MUL  3,4,3 	Op * 
490:     ST  3,-31(1) 	Store parameter 
491:     ST  1,-32(1) 	Store old fp in ghost frame 
492:    LDC  3,9(6) 	Load constant 
493:     ST  3,-34(1) 	Save left side 
494:    LDC  3,10(6) 	Load constant 
495:     LD  4,-34(1) 	Load left into ac1 
496:    MUL  3,4,3 	Op * 
497:     ST  3,-34(1) 	Store parameter 
498:    LDC  3,11(6) 	Load constant 
499:     ST  3,-35(1) 	Save left side 
500:    LDC  3,12(6) 	Load constant 
501:     LD  4,-35(1) 	Load left into ac1 
502:    MUL  3,4,3 	Op * 
503:     ST  3,-35(1) 	Store parameter 
504:    LDA  1,-32(1) 	Load address of new frame 
505:    LDA  3,1(7) 	Return address in ac 
506:    LDA  7,-370(7) 	CALL add
507:    LDA  3,0(2) 	Save the result in ac 
508:     ST  3,-32(1) 	Save left side 
509:    LDC  3,13(6) 	Load constant 
510:     LD  4,-32(1) 	Load left into ac1 
511:    MUL  3,4,3 	Op * 
512:     ST  3,-32(1) 	Store parameter 
513:    LDA  1,-29(1) 	Load address of new frame 
514:    LDA  3,1(7) 	Return address in ac 
515:    LDA  7,-379(7) 	CALL add
516:    LDA  3,0(2) 	Save the result in ac 
517:     LD  4,-28(1) 	Load left into ac1 
518:    MUL  3,4,3 	Op * 
519:     ST  3,-28(1) 	Store parameter 
520:    LDA  1,-26(1) 	Load address of new frame 
521:    LDA  3,1(7) 	Return address in ac 
522:    LDA  7,-517(7) 	CALL output
523:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
524:     ST  1,-26(1) 	Store old fp in ghost frame 
525:    LDA  1,-26(1) 	Load address of new frame 
526:    LDA  3,1(7) 	Return address in ac 
527:    LDA  7,-503(7) 	CALL outnl
528:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
529:    LDC  2,0(6) 	Set return value to 0 
530:     LD  3,-1(1) 	Load return address 
531:     LD  1,0(1) 	Adjust fp 
532:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,532(7) 	Jump to init 
* BEGIN Init
533:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
534:    LDA  1,-1(0) 	set first frame at end of globals 
535:     ST  1,0(1) 	store old fp (point to self) 
536:    LDA  3,1(7) 	Return address in ac 
537:    LDA  7,-254(7) 	Jump to main 
538:   HALT  0,0,0 	DONE! 
* END Init
