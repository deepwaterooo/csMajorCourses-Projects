* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  var.c-
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
* BEGIN function cat
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 31:     ST  1,-4(1) 	Store old fp in ghost frame 
 32:     LD  3,-2(1) 	Load variable x
 33:     ST  3,-6(1) 	Store parameter 
 34:    LDA  1,-4(1) 	Load address of new frame 
 35:    LDA  3,1(7) 	Return address in ac 
 36:    LDA  7,-31(7) 	CALL output
 37:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 38:     ST  1,-4(1) 	Store old fp in ghost frame 
 39:    LDC  3,3(6) 	Load constant 
 40:     LD  4,-3(1) 	Load address of base of array xa
 41:    SUB  3,4,3 	Compute offset of value 
 42:     LD  3,0(3) 	Load the value 
 43:     ST  3,-6(1) 	Store parameter 
 44:    LDA  1,-4(1) 	Load address of new frame 
 45:    LDA  3,1(7) 	Return address in ac 
 46:    LDA  7,-41(7) 	CALL output
 47:    LDA  3,0(2) 	Save the result in ac 

* EXPRESSION STMT
 48:     ST  1,-4(1) 	Store old fp in ghost frame 
 49:     LD  3,-3(1) 	Load address of base of array xa
 50:     LD  3,1(3) 	Load array size 
 51:     ST  3,-6(1) 	Store parameter 
 52:    LDA  1,-4(1) 	Load address of new frame 
 53:    LDA  3,1(7) 	Return address in ac 
 54:    LDA  7,-49(7) 	CALL output
 55:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 56:     ST  1,-4(1) 	Store old fp in ghost frame 
 57:    LDA  1,-4(1) 	Load address of new frame 
 58:    LDA  3,1(7) 	Return address in ac 
 59:    LDA  7,-35(7) 	CALL outnl
 60:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
 61:    LDC  2,0(6) 	Set return value to 0 
 62:     LD  3,-1(1) 	Load return address 
 63:     LD  1,0(1) 	Adjust fp 
 64:    LDA  7,0(3) 	Return 
* END of function cat
* BEGIN function dog
 65:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 66:     ST  1,-4(1) 	Store old fp in ghost frame 
 67:     LD  3,-2(1) 	Load variable x
 68:     ST  3,-6(1) 	Store parameter 
 69:    LDA  1,-4(1) 	Load address of new frame 
 70:    LDA  3,1(7) 	Return address in ac 
 71:    LDA  7,-66(7) 	CALL output
 72:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 73:     ST  1,-4(1) 	Store old fp in ghost frame 
 74:    LDC  3,3(6) 	Load constant 
 75:     LD  4,-3(1) 	Load address of base of array xa
 76:    SUB  3,4,3 	Compute offset of value 
 77:     LD  3,0(3) 	Load the value 
 78:     ST  3,-6(1) 	Store parameter 
 79:    LDA  1,-4(1) 	Load address of new frame 
 80:    LDA  3,1(7) 	Return address in ac 
 81:    LDA  7,-76(7) 	CALL output
 82:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 83:     ST  1,-4(1) 	Store old fp in ghost frame 
 84:    LDA  1,-4(1) 	Load address of new frame 
 85:    LDA  3,1(7) 	Return address in ac 
 86:    LDA  7,-62(7) 	CALL outnl
 87:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 88:    LDC  3,668(6) 	Load constant 
 89:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
 90:    LDC  3,1(6) 	Load constant 
 91:     ST  3,-4(1) 	Save left side 
 92:    LDC  3,2(6) 	Load constant 
 93:     LD  4,-4(1) 	Load left into ac1 
 94:    ADD  3,4,3 	Op + 
 95:     ST  3,-4(1) 	Save index 
 96:    LDC  3,669(6) 	Load constant 
 97:     LD  4,-4(1) 	Restore index 
 98:     LD  5,-3(1) 	Load address of base of array xa
 99:    SUB  5,5,4 	Compute offset of value 
100:     ST  3,0(5) 	Store variable xa

* EXPRESSION STMT
101:     ST  1,-4(1) 	Store old fp in ghost frame 
102:     LD  3,-2(1) 	Load variable x
103:     ST  3,-6(1) 	Store parameter 
104:    LDA  1,-4(1) 	Load address of new frame 
105:    LDA  3,1(7) 	Return address in ac 
106:    LDA  7,-101(7) 	CALL output
107:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
108:     ST  1,-4(1) 	Store old fp in ghost frame 
109:    LDC  3,3(6) 	Load constant 
110:     LD  4,-3(1) 	Load address of base of array xa
111:    SUB  3,4,3 	Compute offset of value 
112:     LD  3,0(3) 	Load the value 
113:     ST  3,-6(1) 	Store parameter 
114:    LDA  1,-4(1) 	Load address of new frame 
115:    LDA  3,1(7) 	Return address in ac 
116:    LDA  7,-111(7) 	CALL output
117:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
118:     ST  1,-4(1) 	Store old fp in ghost frame 
119:    LDA  1,-4(1) 	Load address of new frame 
120:    LDA  3,1(7) 	Return address in ac 
121:    LDA  7,-97(7) 	CALL outnl
122:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
123:    LDC  3,670(6) 	Load constant 
124:     ST  3,0(0) 	Store variable g
* EXPRESSION STMT
125:    LDC  3,2(6) 	Load constant 
126:     ST  3,-4(1) 	Save left side 
127:    LDC  3,1(6) 	Load constant 
128:     LD  4,-4(1) 	Load left into ac1 
129:    ADD  3,4,3 	Op + 
130:     ST  3,-4(1) 	Save index 
131:    LDC  3,671(6) 	Load constant 
132:     LD  4,-4(1) 	Restore index 
133:    LDA  5,-2(0) 	Load address of base of array ga
134:    SUB  5,5,4 	Compute offset of value 
135:     ST  3,0(5) 	Store variable ga
* EXPRESSION STMT
136:     ST  1,-4(1) 	Store old fp in ghost frame 
137:     LD  3,0(0) 	Load variable g
138:     ST  3,-6(1) 	Store parameter 
139:    LDA  1,-4(1) 	Load address of new frame 
140:    LDA  3,1(7) 	Return address in ac 
141:    LDA  7,-136(7) 	CALL output
142:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
143:     ST  1,-4(1) 	Store old fp in ghost frame 
144:    LDC  3,3(6) 	Load constant 
145:    LDA  4,-2(0) 	Load address of base of array ga
146:    SUB  3,4,3 	Compute offset of value 
147:     LD  3,0(3) 	Load the value 
148:     ST  3,-6(1) 	Store parameter 
149:    LDA  1,-4(1) 	Load address of new frame 
150:    LDA  3,1(7) 	Return address in ac 
151:    LDA  7,-146(7) 	CALL output
152:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
153:     ST  1,-4(1) 	Store old fp in ghost frame 
154:    LDA  1,-4(1) 	Load address of new frame 
155:    LDA  3,1(7) 	Return address in ac 
156:    LDA  7,-132(7) 	CALL outnl
157:    LDA  3,0(2) 	Save the result in ac 

* EXPRESSION STMT
158:     ST  1,-4(1) 	Store old fp in ghost frame 
159:     LD  3,-2(1) 	Load variable x
160:     ST  3,-6(1) 	Store parameter 
161:     LD  3,-3(1) 	Load address of base of array xa
162:     ST  3,-7(1) 	Store parameter 
163:    LDA  1,-4(1) 	Load address of new frame 
164:    LDA  3,1(7) 	Return address in ac 
165:    LDA  7,-136(7) 	CALL cat
166:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
167:     ST  1,-4(1) 	Store old fp in ghost frame 
168:     LD  3,0(0) 	Load variable g
169:     ST  3,-6(1) 	Store parameter 
170:    LDA  3,-2(0) 	Load address of base of array ga
171:     ST  3,-7(1) 	Store parameter 
172:    LDA  1,-4(1) 	Load address of new frame 
173:    LDA  3,1(7) 	Return address in ac 
174:    LDA  7,-145(7) 	CALL cat
175:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
176:    LDC  2,0(6) 	Set return value to 0 
177:     LD  3,-1(1) 	Load return address 
178:     LD  1,0(1) 	Adjust fp 
179:    LDA  7,0(3) 	Return 
* END of function dog
* BEGIN function fox
180:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
181:    LDC  3,11(6) 	load size of array sa
182:     ST  3,-13(0) 	save size of array sa
* EXPRESSION STMT
183:    LDC  3,3(6) 	Load constant 
184:     ST  3,-2(1) 	Save index 
185:    LDC  3,1000(6) 	Load constant 
186:     LD  4,-2(1) 	Restore index 
187:    LDA  5,-14(0) 	Load address of base of array sa
188:    SUB  5,5,4 	Compute offset of value 
189:     ST  3,0(5) 	Store variable sa
* EXPRESSION STMT
190:    LDC  3,777(6) 	Load constant 
191:     ST  3,-12(0) 	Store variable s
* EXPRESSION STMT
192:    LDC  3,3(6) 	Load constant 
193:     ST  3,-2(1) 	Save index 
194:     LD  3,-12(0) 	Load variable s
195:     ST  3,-3(1) 	Save left side 
196:    LDC  3,999(6) 	Load constant 
197:     ST  3,-12(0) 	Store variable s
198:     LD  4,-3(1) 	Load left into ac1 
199:    ADD  3,4,3 	Op + 
200:     LD  4,-2(1) 	Restore index 
201:    LDA  5,-14(0) 	Load address of base of array sa
202:    SUB  5,5,4 	Compute offset of value 
203:     LD  4,0(5) 	load lhs variable sa
204:    SUB  3,4,3 	op -= 
205:     ST  3,0(5) 	Store variable sa
* EXPRESSION STMT
206:     ST  1,-2(1) 	Store old fp in ghost frame 
207:     LD  3,-12(0) 	Load variable s
208:     ST  3,-4(1) 	Store parameter 
209:    LDA  1,-2(1) 	Load address of new frame 
210:    LDA  3,1(7) 	Return address in ac 
211:    LDA  7,-206(7) 	CALL output
212:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
213:     ST  1,-2(1) 	Store old fp in ghost frame 
214:    LDC  3,3(6) 	Load constant 
215:    LDA  4,-14(0) 	Load address of base of array sa
216:    SUB  3,4,3 	Compute offset of value 
217:     LD  3,0(3) 	Load the value 
218:     ST  3,-4(1) 	Store parameter 
219:    LDA  1,-2(1) 	Load address of new frame 
220:    LDA  3,1(7) 	Return address in ac 
221:    LDA  7,-216(7) 	CALL output
222:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
223:     ST  1,-2(1) 	Store old fp in ghost frame 
224:    LDA  1,-2(1) 	Load address of new frame 
225:    LDA  3,1(7) 	Return address in ac 
226:    LDA  7,-202(7) 	CALL outnl
227:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
228:     ST  1,-2(1) 	Store old fp in ghost frame 
229:     LD  3,-12(0) 	Load variable s
230:     ST  3,-4(1) 	Store parameter 
231:    LDA  3,-14(0) 	Load address of base of array sa
232:     ST  3,-5(1) 	Store parameter 
233:    LDA  1,-2(1) 	Load address of new frame 
234:    LDA  3,1(7) 	Return address in ac 
235:    LDA  7,-206(7) 	CALL cat
236:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
237:    LDC  2,0(6) 	Set return value to 0 
238:     LD  3,-1(1) 	Load return address 
239:     LD  1,0(1) 	Adjust fp 
240:    LDA  7,0(3) 	Return 
* END of function fox
* BEGIN function main
241:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
242:    LDC  3,12(6) 	load size of array ya
243:     ST  3,-3(1) 	save size of array ya
* EXPRESSION STMT
244:    LDC  3,666(6) 	Load constant 
245:     ST  3,-2(1) 	Store variable y
* EXPRESSION STMT
246:    LDC  3,1(6) 	Load constant 
247:     ST  3,-16(1) 	Save left side 
248:    LDC  3,2(6) 	Load constant 
249:     LD  4,-16(1) 	Load left into ac1 
250:    ADD  3,4,3 	Op + 
251:     ST  3,-16(1) 	Save index 
252:    LDC  3,667(6) 	Load constant 
253:     LD  4,-16(1) 	Restore index 
254:    LDA  5,-4(1) 	Load address of base of array ya
255:    SUB  5,5,4 	Compute offset of value 
256:     ST  3,0(5) 	Store variable ya
* EXPRESSION STMT
257:     ST  1,-16(1) 	Store old fp in ghost frame 
258:     LD  3,-2(1) 	Load variable y
259:     ST  3,-18(1) 	Store parameter 
260:    LDA  1,-16(1) 	Load address of new frame 
261:    LDA  3,1(7) 	Return address in ac 
262:    LDA  7,-257(7) 	CALL output
263:    LDA  3,0(2) 	Save the result in ac 




* EXPRESSION STMT
264:     ST  1,-16(1) 	Store old fp in ghost frame 
265:    LDC  3,3(6) 	Load constant 
266:    LDA  4,-4(1) 	Load address of base of array ya
267:    SUB  3,4,3 	Compute offset of value 
268:     LD  3,0(3) 	Load the value 
269:     ST  3,-18(1) 	Store parameter 
270:    LDA  1,-16(1) 	Load address of new frame 
271:    LDA  3,1(7) 	Return address in ac 
272:    LDA  7,-267(7) 	CALL output
273:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
274:     ST  1,-16(1) 	Store old fp in ghost frame 
275:    LDA  1,-16(1) 	Load address of new frame 
276:    LDA  3,1(7) 	Return address in ac 
277:    LDA  7,-253(7) 	CALL outnl
278:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
279:     ST  1,-16(1) 	Store old fp in ghost frame 
280:     LD  3,-2(1) 	Load variable y
281:     ST  3,-18(1) 	Store parameter 
282:    LDA  3,-4(1) 	Load address of base of array ya
283:     ST  3,-19(1) 	Store parameter 
284:    LDA  1,-16(1) 	Load address of new frame 
285:    LDA  3,1(7) 	Return address in ac 
286:    LDA  7,-222(7) 	CALL dog
287:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
288:     ST  1,-16(1) 	Store old fp in ghost frame 
289:     LD  3,-2(1) 	Load variable y
290:     ST  3,-18(1) 	Store parameter 
291:    LDA  1,-16(1) 	Load address of new frame 
292:    LDA  3,1(7) 	Return address in ac 
293:    LDA  7,-288(7) 	CALL output
294:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
295:     ST  1,-16(1) 	Store old fp in ghost frame 
296:    LDC  3,3(6) 	Load constant 
297:    LDA  4,-4(1) 	Load address of base of array ya
298:    SUB  3,4,3 	Compute offset of value 
299:     LD  3,0(3) 	Load the value 
300:     ST  3,-18(1) 	Store parameter 
301:    LDA  1,-16(1) 	Load address of new frame 
302:    LDA  3,1(7) 	Return address in ac 
303:    LDA  7,-298(7) 	CALL output
304:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
305:     ST  1,-16(1) 	Store old fp in ghost frame 
306:    LDA  1,-16(1) 	Load address of new frame 
307:    LDA  3,1(7) 	Return address in ac 
308:    LDA  7,-284(7) 	CALL outnl
309:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
310:     ST  1,-16(1) 	Store old fp in ghost frame 
311:    LDA  1,-16(1) 	Load address of new frame 
312:    LDA  3,1(7) 	Return address in ac 
313:    LDA  7,-134(7) 	CALL fox
314:    LDA  3,0(2) 	Save the result in ac 
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
320:    LDC  3,10(6) 	load size of array ga
321:     ST  3,-1(0) 	save size of array ga
* END init of global array sizes
322:    LDA  1,-25(0) 	set first frame at end of globals 
323:     ST  1,0(1) 	store old fp (point to self) 
324:    LDA  3,1(7) 	Return address in ac 
325:    LDA  7,-85(7) 	Jump to main 
326:   HALT  0,0,0 	DONE! 
* END Init


