* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  assign3.c-
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
 31:    LDC  3,8(6) 	load size of array x
 32:     ST  3,-2(1) 	save size of array x
 33:    LDC  3,7(6) 	load size of array y
 34:     ST  3,-11(1) 	save size of array y
* EXPRESSION STMT
 35:    LDC  3,5(6) 	Load constant 
 36:     ST  3,-19(1) 	Save index 
 37:    LDC  3,111(6) 	Load constant 
 38:     LD  4,-19(1) 	Restore index 
 39:    LDA  5,-3(1) 	Load address of base of array x
 40:    SUB  5,5,4 	Compute offset of value 
 41:     LD  4,0(5) 	load lhs variable x
 42:    ADD  3,4,3 	op += 
 43:     ST  3,0(5) 	Store variable x
* EXPRESSION STMT
 44:     ST  1,-19(1) 	Store old fp in ghost frame 
 45:    LDC  3,5(6) 	Load constant 
 46:    LDA  4,-3(1) 	Load address of base of array x
 47:    SUB  3,4,3 	Compute offset of value 
 48:     LD  3,0(3) 	Load the value 
 49:     ST  3,-21(1) 	Store parameter 
 50:    LDA  1,-19(1) 	Load address of new frame 
 51:    LDA  3,1(7) 	Return address in ac 
 52:    LDA  7,-47(7) 	CALL output
 53:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 54:    LDC  3,4(6) 	Load constant 
 55:     ST  3,-19(1) 	Save index 
 56:    LDC  3,222(6) 	Load constant 
 57:     LD  4,-19(1) 	Restore index 
 58:    LDA  5,-12(1) 	Load address of base of array y
 59:    SUB  5,5,4 	Compute offset of value 
 60:     LD  4,0(5) 	load lhs variable y
 61:    ADD  3,4,3 	op += 
 62:     ST  3,0(5) 	Store variable y
* EXPRESSION STMT
 63:     ST  1,-19(1) 	Store old fp in ghost frame 
 64:    LDC  3,4(6) 	Load constant 
 65:    LDA  4,-12(1) 	Load address of base of array y
 66:    SUB  3,4,3 	Compute offset of value 
 67:     LD  3,0(3) 	Load the value 
 68:     ST  3,-21(1) 	Store parameter 
 69:    LDA  1,-19(1) 	Load address of new frame 
 70:    LDA  3,1(7) 	Return address in ac 
 71:    LDA  7,-66(7) 	CALL output
 72:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 73:     ST  1,-19(1) 	Store old fp in ghost frame 
 74:    LDA  1,-19(1) 	Load address of new frame 
 75:    LDA  3,1(7) 	Return address in ac 
 76:    LDA  7,-52(7) 	CALL outnl
 77:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 78:    LDC  3,5(6) 	Load constant 
 79:     ST  3,-19(1) 	Save index 
 80:    LDC  3,333(6) 	Load constant 
 81:     LD  4,-19(1) 	Restore index 
 82:    LDA  5,-1(0) 	Load address of base of array gx
 83:    SUB  5,5,4 	Compute offset of value 
 84:     LD  4,0(5) 	load lhs variable gx
 85:    ADD  3,4,3 	op += 
 86:     ST  3,0(5) 	Store variable gx
* EXPRESSION STMT
 87:     ST  1,-19(1) 	Store old fp in ghost frame 
 88:    LDC  3,5(6) 	Load constant 
 89:    LDA  4,-1(0) 	Load address of base of array gx
 90:    SUB  3,4,3 	Compute offset of value 
 91:     LD  3,0(3) 	Load the value 
 92:     ST  3,-21(1) 	Store parameter 
 93:    LDA  1,-19(1) 	Load address of new frame 
 94:    LDA  3,1(7) 	Return address in ac 
 95:    LDA  7,-90(7) 	CALL output
 96:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 97:    LDC  3,4(6) 	Load constant 
 98:     ST  3,-19(1) 	Save index 
 99:    LDC  3,444(6) 	Load constant 
100:     LD  4,-19(1) 	Restore index 
101:    LDA  5,-9(0) 	Load address of base of array gy
102:    SUB  5,5,4 	Compute offset of value 
103:     LD  4,0(5) 	load lhs variable gy
104:    ADD  3,4,3 	op += 
105:     ST  3,0(5) 	Store variable gy
* EXPRESSION STMT
106:     ST  1,-19(1) 	Store old fp in ghost frame 
107:    LDC  3,4(6) 	Load constant 
108:    LDA  4,-9(0) 	Load address of base of array gy
109:    SUB  3,4,3 	Compute offset of value 
110:     LD  3,0(3) 	Load the value 
111:     ST  3,-21(1) 	Store parameter 
112:    LDA  1,-19(1) 	Load address of new frame 
113:    LDA  3,1(7) 	Return address in ac 
114:    LDA  7,-109(7) 	CALL output
115:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
116:     ST  1,-19(1) 	Store old fp in ghost frame 
117:    LDA  1,-19(1) 	Load address of new frame 
118:    LDA  3,1(7) 	Return address in ac 
119:    LDA  7,-95(7) 	CALL outnl
120:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
121:    LDC  3,5(6) 	Load constant 
122:     ST  3,-19(1) 	Save index 
123:    LDC  3,4(6) 	Load constant 
124:    LDA  4,-12(1) 	Load address of base of array y
125:    SUB  3,4,3 	Compute offset of value 
126:     LD  3,0(3) 	Load the value 
127:     LD  4,-19(1) 	Restore index 
128:    LDA  5,-3(1) 	Load address of base of array x
129:    SUB  5,5,4 	Compute offset of value 
130:     LD  4,0(5) 	load lhs variable x
131:    ADD  3,4,3 	op += 
132:     ST  3,0(5) 	Store variable x
* EXPRESSION STMT
133:     ST  1,-19(1) 	Store old fp in ghost frame 
134:    LDC  3,5(6) 	Load constant 
135:    LDA  4,-3(1) 	Load address of base of array x
136:    SUB  3,4,3 	Compute offset of value 
137:     LD  3,0(3) 	Load the value 
138:     ST  3,-21(1) 	Store parameter 
139:    LDA  1,-19(1) 	Load address of new frame 
140:    LDA  3,1(7) 	Return address in ac 
141:    LDA  7,-136(7) 	CALL output
142:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
143:     ST  1,-19(1) 	Store old fp in ghost frame 
144:    LDA  1,-19(1) 	Load address of new frame 
145:    LDA  3,1(7) 	Return address in ac 
146:    LDA  7,-122(7) 	CALL outnl
147:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
148:    LDC  3,5(6) 	Load constant 
149:     ST  3,-19(1) 	Save index 
150:    LDC  3,4(6) 	Load constant 
151:    LDA  4,-9(0) 	Load address of base of array gy
152:    SUB  3,4,3 	Compute offset of value 
153:     LD  3,0(3) 	Load the value 
154:     LD  4,-19(1) 	Restore index 
155:    LDA  5,-1(0) 	Load address of base of array gx
156:    SUB  5,5,4 	Compute offset of value 
157:     LD  4,0(5) 	load lhs variable gx
158:    ADD  3,4,3 	op += 
159:     ST  3,0(5) 	Store variable gx
* EXPRESSION STMT
160:     ST  1,-19(1) 	Store old fp in ghost frame 
161:    LDC  3,5(6) 	Load constant 
162:    LDA  4,-1(0) 	Load address of base of array gx
163:    SUB  3,4,3 	Compute offset of value 
164:     LD  3,0(3) 	Load the value 
165:     ST  3,-21(1) 	Store parameter 
166:    LDA  1,-19(1) 	Load address of new frame 
167:    LDA  3,1(7) 	Return address in ac 
168:    LDA  7,-163(7) 	CALL output
169:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
170:     ST  1,-19(1) 	Store old fp in ghost frame 
171:    LDA  1,-19(1) 	Load address of new frame 
172:    LDA  3,1(7) 	Return address in ac 
173:    LDA  7,-149(7) 	CALL outnl
174:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
175:    LDC  3,5(6) 	Load constant 
176:     ST  3,-19(1) 	Save index 
177:    LDC  3,111(6) 	Load constant 
178:     LD  4,-19(1) 	Restore index 
179:    LDA  5,-3(1) 	Load address of base of array x
180:    SUB  5,5,4 	Compute offset of value 
181:     LD  4,0(5) 	load lhs variable x
182:    SUB  3,4,3 	op -= 
183:     ST  3,0(5) 	Store variable x
* EXPRESSION STMT
184:     ST  1,-19(1) 	Store old fp in ghost frame 
185:    LDC  3,5(6) 	Load constant 
186:    LDA  4,-3(1) 	Load address of base of array x
187:    SUB  3,4,3 	Compute offset of value 
188:     LD  3,0(3) 	Load the value 
189:     ST  3,-21(1) 	Store parameter 
190:    LDA  1,-19(1) 	Load address of new frame 
191:    LDA  3,1(7) 	Return address in ac 
192:    LDA  7,-187(7) 	CALL output
193:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
194:    LDC  3,4(6) 	Load constant 
195:     ST  3,-19(1) 	Save index 
196:    LDC  3,222(6) 	Load constant 
197:     LD  4,-19(1) 	Restore index 
198:    LDA  5,-12(1) 	Load address of base of array y
199:    SUB  5,5,4 	Compute offset of value 
200:     LD  4,0(5) 	load lhs variable y
201:    SUB  3,4,3 	op -= 
202:     ST  3,0(5) 	Store variable y
* EXPRESSION STMT
203:     ST  1,-19(1) 	Store old fp in ghost frame 
204:    LDC  3,4(6) 	Load constant 
205:    LDA  4,-12(1) 	Load address of base of array y
206:    SUB  3,4,3 	Compute offset of value 
207:     LD  3,0(3) 	Load the value 
208:     ST  3,-21(1) 	Store parameter 
209:    LDA  1,-19(1) 	Load address of new frame 
210:    LDA  3,1(7) 	Return address in ac 
211:    LDA  7,-206(7) 	CALL output
212:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
213:     ST  1,-19(1) 	Store old fp in ghost frame 
214:    LDA  1,-19(1) 	Load address of new frame 
215:    LDA  3,1(7) 	Return address in ac 
216:    LDA  7,-192(7) 	CALL outnl
217:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
218:    LDC  3,5(6) 	Load constant 
219:     ST  3,-19(1) 	Save index 
220:    LDC  3,333(6) 	Load constant 
221:     LD  4,-19(1) 	Restore index 
222:    LDA  5,-1(0) 	Load address of base of array gx
223:    SUB  5,5,4 	Compute offset of value 
224:     LD  4,0(5) 	load lhs variable gx
225:    SUB  3,4,3 	op -= 
226:     ST  3,0(5) 	Store variable gx
* EXPRESSION STMT
227:     ST  1,-19(1) 	Store old fp in ghost frame 
228:    LDC  3,5(6) 	Load constant 
229:    LDA  4,-1(0) 	Load address of base of array gx
230:    SUB  3,4,3 	Compute offset of value 
231:     LD  3,0(3) 	Load the value 
232:     ST  3,-21(1) 	Store parameter 
233:    LDA  1,-19(1) 	Load address of new frame 
234:    LDA  3,1(7) 	Return address in ac 
235:    LDA  7,-230(7) 	CALL output
236:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
237:    LDC  3,4(6) 	Load constant 
238:     ST  3,-19(1) 	Save index 
239:    LDC  3,444(6) 	Load constant 
240:     LD  4,-19(1) 	Restore index 
241:    LDA  5,-9(0) 	Load address of base of array gy
242:    SUB  5,5,4 	Compute offset of value 
243:     LD  4,0(5) 	load lhs variable gy
244:    SUB  3,4,3 	op -= 
245:     ST  3,0(5) 	Store variable gy
* EXPRESSION STMT
246:     ST  1,-19(1) 	Store old fp in ghost frame 
247:    LDC  3,4(6) 	Load constant 
248:    LDA  4,-9(0) 	Load address of base of array gy
249:    SUB  3,4,3 	Compute offset of value 
250:     LD  3,0(3) 	Load the value 
251:     ST  3,-21(1) 	Store parameter 
252:    LDA  1,-19(1) 	Load address of new frame 
253:    LDA  3,1(7) 	Return address in ac 
254:    LDA  7,-249(7) 	CALL output
255:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
256:     ST  1,-19(1) 	Store old fp in ghost frame 
257:    LDA  1,-19(1) 	Load address of new frame 
258:    LDA  3,1(7) 	Return address in ac 
259:    LDA  7,-235(7) 	CALL outnl
260:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
261:    LDC  3,5(6) 	Load constant 
262:     ST  3,-19(1) 	Save index 
263:    LDC  3,4(6) 	Load constant 
264:    LDA  4,-12(1) 	Load address of base of array y
265:    SUB  3,4,3 	Compute offset of value 
266:     LD  3,0(3) 	Load the value 
267:     LD  4,-19(1) 	Restore index 
268:    LDA  5,-3(1) 	Load address of base of array x
269:    SUB  5,5,4 	Compute offset of value 
270:     LD  4,0(5) 	load lhs variable x
271:    SUB  3,4,3 	op -= 
272:     ST  3,0(5) 	Store variable x
* EXPRESSION STMT
273:     ST  1,-19(1) 	Store old fp in ghost frame 
274:    LDC  3,5(6) 	Load constant 
275:    LDA  4,-3(1) 	Load address of base of array x
276:    SUB  3,4,3 	Compute offset of value 
277:     LD  3,0(3) 	Load the value 
278:     ST  3,-21(1) 	Store parameter 
279:    LDA  1,-19(1) 	Load address of new frame 
280:    LDA  3,1(7) 	Return address in ac 
281:    LDA  7,-276(7) 	CALL output
282:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
283:     ST  1,-19(1) 	Store old fp in ghost frame 
284:    LDA  1,-19(1) 	Load address of new frame 
285:    LDA  3,1(7) 	Return address in ac 
286:    LDA  7,-262(7) 	CALL outnl
287:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
288:    LDC  3,5(6) 	Load constant 
289:     ST  3,-19(1) 	Save index 
290:    LDC  3,4(6) 	Load constant 
291:    LDA  4,-9(0) 	Load address of base of array gy
292:    SUB  3,4,3 	Compute offset of value 
293:     LD  3,0(3) 	Load the value 
294:     LD  4,-19(1) 	Restore index 
295:    LDA  5,-1(0) 	Load address of base of array gx
296:    SUB  5,5,4 	Compute offset of value 
297:     LD  4,0(5) 	load lhs variable gx
298:    SUB  3,4,3 	op -= 
299:     ST  3,0(5) 	Store variable gx
* EXPRESSION STMT
300:     ST  1,-19(1) 	Store old fp in ghost frame 
301:    LDC  3,5(6) 	Load constant 
302:    LDA  4,-1(0) 	Load address of base of array gx
303:    SUB  3,4,3 	Compute offset of value 
304:     LD  3,0(3) 	Load the value 
305:     ST  3,-21(1) 	Store parameter 
306:    LDA  1,-19(1) 	Load address of new frame 
307:    LDA  3,1(7) 	Return address in ac 
308:    LDA  7,-303(7) 	CALL output
309:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
310:     ST  1,-19(1) 	Store old fp in ghost frame 
311:    LDA  1,-19(1) 	Load address of new frame 
312:    LDA  3,1(7) 	Return address in ac 
313:    LDA  7,-289(7) 	CALL outnl
314:    LDA  3,0(2) 	Save the result in ac 
* RETURN
315:    LDA  2,0(3) 	Copy result to rt register 
316:     LD  3,-1(1) 	Load return address 
317:     LD  1,0(1) 	Adjust fp 
318:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
319:    LDC  2,0(6) 	Set return value to 0 
320:     LD  3,-1(1) 	Load return address 
321:     LD  1,0(1) 	Adjust fp 
322:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,322(7) 	Jump to init 
* BEGIN Init
323:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
324:    LDC  3,7(6) 	load size of array gx
325:     ST  3,0(0) 	save size of array gx
326:    LDC  3,6(6) 	load size of array gy
327:     ST  3,-8(0) 	save size of array gy
* END init of global array sizes
328:    LDA  1,-15(0) 	set first frame at end of globals 
329:     ST  1,0(1) 	store old fp (point to self) 
330:    LDA  3,1(7) 	Return address in ac 
331:    LDA  7,-302(7) 	Jump to main 
332:   HALT  0,0,0 	DONE! 
* END Init
