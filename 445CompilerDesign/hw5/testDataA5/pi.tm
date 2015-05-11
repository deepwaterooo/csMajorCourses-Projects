* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  pi.c-
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
 31:    LDC  3,340(6) 	load size of array a
 32:     ST  3,-11(1) 	save size of array a
* EXPRESSION STMT
 33:    LDC  3,100(6) 	Load constant 
 34:     ST  3,-2(1) 	Store variable N
* EXPRESSION STMT
 35:     LD  3,-2(1) 	Load variable N
 36:     ST  3,-352(1) 	Save left side 
 37:    LDC  3,10(6) 	Load constant 
 38:     LD  4,-352(1) 	Load left into ac1 
 39:    MUL  3,4,3 	Op * 
 40:     ST  3,-352(1) 	Save left side 
 41:    LDC  3,3(6) 	Load constant 
 42:     LD  4,-352(1) 	Load left into ac1 
 43:    DIV  3,4,3 	Op / 
 44:     ST  3,-3(1) 	Store variable LEN
* EXPRESSION STMT
 45:    LDC  3,0(6) 	Load constant 
 46:     ST  3,-5(1) 	Store variable j
* WHILE
 47:     LD  3,-5(1) 	Load variable j
 48:     ST  3,-352(1) 	Save left side 
 49:     LD  3,-3(1) 	Load variable LEN
 50:     LD  4,-352(1) 	Load left into ac1 
 51:    SUB  4,4,3 	Op < 
 52:    LDC  3,1(6) 	True case 
 53:    JLT  4,1(7) 	Jump if true 
 54:    LDC  3,0(6) 	False case 
 55:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 57:     LD  3,-5(1) 	Load variable j
 58:     ST  3,-352(1) 	Save index 
 59:    LDC  3,2(6) 	Load constant 
 60:     LD  4,-352(1) 	Restore index 
 61:    LDA  5,-12(1) 	Load address of base of array a
 62:    SUB  5,5,4 	Compute offset of value 
 63:     ST  3,0(5) 	Store variable a
* EXPRESSION STMT
 64:     LD  3,-5(1) 	load lhs variable j
 65:    LDA  3,1(3) 	increment value of j
 66:     ST  3,-5(1) 	Store variable j
* END compound statement
 67:    LDA  7,-21(7) 	go to beginning of loop 
 56:    LDA  7,11(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
 68:    LDC  3,0(6) 	Load constant 
 69:     ST  3,-9(1) 	Store variable nines
* EXPRESSION STMT
 70:    LDC  3,0(6) 	Load constant 
 71:     ST  3,-10(1) 	Store variable predigit
* EXPRESSION STMT
 72:    LDC  3,0(6) 	Load constant 
 73:     ST  3,-5(1) 	Store variable j
* WHILE
 74:     LD  3,-5(1) 	Load variable j
 75:     ST  3,-352(1) 	Save left side 
 76:     LD  3,-2(1) 	Load variable N
 77:     LD  4,-352(1) 	Load left into ac1 
 78:    SUB  4,4,3 	Op < 
 79:    LDC  3,1(6) 	True case 
 80:    JLT  4,1(7) 	Jump if true 
 81:    LDC  3,0(6) 	False case 
 82:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 84:    LDC  3,0(6) 	Load constant 
 85:     ST  3,-7(1) 	Store variable q
* EXPRESSION STMT
 86:     LD  3,-3(1) 	Load variable LEN
 87:     ST  3,-4(1) 	Store variable i
* WHILE
 88:     LD  3,-4(1) 	Load variable i
 89:     ST  3,-352(1) 	Save left side 
 90:    LDC  3,0(6) 	Load constant 
 91:     LD  4,-352(1) 	Load left into ac1 
 92:    SUB  4,4,3 	Op > 
 93:    LDC  3,1(6) 	True case 
 94:    JGT  4,1(7) 	Jump if true 
 95:    LDC  3,0(6) 	False case 
 96:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 98:    LDC  3,10(6) 	Load constant 
 99:     ST  3,-352(1) 	Save left side 
100:     LD  3,-4(1) 	Load variable i
101:     ST  3,-353(1) 	Save left side 
102:    LDC  3,1(6) 	Load constant 
103:     LD  4,-353(1) 	Load left into ac1 
104:    SUB  3,4,3 	Op - 
105:    LDA  4,-12(1) 	Load address of base of array a
106:    SUB  3,4,3 	Compute offset of value 
107:     LD  3,0(3) 	Load the value 
108:     LD  4,-352(1) 	Load left into ac1 
109:    MUL  3,4,3 	Op * 
110:     ST  3,-352(1) 	Save left side 
111:     LD  3,-7(1) 	Load variable q
112:     ST  3,-353(1) 	Save left side 
113:     LD  3,-4(1) 	Load variable i
114:     LD  4,-353(1) 	Load left into ac1 
115:    MUL  3,4,3 	Op * 
116:     LD  4,-352(1) 	Load left into ac1 
117:    ADD  3,4,3 	Op + 
118:     ST  3,-8(1) 	Store variable x
* EXPRESSION STMT
119:     LD  3,-4(1) 	Load variable i
120:     ST  3,-352(1) 	Save left side 
121:    LDC  3,1(6) 	Load constant 
122:     LD  4,-352(1) 	Load left into ac1 
123:    SUB  3,4,3 	Op - 
124:     ST  3,-352(1) 	Save index 
125:     LD  3,-8(1) 	Load variable x
126:     ST  3,-353(1) 	Save left side 
127:    LDC  3,2(6) 	Load constant 
128:     ST  3,-354(1) 	Save left side 
129:     LD  3,-4(1) 	Load variable i
130:     LD  4,-354(1) 	Load left into ac1 
131:    MUL  3,4,3 	Op * 
132:     ST  3,-354(1) 	Save left side 
133:    LDC  3,1(6) 	Load constant 
134:     LD  4,-354(1) 	Load left into ac1 
135:    SUB  3,4,3 	Op - 
136:     LD  4,-353(1) 	Load left into ac1 
137:    DIV  5,4,3 	Op % 
138:    MUL  5,5,3 	 
139:    SUB  3,4,5 	 
140:     LD  4,-352(1) 	Restore index 
141:    LDA  5,-12(1) 	Load address of base of array a
142:    SUB  5,5,4 	Compute offset of value 
143:     ST  3,0(5) 	Store variable a
* EXPRESSION STMT
144:     LD  3,-8(1) 	Load variable x
145:     ST  3,-352(1) 	Save left side 
146:    LDC  3,2(6) 	Load constant 
147:     ST  3,-353(1) 	Save left side 
148:     LD  3,-4(1) 	Load variable i
149:     LD  4,-353(1) 	Load left into ac1 
150:    MUL  3,4,3 	Op * 
151:     ST  3,-353(1) 	Save left side 
152:    LDC  3,1(6) 	Load constant 
153:     LD  4,-353(1) 	Load left into ac1 
154:    SUB  3,4,3 	Op - 
155:     LD  4,-352(1) 	Load left into ac1 
156:    DIV  3,4,3 	Op / 
157:     ST  3,-7(1) 	Store variable q
* EXPRESSION STMT
158:    LDC  3,1(6) 	Load constant 
159:     LD  4,-4(1) 	load lhs variable i
160:    SUB  3,4,3 	op -= 
161:     ST  3,-4(1) 	Store variable i
* END compound statement
162:    LDA  7,-75(7) 	go to beginning of loop 
 97:    LDA  7,65(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
163:    LDC  3,0(6) 	Load constant 
164:     ST  3,-352(1) 	Save index 
165:     LD  3,-7(1) 	Load variable q
166:     ST  3,-353(1) 	Save left side 
167:    LDC  3,10(6) 	Load constant 
168:     LD  4,-353(1) 	Load left into ac1 
169:    DIV  5,4,3 	Op % 
170:    MUL  5,5,3 	 
171:    SUB  3,4,5 	 
172:     LD  4,-352(1) 	Restore index 
173:    LDA  5,-12(1) 	Load address of base of array a
174:    SUB  5,5,4 	Compute offset of value 
175:     ST  3,0(5) 	Store variable a
* EXPRESSION STMT
176:     LD  3,-7(1) 	Load variable q
177:     ST  3,-352(1) 	Save left side 
178:    LDC  3,10(6) 	Load constant 
179:     LD  4,-352(1) 	Load left into ac1 
180:    DIV  3,4,3 	Op / 
181:     ST  3,-7(1) 	Store variable q
* IF
182:     LD  3,-7(1) 	Load variable q
183:     ST  3,-352(1) 	Save left side 
184:    LDC  3,9(6) 	Load constant 
185:     LD  4,-352(1) 	Load left into ac1 
186:    SUB  4,4,3 	Op == 
187:    LDC  3,1(6) 	True case 
188:    JEQ  4,1(7) 	Jump if true 
189:    LDC  3,0(6) 	False case 
190:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
192:     LD  3,-9(1) 	load lhs variable nines
193:    LDA  3,1(3) 	increment value of nines
194:     ST  3,-9(1) 	Store variable nines
* END compound statement
* ELSE
191:    LDA  7,4(7) 	Jump around the THEN 
* BEGIN compound statement
* IF
196:     LD  3,-7(1) 	Load variable q
197:     ST  3,-352(1) 	Save left side 
198:    LDC  3,10(6) 	Load constant 
199:     LD  4,-352(1) 	Load left into ac1 
200:    SUB  4,4,3 	Op == 
201:    LDC  3,1(6) 	True case 
202:    JEQ  4,1(7) 	Jump if true 
203:    LDC  3,0(6) 	False case 
204:    JGT  3,1(7) 	Jump to then part 
* THEN
* BEGIN compound statement
* EXPRESSION STMT
206:     ST  1,-352(1) 	Store old fp in ghost frame 
207:     LD  3,-10(1) 	Load variable predigit
208:     ST  3,-354(1) 	Save left side 
209:    LDC  3,1(6) 	Load constant 
210:     LD  4,-354(1) 	Load left into ac1 
211:    ADD  3,4,3 	Op + 
212:     ST  3,-354(1) 	Store parameter 
213:    LDA  1,-352(1) 	Load address of new frame 
214:    LDA  3,1(7) 	Return address in ac 
215:    LDA  7,-210(7) 	CALL output
216:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
217:     ST  1,-352(1) 	Store old fp in ghost frame 
218:    LDA  1,-352(1) 	Load address of new frame 
219:    LDA  3,1(7) 	Return address in ac 
220:    LDA  7,-196(7) 	CALL outnl
221:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
222:    LDC  3,0(6) 	Load constant 
223:     ST  3,-10(1) 	Store variable predigit
* WHILE
224:     LD  3,-9(1) 	Load variable nines
225:     ST  3,-352(1) 	Save left side 
226:    LDC  3,0(6) 	Load constant 
227:     LD  4,-352(1) 	Load left into ac1 
228:    SUB  4,4,3 	Op > 
229:    LDC  3,1(6) 	True case 
230:    JGT  4,1(7) 	Jump if true 
231:    LDC  3,0(6) 	False case 
232:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
234:     ST  1,-352(1) 	Store old fp in ghost frame 
235:    LDC  3,0(6) 	Load constant 
236:     ST  3,-354(1) 	Store parameter 
237:    LDA  1,-352(1) 	Load address of new frame 
238:    LDA  3,1(7) 	Return address in ac 
239:    LDA  7,-234(7) 	CALL output
240:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
241:     ST  1,-352(1) 	Store old fp in ghost frame 
242:    LDA  1,-352(1) 	Load address of new frame 
243:    LDA  3,1(7) 	Return address in ac 
244:    LDA  7,-220(7) 	CALL outnl
245:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
246:     LD  3,-9(1) 	load lhs variable nines
247:    LDA  3,-1(3) 	decrement value of nines
248:     ST  3,-9(1) 	Store variable nines
* END compound statement
249:    LDA  7,-26(7) 	go to beginning of loop 
233:    LDA  7,16(7) 	No more loop 
* ENDWHILE
* END compound statement
* ELSE
205:    LDA  7,45(7) 	Jump around the THEN 
* BEGIN compound statement
* EXPRESSION STMT
251:     ST  1,-352(1) 	Store old fp in ghost frame 
252:     LD  3,-10(1) 	Load variable predigit
253:     ST  3,-354(1) 	Store parameter 
254:    LDA  1,-352(1) 	Load address of new frame 
255:    LDA  3,1(7) 	Return address in ac 
256:    LDA  7,-251(7) 	CALL output
257:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
258:     ST  1,-352(1) 	Store old fp in ghost frame 
259:    LDA  1,-352(1) 	Load address of new frame 
260:    LDA  3,1(7) 	Return address in ac 
261:    LDA  7,-237(7) 	CALL outnl
262:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
263:     LD  3,-7(1) 	Load variable q
264:     ST  3,-10(1) 	Store variable predigit
* WHILE
265:     LD  3,-9(1) 	Load variable nines
266:     ST  3,-352(1) 	Save left side 
267:    LDC  3,0(6) 	Load constant 
268:     LD  4,-352(1) 	Load left into ac1 
269:    SUB  4,4,3 	Op > 
270:    LDC  3,1(6) 	True case 
271:    JGT  4,1(7) 	Jump if true 
272:    LDC  3,0(6) 	False case 
273:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
275:     ST  1,-352(1) 	Store old fp in ghost frame 
276:    LDC  3,9(6) 	Load constant 
277:     ST  3,-354(1) 	Store parameter 
278:    LDA  1,-352(1) 	Load address of new frame 
279:    LDA  3,1(7) 	Return address in ac 
280:    LDA  7,-275(7) 	CALL output
281:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
282:     ST  1,-352(1) 	Store old fp in ghost frame 
283:    LDA  1,-352(1) 	Load address of new frame 
284:    LDA  3,1(7) 	Return address in ac 
285:    LDA  7,-261(7) 	CALL outnl
286:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
287:     LD  3,-9(1) 	load lhs variable nines
288:    LDA  3,-1(3) 	decrement value of nines
289:     ST  3,-9(1) 	Store variable nines
* END compound statement
290:    LDA  7,-26(7) 	go to beginning of loop 
274:    LDA  7,16(7) 	No more loop 
* ENDWHILE
* END compound statement
250:    LDA  7,40(7) 	Jump around the ELSE 
* ENDIF
* END compound statement
195:    LDA  7,95(7) 	Jump around the ELSE 
* ENDIF
* EXPRESSION STMT
291:     LD  3,-5(1) 	load lhs variable j
292:    LDA  3,1(3) 	increment value of j
293:     ST  3,-5(1) 	Store variable j
* END compound statement
294:    LDA  7,-221(7) 	go to beginning of loop 
 83:    LDA  7,211(7) 	No more loop 
* ENDWHILE
* EXPRESSION STMT
295:     ST  1,-352(1) 	Store old fp in ghost frame 
296:     LD  3,-10(1) 	Load variable predigit
297:     ST  3,-354(1) 	Store parameter 
298:    LDA  1,-352(1) 	Load address of new frame 
299:    LDA  3,1(7) 	Return address in ac 
300:    LDA  7,-295(7) 	CALL output
301:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
302:     ST  1,-352(1) 	Store old fp in ghost frame 
303:    LDA  1,-352(1) 	Load address of new frame 
304:    LDA  3,1(7) 	Return address in ac 
305:    LDA  7,-281(7) 	CALL outnl
306:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
307:    LDC  2,0(6) 	Set return value to 0 
308:     LD  3,-1(1) 	Load return address 
309:     LD  1,0(1) 	Adjust fp 
310:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,310(7) 	Jump to init 
* BEGIN Init
311:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
312:    LDA  1,0(0) 	set first frame at end of globals 
313:     ST  1,0(1) 	store old fp (point to self) 
314:    LDA  3,1(7) 	Return address in ac 
315:    LDA  7,-286(7) 	Jump to main 
316:   HALT  0,0,0 	DONE! 
* END Init
