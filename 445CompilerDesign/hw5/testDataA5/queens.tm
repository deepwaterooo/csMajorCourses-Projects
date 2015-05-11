* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  queens.c-
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
* BEGIN function printboard
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 31:    LDC  3,0(6) 	Load constant 
 32:     ST  3,-3(1) 	Store variable i
* WHILE
 33:     LD  3,-3(1) 	Load variable i
 34:     ST  3,-4(1) 	Save left side 
 35:     LD  3,-78(0) 	Load variable n
 36:     LD  4,-4(1) 	Load left into ac1 
 37:    SUB  4,4,3 	Op < 
 38:    LDC  3,1(6) 	True case 
 39:    JLT  4,1(7) 	Jump if true 
 40:    LDC  3,0(6) 	False case 
 41:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 43:     ST  1,-4(1) 	Store old fp in ghost frame 
 44:     LD  3,-3(1) 	Load variable i
 45:     LD  4,-2(1) 	Load address of base of array col
 46:    SUB  3,4,3 	Compute offset of value 
 47:     LD  3,0(3) 	Load the value 
 48:     ST  3,-6(1) 	Store parameter 
 49:    LDA  1,-4(1) 	Load address of new frame 
 50:    LDA  3,1(7) 	Return address in ac 
 51:    LDA  7,-46(7) 	CALL output
 52:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 53:     LD  3,-3(1) 	load lhs variable i
 54:    LDA  3,1(3) 	increment value of i
 55:     ST  3,-3(1) 	Store variable i
* END compound statement
 56:    LDA  7,-24(7) 	go to beginning of loop 
 42:    LDA  7,14(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
 57:     ST  1,-4(1) 	Store old fp in ghost frame 
 58:    LDA  1,-4(1) 	Load address of new frame 
 59:    LDA  3,1(7) 	Return address in ac 
 60:    LDA  7,-36(7) 	CALL outnl
 61:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 62:     LD  3,-79(0) 	load lhs variable count
 63:    LDA  3,1(3) 	increment value of count
 64:     ST  3,-79(0) 	Store variable count
* END compound statement
* Add standard closing in case there is no return statement
 65:    LDC  2,0(6) 	Set return value to 0 
 66:     LD  3,-1(1) 	Load return address 
 67:     LD  1,0(1) 	Adjust fp 
 68:    LDA  7,0(3) 	Return 
* END of function printboard
* BEGIN function try
 69:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* IF
 70:     LD  3,-2(1) 	Load variable c
 71:     ST  3,-4(1) 	Save left side 
 72:     LD  3,-78(0) 	Load variable n
 73:     LD  4,-4(1) 	Load left into ac1 
 74:    SUB  4,4,3 	Op == 
 75:    LDC  3,1(6) 	True case 
 76:    JEQ  4,1(7) 	Jump if true 
 77:    LDC  3,0(6) 	False case 
 78:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
 80:     ST  1,-4(1) 	Store old fp in ghost frame 
 81:    LDA  3,-14(0) 	Load address of base of array col
 82:     ST  3,-6(1) 	Store parameter 
 83:    LDA  1,-4(1) 	Load address of new frame 
 84:    LDA  3,1(7) 	Return address in ac 
 85:    LDA  7,-56(7) 	CALL printboard
 86:    LDA  3,0(2) 	Save the result in ac 
* ELSE
 79:    LDA  7,8(7) 	Jump around the THEN 
* BEGIN compound statement
* EXPRESSION STMT
 88:    LDC  3,0(6) 	Load constant 
 89:     ST  3,-3(1) 	Store variable r
* WHILE
 90:     LD  3,-3(1) 	Load variable r
 91:     ST  3,-4(1) 	Save left side 
 92:     LD  3,-78(0) 	Load variable n
 93:     LD  4,-4(1) 	Load left into ac1 
 94:    SUB  4,4,3 	Op < 
 95:    LDC  3,1(6) 	True case 
 96:    JLT  4,1(7) 	Jump if true 
 97:    LDC  3,0(6) 	False case 
 98:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* IF
100:     LD  3,-3(1) 	Load variable r
101:    LDA  4,-1(0) 	Load address of base of array row
102:    SUB  3,4,3 	Compute offset of value 
103:     LD  3,0(3) 	Load the value 
104:     ST  3,-4(1) 	Save left side 
105:    LDC  3,0(6) 	Load constant 
106:     LD  4,-4(1) 	Load left into ac1 
107:    SUB  4,4,3 	Op == 
108:    LDC  3,1(6) 	True case 
109:    JEQ  4,1(7) 	Jump if true 
110:    LDC  3,0(6) 	False case 
111:     ST  3,-4(1) 	Save left side 
112:     LD  3,-3(1) 	Load variable r
113:     ST  3,-5(1) 	Save left side 
114:     LD  3,-2(1) 	Load variable c
115:     LD  4,-5(1) 	Load left into ac1 
116:    ADD  3,4,3 	Op + 
117:    LDA  4,-27(0) 	Load address of base of array diagone
118:    SUB  3,4,3 	Compute offset of value 
119:     LD  3,0(3) 	Load the value 
120:     ST  3,-5(1) 	Save left side 
121:    LDC  3,0(6) 	Load constant 
122:     LD  4,-5(1) 	Load left into ac1 
123:    SUB  4,4,3 	Op == 
124:    LDC  3,1(6) 	True case 
125:    JEQ  4,1(7) 	Jump if true 
126:    LDC  3,0(6) 	False case 
127:     LD  4,-4(1) 	Load left into ac1 
128:    JEQ  3,1(7) 	Op AND 
129:    LDA  3,0(4) 	 
130:     ST  3,-4(1) 	Save left side 
131:     LD  3,-3(1) 	Load variable r
132:     ST  3,-5(1) 	Save left side 
133:     LD  3,-78(0) 	Load variable n
134:     ST  3,-6(1) 	Save left side 
135:    LDC  3,1(6) 	Load constant 
136:     LD  4,-6(1) 	Load left into ac1 
137:    SUB  3,4,3 	Op - 
138:     LD  4,-5(1) 	Load left into ac1 
139:    ADD  3,4,3 	Op + 
140:     ST  3,-5(1) 	Save left side 
141:     LD  3,-2(1) 	Load variable c
142:     LD  4,-5(1) 	Load left into ac1 
143:    SUB  3,4,3 	Op - 
144:    LDA  4,-53(0) 	Load address of base of array diagtwo
145:    SUB  3,4,3 	Compute offset of value 
146:     LD  3,0(3) 	Load the value 
147:     ST  3,-5(1) 	Save left side 
148:    LDC  3,0(6) 	Load constant 
149:     LD  4,-5(1) 	Load left into ac1 
150:    SUB  4,4,3 	Op == 
151:    LDC  3,1(6) 	True case 
152:    JEQ  4,1(7) 	Jump if true 
153:    LDC  3,0(6) 	False case 
154:     LD  4,-4(1) 	Load left into ac1 
155:    JEQ  3,1(7) 	Op AND 
156:    LDA  3,0(4) 	 
157:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
159:     LD  3,-3(1) 	Load variable r
160:     ST  3,-4(1) 	Save index 
161:    LDC  3,1(6) 	Load constant 
162:     LD  4,-4(1) 	Restore index 
163:    LDA  5,-1(0) 	Load address of base of array row
164:    SUB  5,5,4 	Compute offset of value 
165:     ST  3,0(5) 	Store variable row
* EXPRESSION STMT
166:     LD  3,-2(1) 	Load variable c
167:     ST  3,-4(1) 	Save index 
168:     LD  3,-3(1) 	Load variable r
169:     LD  4,-4(1) 	Restore index 
170:    LDA  5,-14(0) 	Load address of base of array col
171:    SUB  5,5,4 	Compute offset of value 
172:     ST  3,0(5) 	Store variable col
* EXPRESSION STMT
173:     LD  3,-3(1) 	Load variable r
174:     ST  3,-4(1) 	Save left side 
175:     LD  3,-2(1) 	Load variable c
176:     LD  4,-4(1) 	Load left into ac1 
177:    ADD  3,4,3 	Op + 
178:     ST  3,-4(1) 	Save index 
179:    LDC  3,1(6) 	Load constant 
180:     LD  4,-4(1) 	Restore index 
181:    LDA  5,-27(0) 	Load address of base of array diagone
182:    SUB  5,5,4 	Compute offset of value 
183:     ST  3,0(5) 	Store variable diagone
* EXPRESSION STMT
184:     LD  3,-3(1) 	Load variable r
185:     ST  3,-4(1) 	Save left side 
186:     LD  3,-78(0) 	Load variable n
187:     ST  3,-5(1) 	Save left side 
188:    LDC  3,1(6) 	Load constant 
189:     LD  4,-5(1) 	Load left into ac1 
190:    SUB  3,4,3 	Op - 
191:     LD  4,-4(1) 	Load left into ac1 
192:    ADD  3,4,3 	Op + 
193:     ST  3,-4(1) 	Save left side 
194:     LD  3,-2(1) 	Load variable c
195:     LD  4,-4(1) 	Load left into ac1 
196:    SUB  3,4,3 	Op - 
197:     ST  3,-4(1) 	Save index 
198:    LDC  3,1(6) 	Load constant 
199:     LD  4,-4(1) 	Restore index 
200:    LDA  5,-53(0) 	Load address of base of array diagtwo
201:    SUB  5,5,4 	Compute offset of value 
202:     ST  3,0(5) 	Store variable diagtwo
* EXPRESSION STMT
203:     ST  1,-4(1) 	Store old fp in ghost frame 
204:     LD  3,-2(1) 	Load variable c
205:     ST  3,-6(1) 	Save left side 
206:    LDC  3,1(6) 	Load constant 
207:     LD  4,-6(1) 	Load left into ac1 
208:    ADD  3,4,3 	Op + 
209:     ST  3,-6(1) 	Store parameter 
210:    LDA  1,-4(1) 	Load address of new frame 
211:    LDA  3,1(7) 	Return address in ac 
212:    LDA  7,-144(7) 	CALL try
213:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
214:     LD  3,-3(1) 	Load variable r
215:     ST  3,-4(1) 	Save index 
216:    LDC  3,0(6) 	Load constant 
217:     LD  4,-4(1) 	Restore index 
218:    LDA  5,-1(0) 	Load address of base of array row
219:    SUB  5,5,4 	Compute offset of value 
220:     ST  3,0(5) 	Store variable row
* EXPRESSION STMT
221:     LD  3,-3(1) 	Load variable r
222:     ST  3,-4(1) 	Save left side 
223:     LD  3,-2(1) 	Load variable c
224:     LD  4,-4(1) 	Load left into ac1 
225:    ADD  3,4,3 	Op + 
226:     ST  3,-4(1) 	Save index 
227:    LDC  3,0(6) 	Load constant 
228:     LD  4,-4(1) 	Restore index 
229:    LDA  5,-27(0) 	Load address of base of array diagone
230:    SUB  5,5,4 	Compute offset of value 
231:     ST  3,0(5) 	Store variable diagone
* EXPRESSION STMT
232:     LD  3,-3(1) 	Load variable r
233:     ST  3,-4(1) 	Save left side 
234:     LD  3,-78(0) 	Load variable n
235:     ST  3,-5(1) 	Save left side 
236:    LDC  3,1(6) 	Load constant 
237:     LD  4,-5(1) 	Load left into ac1 
238:    SUB  3,4,3 	Op - 
239:     LD  4,-4(1) 	Load left into ac1 
240:    ADD  3,4,3 	Op + 
241:     ST  3,-4(1) 	Save left side 
242:     LD  3,-2(1) 	Load variable c
243:     LD  4,-4(1) 	Load left into ac1 
244:    SUB  3,4,3 	Op - 
245:     ST  3,-4(1) 	Save index 
246:    LDC  3,0(6) 	Load constant 
247:     LD  4,-4(1) 	Restore index 
248:    LDA  5,-53(0) 	Load address of base of array diagtwo
249:    SUB  5,5,4 	Compute offset of value 
250:     ST  3,0(5) 	Store variable diagtwo
* END compound statement
158:    LDA  7,92(7) 	Jump around the THEN 
* ENDIF
* EXPRESSION STMT
251:     LD  3,-3(1) 	load lhs variable r
252:    LDA  3,1(3) 	increment value of r
253:     ST  3,-3(1) 	Store variable r
* END compound statement
254:    LDA  7,-165(7) 	go to beginning of loop 
 99:    LDA  7,155(7) 	No more loop 
* ENDWHILE
* END compound statement
 87:    LDA  7,167(7) 	Jump around the ELSE 
* ENDIF
* END compound statement
* Add standard closing in case there is no return statement
255:    LDC  2,0(6) 	Set return value to 0 
256:     LD  3,-1(1) 	Load return address 
257:     LD  1,0(1) 	Adjust fp 
258:    LDA  7,0(3) 	Return 
* END of function try
* BEGIN function solve
259:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
260:     LD  3,-2(1) 	Load variable num
261:     ST  3,-78(0) 	Store variable n
* EXPRESSION STMT
262:    LDC  3,0(6) 	Load constant 
263:     ST  3,-79(0) 	Store variable count
* EXPRESSION STMT
264:     ST  1,-3(1) 	Store old fp in ghost frame 
265:    LDC  3,0(6) 	Load constant 
266:     ST  3,-5(1) 	Store parameter 
267:    LDA  1,-3(1) 	Load address of new frame 
268:    LDA  3,1(7) 	Return address in ac 
269:    LDA  7,-201(7) 	CALL try
270:    LDA  3,0(2) 	Save the result in ac 
* RETURN
271:     LD  3,-79(0) 	Load variable count
272:    LDA  2,0(3) 	Copy result to rt register 
273:     LD  3,-1(1) 	Load return address 
274:     LD  1,0(1) 	Adjust fp 
275:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
276:    LDC  2,0(6) 	Set return value to 0 
277:     LD  3,-1(1) 	Load return address 
278:     LD  1,0(1) 	Adjust fp 
279:    LDA  7,0(3) 	Return 
* END of function solve
* BEGIN function main
280:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* WHILE
281:     ST  1,-3(1) 	Store old fp in ghost frame 
282:    LDA  1,-3(1) 	Load address of new frame 
283:    LDA  3,1(7) 	Return address in ac 
284:    LDA  7,-284(7) 	CALL input
285:    LDA  3,0(2) 	Save the result in ac 
286:     ST  3,-2(1) 	Store variable num
287:     ST  3,-3(1) 	Save left side 
288:    LDC  3,0(6) 	Load constant 
289:     LD  4,-3(1) 	Load left into ac1 
290:    SUB  4,4,3 	Op > 
291:    LDC  3,1(6) 	True case 
292:    JGT  4,1(7) 	Jump if true 
293:    LDC  3,0(6) 	False case 
294:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
296:     ST  1,-3(1) 	Store old fp in ghost frame 
297:     ST  1,-5(1) 	Store old fp in ghost frame 
298:     LD  3,-2(1) 	Load variable num
299:     ST  3,-7(1) 	Store parameter 
300:    LDA  1,-5(1) 	Load address of new frame 
301:    LDA  3,1(7) 	Return address in ac 
302:    LDA  7,-44(7) 	CALL solve
303:    LDA  3,0(2) 	Save the result in ac 
304:     ST  3,-5(1) 	Store parameter 
305:    LDA  1,-3(1) 	Load address of new frame 
306:    LDA  3,1(7) 	Return address in ac 
307:    LDA  7,-302(7) 	CALL output
308:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
309:     ST  1,-3(1) 	Store old fp in ghost frame 
310:    LDA  1,-3(1) 	Load address of new frame 
311:    LDA  3,1(7) 	Return address in ac 
312:    LDA  7,-288(7) 	CALL outnl
313:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
314:    LDA  7,-34(7) 	go to beginning of loop 
295:    LDA  7,19(7) 	No more loop 
* ENDWHILE
* END compound statement
* Add standard closing in case there is no return statement
315:    LDC  2,0(6) 	Set return value to 0 
316:     LD  3,-1(1) 	Load return address 
317:     LD  1,0(1) 	Adjust fp 
318:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,318(7) 	Jump to init 
* BEGIN Init
319:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
320:    LDC  3,12(6) 	load size of array row
321:     ST  3,0(0) 	save size of array row
322:    LDC  3,12(6) 	load size of array col
323:     ST  3,-13(0) 	save size of array col
324:    LDC  3,25(6) 	load size of array diagone
325:     ST  3,-26(0) 	save size of array diagone
326:    LDC  3,25(6) 	load size of array diagtwo
327:     ST  3,-52(0) 	save size of array diagtwo
* END init of global array sizes
328:    LDA  1,-80(0) 	set first frame at end of globals 
329:     ST  1,0(1) 	store old fp (point to self) 
330:    LDA  3,1(7) 	Return address in ac 
331:    LDA  7,-52(7) 	Jump to main 
332:   HALT  0,0,0 	DONE! 
* END Init
