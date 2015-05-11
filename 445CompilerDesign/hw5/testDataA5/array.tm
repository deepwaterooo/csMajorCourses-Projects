* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  array.c-
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
* BEGIN function get
 30:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
* EXPRESSION STMT
 31:     ST  1,-4(1) 	Store old fp in ghost frame 
 32:    LDC  3,0(6) 	Load constant 
 33:     LD  4,-2(1) 	Load address of base of array x
 34:    SUB  3,4,3 	Compute offset of value 
 35:     LD  3,0(3) 	Load the value 
 36:     ST  3,-6(1) 	Store parameter 
 37:    LDA  1,-4(1) 	Load address of new frame 
 38:    LDA  3,1(7) 	Return address in ac 
 39:    LDA  7,-34(7) 	CALL output
 40:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 41:     ST  1,-4(1) 	Store old fp in ghost frame 
 42:    LDA  1,-4(1) 	Load address of new frame 
 43:    LDA  3,1(7) 	Return address in ac 
 44:    LDA  7,-20(7) 	CALL outnl
 45:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 46:    LDC  3,1(6) 	Load constant 
 47:     ST  3,-4(1) 	Save index 
 48:    LDC  3,666(6) 	Load constant 
 49:     LD  4,-4(1) 	Restore index 
 50:     LD  5,-2(1) 	Load address of base of array x
 51:    SUB  5,5,4 	Compute offset of value 
 52:     ST  3,0(5) 	Store variable x
* RETURN
 53:     LD  3,-3(1) 	Load variable i
 54:     LD  4,-2(1) 	Load address of base of array x
 55:    SUB  3,4,3 	Compute offset of value 
 56:     LD  3,0(3) 	Load the value 
 57:    LDA  2,0(3) 	Copy result to rt register 
 58:     LD  3,-1(1) 	Load return address 
 59:     LD  1,0(1) 	Adjust fp 
 60:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
 61:    LDC  2,0(6) 	Set return value to 0 
 62:     LD  3,-1(1) 	Load return address 
 63:     LD  1,0(1) 	Adjust fp 
 64:    LDA  7,0(3) 	Return 
* END of function get
* BEGIN function main
 65:     ST  3,-1(1) 	Store return address. 
* BEGIN compound statement
 66:    LDC  3,5(6) 	load size of array x
 67:     ST  3,-2(1) 	save size of array x
* EXPRESSION STMT
 68:    LDC  3,2(6) 	Load constant 
 69:     ST  3,-8(1) 	Store variable dog
* EXPRESSION STMT
 70:    LDC  3,0(6) 	Load constant 
 71:     ST  3,-9(1) 	Save index 
 72:    LDC  3,3(6) 	Load constant 
 73:     LD  4,-9(1) 	Restore index 
 74:    LDA  5,-3(1) 	Load address of base of array x
 75:    SUB  5,5,4 	Compute offset of value 
 76:     ST  3,0(5) 	Store variable x
* EXPRESSION STMT
 77:     ST  1,-9(1) 	Store old fp in ghost frame 
 78:    LDC  3,0(6) 	Load constant 
 79:    LDA  4,-3(1) 	Load address of base of array x
 80:    SUB  3,4,3 	Compute offset of value 
 81:     LD  3,0(3) 	Load the value 
 82:     ST  3,-11(1) 	Store parameter 
 83:    LDA  1,-9(1) 	Load address of new frame 
 84:    LDA  3,1(7) 	Return address in ac 
 85:    LDA  7,-80(7) 	CALL output
 86:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 87:    LDC  3,1(6) 	Load constant 
 88:     ST  3,-9(1) 	Save index 
 89:    LDC  3,0(6) 	Load constant 
 90:    LDA  4,-3(1) 	Load address of base of array x
 91:    SUB  3,4,3 	Compute offset of value 
 92:     LD  3,0(3) 	Load the value 
 93:     LD  4,-9(1) 	Restore index 
 94:    LDA  5,-3(1) 	Load address of base of array x
 95:    SUB  5,5,4 	Compute offset of value 
 96:     ST  3,0(5) 	Store variable x
* EXPRESSION STMT
 97:     ST  1,-9(1) 	Store old fp in ghost frame 
 98:    LDC  3,1(6) 	Load constant 
 99:    LDA  4,-3(1) 	Load address of base of array x
100:    SUB  3,4,3 	Compute offset of value 
101:     LD  3,0(3) 	Load the value 
102:     ST  3,-11(1) 	Store parameter 
103:    LDA  1,-9(1) 	Load address of new frame 
104:    LDA  3,1(7) 	Return address in ac 
105:    LDA  7,-100(7) 	CALL output
106:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
107:    LDC  3,2(6) 	Load constant 
108:     ST  3,-9(1) 	Save index 
109:    LDC  3,1(6) 	Load constant 
110:    LDA  4,-3(1) 	Load address of base of array x
111:    SUB  3,4,3 	Compute offset of value 
112:     LD  3,0(3) 	Load the value 
113:     ST  3,-10(1) 	Save left side 
114:    LDC  3,1(6) 	Load constant 
115:     LD  4,-10(1) 	Load left into ac1 
116:    ADD  3,4,3 	Op + 
117:     LD  4,-9(1) 	Restore index 
118:    LDA  5,-3(1) 	Load address of base of array x
119:    SUB  5,5,4 	Compute offset of value 
120:     ST  3,0(5) 	Store variable x
* EXPRESSION STMT
121:     ST  1,-9(1) 	Store old fp in ghost frame 
122:    LDC  3,2(6) 	Load constant 
123:    LDA  4,-3(1) 	Load address of base of array x
124:    SUB  3,4,3 	Compute offset of value 
125:     LD  3,0(3) 	Load the value 
126:     ST  3,-11(1) 	Store parameter 
127:    LDA  1,-9(1) 	Load address of new frame 
128:    LDA  3,1(7) 	Return address in ac 
129:    LDA  7,-124(7) 	CALL output
130:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
131:     LD  3,-8(1) 	Load variable dog
132:     ST  3,-9(1) 	Save left side 
133:     LD  3,-8(1) 	Load variable dog
134:     LD  4,-9(1) 	Load left into ac1 
135:    ADD  3,4,3 	Op + 
136:     ST  3,-9(1) 	Save index 
137:    LDC  3,496(6) 	Load constant 
138:     LD  4,-9(1) 	Restore index 
139:    LDA  5,-3(1) 	Load address of base of array x
140:    SUB  5,5,4 	Compute offset of value 
141:     ST  3,0(5) 	Store variable x
* EXPRESSION STMT
142:     ST  1,-9(1) 	Store old fp in ghost frame 
143:    LDC  3,4(6) 	Load constant 
144:    LDA  4,-3(1) 	Load address of base of array x
145:    SUB  3,4,3 	Compute offset of value 
146:     LD  3,0(3) 	Load the value 
147:     ST  3,-11(1) 	Store parameter 
148:    LDA  1,-9(1) 	Load address of new frame 
149:    LDA  3,1(7) 	Return address in ac 
150:    LDA  7,-145(7) 	CALL output
151:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
152:     ST  1,-9(1) 	Store old fp in ghost frame 
153:    LDA  1,-9(1) 	Load address of new frame 
154:    LDA  3,1(7) 	Return address in ac 
155:    LDA  7,-131(7) 	CALL outnl
156:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
157:    LDC  3,2(6) 	Load constant 
158:     ST  3,-8(1) 	Store variable dog
* EXPRESSION STMT
159:    LDC  3,0(6) 	Load constant 
160:     ST  3,-9(1) 	Save index 
161:    LDC  3,3(6) 	Load constant 
162:     LD  4,-9(1) 	Restore index 
163:    LDA  5,-1(0) 	Load address of base of array y
164:    SUB  5,5,4 	Compute offset of value 
165:     ST  3,0(5) 	Store variable y
* EXPRESSION STMT
166:     ST  1,-9(1) 	Store old fp in ghost frame 
167:    LDC  3,0(6) 	Load constant 
168:    LDA  4,-1(0) 	Load address of base of array y
169:    SUB  3,4,3 	Compute offset of value 
170:     LD  3,0(3) 	Load the value 
171:     ST  3,-11(1) 	Store parameter 
172:    LDA  1,-9(1) 	Load address of new frame 
173:    LDA  3,1(7) 	Return address in ac 
174:    LDA  7,-169(7) 	CALL output
175:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
176:    LDC  3,1(6) 	Load constant 
177:     ST  3,-9(1) 	Save index 
178:    LDC  3,0(6) 	Load constant 
179:    LDA  4,-1(0) 	Load address of base of array y
180:    SUB  3,4,3 	Compute offset of value 
181:     LD  3,0(3) 	Load the value 
182:     LD  4,-9(1) 	Restore index 
183:    LDA  5,-1(0) 	Load address of base of array y
184:    SUB  5,5,4 	Compute offset of value 
185:     ST  3,0(5) 	Store variable y
* EXPRESSION STMT
186:     ST  1,-9(1) 	Store old fp in ghost frame 
187:    LDC  3,1(6) 	Load constant 
188:    LDA  4,-1(0) 	Load address of base of array y
189:    SUB  3,4,3 	Compute offset of value 
190:     LD  3,0(3) 	Load the value 
191:     ST  3,-11(1) 	Store parameter 
192:    LDA  1,-9(1) 	Load address of new frame 
193:    LDA  3,1(7) 	Return address in ac 
194:    LDA  7,-189(7) 	CALL output
195:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
196:    LDC  3,2(6) 	Load constant 
197:     ST  3,-9(1) 	Save index 
198:    LDC  3,1(6) 	Load constant 
199:    LDA  4,-1(0) 	Load address of base of array y
200:    SUB  3,4,3 	Compute offset of value 
201:     LD  3,0(3) 	Load the value 
202:     ST  3,-10(1) 	Save left side 
203:    LDC  3,311(6) 	Load constant 
204:     LD  4,-10(1) 	Load left into ac1 
205:    ADD  3,4,3 	Op + 
206:     LD  4,-9(1) 	Restore index 
207:    LDA  5,-1(0) 	Load address of base of array y
208:    SUB  5,5,4 	Compute offset of value 
209:     ST  3,0(5) 	Store variable y
* EXPRESSION STMT
210:     ST  1,-9(1) 	Store old fp in ghost frame 
211:    LDC  3,2(6) 	Load constant 
212:    LDA  4,-1(0) 	Load address of base of array y
213:    SUB  3,4,3 	Compute offset of value 
214:     LD  3,0(3) 	Load the value 
215:     ST  3,-11(1) 	Store parameter 
216:    LDA  1,-9(1) 	Load address of new frame 
217:    LDA  3,1(7) 	Return address in ac 
218:    LDA  7,-213(7) 	CALL output
219:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
220:     LD  3,-8(1) 	Load variable dog
221:     ST  3,-9(1) 	Save left side 
222:     LD  3,-8(1) 	Load variable dog
223:     LD  4,-9(1) 	Load left into ac1 
224:    ADD  3,4,3 	Op + 
225:     ST  3,-9(1) 	Save index 
226:    LDC  3,496(6) 	Load constant 
227:     LD  4,-9(1) 	Restore index 
228:    LDA  5,-1(0) 	Load address of base of array y
229:    SUB  5,5,4 	Compute offset of value 
230:     ST  3,0(5) 	Store variable y
* EXPRESSION STMT
231:     ST  1,-9(1) 	Store old fp in ghost frame 
232:    LDC  3,4(6) 	Load constant 
233:    LDA  4,-1(0) 	Load address of base of array y
234:    SUB  3,4,3 	Compute offset of value 
235:     LD  3,0(3) 	Load the value 
236:     ST  3,-11(1) 	Store parameter 
237:    LDA  1,-9(1) 	Load address of new frame 
238:    LDA  3,1(7) 	Return address in ac 
239:    LDA  7,-234(7) 	CALL output
240:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
241:     ST  1,-9(1) 	Store old fp in ghost frame 
242:    LDA  1,-9(1) 	Load address of new frame 
243:    LDA  3,1(7) 	Return address in ac 
244:    LDA  7,-220(7) 	CALL outnl
245:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
246:     ST  1,-9(1) 	Store old fp in ghost frame 
247:    LDA  3,-1(0) 	Load address of base of array y
248:     ST  3,-11(1) 	Store parameter 
249:    LDC  3,2(6) 	Load constant 
250:     ST  3,-12(1) 	Store parameter 
251:    LDA  1,-9(1) 	Load address of new frame 
252:    LDA  3,1(7) 	Return address in ac 
253:    LDA  7,-224(7) 	CALL get
254:    LDA  3,0(2) 	Save the result in ac 
255:     ST  3,-8(1) 	Store variable dog
* EXPRESSION STMT
256:     ST  1,-9(1) 	Store old fp in ghost frame 
257:     LD  3,-8(1) 	Load variable dog
258:     ST  3,-11(1) 	Store parameter 
259:    LDA  1,-9(1) 	Load address of new frame 
260:    LDA  3,1(7) 	Return address in ac 
261:    LDA  7,-256(7) 	CALL output
262:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
263:     ST  1,-9(1) 	Store old fp in ghost frame 
264:     ST  1,-11(1) 	Store old fp in ghost frame 
265:    LDA  3,-1(0) 	Load address of base of array y
266:     ST  3,-13(1) 	Store parameter 
267:    LDC  3,2(6) 	Load constant 
268:     ST  3,-14(1) 	Store parameter 
269:    LDA  1,-11(1) 	Load address of new frame 
270:    LDA  3,1(7) 	Return address in ac 
271:    LDA  7,-242(7) 	CALL get
272:    LDA  3,0(2) 	Save the result in ac 
273:     ST  3,-11(1) 	Store parameter 
274:    LDA  1,-9(1) 	Load address of new frame 
275:    LDA  3,1(7) 	Return address in ac 
276:    LDA  7,-271(7) 	CALL output
277:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
278:     ST  1,-9(1) 	Store old fp in ghost frame 
279:    LDC  3,1(6) 	Load constant 
280:    LDA  4,-3(1) 	Load address of base of array x
281:    SUB  3,4,3 	Compute offset of value 
282:     LD  3,0(3) 	Load the value 
283:     ST  3,-11(1) 	Store parameter 
284:    LDA  1,-9(1) 	Load address of new frame 
285:    LDA  3,1(7) 	Return address in ac 
286:    LDA  7,-281(7) 	CALL output
287:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
288:     ST  1,-9(1) 	Store old fp in ghost frame 
289:    LDA  1,-9(1) 	Load address of new frame 
290:    LDA  3,1(7) 	Return address in ac 
291:    LDA  7,-267(7) 	CALL outnl
292:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
293:    LDC  2,0(6) 	Set return value to 0 
294:     LD  3,-1(1) 	Load return address 
295:     LD  1,0(1) 	Adjust fp 
296:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,296(7) 	Jump to init 
* BEGIN Init
297:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
298:    LDC  3,5(6) 	load size of array y
299:     ST  3,0(0) 	save size of array y
* END init of global array sizes
300:    LDA  1,-6(0) 	set first frame at end of globals 
301:     ST  1,0(1) 	store old fp (point to self) 
302:    LDA  3,1(7) 	Return address in ac 
303:    LDA  7,-239(7) 	Jump to main 
304:   HALT  0,0,0 	DONE! 
* END Init
