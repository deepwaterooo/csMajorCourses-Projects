* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  whiletest.c-
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
* IF
 31:    LDC  3,1(6) 	Load constant 
 32:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
 34:    LDC  3,0(6) 	Load constant 
 33:    LDA  7,1(7) 	Jump around the THEN 
* ENDIF
* IF
 35:    LDC  3,1(6) 	Load constant 
 36:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
 38:    LDC  3,0(6) 	Load constant 
* ELSE
 37:    LDA  7,2(7) 	Jump around the THEN 
* EXPRESSION STMT
 40:    LDC  3,1(6) 	Load constant 
 39:    LDA  7,1(7) 	Jump around the ELSE 
* ENDIF
* IF
 41:    LDC  3,0(6) 	Load constant 
 42:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
 44:    LDC  3,1(6) 	Load constant 
* ELSE
 43:    LDA  7,2(7) 	Jump around the THEN 
* IF
 46:    LDC  3,0(6) 	Load constant 
 47:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
 49:    LDC  3,1(6) 	Load constant 
 48:    LDA  7,1(7) 	Jump around the THEN 
* ENDIF
 45:    LDA  7,4(7) 	Jump around the ELSE 
* ENDIF
* IF
 50:    LDC  3,0(6) 	Load constant 
 51:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
 53:    LDC  3,1(6) 	Load constant 
* ELSE
 52:    LDA  7,2(7) 	Jump around the THEN 
* IF
 55:    LDC  3,0(6) 	Load constant 
 56:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
 58:    LDC  3,1(6) 	Load constant 
* ELSE
 57:    LDA  7,2(7) 	Jump around the THEN 
* EXPRESSION STMT
 60:    LDC  3,0(6) 	Load constant 
 59:    LDA  7,1(7) 	Jump around the ELSE 
* ENDIF
 54:    LDA  7,6(7) 	Jump around the ELSE 
* ENDIF
* IF
 61:    LDC  3,1(6) 	Load constant 
 62:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
 64:    LDC  3,0(6) 	Load constant 
* ELSE
 63:    LDA  7,2(7) 	Jump around the THEN 
* IF
 66:    LDC  3,1(6) 	Load constant 
 67:    JGT  3,1(7) 	Jump to then part 
* THEN
* IF
 69:    LDC  3,0(6) 	Load constant 
 70:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
 72:    LDC  3,1(6) 	Load constant 
 71:    LDA  7,1(7) 	Jump around the THEN 
* ENDIF
 68:    LDA  7,4(7) 	Jump around the THEN 
* ENDIF
 65:    LDA  7,7(7) 	Jump around the ELSE 
* ENDIF
* IF
 73:    LDC  3,0(6) 	Load constant 
 74:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
 76:    LDC  3,1(6) 	Load constant 
* ELSE
 75:    LDA  7,2(7) 	Jump around the THEN 
* IF
 78:    LDC  3,0(6) 	Load constant 
 79:    JGT  3,1(7) 	Jump to then part 
* THEN
* WHILE
 81:    LDC  3,1(6) 	Load constant 
 82:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
 84:    LDC  3,0(6) 	Load constant 
 85:    LDA  7,-5(7) 	go to beginning of loop 
 83:    LDA  7,2(7) 	No more loop 
* ENDWHILE
 80:    LDA  7,5(7) 	Jump around the THEN 
* ENDIF
 77:    LDA  7,8(7) 	Jump around the ELSE 
* ENDIF
* IF
 86:    LDC  3,1(6) 	Load constant 
 87:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
 89:    LDC  3,0(6) 	Load constant 
* ELSE
 88:    LDA  7,2(7) 	Jump around the THEN 
* WHILE
 91:    LDC  3,1(6) 	Load constant 
 92:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
 94:    LDC  3,0(6) 	Load constant 
 95:    LDA  7,-5(7) 	go to beginning of loop 
 93:    LDA  7,2(7) 	No more loop 
* ENDWHILE
 90:    LDA  7,5(7) 	Jump around the ELSE 
* ENDIF
* IF
 96:    LDC  3,1(6) 	Load constant 
 97:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
 99:    LDC  3,0(6) 	Load constant 
* ELSE
 98:    LDA  7,2(7) 	Jump around the THEN 
* WHILE
101:    LDC  3,1(6) 	Load constant 
102:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
104:    LDC  3,0(6) 	Load constant 
105:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
107:    LDC  3,1(6) 	Load constant 
106:    LDA  7,1(7) 	Jump around the THEN 
* ENDIF
108:    LDA  7,-8(7) 	go to beginning of loop 
103:    LDA  7,5(7) 	No more loop 
* ENDWHILE
100:    LDA  7,8(7) 	Jump around the ELSE 
* ENDIF
* IF
109:    LDC  3,0(6) 	Load constant 
110:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
112:    LDC  3,1(6) 	Load constant 
* ELSE
111:    LDA  7,2(7) 	Jump around the THEN 
* WHILE
114:    LDC  3,0(6) 	Load constant 
115:    JGT  3,1(7) 	Jump to while part 
* DO
* WHILE
117:    LDC  3,1(6) 	Load constant 
118:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
120:    LDC  3,0(6) 	Load constant 
121:    LDA  7,-5(7) 	go to beginning of loop 
119:    LDA  7,2(7) 	No more loop 
* ENDWHILE
122:    LDA  7,-9(7) 	go to beginning of loop 
116:    LDA  7,6(7) 	No more loop 
* ENDWHILE
113:    LDA  7,9(7) 	Jump around the ELSE 
* ENDIF
* IF
123:    LDC  3,1(6) 	Load constant 
124:    JGT  3,1(7) 	Jump to then part 
* THEN
* IF
126:    LDC  3,0(6) 	Load constant 
127:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
129:    LDC  3,1(6) 	Load constant 
128:    LDA  7,1(7) 	Jump around the THEN 
* ENDIF
125:    LDA  7,4(7) 	Jump around the THEN 
* ENDIF
* IF
130:    LDC  3,0(6) 	Load constant 
131:    JGT  3,1(7) 	Jump to then part 
* THEN
* IF
133:    LDC  3,1(6) 	Load constant 
134:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
136:    LDC  3,0(6) 	Load constant 
* ELSE
135:    LDA  7,2(7) 	Jump around the THEN 
* EXPRESSION STMT
138:    LDC  3,1(6) 	Load constant 
137:    LDA  7,1(7) 	Jump around the ELSE 
* ENDIF
132:    LDA  7,6(7) 	Jump around the THEN 
* ENDIF
* IF
139:    LDC  3,0(6) 	Load constant 
140:    JGT  3,1(7) 	Jump to then part 
* THEN
* IF
142:    LDC  3,1(6) 	Load constant 
143:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
145:    LDC  3,0(6) 	Load constant 
* ELSE
144:    LDA  7,2(7) 	Jump around the THEN 
* EXPRESSION STMT
147:    LDC  3,1(6) 	Load constant 
146:    LDA  7,1(7) 	Jump around the ELSE 
* ENDIF
* ELSE
141:    LDA  7,7(7) 	Jump around the THEN 
* EXPRESSION STMT
149:    LDC  3,0(6) 	Load constant 
148:    LDA  7,1(7) 	Jump around the ELSE 
* ENDIF
* IF
150:    LDC  3,1(6) 	Load constant 
151:    JGT  3,1(7) 	Jump to then part 
* THEN
* IF
153:    LDC  3,0(6) 	Load constant 
154:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
156:    LDC  3,1(6) 	Load constant 
* ELSE
155:    LDA  7,2(7) 	Jump around the THEN 
* IF
158:    LDC  3,0(6) 	Load constant 
159:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
161:    LDC  3,1(6) 	Load constant 
160:    LDA  7,1(7) 	Jump around the THEN 
* ENDIF
157:    LDA  7,4(7) 	Jump around the ELSE 
* ENDIF
152:    LDA  7,9(7) 	Jump around the THEN 
* ENDIF
* IF
162:    LDC  3,0(6) 	Load constant 
163:    JGT  3,1(7) 	Jump to then part 
* THEN
* IF
165:    LDC  3,1(6) 	Load constant 
166:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
168:    LDC  3,0(6) 	Load constant 
* ELSE
167:    LDA  7,2(7) 	Jump around the THEN 
* WHILE
170:    LDC  3,1(6) 	Load constant 
171:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
173:    LDC  3,0(6) 	Load constant 
174:    LDA  7,-5(7) 	go to beginning of loop 
172:    LDA  7,2(7) 	No more loop 
* ENDWHILE
169:    LDA  7,5(7) 	Jump around the ELSE 
* ENDIF
164:    LDA  7,10(7) 	Jump around the THEN 
* ENDIF
* IF
175:    LDC  3,1(6) 	Load constant 
176:    JGT  3,1(7) 	Jump to then part 
* THEN
* IF
178:    LDC  3,0(6) 	Load constant 
179:    JGT  3,1(7) 	Jump to then part 
* THEN
* IF
181:    LDC  3,1(6) 	Load constant 
182:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
184:    LDC  3,0(6) 	Load constant 
183:    LDA  7,1(7) 	Jump around the THEN 
* ENDIF
180:    LDA  7,4(7) 	Jump around the THEN 
* ENDIF
177:    LDA  7,7(7) 	Jump around the THEN 
* ENDIF
* IF
185:    LDC  3,1(6) 	Load constant 
186:    JGT  3,1(7) 	Jump to then part 
* THEN
* IF
188:    LDC  3,0(6) 	Load constant 
189:    JGT  3,1(7) 	Jump to then part 
* THEN
* IF
191:    LDC  3,1(6) 	Load constant 
192:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
194:    LDC  3,0(6) 	Load constant 
* ELSE
193:    LDA  7,2(7) 	Jump around the THEN 
* EXPRESSION STMT
196:    LDC  3,1(6) 	Load constant 
195:    LDA  7,1(7) 	Jump around the ELSE 
* ENDIF
190:    LDA  7,6(7) 	Jump around the THEN 
* ENDIF
187:    LDA  7,9(7) 	Jump around the THEN 
* ENDIF
* IF
197:    LDC  3,0(6) 	Load constant 
198:    JGT  3,1(7) 	Jump to then part 
* THEN
* IF
200:    LDC  3,1(6) 	Load constant 
201:    JGT  3,1(7) 	Jump to then part 
* THEN
* IF
203:    LDC  3,0(6) 	Load constant 
204:    JGT  3,1(7) 	Jump to then part 
* THEN
* IF
206:    LDC  3,1(6) 	Load constant 
207:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
209:    LDC  3,0(6) 	Load constant 
208:    LDA  7,1(7) 	Jump around the THEN 
* ENDIF
205:    LDA  7,4(7) 	Jump around the THEN 
* ENDIF
202:    LDA  7,7(7) 	Jump around the THEN 
* ENDIF
199:    LDA  7,10(7) 	Jump around the THEN 
* ENDIF
* IF
210:    LDC  3,1(6) 	Load constant 
211:    JGT  3,1(7) 	Jump to then part 
* THEN
* IF
213:    LDC  3,0(6) 	Load constant 
214:    JGT  3,1(7) 	Jump to then part 
* THEN
* IF
216:    LDC  3,1(6) 	Load constant 
217:    JGT  3,1(7) 	Jump to then part 
* THEN
* WHILE
219:    LDC  3,0(6) 	Load constant 
220:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
222:    LDC  3,1(6) 	Load constant 
223:    LDA  7,-5(7) 	go to beginning of loop 
221:    LDA  7,2(7) 	No more loop 
* ENDWHILE
218:    LDA  7,5(7) 	Jump around the THEN 
* ENDIF
215:    LDA  7,8(7) 	Jump around the THEN 
* ENDIF
212:    LDA  7,11(7) 	Jump around the THEN 
* ENDIF
* IF
224:    LDC  3,0(6) 	Load constant 
225:    JGT  3,1(7) 	Jump to then part 
* THEN
* IF
227:    LDC  3,1(6) 	Load constant 
228:    JGT  3,1(7) 	Jump to then part 
* THEN
* WHILE
230:    LDC  3,0(6) 	Load constant 
231:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
233:    LDC  3,1(6) 	Load constant 
234:    LDA  7,-5(7) 	go to beginning of loop 
232:    LDA  7,2(7) 	No more loop 
* ENDWHILE
229:    LDA  7,5(7) 	Jump around the THEN 
* ENDIF
226:    LDA  7,8(7) 	Jump around the THEN 
* ENDIF
* IF
235:    LDC  3,0(6) 	Load constant 
236:    JGT  3,1(7) 	Jump to then part 
* THEN
* IF
238:    LDC  3,1(6) 	Load constant 
239:    JGT  3,1(7) 	Jump to then part 
* THEN
* WHILE
241:    LDC  3,0(6) 	Load constant 
242:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
244:    LDC  3,1(6) 	Load constant 
245:    LDA  7,-5(7) 	go to beginning of loop 
243:    LDA  7,2(7) 	No more loop 
* ENDWHILE
* ELSE
240:    LDA  7,6(7) 	Jump around the THEN 
* EXPRESSION STMT
247:    LDC  3,0(6) 	Load constant 
246:    LDA  7,1(7) 	Jump around the ELSE 
* ENDIF
237:    LDA  7,10(7) 	Jump around the THEN 
* ENDIF
* IF
248:    LDC  3,1(6) 	Load constant 
249:    JGT  3,1(7) 	Jump to then part 
* THEN
* IF
251:    LDC  3,0(6) 	Load constant 
252:    JGT  3,1(7) 	Jump to then part 
* THEN
* WHILE
254:    LDC  3,1(6) 	Load constant 
255:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
257:    LDC  3,0(6) 	Load constant 
258:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
260:    LDC  3,1(6) 	Load constant 
259:    LDA  7,1(7) 	Jump around the THEN 
* ENDIF
261:    LDA  7,-8(7) 	go to beginning of loop 
256:    LDA  7,5(7) 	No more loop 
* ENDWHILE
253:    LDA  7,8(7) 	Jump around the THEN 
* ENDIF
250:    LDA  7,11(7) 	Jump around the THEN 
* ENDIF
* IF
262:    LDC  3,0(6) 	Load constant 
263:    JGT  3,1(7) 	Jump to then part 
* THEN
* IF
265:    LDC  3,1(6) 	Load constant 
266:    JGT  3,1(7) 	Jump to then part 
* THEN
* WHILE
268:    LDC  3,0(6) 	Load constant 
269:    JGT  3,1(7) 	Jump to while part 
* DO
* WHILE
271:    LDC  3,1(6) 	Load constant 
272:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
274:    LDC  3,0(6) 	Load constant 
275:    LDA  7,-5(7) 	go to beginning of loop 
273:    LDA  7,2(7) 	No more loop 
* ENDWHILE
276:    LDA  7,-9(7) 	go to beginning of loop 
270:    LDA  7,6(7) 	No more loop 
* ENDWHILE
267:    LDA  7,9(7) 	Jump around the THEN 
* ENDIF
264:    LDA  7,12(7) 	Jump around the THEN 
* ENDIF
* IF
277:    LDC  3,1(6) 	Load constant 
278:    JGT  3,1(7) 	Jump to then part 
* THEN
* WHILE
280:    LDC  3,0(6) 	Load constant 
281:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
283:    LDC  3,1(6) 	Load constant 
284:    LDA  7,-5(7) 	go to beginning of loop 
282:    LDA  7,2(7) 	No more loop 
* ENDWHILE
279:    LDA  7,5(7) 	Jump around the THEN 
* ENDIF
* IF
285:    LDC  3,0(6) 	Load constant 
286:    JGT  3,1(7) 	Jump to then part 
* THEN
* WHILE
288:    LDC  3,1(6) 	Load constant 
289:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
291:    LDC  3,0(6) 	Load constant 
292:    LDA  7,-5(7) 	go to beginning of loop 
290:    LDA  7,2(7) 	No more loop 
* ENDWHILE
* ELSE
287:    LDA  7,6(7) 	Jump around the THEN 
* EXPRESSION STMT
294:    LDC  3,1(6) 	Load constant 
293:    LDA  7,1(7) 	Jump around the ELSE 
* ENDIF
* IF
295:    LDC  3,0(6) 	Load constant 
296:    JGT  3,1(7) 	Jump to then part 
* THEN
* WHILE
298:    LDC  3,1(6) 	Load constant 
299:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
301:    LDC  3,0(6) 	Load constant 
302:    LDA  7,-5(7) 	go to beginning of loop 
300:    LDA  7,2(7) 	No more loop 
* ENDWHILE
* ELSE
297:    LDA  7,6(7) 	Jump around the THEN 
* IF
304:    LDC  3,1(6) 	Load constant 
305:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
307:    LDC  3,0(6) 	Load constant 
306:    LDA  7,1(7) 	Jump around the THEN 
* ENDIF
303:    LDA  7,4(7) 	Jump around the ELSE 
* ENDIF
* IF
308:    LDC  3,1(6) 	Load constant 
309:    JGT  3,1(7) 	Jump to then part 
* THEN
* WHILE
311:    LDC  3,0(6) 	Load constant 
312:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
314:    LDC  3,1(6) 	Load constant 
315:    LDA  7,-5(7) 	go to beginning of loop 
313:    LDA  7,2(7) 	No more loop 
* ENDWHILE
* ELSE
310:    LDA  7,6(7) 	Jump around the THEN 
* WHILE
317:    LDC  3,0(6) 	Load constant 
318:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
320:    LDC  3,1(6) 	Load constant 
321:    LDA  7,-5(7) 	go to beginning of loop 
319:    LDA  7,2(7) 	No more loop 
* ENDWHILE
316:    LDA  7,5(7) 	Jump around the ELSE 
* ENDIF
* IF
322:    LDC  3,0(6) 	Load constant 
323:    JGT  3,1(7) 	Jump to then part 
* THEN
* WHILE
325:    LDC  3,1(6) 	Load constant 
326:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
328:    LDC  3,0(6) 	Load constant 
329:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
331:    LDC  3,1(6) 	Load constant 
330:    LDA  7,1(7) 	Jump around the THEN 
* ENDIF
332:    LDA  7,-8(7) 	go to beginning of loop 
327:    LDA  7,5(7) 	No more loop 
* ENDWHILE
324:    LDA  7,8(7) 	Jump around the THEN 
* ENDIF
* IF
333:    LDC  3,0(6) 	Load constant 
334:    JGT  3,1(7) 	Jump to then part 
* THEN
* WHILE
336:    LDC  3,1(6) 	Load constant 
337:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
339:    LDC  3,0(6) 	Load constant 
340:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
342:    LDC  3,1(6) 	Load constant 
* ELSE
341:    LDA  7,2(7) 	Jump around the THEN 
* EXPRESSION STMT
344:    LDC  3,0(6) 	Load constant 
343:    LDA  7,1(7) 	Jump around the ELSE 
* ENDIF
345:    LDA  7,-10(7) 	go to beginning of loop 
338:    LDA  7,7(7) 	No more loop 
* ENDWHILE
335:    LDA  7,10(7) 	Jump around the THEN 
* ENDIF
* IF
346:    LDC  3,1(6) 	Load constant 
347:    JGT  3,1(7) 	Jump to then part 
* THEN
* WHILE
349:    LDC  3,0(6) 	Load constant 
350:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
352:    LDC  3,1(6) 	Load constant 
353:    JGT  3,1(7) 	Jump to then part 
* THEN
* IF
355:    LDC  3,0(6) 	Load constant 
356:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
358:    LDC  3,1(6) 	Load constant 
357:    LDA  7,1(7) 	Jump around the THEN 
* ENDIF
354:    LDA  7,4(7) 	Jump around the THEN 
* ENDIF
359:    LDA  7,-11(7) 	go to beginning of loop 
351:    LDA  7,8(7) 	No more loop 
* ENDWHILE
348:    LDA  7,11(7) 	Jump around the THEN 
* ENDIF
* IF
360:    LDC  3,0(6) 	Load constant 
361:    JGT  3,1(7) 	Jump to then part 
* THEN
* WHILE
363:    LDC  3,1(6) 	Load constant 
364:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
366:    LDC  3,0(6) 	Load constant 
367:    JGT  3,1(7) 	Jump to then part 
* THEN
* WHILE
369:    LDC  3,1(6) 	Load constant 
370:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
372:    LDC  3,0(6) 	Load constant 
373:    LDA  7,-5(7) 	go to beginning of loop 
371:    LDA  7,2(7) 	No more loop 
* ENDWHILE
368:    LDA  7,5(7) 	Jump around the THEN 
* ENDIF
374:    LDA  7,-12(7) 	go to beginning of loop 
365:    LDA  7,9(7) 	No more loop 
* ENDWHILE
362:    LDA  7,12(7) 	Jump around the THEN 
* ENDIF
* IF
375:    LDC  3,1(6) 	Load constant 
376:    JGT  3,1(7) 	Jump to then part 
* THEN
* WHILE
378:    LDC  3,0(6) 	Load constant 
379:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
381:    LDC  3,1(6) 	Load constant 
382:    JGT  3,1(7) 	Jump to then part 
* THEN
* WHILE
384:    LDC  3,0(6) 	Load constant 
385:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
387:    LDC  3,1(6) 	Load constant 
388:    LDA  7,-5(7) 	go to beginning of loop 
386:    LDA  7,2(7) 	No more loop 
* ENDWHILE
* ELSE
383:    LDA  7,6(7) 	Jump around the THEN 
* EXPRESSION STMT
390:    LDC  3,0(6) 	Load constant 
389:    LDA  7,1(7) 	Jump around the ELSE 
* ENDIF
391:    LDA  7,-14(7) 	go to beginning of loop 
380:    LDA  7,11(7) 	No more loop 
* ENDWHILE
377:    LDA  7,14(7) 	Jump around the THEN 
* ENDIF
* IF
392:    LDC  3,1(6) 	Load constant 
393:    JGT  3,1(7) 	Jump to then part 
* THEN
* WHILE
395:    LDC  3,0(6) 	Load constant 
396:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
398:    LDC  3,1(6) 	Load constant 
399:    JGT  3,1(7) 	Jump to then part 
* THEN
* WHILE
401:    LDC  3,0(6) 	Load constant 
402:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
404:    LDC  3,1(6) 	Load constant 
405:    LDA  7,-5(7) 	go to beginning of loop 
403:    LDA  7,2(7) 	No more loop 
* ENDWHILE
* ELSE
400:    LDA  7,6(7) 	Jump around the THEN 
* EXPRESSION STMT
407:    LDC  3,0(6) 	Load constant 
406:    LDA  7,1(7) 	Jump around the ELSE 
* ENDIF
408:    LDA  7,-14(7) 	go to beginning of loop 
397:    LDA  7,11(7) 	No more loop 
* ENDWHILE
* ELSE
394:    LDA  7,15(7) 	Jump around the THEN 
* EXPRESSION STMT
410:    LDC  3,1(6) 	Load constant 
409:    LDA  7,1(7) 	Jump around the ELSE 
* ENDIF
* IF
411:    LDC  3,0(6) 	Load constant 
412:    JGT  3,1(7) 	Jump to then part 
* THEN
* WHILE
414:    LDC  3,1(6) 	Load constant 
415:    JGT  3,1(7) 	Jump to while part 
* DO
* WHILE
417:    LDC  3,0(6) 	Load constant 
418:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
420:    LDC  3,1(6) 	Load constant 
421:    LDA  7,-5(7) 	go to beginning of loop 
419:    LDA  7,2(7) 	No more loop 
* ENDWHILE
422:    LDA  7,-9(7) 	go to beginning of loop 
416:    LDA  7,6(7) 	No more loop 
* ENDWHILE
413:    LDA  7,9(7) 	Jump around the THEN 
* ENDIF
* IF
423:    LDC  3,0(6) 	Load constant 
424:    JGT  3,1(7) 	Jump to then part 
* THEN
* WHILE
426:    LDC  3,1(6) 	Load constant 
427:    JGT  3,1(7) 	Jump to while part 
* DO
* WHILE
429:    LDC  3,0(6) 	Load constant 
430:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
432:    LDC  3,1(6) 	Load constant 
433:    LDA  7,-5(7) 	go to beginning of loop 
431:    LDA  7,2(7) 	No more loop 
* ENDWHILE
434:    LDA  7,-9(7) 	go to beginning of loop 
428:    LDA  7,6(7) 	No more loop 
* ENDWHILE
* ELSE
425:    LDA  7,10(7) 	Jump around the THEN 
* EXPRESSION STMT
436:    LDC  3,0(6) 	Load constant 
435:    LDA  7,1(7) 	Jump around the ELSE 
* ENDIF
* IF
437:    LDC  3,1(6) 	Load constant 
438:    JGT  3,1(7) 	Jump to then part 
* THEN
* WHILE
440:    LDC  3,0(6) 	Load constant 
441:    JGT  3,1(7) 	Jump to while part 
* DO
* WHILE
443:    LDC  3,1(6) 	Load constant 
444:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
446:    LDC  3,0(6) 	Load constant 
447:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
449:    LDC  3,1(6) 	Load constant 
448:    LDA  7,1(7) 	Jump around the THEN 
* ENDIF
450:    LDA  7,-8(7) 	go to beginning of loop 
445:    LDA  7,5(7) 	No more loop 
* ENDWHILE
451:    LDA  7,-12(7) 	go to beginning of loop 
442:    LDA  7,9(7) 	No more loop 
* ENDWHILE
439:    LDA  7,12(7) 	Jump around the THEN 
* ENDIF
* IF
452:    LDC  3,0(6) 	Load constant 
453:    JGT  3,1(7) 	Jump to then part 
* THEN
* WHILE
455:    LDC  3,1(6) 	Load constant 
456:    JGT  3,1(7) 	Jump to while part 
* DO
* WHILE
458:    LDC  3,0(6) 	Load constant 
459:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
461:    LDC  3,1(6) 	Load constant 
462:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
464:    LDC  3,0(6) 	Load constant 
* ELSE
463:    LDA  7,2(7) 	Jump around the THEN 
* EXPRESSION STMT
466:    LDC  3,1(6) 	Load constant 
465:    LDA  7,1(7) 	Jump around the ELSE 
* ENDIF
467:    LDA  7,-10(7) 	go to beginning of loop 
460:    LDA  7,7(7) 	No more loop 
* ENDWHILE
468:    LDA  7,-14(7) 	go to beginning of loop 
457:    LDA  7,11(7) 	No more loop 
* ENDWHILE
454:    LDA  7,14(7) 	Jump around the THEN 
* ENDIF
* IF
469:    LDC  3,0(6) 	Load constant 
470:    JGT  3,1(7) 	Jump to then part 
* THEN
* WHILE
472:    LDC  3,1(6) 	Load constant 
473:    JGT  3,1(7) 	Jump to while part 
* DO
* WHILE
475:    LDC  3,0(6) 	Load constant 
476:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
478:    LDC  3,1(6) 	Load constant 
479:    JGT  3,1(7) 	Jump to then part 
* THEN
* IF
481:    LDC  3,0(6) 	Load constant 
482:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
484:    LDC  3,1(6) 	Load constant 
483:    LDA  7,1(7) 	Jump around the THEN 
* ENDIF
480:    LDA  7,4(7) 	Jump around the THEN 
* ENDIF
485:    LDA  7,-11(7) 	go to beginning of loop 
477:    LDA  7,8(7) 	No more loop 
* ENDWHILE
486:    LDA  7,-15(7) 	go to beginning of loop 
474:    LDA  7,12(7) 	No more loop 
* ENDWHILE
471:    LDA  7,15(7) 	Jump around the THEN 
* ENDIF
* IF
487:    LDC  3,0(6) 	Load constant 
488:    JGT  3,1(7) 	Jump to then part 
* THEN
* WHILE
490:    LDC  3,1(6) 	Load constant 
491:    JGT  3,1(7) 	Jump to while part 
* DO
* WHILE
493:    LDC  3,0(6) 	Load constant 
494:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
496:    LDC  3,1(6) 	Load constant 
497:    JGT  3,1(7) 	Jump to then part 
* THEN
* IF
499:    LDC  3,0(6) 	Load constant 
500:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
502:    LDC  3,1(6) 	Load constant 
* ELSE
501:    LDA  7,2(7) 	Jump around the THEN 
* EXPRESSION STMT
504:    LDC  3,0(6) 	Load constant 
503:    LDA  7,1(7) 	Jump around the ELSE 
* ENDIF
498:    LDA  7,6(7) 	Jump around the THEN 
* ENDIF
505:    LDA  7,-13(7) 	go to beginning of loop 
495:    LDA  7,10(7) 	No more loop 
* ENDWHILE
506:    LDA  7,-17(7) 	go to beginning of loop 
492:    LDA  7,14(7) 	No more loop 
* ENDWHILE
489:    LDA  7,17(7) 	Jump around the THEN 
* ENDIF
* WHILE
507:    LDC  3,1(6) 	Load constant 
508:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
510:    LDC  3,0(6) 	Load constant 
511:    LDA  7,-5(7) 	go to beginning of loop 
509:    LDA  7,2(7) 	No more loop 
* ENDWHILE
* WHILE
512:    LDC  3,1(6) 	Load constant 
513:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
515:    LDC  3,0(6) 	Load constant 
516:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
518:    LDC  3,1(6) 	Load constant 
517:    LDA  7,1(7) 	Jump around the THEN 
* ENDIF
519:    LDA  7,-8(7) 	go to beginning of loop 
514:    LDA  7,5(7) 	No more loop 
* ENDWHILE
* WHILE
520:    LDC  3,0(6) 	Load constant 
521:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
523:    LDC  3,1(6) 	Load constant 
524:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
526:    LDC  3,0(6) 	Load constant 
* ELSE
525:    LDA  7,2(7) 	Jump around the THEN 
* EXPRESSION STMT
528:    LDC  3,1(6) 	Load constant 
527:    LDA  7,1(7) 	Jump around the ELSE 
* ENDIF
529:    LDA  7,-10(7) 	go to beginning of loop 
522:    LDA  7,7(7) 	No more loop 
* ENDWHILE
* WHILE
530:    LDC  3,0(6) 	Load constant 
531:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
533:    LDC  3,1(6) 	Load constant 
534:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
536:    LDC  3,0(6) 	Load constant 
* ELSE
535:    LDA  7,2(7) 	Jump around the THEN 
* IF
538:    LDC  3,1(6) 	Load constant 
539:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
541:    LDC  3,0(6) 	Load constant 
540:    LDA  7,1(7) 	Jump around the THEN 
* ENDIF
537:    LDA  7,4(7) 	Jump around the ELSE 
* ENDIF
542:    LDA  7,-13(7) 	go to beginning of loop 
532:    LDA  7,10(7) 	No more loop 
* ENDWHILE
* WHILE
543:    LDC  3,1(6) 	Load constant 
544:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
546:    LDC  3,0(6) 	Load constant 
547:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
549:    LDC  3,1(6) 	Load constant 
* ELSE
548:    LDA  7,2(7) 	Jump around the THEN 
* WHILE
551:    LDC  3,0(6) 	Load constant 
552:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
554:    LDC  3,1(6) 	Load constant 
555:    LDA  7,-5(7) 	go to beginning of loop 
553:    LDA  7,2(7) 	No more loop 
* ENDWHILE
550:    LDA  7,5(7) 	Jump around the ELSE 
* ENDIF
556:    LDA  7,-14(7) 	go to beginning of loop 
545:    LDA  7,11(7) 	No more loop 
* ENDWHILE
* WHILE
557:    LDC  3,0(6) 	Load constant 
558:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
560:    LDC  3,1(6) 	Load constant 
561:    JGT  3,1(7) 	Jump to then part 
* THEN
* IF
563:    LDC  3,0(6) 	Load constant 
564:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
566:    LDC  3,1(6) 	Load constant 
565:    LDA  7,1(7) 	Jump around the THEN 
* ENDIF
562:    LDA  7,4(7) 	Jump around the THEN 
* ENDIF
567:    LDA  7,-11(7) 	go to beginning of loop 
559:    LDA  7,8(7) 	No more loop 
* ENDWHILE
* WHILE
568:    LDC  3,0(6) 	Load constant 
569:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
571:    LDC  3,1(6) 	Load constant 
572:    JGT  3,1(7) 	Jump to then part 
* THEN
* IF
574:    LDC  3,0(6) 	Load constant 
575:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
577:    LDC  3,1(6) 	Load constant 
* ELSE
576:    LDA  7,2(7) 	Jump around the THEN 
* EXPRESSION STMT
579:    LDC  3,0(6) 	Load constant 
578:    LDA  7,1(7) 	Jump around the ELSE 
* ENDIF
573:    LDA  7,6(7) 	Jump around the THEN 
* ENDIF
580:    LDA  7,-13(7) 	go to beginning of loop 
570:    LDA  7,10(7) 	No more loop 
* ENDWHILE
* WHILE
581:    LDC  3,1(6) 	Load constant 
582:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
584:    LDC  3,0(6) 	Load constant 
585:    JGT  3,1(7) 	Jump to then part 
* THEN
* IF
587:    LDC  3,1(6) 	Load constant 
588:    JGT  3,1(7) 	Jump to then part 
* THEN
* IF
590:    LDC  3,0(6) 	Load constant 
591:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
593:    LDC  3,1(6) 	Load constant 
592:    LDA  7,1(7) 	Jump around the THEN 
* ENDIF
589:    LDA  7,4(7) 	Jump around the THEN 
* ENDIF
586:    LDA  7,7(7) 	Jump around the THEN 
* ENDIF
594:    LDA  7,-14(7) 	go to beginning of loop 
583:    LDA  7,11(7) 	No more loop 
* ENDWHILE
* WHILE
595:    LDC  3,0(6) 	Load constant 
596:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
598:    LDC  3,1(6) 	Load constant 
599:    JGT  3,1(7) 	Jump to then part 
* THEN
* WHILE
601:    LDC  3,0(6) 	Load constant 
602:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
604:    LDC  3,1(6) 	Load constant 
605:    LDA  7,-5(7) 	go to beginning of loop 
603:    LDA  7,2(7) 	No more loop 
* ENDWHILE
600:    LDA  7,5(7) 	Jump around the THEN 
* ENDIF
606:    LDA  7,-12(7) 	go to beginning of loop 
597:    LDA  7,9(7) 	No more loop 
* ENDWHILE
* WHILE
607:    LDC  3,0(6) 	Load constant 
608:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
610:    LDC  3,1(6) 	Load constant 
611:    JGT  3,1(7) 	Jump to then part 
* THEN
* WHILE
613:    LDC  3,0(6) 	Load constant 
614:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
616:    LDC  3,1(6) 	Load constant 
617:    LDA  7,-5(7) 	go to beginning of loop 
615:    LDA  7,2(7) 	No more loop 
* ENDWHILE
* ELSE
612:    LDA  7,6(7) 	Jump around the THEN 
* EXPRESSION STMT
619:    LDC  3,0(6) 	Load constant 
618:    LDA  7,1(7) 	Jump around the ELSE 
* ENDIF
620:    LDA  7,-14(7) 	go to beginning of loop 
609:    LDA  7,11(7) 	No more loop 
* ENDWHILE
* WHILE
621:    LDC  3,1(6) 	Load constant 
622:    JGT  3,1(7) 	Jump to while part 
* DO
* WHILE
624:    LDC  3,0(6) 	Load constant 
625:    JGT  3,1(7) 	Jump to while part 
* DO
* EXPRESSION STMT
627:    LDC  3,1(6) 	Load constant 
628:    LDA  7,-5(7) 	go to beginning of loop 
626:    LDA  7,2(7) 	No more loop 
* ENDWHILE
629:    LDA  7,-9(7) 	go to beginning of loop 
623:    LDA  7,6(7) 	No more loop 
* ENDWHILE
* WHILE
630:    LDC  3,0(6) 	Load constant 
631:    JGT  3,1(7) 	Jump to while part 
* DO
* WHILE
633:    LDC  3,1(6) 	Load constant 
634:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
636:    LDC  3,0(6) 	Load constant 
637:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
639:    LDC  3,1(6) 	Load constant 
638:    LDA  7,1(7) 	Jump around the THEN 
* ENDIF
640:    LDA  7,-8(7) 	go to beginning of loop 
635:    LDA  7,5(7) 	No more loop 
* ENDWHILE
641:    LDA  7,-12(7) 	go to beginning of loop 
632:    LDA  7,9(7) 	No more loop 
* ENDWHILE
* WHILE
642:    LDC  3,0(6) 	Load constant 
643:    JGT  3,1(7) 	Jump to while part 
* DO
* WHILE
645:    LDC  3,1(6) 	Load constant 
646:    JGT  3,1(7) 	Jump to while part 
* DO
* IF
648:    LDC  3,0(6) 	Load constant 
649:    JGT  3,1(7) 	Jump to then part 
* THEN
* EXPRESSION STMT
651:    LDC  3,1(6) 	Load constant 
* ELSE
650:    LDA  7,2(7) 	Jump around the THEN 
* EXPRESSION STMT
653:    LDC  3,0(6) 	Load constant 
652:    LDA  7,1(7) 	Jump around the ELSE 
* ENDIF
654:    LDA  7,-10(7) 	go to beginning of loop 
647:    LDA  7,7(7) 	No more loop 
* ENDWHILE
655:    LDA  7,-14(7) 	go to beginning of loop 
644:    LDA  7,11(7) 	No more loop 
* ENDWHILE
* END compound statement
* Add standard closing in case there is no return statement
656:    LDC  2,0(6) 	Set return value to 0 
657:     LD  3,-1(1) 	Load return address 
658:     LD  1,0(1) 	Adjust fp 
659:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,659(7) 	Jump to init 
* BEGIN Init
660:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
661:    LDA  1,0(0) 	set first frame at end of globals 
662:     ST  1,0(1) 	store old fp (point to self) 
663:    LDA  3,1(7) 	Return address in ac 
664:    LDA  7,-635(7) 	Jump to main 
665:   HALT  0,0,0 	DONE! 
* END Init
