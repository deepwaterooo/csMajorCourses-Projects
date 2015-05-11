* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  proc.c-
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
* BEGIN function square
 30:     ST  3,-1(1) 	Store return address. 
* RETURN
 31:     LD  3,-2(1) 	Load variable x
 32:     ST  3,-3(1) 	Save left side 
 33:     LD  3,-2(1) 	Load variable x
 34:     LD  4,-3(1) 	Load left into ac1 
 35:    MUL  3,4,3 	Op * 
 36:    LDA  2,0(3) 	Copy result to rt register 
 37:     LD  3,-1(1) 	Load return address 
 38:     LD  1,0(1) 	Adjust fp 
 39:    LDA  7,0(3) 	Return 
* Add standard closing in case there is no return statement
 40:    LDC  2,0(6) 	Set return value to 0 
 41:     LD  3,-1(1) 	Load return address 
 42:     LD  1,0(1) 	Adjust fp 
 43:    LDA  7,0(3) 	Return 
* END of function square
* BEGIN function max
 44:     ST  3,-1(1) 	Store return address. 
* IF
 45:     LD  3,-2(1) 	Load variable x
 46:     ST  3,-4(1) 	Save left side 
 47:     LD  3,-3(1) 	Load variable y
 48:     LD  4,-4(1) 	Load left into ac1 
 49:    SUB  4,4,3 	Op > 
 50:    LDC  3,1(6) 	True case 
 51:    JGT  4,1(7) 	Jump if true 
 52:    LDC  3,0(6) 	False case 
 53:    JGT  3,1(7) 	Jump to then part 
* THEN
* RETURN
 55:     LD  3,-2(1) 	Load variable x
 56:    LDA  2,0(3) 	Copy result to rt register 
 57:     LD  3,-1(1) 	Load return address 
 58:     LD  1,0(1) 	Adjust fp 
 59:    LDA  7,0(3) 	Return 
* ELSE
 54:    LDA  7,6(7) 	Jump around the THEN 
* RETURN
 61:     LD  3,-3(1) 	Load variable y
 62:    LDA  2,0(3) 	Copy result to rt register 
 63:     LD  3,-1(1) 	Load return address 
 64:     LD  1,0(1) 	Adjust fp 
 65:    LDA  7,0(3) 	Return 
 60:    LDA  7,5(7) 	Jump around the ELSE 
* ENDIF
* Add standard closing in case there is no return statement
 66:    LDC  2,0(6) 	Set return value to 0 
 67:     LD  3,-1(1) 	Load return address 
 68:     LD  1,0(1) 	Adjust fp 
 69:    LDA  7,0(3) 	Return 
* END of function max
* BEGIN function toInt
 70:     ST  3,-1(1) 	Store return address. 
* IF
 71:     LD  3,-2(1) 	Load variable b
 72:    JGT  3,1(7) 	Jump to then part 
* THEN
* RETURN
 74:    LDC  3,1(6) 	Load constant 
 75:    LDA  2,0(3) 	Copy result to rt register 
 76:     LD  3,-1(1) 	Load return address 
 77:     LD  1,0(1) 	Adjust fp 
 78:    LDA  7,0(3) 	Return 
* ELSE
 73:    LDA  7,6(7) 	Jump around the THEN 
* RETURN
 80:    LDC  3,0(6) 	Load constant 
 81:    LDA  2,0(3) 	Copy result to rt register 
 82:     LD  3,-1(1) 	Load return address 
 83:     LD  1,0(1) 	Adjust fp 
 84:    LDA  7,0(3) 	Return 
 79:    LDA  7,5(7) 	Jump around the ELSE 
* ENDIF
* Add standard closing in case there is no return statement
 85:    LDC  2,0(6) 	Set return value to 0 
 86:     LD  3,-1(1) 	Load return address 
 87:     LD  1,0(1) 	Adjust fp 
 88:    LDA  7,0(3) 	Return 
* END of function toInt
* BEGIN function toBool
 89:     ST  3,-1(1) 	Store return address. 
* IF
 90:     LD  3,-2(1) 	Load variable x
 91:     ST  3,-3(1) 	Save left side 
 92:    LDC  3,0(6) 	Load constant 
 93:     LD  4,-3(1) 	Load left into ac1 
 94:    SUB  4,4,3 	Op == 
 95:    LDC  3,1(6) 	True case 
 96:    JEQ  4,1(7) 	Jump if true 
 97:    LDC  3,0(6) 	False case 
 98:    JGT  3,1(7) 	Jump to then part 
* THEN
* RETURN
100:    LDC  3,0(6) 	Load constant 
101:    LDA  2,0(3) 	Copy result to rt register 
102:     LD  3,-1(1) 	Load return address 
103:     LD  1,0(1) 	Adjust fp 
104:    LDA  7,0(3) 	Return 
* ELSE
 99:    LDA  7,6(7) 	Jump around the THEN 
* RETURN
106:    LDC  3,1(6) 	Load constant 
107:    LDA  2,0(3) 	Copy result to rt register 
108:     LD  3,-1(1) 	Load return address 
109:     LD  1,0(1) 	Adjust fp 
110:    LDA  7,0(3) 	Return 
105:    LDA  7,5(7) 	Jump around the ELSE 
* ENDIF
* Add standard closing in case there is no return statement
111:    LDC  2,0(6) 	Set return value to 0 
112:     LD  3,-1(1) 	Load return address 
113:     LD  1,0(1) 	Adjust fp 
114:    LDA  7,0(3) 	Return 
* END of function toBool
* BEGIN function main
115:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
116:     ST  1,-6(1) 	Store old fp in ghost frame 
117:     ST  1,-8(1) 	Store old fp in ghost frame 
118:    LDC  3,31(6) 	Load constant 
119:     ST  3,-10(1) 	Store parameter 
120:    LDA  1,-8(1) 	Load address of new frame 
121:    LDA  3,1(7) 	Return address in ac 
122:    LDA  7,-93(7) 	CALL square
123:    LDA  3,0(2) 	Save the result in ac 
124:     ST  3,-8(1) 	Store parameter 
125:    LDA  1,-6(1) 	Load address of new frame 
126:    LDA  3,1(7) 	Return address in ac 
127:    LDA  7,-122(7) 	CALL output
128:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
129:     ST  1,-6(1) 	Store old fp in ghost frame 
130:    LDA  1,-6(1) 	Load address of new frame 
131:    LDA  3,1(7) 	Return address in ac 
132:    LDA  7,-108(7) 	CALL outnl
133:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
134:     ST  1,-6(1) 	Store old fp in ghost frame 
135:     ST  1,-8(1) 	Store old fp in ghost frame 
136:    LDC  3,131(6) 	Load constant 
137:     ST  3,-10(1) 	Store parameter 
138:    LDC  3,42(6) 	Load constant 
139:     ST  3,-11(1) 	Store parameter 
140:    LDA  1,-8(1) 	Load address of new frame 
141:    LDA  3,1(7) 	Return address in ac 
142:    LDA  7,-99(7) 	CALL max
143:    LDA  3,0(2) 	Save the result in ac 
144:     ST  3,-8(1) 	Store parameter 
145:    LDA  1,-6(1) 	Load address of new frame 
146:    LDA  3,1(7) 	Return address in ac 
147:    LDA  7,-142(7) 	CALL output
148:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
149:     ST  1,-6(1) 	Store old fp in ghost frame 
150:    LDA  1,-6(1) 	Load address of new frame 
151:    LDA  3,1(7) 	Return address in ac 
152:    LDA  7,-128(7) 	CALL outnl
153:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
154:     ST  1,-6(1) 	Store old fp in ghost frame 
155:    LDC  3,42(6) 	Load constant 
156:     ST  3,-8(1) 	Store parameter 
157:    LDA  1,-6(1) 	Load address of new frame 
158:    LDA  3,1(7) 	Return address in ac 
159:    LDA  7,-71(7) 	CALL toBool
160:    LDA  3,0(2) 	Save the result in ac 
161:     ST  3,-2(1) 	Store variable a
* EXPRESSION STMT
162:     ST  1,-6(1) 	Store old fp in ghost frame 
163:    LDC  3,1(6) 	Load constant 
164:     ST  3,-8(1) 	Store parameter 
165:    LDA  1,-6(1) 	Load address of new frame 
166:    LDA  3,1(7) 	Return address in ac 
167:    LDA  7,-98(7) 	CALL toInt
168:    LDA  3,0(2) 	Save the result in ac 
169:     ST  3,-4(1) 	Store variable x
* EXPRESSION STMT
170:     ST  1,-6(1) 	Store old fp in ghost frame 
171:     LD  3,-4(1) 	Load variable x
172:     ST  3,-8(1) 	Store parameter 
173:    LDA  1,-6(1) 	Load address of new frame 
174:    LDA  3,1(7) 	Return address in ac 
175:    LDA  7,-170(7) 	CALL output
176:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
177:     ST  1,-6(1) 	Store old fp in ghost frame 
178:     LD  3,-2(1) 	Load variable a
179:     ST  3,-8(1) 	Store parameter 
180:    LDA  1,-6(1) 	Load address of new frame 
181:    LDA  3,1(7) 	Return address in ac 
182:    LDA  7,-165(7) 	CALL outputb
183:    LDA  3,0(2) 	Save the result in ac 
* IF
184:    LDC  3,666(6) 	Load constant 
185:     ST  3,-6(1) 	Save left side 
186:    LDC  3,1(6) 	Load constant 
187:     LD  4,-6(1) 	Load left into ac1 
188:    ADD  3,4,3 	Op + 
189:     ST  3,-6(1) 	Save left side 
190:    LDC  3,13(6) 	Load constant 
191:     LD  4,-6(1) 	Load left into ac1 
192:    SUB  4,4,3 	Op > 
193:    LDC  3,1(6) 	True case 
194:    JGT  4,1(7) 	Jump if true 
195:    LDC  3,0(6) 	False case 
196:    LDC  4,1(6) 	Load 1 
197:    SUB  3,4,3 	Op NOT 
198:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
200:     ST  1,-6(1) 	Store old fp in ghost frame 
201:    LDC  3,0(6) 	Load constant 
202:     ST  3,-8(1) 	Store parameter 
203:    LDA  1,-6(1) 	Load address of new frame 
204:    LDA  3,1(7) 	Return address in ac 
205:    LDA  7,-200(7) 	CALL output
206:    LDA  3,0(2) 	Save the result in ac 
* ELSE
199:    LDA  7,8(7) 	Jump around the THEN 
* EXPRESSION STMT
208:     ST  1,-6(1) 	Store old fp in ghost frame 
209:    LDC  3,666(6) 	Load constant 
210:     ST  3,-8(1) 	Store parameter 
211:    LDA  1,-6(1) 	Load address of new frame 
212:    LDA  3,1(7) 	Return address in ac 
213:    LDA  7,-208(7) 	CALL output
214:    LDA  3,0(2) 	Save the result in ac 
207:    LDA  7,7(7) 	Jump around the ELSE 
* ENDIF
* IF
215:    LDC  3,666(6) 	Load constant 
216:    LDC  4,0(6) 	Load 0 
217:    SUB  3,4,3 	Op unary - 
218:     ST  3,-6(1) 	Save left side 
219:    LDC  3,1(6) 	Load constant 
220:     LD  4,-6(1) 	Load left into ac1 
221:    ADD  3,4,3 	Op + 
222:     ST  3,-6(1) 	Save left side 
223:    LDC  3,13(6) 	Load constant 
224:    LDC  4,0(6) 	Load 0 
225:    SUB  3,4,3 	Op unary - 
226:     LD  4,-6(1) 	Load left into ac1 
227:    SUB  4,4,3 	Op > 
228:    LDC  3,1(6) 	True case 
229:    JGT  4,1(7) 	Jump if true 
230:    LDC  3,0(6) 	False case 
231:    LDC  4,1(6) 	Load 1 
232:    SUB  3,4,3 	Op NOT 
233:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
235:     ST  1,-6(1) 	Store old fp in ghost frame 
236:    LDC  3,0(6) 	Load constant 
237:     ST  3,-8(1) 	Store parameter 
238:    LDA  1,-6(1) 	Load address of new frame 
239:    LDA  3,1(7) 	Return address in ac 
240:    LDA  7,-235(7) 	CALL output
241:    LDA  3,0(2) 	Save the result in ac 
* ELSE
234:    LDA  7,8(7) 	Jump around the THEN 
* EXPRESSION STMT
243:     ST  1,-6(1) 	Store old fp in ghost frame 
244:    LDC  3,666(6) 	Load constant 
245:     ST  3,-8(1) 	Store parameter 
246:    LDA  1,-6(1) 	Load address of new frame 
247:    LDA  3,1(7) 	Return address in ac 
248:    LDA  7,-243(7) 	CALL output
249:    LDA  3,0(2) 	Save the result in ac 
242:    LDA  7,7(7) 	Jump around the ELSE 
* ENDIF
* IF
250:    LDC  3,666(6) 	Load constant 
251:    LDC  4,0(6) 	Load 0 
252:    SUB  3,4,3 	Op unary - 
253:     ST  3,-6(1) 	Save left side 
254:    LDC  3,1(6) 	Load constant 
255:     LD  4,-6(1) 	Load left into ac1 
256:    ADD  3,4,3 	Op + 
257:     ST  3,-6(1) 	Save left side 
258:    LDC  3,13(6) 	Load constant 
259:    LDC  4,0(6) 	Load 0 
260:    SUB  3,4,3 	Op unary - 
261:     LD  4,-6(1) 	Load left into ac1 
262:    SUB  4,4,3 	Op > 
263:    LDC  3,1(6) 	True case 
264:    JGT  4,1(7) 	Jump if true 
265:    LDC  3,0(6) 	False case 
266:    LDC  4,1(6) 	Load 1 
267:    SUB  3,4,3 	Op NOT 
268:    LDC  4,1(6) 	Load 1 
269:    SUB  3,4,3 	Op NOT 
270:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
272:     ST  1,-6(1) 	Store old fp in ghost frame 
273:    LDC  3,0(6) 	Load constant 
274:     ST  3,-8(1) 	Store parameter 
275:    LDA  1,-6(1) 	Load address of new frame 
276:    LDA  3,1(7) 	Return address in ac 
277:    LDA  7,-272(7) 	CALL output
278:    LDA  3,0(2) 	Save the result in ac 
* ELSE
271:    LDA  7,8(7) 	Jump around the THEN 
* EXPRESSION STMT
280:     ST  1,-6(1) 	Store old fp in ghost frame 
281:    LDC  3,666(6) 	Load constant 
282:     ST  3,-8(1) 	Store parameter 
283:    LDA  1,-6(1) 	Load address of new frame 
284:    LDA  3,1(7) 	Return address in ac 
285:    LDA  7,-280(7) 	CALL output
286:    LDA  3,0(2) 	Save the result in ac 
279:    LDA  7,7(7) 	Jump around the ELSE 
* ENDIF
* IF
287:    LDC  3,0(6) 	Load constant 
288:    LDC  4,1(6) 	Load 1 
289:    SUB  3,4,3 	Op NOT 
290:     ST  3,-6(1) 	Save left side 
291:    LDC  3,1(6) 	Load constant 
292:     LD  4,-6(1) 	Load left into ac1 
293:    JEQ  3,1(7) 	Op AND 
294:    LDA  3,0(4) 	 
295:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
297:     ST  1,-6(1) 	Store old fp in ghost frame 
298:    LDC  3,7(6) 	Load constant 
299:     ST  3,-8(1) 	Store parameter 
300:    LDA  1,-6(1) 	Load address of new frame 
301:    LDA  3,1(7) 	Return address in ac 
302:    LDA  7,-297(7) 	CALL output
303:    LDA  3,0(2) 	Save the result in ac 
296:    LDA  7,7(7) 	Jump around the THEN 
* ENDIF
* IF
304:    LDC  3,4(6) 	Load constant 
305:     ST  3,-6(1) 	Save left side 
306:    LDC  3,6(6) 	Load constant 
307:     LD  4,-6(1) 	Load left into ac1 
308:    SUB  4,4,3 	Op > 
309:    LDC  3,1(6) 	True case 
310:    JGT  4,1(7) 	Jump if true 
311:    LDC  3,0(6) 	False case 
312:    LDC  4,1(6) 	Load 1 
313:    SUB  3,4,3 	Op NOT 
314:     ST  3,-6(1) 	Save left side 
315:    LDC  3,6(6) 	Load constant 
316:     ST  3,-7(1) 	Save left side 
317:    LDC  3,4(6) 	Load constant 
318:     LD  4,-7(1) 	Load left into ac1 
319:    SUB  4,4,3 	Op > 
320:    LDC  3,1(6) 	True case 
321:    JGT  4,1(7) 	Jump if true 
322:    LDC  3,0(6) 	False case 
323:     LD  4,-6(1) 	Load left into ac1 
324:    JEQ  3,1(7) 	Op AND 
325:    LDA  3,0(4) 	 
326:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
328:     ST  1,-6(1) 	Store old fp in ghost frame 
329:    LDC  3,7(6) 	Load constant 
330:     ST  3,-8(1) 	Store parameter 
331:    LDA  1,-6(1) 	Load address of new frame 
332:    LDA  3,1(7) 	Return address in ac 
333:    LDA  7,-328(7) 	CALL output
334:    LDA  3,0(2) 	Save the result in ac 
327:    LDA  7,7(7) 	Jump around the THEN 
* ENDIF
* EXPRESSION STMT
335:     ST  1,-6(1) 	Store old fp in ghost frame 
336:    LDA  1,-6(1) 	Load address of new frame 
337:    LDA  3,1(7) 	Return address in ac 
338:    LDA  7,-314(7) 	CALL outnl
339:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
340:    LDC  2,0(6) 	Set return value to 0 
341:     LD  3,-1(1) 	Load return address 
342:     LD  1,0(1) 	Adjust fp 
343:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,343(7) 	Jump to init 
* BEGIN Init
344:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
345:    LDA  1,0(0) 	set first frame at end of globals 
346:     ST  1,0(1) 	store old fp (point to self) 
347:    LDA  3,1(7) 	Return address in ac 
348:    LDA  7,-234(7) 	Jump to main 
349:   HALT  0,0,0 	DONE! 
* END Init
