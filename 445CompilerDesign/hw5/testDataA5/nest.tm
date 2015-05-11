* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  nest.c-
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
* BEGIN function agamemnon
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 31:    LDC  3,666(6) 	Load constant 
 32:     ST  3,-2(1) 	Store variable a
* EXPRESSION STMT
 33:    LDC  3,666(6) 	Load constant 
 34:     ST  3,-3(1) 	Store variable b
* EXPRESSION STMT
 35:    LDC  3,666(6) 	Load constant 
 36:     ST  3,-4(1) 	Store variable x
* EXPRESSION STMT
 37:    LDC  3,666(6) 	Load constant 
 38:     ST  3,-2(0) 	Store variable z
* EXPRESSION STMT
 39:     ST  1,-5(1) 	Store old fp in ghost frame 
 40:     LD  3,-2(1) 	Load variable a
 41:     ST  3,-7(1) 	Store parameter 
 42:    LDA  1,-5(1) 	Load address of new frame 
 43:    LDA  3,1(7) 	Return address in ac 
 44:    LDA  7,-39(7) 	CALL output
 45:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 46:     ST  1,-5(1) 	Store old fp in ghost frame 
 47:     LD  3,-3(1) 	Load variable b
 48:     ST  3,-7(1) 	Store parameter 
 49:    LDA  1,-5(1) 	Load address of new frame 
 50:    LDA  3,1(7) 	Return address in ac 
 51:    LDA  7,-46(7) 	CALL output
 52:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 53:     ST  1,-5(1) 	Store old fp in ghost frame 
 54:     LD  3,-4(1) 	Load variable x
 55:     ST  3,-7(1) 	Store parameter 
 56:    LDA  1,-5(1) 	Load address of new frame 
 57:    LDA  3,1(7) 	Return address in ac 
 58:    LDA  7,-53(7) 	CALL output
 59:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 60:     ST  1,-5(1) 	Store old fp in ghost frame 
 61:     LD  3,-1(0) 	Load variable y
 62:     ST  3,-7(1) 	Store parameter 
 63:    LDA  1,-5(1) 	Load address of new frame 
 64:    LDA  3,1(7) 	Return address in ac 
 65:    LDA  7,-60(7) 	CALL output
 66:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 67:     ST  1,-5(1) 	Store old fp in ghost frame 
 68:     LD  3,-2(0) 	Load variable z
 69:     ST  3,-7(1) 	Store parameter 
 70:    LDA  1,-5(1) 	Load address of new frame 
 71:    LDA  3,1(7) 	Return address in ac 
 72:    LDA  7,-67(7) 	CALL output
 73:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 74:    LDC  3,1(6) 	Load constant 
 75:     ST  3,-2(1) 	Store variable a
* EXPRESSION STMT
 76:    LDC  3,2(6) 	Load constant 
 77:     ST  3,-3(1) 	Store variable b
* EXPRESSION STMT
 78:    LDC  3,3(6) 	Load constant 
 79:     ST  3,-4(1) 	Store variable x
* EXPRESSION STMT
 80:    LDC  3,4(6) 	Load constant 
 81:     ST  3,-1(0) 	Store variable y
* EXPRESSION STMT
 82:    LDC  3,5(6) 	Load constant 
 83:     ST  3,-2(0) 	Store variable z
* END compound statement
* Add standard closing in case there is no return statement
 84:    LDC  2,0(6) 	Set return value to 0 
 85:     LD  3,-1(1) 	Load return address 
 86:     LD  1,0(1) 	Adjust fp 
 87:    LDA  7,0(3) 	Return 
* END of function agamemnon
* BEGIN function main
 88:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 89:    LDC  3,6(6) 	Load constant 
 90:     ST  3,-2(1) 	Store variable a
* EXPRESSION STMT
 91:    LDC  3,7(6) 	Load constant 
 92:     ST  3,-3(1) 	Store variable b
* EXPRESSION STMT
 93:    LDC  3,8(6) 	Load constant 
 94:     ST  3,0(0) 	Store variable x
* EXPRESSION STMT
 95:    LDC  3,9(6) 	Load constant 
 96:     ST  3,-1(0) 	Store variable y
* EXPRESSION STMT
 97:    LDC  3,10(6) 	Load constant 
 98:     ST  3,-4(1) 	Store variable z
* EXPRESSION STMT
 99:     ST  1,-8(1) 	Store old fp in ghost frame 
100:     LD  3,-2(1) 	Load variable a
101:     ST  3,-10(1) 	Store parameter 
102:    LDA  1,-8(1) 	Load address of new frame 
103:    LDA  3,1(7) 	Return address in ac 
104:    LDA  7,-99(7) 	CALL output
105:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
106:     ST  1,-8(1) 	Store old fp in ghost frame 
107:     LD  3,-3(1) 	Load variable b
108:     ST  3,-10(1) 	Store parameter 
109:    LDA  1,-8(1) 	Load address of new frame 
110:    LDA  3,1(7) 	Return address in ac 
111:    LDA  7,-106(7) 	CALL output
112:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
113:     ST  1,-8(1) 	Store old fp in ghost frame 
114:     LD  3,0(0) 	Load variable x
115:     ST  3,-10(1) 	Store parameter 
116:    LDA  1,-8(1) 	Load address of new frame 
117:    LDA  3,1(7) 	Return address in ac 
118:    LDA  7,-113(7) 	CALL output
119:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
120:     ST  1,-8(1) 	Store old fp in ghost frame 
121:     LD  3,-1(0) 	Load variable y
122:     ST  3,-10(1) 	Store parameter 
123:    LDA  1,-8(1) 	Load address of new frame 
124:    LDA  3,1(7) 	Return address in ac 
125:    LDA  7,-120(7) 	CALL output
126:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
127:     ST  1,-8(1) 	Store old fp in ghost frame 
128:     LD  3,-4(1) 	Load variable z
129:     ST  3,-10(1) 	Store parameter 
130:    LDA  1,-8(1) 	Load address of new frame 
131:    LDA  3,1(7) 	Return address in ac 
132:    LDA  7,-127(7) 	CALL output
133:    LDA  3,0(2) 	Save the result in ac 
* BEGIN compound statement
* EXPRESSION STMT
134:    LDC  3,666(6) 	Load constant 
135:     ST  3,-5(1) 	Store variable a
* EXPRESSION STMT
136:    LDC  3,666(6) 	Load constant 
137:     ST  3,-6(1) 	Store variable b
* EXPRESSION STMT
138:    LDC  3,666(6) 	Load constant 
139:     ST  3,-7(1) 	Store variable z
* EXPRESSION STMT
140:     ST  1,-8(1) 	Store old fp in ghost frame 
141:     LD  3,-5(1) 	Load variable a
142:     ST  3,-10(1) 	Store parameter 
143:    LDA  1,-8(1) 	Load address of new frame 
144:    LDA  3,1(7) 	Return address in ac 
145:    LDA  7,-140(7) 	CALL output
146:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
147:     ST  1,-8(1) 	Store old fp in ghost frame 
148:     LD  3,-6(1) 	Load variable b
149:     ST  3,-10(1) 	Store parameter 
150:    LDA  1,-8(1) 	Load address of new frame 
151:    LDA  3,1(7) 	Return address in ac 
152:    LDA  7,-147(7) 	CALL output
153:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
154:     ST  1,-8(1) 	Store old fp in ghost frame 
155:     LD  3,0(0) 	Load variable x
156:     ST  3,-10(1) 	Store parameter 
157:    LDA  1,-8(1) 	Load address of new frame 
158:    LDA  3,1(7) 	Return address in ac 
159:    LDA  7,-154(7) 	CALL output
160:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
161:     ST  1,-8(1) 	Store old fp in ghost frame 
162:     LD  3,-1(0) 	Load variable y
163:     ST  3,-10(1) 	Store parameter 
164:    LDA  1,-8(1) 	Load address of new frame 
165:    LDA  3,1(7) 	Return address in ac 
166:    LDA  7,-161(7) 	CALL output
167:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
168:     ST  1,-8(1) 	Store old fp in ghost frame 
169:     LD  3,-7(1) 	Load variable z
170:     ST  3,-10(1) 	Store parameter 
171:    LDA  1,-8(1) 	Load address of new frame 
172:    LDA  3,1(7) 	Return address in ac 
173:    LDA  7,-168(7) 	CALL output
174:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
175:    LDC  3,11(6) 	Load constant 
176:     ST  3,-5(1) 	Store variable a
* EXPRESSION STMT
177:    LDC  3,12(6) 	Load constant 
178:     ST  3,-6(1) 	Store variable b
* EXPRESSION STMT
179:    LDC  3,13(6) 	Load constant 
180:     ST  3,0(0) 	Store variable x
* EXPRESSION STMT
181:    LDC  3,14(6) 	Load constant 
182:     ST  3,-1(0) 	Store variable y
* EXPRESSION STMT
183:    LDC  3,15(6) 	Load constant 
184:     ST  3,-7(1) 	Store variable z
* EXPRESSION STMT
185:     ST  1,-8(1) 	Store old fp in ghost frame 
186:     LD  3,-5(1) 	Load variable a
187:     ST  3,-10(1) 	Store parameter 
188:    LDA  1,-8(1) 	Load address of new frame 
189:    LDA  3,1(7) 	Return address in ac 
190:    LDA  7,-185(7) 	CALL output
191:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
192:     ST  1,-8(1) 	Store old fp in ghost frame 
193:     LD  3,-6(1) 	Load variable b
194:     ST  3,-10(1) 	Store parameter 
195:    LDA  1,-8(1) 	Load address of new frame 
196:    LDA  3,1(7) 	Return address in ac 
197:    LDA  7,-192(7) 	CALL output
198:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
199:     ST  1,-8(1) 	Store old fp in ghost frame 
200:     LD  3,0(0) 	Load variable x
201:     ST  3,-10(1) 	Store parameter 
202:    LDA  1,-8(1) 	Load address of new frame 
203:    LDA  3,1(7) 	Return address in ac 
204:    LDA  7,-199(7) 	CALL output
205:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
206:     ST  1,-8(1) 	Store old fp in ghost frame 
207:     LD  3,-1(0) 	Load variable y
208:     ST  3,-10(1) 	Store parameter 
209:    LDA  1,-8(1) 	Load address of new frame 
210:    LDA  3,1(7) 	Return address in ac 
211:    LDA  7,-206(7) 	CALL output
212:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
213:     ST  1,-8(1) 	Store old fp in ghost frame 
214:     LD  3,-7(1) 	Load variable z
215:     ST  3,-10(1) 	Store parameter 
216:    LDA  1,-8(1) 	Load address of new frame 
217:    LDA  3,1(7) 	Return address in ac 
218:    LDA  7,-213(7) 	CALL output
219:    LDA  3,0(2) 	Save the result in ac 
* BEGIN compound statement
* EXPRESSION STMT
220:     ST  1,-8(1) 	Store old fp in ghost frame 
221:     LD  3,-5(1) 	Load variable a
222:     ST  3,-10(1) 	Store parameter 
223:    LDA  1,-8(1) 	Load address of new frame 
224:    LDA  3,1(7) 	Return address in ac 
225:    LDA  7,-220(7) 	CALL output
226:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
227:     ST  1,-8(1) 	Store old fp in ghost frame 
228:     LD  3,-6(1) 	Load variable b
229:     ST  3,-10(1) 	Store parameter 
230:    LDA  1,-8(1) 	Load address of new frame 
231:    LDA  3,1(7) 	Return address in ac 
232:    LDA  7,-227(7) 	CALL output
233:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
234:     ST  1,-8(1) 	Store old fp in ghost frame 
235:     LD  3,0(0) 	Load variable x
236:     ST  3,-10(1) 	Store parameter 
237:    LDA  1,-8(1) 	Load address of new frame 
238:    LDA  3,1(7) 	Return address in ac 
239:    LDA  7,-234(7) 	CALL output
240:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
241:     ST  1,-8(1) 	Store old fp in ghost frame 
242:     LD  3,-1(0) 	Load variable y
243:     ST  3,-10(1) 	Store parameter 
244:    LDA  1,-8(1) 	Load address of new frame 
245:    LDA  3,1(7) 	Return address in ac 
246:    LDA  7,-241(7) 	CALL output
247:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
248:     ST  1,-8(1) 	Store old fp in ghost frame 
249:     LD  3,-7(1) 	Load variable z
250:     ST  3,-10(1) 	Store parameter 
251:    LDA  1,-8(1) 	Load address of new frame 
252:    LDA  3,1(7) 	Return address in ac 
253:    LDA  7,-248(7) 	CALL output
254:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
255:    LDC  3,16(6) 	Load constant 
256:     ST  3,-5(1) 	Store variable a
* EXPRESSION STMT
257:    LDC  3,17(6) 	Load constant 
258:     ST  3,-6(1) 	Store variable b
* EXPRESSION STMT
259:    LDC  3,18(6) 	Load constant 
260:     ST  3,0(0) 	Store variable x
* EXPRESSION STMT
261:    LDC  3,19(6) 	Load constant 
262:     ST  3,-1(0) 	Store variable y
* EXPRESSION STMT
263:    LDC  3,20(6) 	Load constant 
264:     ST  3,-7(1) 	Store variable z
* EXPRESSION STMT
265:     ST  1,-8(1) 	Store old fp in ghost frame 
266:     LD  3,-5(1) 	Load variable a
267:     ST  3,-10(1) 	Store parameter 
268:    LDA  1,-8(1) 	Load address of new frame 
269:    LDA  3,1(7) 	Return address in ac 
270:    LDA  7,-265(7) 	CALL output
271:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
272:     ST  1,-8(1) 	Store old fp in ghost frame 
273:     LD  3,-6(1) 	Load variable b
274:     ST  3,-10(1) 	Store parameter 
275:    LDA  1,-8(1) 	Load address of new frame 
276:    LDA  3,1(7) 	Return address in ac 
277:    LDA  7,-272(7) 	CALL output
278:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
279:     ST  1,-8(1) 	Store old fp in ghost frame 
280:     LD  3,0(0) 	Load variable x
281:     ST  3,-10(1) 	Store parameter 
282:    LDA  1,-8(1) 	Load address of new frame 
283:    LDA  3,1(7) 	Return address in ac 
284:    LDA  7,-279(7) 	CALL output
285:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
286:     ST  1,-8(1) 	Store old fp in ghost frame 
287:     LD  3,-1(0) 	Load variable y
288:     ST  3,-10(1) 	Store parameter 
289:    LDA  1,-8(1) 	Load address of new frame 
290:    LDA  3,1(7) 	Return address in ac 
291:    LDA  7,-286(7) 	CALL output
292:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
293:     ST  1,-8(1) 	Store old fp in ghost frame 
294:     LD  3,-7(1) 	Load variable z
295:     ST  3,-10(1) 	Store parameter 
296:    LDA  1,-8(1) 	Load address of new frame 
297:    LDA  3,1(7) 	Return address in ac 
298:    LDA  7,-293(7) 	CALL output
299:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* EXPRESSION STMT
300:     ST  1,-8(1) 	Store old fp in ghost frame 
301:     LD  3,-5(1) 	Load variable a
302:     ST  3,-10(1) 	Store parameter 
303:    LDA  1,-8(1) 	Load address of new frame 
304:    LDA  3,1(7) 	Return address in ac 
305:    LDA  7,-300(7) 	CALL output
306:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
307:     ST  1,-8(1) 	Store old fp in ghost frame 
308:     LD  3,-6(1) 	Load variable b
309:     ST  3,-10(1) 	Store parameter 
310:    LDA  1,-8(1) 	Load address of new frame 
311:    LDA  3,1(7) 	Return address in ac 
312:    LDA  7,-307(7) 	CALL output
313:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
314:     ST  1,-8(1) 	Store old fp in ghost frame 
315:     LD  3,0(0) 	Load variable x
316:     ST  3,-10(1) 	Store parameter 
317:    LDA  1,-8(1) 	Load address of new frame 
318:    LDA  3,1(7) 	Return address in ac 
319:    LDA  7,-314(7) 	CALL output
320:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
321:     ST  1,-8(1) 	Store old fp in ghost frame 
322:     LD  3,-1(0) 	Load variable y
323:     ST  3,-10(1) 	Store parameter 
324:    LDA  1,-8(1) 	Load address of new frame 
325:    LDA  3,1(7) 	Return address in ac 
326:    LDA  7,-321(7) 	CALL output
327:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
328:     ST  1,-8(1) 	Store old fp in ghost frame 
329:     LD  3,-7(1) 	Load variable z
330:     ST  3,-10(1) 	Store parameter 
331:    LDA  1,-8(1) 	Load address of new frame 
332:    LDA  3,1(7) 	Return address in ac 
333:    LDA  7,-328(7) 	CALL output
334:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
335:     ST  1,-8(1) 	Store old fp in ghost frame 
336:    LDA  1,-8(1) 	Load address of new frame 
337:    LDA  3,1(7) 	Return address in ac 
338:    LDA  7,-309(7) 	CALL agamemnon
339:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
340:     ST  1,-8(1) 	Store old fp in ghost frame 
341:     LD  3,-5(1) 	Load variable a
342:     ST  3,-10(1) 	Store parameter 
343:    LDA  1,-8(1) 	Load address of new frame 
344:    LDA  3,1(7) 	Return address in ac 
345:    LDA  7,-340(7) 	CALL output
346:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
347:     ST  1,-8(1) 	Store old fp in ghost frame 
348:     LD  3,-6(1) 	Load variable b
349:     ST  3,-10(1) 	Store parameter 
350:    LDA  1,-8(1) 	Load address of new frame 
351:    LDA  3,1(7) 	Return address in ac 
352:    LDA  7,-347(7) 	CALL output
353:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
354:     ST  1,-8(1) 	Store old fp in ghost frame 
355:     LD  3,0(0) 	Load variable x
356:     ST  3,-10(1) 	Store parameter 
357:    LDA  1,-8(1) 	Load address of new frame 
358:    LDA  3,1(7) 	Return address in ac 
359:    LDA  7,-354(7) 	CALL output
360:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
361:     ST  1,-8(1) 	Store old fp in ghost frame 
362:     LD  3,-1(0) 	Load variable y
363:     ST  3,-10(1) 	Store parameter 
364:    LDA  1,-8(1) 	Load address of new frame 
365:    LDA  3,1(7) 	Return address in ac 
366:    LDA  7,-361(7) 	CALL output
367:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
368:     ST  1,-8(1) 	Store old fp in ghost frame 
369:     LD  3,-7(1) 	Load variable z
370:     ST  3,-10(1) 	Store parameter 
371:    LDA  1,-8(1) 	Load address of new frame 
372:    LDA  3,1(7) 	Return address in ac 
373:    LDA  7,-368(7) 	CALL output
374:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* END compound statement
* Add standard closing in case there is no return statement
375:    LDC  2,0(6) 	Set return value to 0 
376:     LD  3,-1(1) 	Load return address 
377:     LD  1,0(1) 	Adjust fp 
378:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,378(7) 	Jump to init 
* BEGIN Init
379:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
380:    LDA  1,-3(0) 	set first frame at end of globals 
381:     ST  1,0(1) 	store old fp (point to self) 
382:    LDA  3,1(7) 	Return address in ac 
383:    LDA  7,-296(7) 	Jump to main 
384:   HALT  0,0,0 	DONE! 
* END Init
