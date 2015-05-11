* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  relop.tm
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
* WHILE
 31:     LD  3,0(1) 	Load variable x
 32:     ST  3,-7(1) 	Save left side 
 33:     LD  3,-2(1) 	Load variable y
 34:     LD  4,-7(1) 	Load left into ac1 
 35:    SUB  4,4,3 	Op < 
 36:    LDC  3,1(6) 	True case 
 37:    JLT  4,1(7) 	Jump if true 
 38:    LDC  3,0(6) 	False case 
 39:    JGT  3,1(7) 	Jump to while part 
* DO
 41:    LDA  7,-11(7) 	go to beginning of loop 
 40:    LDA  7,1(7) 	No more loop 
* ENDWHILE
* WHILE
 42:     LD  3,0(1) 	Load variable x
 43:     ST  3,-7(1) 	Save left side 
 44:     LD  3,-2(1) 	Load variable y
 45:     LD  4,-7(1) 	Load left into ac1 
 46:    SUB  4,4,3 	Op > 
 47:    LDC  3,1(6) 	True case 
 48:    JLT  4,1(7) 	Jump if true 
 49:    LDC  3,0(6) 	False case 
 50:    JGT  3,1(7) 	Jump to while part 
* DO
 52:    LDA  7,-11(7) 	go to beginning of loop 
 51:    LDA  7,1(7) 	No more loop 
* ENDWHILE
* WHILE
 53:     LD  3,0(1) 	Load variable x
 54:     ST  3,-7(1) 	Save left side 
 55:     LD  3,-2(1) 	Load variable y
 56:     LD  4,-7(1) 	Load left into ac1 
 57:    SUB  4,4,3 	Op < 
 58:    LDC  3,1(6) 	True case 
 59:    JLT  4,1(7) 	Jump if true 
 60:    LDC  3,0(6) 	False case 
 61:    JGT  3,1(7) 	Jump to while part 
* DO
 63:    LDA  7,-11(7) 	go to beginning of loop 
 62:    LDA  7,1(7) 	No more loop 
* ENDWHILE
* WHILE
 64:     LD  3,0(1) 	Load variable x
 65:     ST  3,-7(1) 	Save left side 
 66:     LD  3,-2(1) 	Load variable y
 67:     LD  4,-7(1) 	Load left into ac1 
 68:    SUB  4,4,3 	Op > 
 69:    LDC  3,1(6) 	True case 
 70:    JLT  4,1(7) 	Jump if true 
 71:    LDC  3,0(6) 	False case 
 72:    JGT  3,1(7) 	Jump to while part 
* DO
 74:    LDA  7,-11(7) 	go to beginning of loop 
 73:    LDA  7,1(7) 	No more loop 
* ENDWHILE
* WHILE
 75:     LD  3,0(1) 	Load variable x
 76:     ST  3,-7(1) 	Save left side 
 77:     LD  3,-2(1) 	Load variable y
 78:     LD  4,-7(1) 	Load left into ac1 
 79:    SUB  4,4,3 	Op == 
 80:    LDC  3,1(6) 	True case 
 81:    JEQ  4,1(7) 	Jump if true 
 82:    LDC  3,0(6) 	False case 
 83:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* END compound statement
 85:    LDA  7,-11(7) 	go to beginning of loop 
 84:    LDA  7,1(7) 	No more loop 
* ENDWHILE
* WHILE
 86:     LD  3,0(1) 	Load variable x
 87:     ST  3,-7(1) 	Save left side 
 88:     LD  3,-2(1) 	Load variable y
 89:     LD  4,-7(1) 	Load left into ac1 
 90:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* END compound statement
 92:    LDA  7,-7(7) 	go to beginning of loop 
 91:    LDA  7,1(7) 	No more loop 
* ENDWHILE
* WHILE
 93:     LD  3,0(1) 	Load variable x
 94:     ST  3,-7(1) 	Save left side 
 95:     LD  3,-2(1) 	Load variable y
 96:     LD  4,-7(1) 	Load left into ac1 
 97:    JGT  3,1(7) 	Jump to while part 
* DO
* BEGIN compound statement
* EXPRESSION STMT
 99:    LDC  3,4(6) 	Load constant 
100:     ST  3,0(1) 	Store variable x
* END compound statement
101:    LDA  7,-9(7) 	go to beginning of loop 
 98:    LDA  7,3(7) 	No more loop 
* ENDWHILE
* WHILE
102:     LD  3,0(1) 	Load variable x
103:     ST  3,-7(1) 	Save left side 
104:     LD  3,-2(1) 	Load variable y
105:     LD  4,-7(1) 	Load left into ac1 
106:    JGT  3,1(7) 	Jump to while part 
* DO
* WHILE
108:     LD  3,0(1) 	Load variable x
109:     ST  3,-7(1) 	Save left side 
110:     LD  3,-2(1) 	Load variable y
111:     LD  4,-7(1) 	Load left into ac1 
112:    SUB  4,4,3 	Op == 
113:    LDC  3,1(6) 	True case 
114:    JEQ  4,1(7) 	Jump if true 
115:    LDC  3,0(6) 	False case 
116:    JGT  3,1(7) 	Jump to while part 
* DO
118:    LDA  7,-11(7) 	go to beginning of loop 
117:    LDA  7,1(7) 	No more loop 
* ENDWHILE
119:    LDA  7,-18(7) 	go to beginning of loop 
107:    LDA  7,12(7) 	No more loop 
* ENDWHILE
* IfK:
* IfK: t->child[0] condition
120:     LD  3,0(1) 	Load variable x
121:     ST  3,-7(1) 	Save left side 
122:     LD  3,-2(1) 	Load variable y
123:     LD  4,-7(1) 	Load left into ac1 
124:    SUB  4,4,3 	Op > 
125:    LDC  3,1(6) 	True case 
126:    JLT  4,1(7) 	Jump if true 
127:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
128:    JEQ  3,1(7) 	if: jmp to else 
* IfK: t->child[2] else part
129:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
130:     LD  3,0(1) 	Load variable x
131:     ST  3,-7(1) 	Save left side 
132:     LD  3,-2(1) 	Load variable y
133:     LD  4,-7(1) 	Load left into ac1 
134:    SUB  4,4,3 	Op == 
135:    LDC  3,1(6) 	True case 
136:    JEQ  4,1(7) 	Jump if true 
137:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
* BEGIN compound statement
* END compound statement
138:    JEQ  3,1(7) 	if: jmp to else 
* IfK: t->child[2] else part
139:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
140:     LD  3,0(1) 	Load variable x
141:     ST  3,-7(1) 	Save left side 
142:     LD  3,-2(1) 	Load variable y
143:     LD  4,-7(1) 	Load left into ac1 
* IfK: t->child[1] then part
* BEGIN compound statement
* END compound statement
144:    JEQ  3,1(7) 	if: jmp to else 
* IfK: t->child[2] else part
145:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
146:     LD  3,0(1) 	Load variable x
147:     ST  3,-7(1) 	Save left side 
148:     LD  3,-2(1) 	Load variable y
149:     LD  4,-7(1) 	Load left into ac1 
* IfK: t->child[1] then part
* BEGIN compound statement
* EXPRESSION STMT
151:    LDC  3,4(6) 	Load constant 
152:     ST  3,0(1) 	Store variable x
* END compound statement
150:    JEQ  3,3(7) 	if: jmp to else 
* IfK: t->child[2] else part
153:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
154:     LD  3,0(1) 	Load variable x
155:     ST  3,-7(1) 	Save left side 
156:     LD  3,-2(1) 	Load variable y
157:     LD  4,-7(1) 	Load left into ac1 
* IfK: t->child[1] then part
* WHILE
159:     LD  3,0(1) 	Load variable x
160:     ST  3,-7(1) 	Save left side 
161:     LD  3,-2(1) 	Load variable y
162:     LD  4,-7(1) 	Load left into ac1 
163:    SUB  4,4,3 	Op == 
164:    LDC  3,1(6) 	True case 
165:    JEQ  4,1(7) 	Jump if true 
166:    LDC  3,0(6) 	False case 
167:    JGT  3,1(7) 	Jump to while part 
* DO
169:    LDA  7,-11(7) 	go to beginning of loop 
168:    LDA  7,1(7) 	No more loop 
* ENDWHILE
158:    JEQ  3,12(7) 	if: jmp to else 
* IfK: t->child[2] else part
170:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
171:     LD  3,0(1) 	Load variable x
172:     ST  3,-7(1) 	Save left side 
173:     LD  3,-2(1) 	Load variable y
174:     LD  4,-7(1) 	Load left into ac1 
175:    SUB  4,4,3 	Op > 
176:    LDC  3,1(6) 	True case 
177:    JLT  4,1(7) 	Jump if true 
178:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
179:    JEQ  3,1(7) 	if: jmp to else 
* IfK: t->child[2] else part
180:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
181:     LD  3,0(1) 	Load variable x
182:     ST  3,-7(1) 	Save left side 
183:     LD  3,-2(1) 	Load variable y
184:     LD  4,-7(1) 	Load left into ac1 
185:    SUB  4,4,3 	Op > 
186:    LDC  3,1(6) 	True case 
187:    JLT  4,1(7) 	Jump if true 
188:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
189:    JEQ  3,1(7) 	if: jmp to else 
* IfK: t->child[2] else part
190:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
191:     LD  3,0(1) 	Load variable x
192:     ST  3,-7(1) 	Save left side 
193:     LD  3,-2(1) 	Load variable y
194:     LD  4,-7(1) 	Load left into ac1 
195:    SUB  4,4,3 	Op == 
196:    LDC  3,1(6) 	True case 
197:    JEQ  4,1(7) 	Jump if true 
198:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
* BEGIN compound statement
* END compound statement
199:    JEQ  3,1(7) 	if: jmp to else 
* IfK: t->child[2] else part
* BEGIN compound statement
* END compound statement
200:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
201:     LD  3,0(1) 	Load variable x
202:     ST  3,-7(1) 	Save left side 
203:     LD  3,-2(1) 	Load variable y
204:     LD  4,-7(1) 	Load left into ac1 
205:    SUB  4,4,3 	Op < 
206:    LDC  3,1(6) 	True case 
207:    JLT  4,1(7) 	Jump if true 
208:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
* IfK:
* IfK: t->child[0] condition
210:     LD  3,0(1) 	Load variable x
211:     ST  3,-7(1) 	Save left side 
212:     LD  3,-2(1) 	Load variable y
213:     LD  4,-7(1) 	Load left into ac1 
214:    SUB  4,4,3 	Op > 
215:    LDC  3,1(6) 	True case 
216:    JLT  4,1(7) 	Jump if true 
217:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
* EXPRESSION STMT
219:    LDC  3,2(6) 	Load constant 
220:     ST  3,0(1) 	Store variable x
218:    JEQ  3,3(7) 	if: jmp to else 
* IfK: t->child[2] else part
* EXPRESSION STMT
222:    LDC  3,3(6) 	Load constant 
223:     ST  3,0(1) 	Store variable x
221:    LDA  7,2(7) 	jmp to end 
* ENDIF
209:    JEQ  3,15(7) 	if: jmp to else 
* IfK: t->child[2] else part
224:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
225:     LD  3,0(1) 	Load variable x
226:     ST  3,-7(1) 	Save left side 
227:     LD  3,-2(1) 	Load variable y
228:     LD  4,-7(1) 	Load left into ac1 
229:    SUB  4,4,3 	Op < 
230:    LDC  3,1(6) 	True case 
231:    JLT  4,1(7) 	Jump if true 
232:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
* BEGIN compound statement
* IfK:
* IfK: t->child[0] condition
234:     LD  3,0(1) 	Load variable x
235:     ST  3,-7(1) 	Save left side 
236:     LD  3,-2(1) 	Load variable y
237:     LD  4,-7(1) 	Load left into ac1 
238:    SUB  4,4,3 	Op > 
239:    LDC  3,1(6) 	True case 
240:    JLT  4,1(7) 	Jump if true 
241:    LDC  3,0(6) 	False case 
* IfK: t->child[1] then part
* EXPRESSION STMT
243:    LDC  3,2(6) 	Load constant 
244:     ST  3,0(1) 	Store variable x
242:    JEQ  3,3(7) 	if: jmp to else 
* IfK: t->child[2] else part
245:    LDA  7,0(7) 	jmp to end 
* ENDIF
* END compound statement
233:    JEQ  3,13(7) 	if: jmp to else 
* IfK: t->child[2] else part
* EXPRESSION STMT
247:    LDC  3,3(6) 	Load constant 
248:     ST  3,0(1) 	Store variable x
246:    LDA  7,2(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
249:     LD  3,-5(1) 	Load variable b
* IfK: t->child[1] then part
250:    JEQ  3,1(7) 	if: jmp to else 
* IfK: t->child[2] else part
251:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
252:     LD  3,-5(1) 	Load variable b
* IfK: t->child[1] then part
253:    JEQ  3,1(7) 	if: jmp to else 
* IfK: t->child[2] else part
254:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
255:     LD  3,-4(1) 	Load variable a
256:     ST  3,-7(1) 	Save left side 
257:     LD  3,-5(1) 	Load variable b
258:     LD  4,-7(1) 	Load left into ac1 
259:    JEQ  3,1(7) 	Op AND 
260:    LDA  3,0(4) 	 
* IfK: t->child[1] then part
261:    JEQ  3,1(7) 	if: jmp to else 
* IfK: t->child[2] else part
262:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
263:     LD  3,-4(1) 	Load variable a
264:     ST  3,-7(1) 	Save left side 
265:     LD  3,-5(1) 	Load variable b
266:     LD  4,-7(1) 	Load left into ac1 
* IfK: t->child[1] then part
267:    JEQ  3,1(7) 	if: jmp to else 
* IfK: t->child[2] else part
268:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
269:     LD  3,-4(1) 	Load variable a
270:     ST  3,-7(1) 	Save left side 
271:     LD  3,-5(1) 	Load variable b
272:     ST  3,-8(1) 	Save left side 
273:     LD  3,-6(1) 	Load variable c
274:     LD  4,-8(1) 	Load left into ac1 
275:    JEQ  3,1(7) 	Op AND 
276:    LDA  3,0(4) 	 
277:     LD  4,-7(1) 	Load left into ac1 
* IfK: t->child[1] then part
278:    JEQ  3,1(7) 	if: jmp to else 
* IfK: t->child[2] else part
279:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
280:     LD  3,-4(1) 	Load variable a
281:     ST  3,-7(1) 	Save left side 
282:     LD  3,-5(1) 	Load variable b
283:     LD  4,-7(1) 	Load left into ac1 
* IfK: t->child[1] then part
284:    JEQ  3,1(7) 	if: jmp to else 
* IfK: t->child[2] else part
285:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
286:     LD  3,0(1) 	Load variable x
287:     ST  3,-7(1) 	Save left side 
288:     LD  3,-2(1) 	Load variable y
289:     LD  4,-7(1) 	Load left into ac1 
290:    SUB  4,4,3 	Op > 
291:    LDC  3,1(6) 	True case 
292:    JLT  4,1(7) 	Jump if true 
293:    LDC  3,0(6) 	False case 
294:     ST  3,-7(1) 	Save left side 
295:     LD  3,-2(1) 	Load variable y
296:     ST  3,-8(1) 	Save left side 
297:     LD  3,-3(1) 	Load variable z
298:     LD  4,-8(1) 	Load left into ac1 
299:    SUB  4,4,3 	Op > 
300:    LDC  3,1(6) 	True case 
301:    JLT  4,1(7) 	Jump if true 
302:    LDC  3,0(6) 	False case 
303:     LD  4,-7(1) 	Load left into ac1 
304:    JEQ  3,1(7) 	Op AND 
305:    LDA  3,0(4) 	 
* IfK: t->child[1] then part
306:    JEQ  3,1(7) 	if: jmp to else 
* IfK: t->child[2] else part
307:    LDA  7,0(7) 	jmp to end 
* ENDIF
* IfK:
* IfK: t->child[0] condition
308:     LD  3,0(1) 	Load variable x
309:     ST  3,-7(1) 	Save left side 
310:     LD  3,-2(1) 	Load variable y
311:     LD  4,-7(1) 	Load left into ac1 
312:    SUB  4,4,3 	Op > 
313:    LDC  3,1(6) 	True case 
314:    JLT  4,1(7) 	Jump if true 
315:    LDC  3,0(6) 	False case 
316:     ST  3,-7(1) 	Save left side 
317:     LD  3,-2(1) 	Load variable y
318:     ST  3,-8(1) 	Save left side 
319:     LD  3,-3(1) 	Load variable z
320:     LD  4,-8(1) 	Load left into ac1 
321:    SUB  4,4,3 	Op > 
322:    LDC  3,1(6) 	True case 
323:    JLT  4,1(7) 	Jump if true 
324:    LDC  3,0(6) 	False case 
325:     LD  4,-7(1) 	Load left into ac1 
* IfK: t->child[1] then part
326:    JEQ  3,1(7) 	if: jmp to else 
* IfK: t->child[2] else part
327:    LDA  7,0(7) 	jmp to end 
* ENDIF
* EXPRESSION STMT
328:     LD  3,0(1) 	Load variable x
329:     ST  3,-7(1) 	Save left side 
330:     LD  3,-2(1) 	Load variable y
331:     LD  4,-7(1) 	Load left into ac1 
332:    SUB  4,4,3 	Op > 
333:    LDC  3,1(6) 	True case 
334:    JLT  4,1(7) 	Jump if true 
335:    LDC  3,0(6) 	False case 
336:     ST  3,-7(1) 	Save left side 
337:     LD  3,-2(1) 	Load variable y
338:     ST  3,-8(1) 	Save left side 
339:     LD  3,-3(1) 	Load variable z
340:     LD  4,-8(1) 	Load left into ac1 
341:    SUB  4,4,3 	Op > 
342:    LDC  3,1(6) 	True case 
343:    JLT  4,1(7) 	Jump if true 
344:    LDC  3,0(6) 	False case 
345:     LD  4,-7(1) 	Load left into ac1 
346:    JEQ  3,1(7) 	Op AND 
347:    LDA  3,0(4) 	 
348:     ST  3,-6(1) 	Store variable c
* EXPRESSION STMT
349:     LD  3,0(1) 	Load variable x
350:     ST  3,-7(1) 	Save left side 
351:     LD  3,-2(1) 	Load variable y
352:     LD  4,-7(1) 	Load left into ac1 
353:    SUB  4,4,3 	Op > 
354:    LDC  3,1(6) 	True case 
355:    JLT  4,1(7) 	Jump if true 
356:    LDC  3,0(6) 	False case 
357:     ST  3,-7(1) 	Save left side 
358:     LD  3,-2(1) 	Load variable y
359:     ST  3,-8(1) 	Save left side 
360:     LD  3,-3(1) 	Load variable z
361:     LD  4,-8(1) 	Load left into ac1 
362:    SUB  4,4,3 	Op > 
363:    LDC  3,1(6) 	True case 
364:    JLT  4,1(7) 	Jump if true 
365:    LDC  3,0(6) 	False case 
366:     LD  4,-7(1) 	Load left into ac1 
367:     ST  3,-6(1) 	Store variable c
* EXPRESSION STMT
368:     LD  3,0(1) 	Load variable x
369:     ST  3,-7(1) 	Save left side 
370:     LD  3,-2(1) 	Load variable y
371:     LD  4,-7(1) 	Load left into ac1 
372:    SUB  4,4,3 	Op > 
373:    LDC  3,1(6) 	True case 
374:    JLT  4,1(7) 	Jump if true 
375:    LDC  3,0(6) 	False case 
376:     ST  3,-7(1) 	Save left side 
377:     LD  3,-2(1) 	Load variable y
378:     ST  3,-8(1) 	Save left side 
379:     LD  3,-3(1) 	Load variable z
380:     LD  4,-8(1) 	Load left into ac1 
381:    SUB  4,4,3 	Op > 
382:    LDC  3,1(6) 	True case 
383:    JLT  4,1(7) 	Jump if true 
384:    LDC  3,0(6) 	False case 
385:     LD  4,-7(1) 	Load left into ac1 
386:    JEQ  3,1(7) 	Op AND 
387:    LDA  3,0(4) 	 
388:     ST  3,-6(1) 	Store variable c
* EXPRESSION STMT
389:     LD  3,0(1) 	Load variable x
390:     ST  3,-7(1) 	Save left side 
391:     LD  3,-2(1) 	Load variable y
392:     LD  4,-7(1) 	Load left into ac1 
393:    SUB  4,4,3 	Op > 
394:    LDC  3,1(6) 	True case 
395:    JLT  4,1(7) 	Jump if true 
396:    LDC  3,0(6) 	False case 
397:     ST  3,-7(1) 	Save left side 
398:     LD  3,-2(1) 	Load variable y
399:     ST  3,-8(1) 	Save left side 
400:     LD  3,-3(1) 	Load variable z
401:     LD  4,-8(1) 	Load left into ac1 
402:    SUB  4,4,3 	Op > 
403:    LDC  3,1(6) 	True case 
404:    JLT  4,1(7) 	Jump if true 
405:    LDC  3,0(6) 	False case 
406:     LD  4,-7(1) 	Load left into ac1 
407:     ST  3,-6(1) 	Store variable c
* EXPRESSION STMT
408:     LD  3,-2(1) 	Load variable y
409:     ST  3,-7(1) 	Save left side 
410:     LD  3,0(1) 	Load variable x
411:     LD  4,-7(1) 	Load left into ac1 
412:    SUB  4,4,3 	Op == 
413:    LDC  3,1(6) 	True case 
414:    JEQ  4,1(7) 	Jump if true 
415:    LDC  3,0(6) 	False case 
416:     ST  3,-7(1) 	Save left side 
417:     LD  3,0(1) 	Load variable x
418:     ST  3,-8(1) 	Save left side 
419:     LD  3,-2(1) 	Load variable y
420:     LD  4,-8(1) 	Load left into ac1 
421:    SUB  4,4,3 	Op > 
422:    LDC  3,1(6) 	True case 
423:    JLT  4,1(7) 	Jump if true 
424:    LDC  3,0(6) 	False case 
425:     ST  3,-8(1) 	Save left side 
426:     LD  3,-2(1) 	Load variable y
427:     ST  3,-9(1) 	Save left side 
428:     LD  3,-3(1) 	Load variable z
429:     LD  4,-9(1) 	Load left into ac1 
430:    SUB  4,4,3 	Op > 
431:    LDC  3,1(6) 	True case 
432:    JLT  4,1(7) 	Jump if true 
433:    LDC  3,0(6) 	False case 
434:     LD  4,-8(1) 	Load left into ac1 
435:    JEQ  3,1(7) 	Op AND 
436:    LDA  3,0(4) 	 
437:     LD  4,-7(1) 	Load left into ac1 
438:     ST  3,-6(1) 	Store variable c
* IfK:
* IfK: t->child[0] condition
439:     LD  3,-5(1) 	Load variable b
440:     ST  3,-7(1) 	Save left side 
441:     LD  3,0(1) 	Load variable x
442:     ST  3,-8(1) 	Save left side 
443:     LD  3,-2(1) 	Load variable y
444:     LD  4,-8(1) 	Load left into ac1 
445:    SUB  4,4,3 	Op > 
446:    LDC  3,1(6) 	True case 
447:    JLT  4,1(7) 	Jump if true 
448:    LDC  3,0(6) 	False case 
449:     ST  3,-8(1) 	Save left side 
450:     LD  3,-2(1) 	Load variable y
451:     ST  3,-9(1) 	Save left side 
452:     LD  3,-3(1) 	Load variable z
453:     LD  4,-9(1) 	Load left into ac1 
454:    SUB  4,4,3 	Op > 
455:    LDC  3,1(6) 	True case 
456:    JLT  4,1(7) 	Jump if true 
457:    LDC  3,0(6) 	False case 
458:     LD  4,-8(1) 	Load left into ac1 
459:    JEQ  3,1(7) 	Op AND 
460:    LDA  3,0(4) 	 
461:     LD  4,-7(1) 	Load left into ac1 
* IfK: t->child[1] then part
462:    JEQ  3,1(7) 	if: jmp to else 
* IfK: t->child[2] else part
463:    LDA  7,0(7) 	jmp to end 
* ENDIF
* END compound statement
* Add standard closing in case there is no return statement
464:    LDC  2,0(6) 	Set return value to 0 
465:     LD  3,-1(1) 	Load return address 
466:     LD  1,0(1) 	Adjust fp 
467:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,467(7) 	Jump to init 
* BEGIN Init
468:     LD  0,0(0) 	Set the global pointer 
469:    LDA  1,0(0) 	set first frame at end of globals 
470:     ST  1,0(1) 	store old fp (point to self) 
471:    LDA  3,1(7) 	Return address in ac 
472:    LDA  7,-443(7) 	Jump to main 
473:   HALT  0,0,0 	DONE! 
* END Init
