* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  assign2.c-
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
 35:    LDC  3,6(6) 	load size of array a
 36:     ST  3,-19(1) 	save size of array a
 37:    LDC  3,5(6) 	load size of array b
 38:     ST  3,-26(1) 	save size of array b
* EXPRESSION STMT
 39:    LDC  3,5(6) 	Load constant 
 40:     ST  3,-32(1) 	Save index 
 41:    LDC  3,111(6) 	Load constant 
 42:     LD  4,-32(1) 	Restore index 
 43:    LDA  5,-3(1) 	Load address of base of array x
 44:    SUB  5,5,4 	Compute offset of value 
 45:     ST  3,0(5) 	Store variable x
* EXPRESSION STMT
 46:     ST  1,-32(1) 	Store old fp in ghost frame 
 47:    LDC  3,5(6) 	Load constant 
 48:    LDA  4,-3(1) 	Load address of base of array x
 49:    SUB  3,4,3 	Compute offset of value 
 50:     LD  3,0(3) 	Load the value 
 51:     ST  3,-34(1) 	Store parameter 
 52:    LDA  1,-32(1) 	Load address of new frame 
 53:    LDA  3,1(7) 	Return address in ac 
 54:    LDA  7,-49(7) 	CALL output
 55:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 56:    LDC  3,4(6) 	Load constant 
 57:     ST  3,-32(1) 	Save index 
 58:    LDC  3,222(6) 	Load constant 
 59:     LD  4,-32(1) 	Restore index 
 60:    LDA  5,-12(1) 	Load address of base of array y
 61:    SUB  5,5,4 	Compute offset of value 
 62:     ST  3,0(5) 	Store variable y
* EXPRESSION STMT
 63:     ST  1,-32(1) 	Store old fp in ghost frame 
 64:    LDC  3,4(6) 	Load constant 
 65:    LDA  4,-12(1) 	Load address of base of array y
 66:    SUB  3,4,3 	Compute offset of value 
 67:     LD  3,0(3) 	Load the value 
 68:     ST  3,-34(1) 	Store parameter 
 69:    LDA  1,-32(1) 	Load address of new frame 
 70:    LDA  3,1(7) 	Return address in ac 
 71:    LDA  7,-66(7) 	CALL output
 72:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 73:    LDC  3,3(6) 	Load constant 
 74:     ST  3,-32(1) 	Save index 
 75:    LDC  3,1(6) 	Load constant 
 76:     LD  4,-32(1) 	Restore index 
 77:    LDA  5,-20(1) 	Load address of base of array a
 78:    SUB  5,5,4 	Compute offset of value 
 79:     ST  3,0(5) 	Store variable a
* EXPRESSION STMT
 80:     ST  1,-32(1) 	Store old fp in ghost frame 
 81:    LDC  3,3(6) 	Load constant 
 82:    LDA  4,-20(1) 	Load address of base of array a
 83:    SUB  3,4,3 	Compute offset of value 
 84:     LD  3,0(3) 	Load the value 
 85:     ST  3,-34(1) 	Store parameter 
 86:    LDA  1,-32(1) 	Load address of new frame 
 87:    LDA  3,1(7) 	Return address in ac 
 88:    LDA  7,-71(7) 	CALL outputb
 89:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 90:    LDC  3,2(6) 	Load constant 
 91:     ST  3,-32(1) 	Save index 
 92:    LDC  3,0(6) 	Load constant 
 93:     LD  4,-32(1) 	Restore index 
 94:    LDA  5,-27(1) 	Load address of base of array b
 95:    SUB  5,5,4 	Compute offset of value 
 96:     ST  3,0(5) 	Store variable b
* EXPRESSION STMT
 97:     ST  1,-32(1) 	Store old fp in ghost frame 
 98:    LDC  3,2(6) 	Load constant 
 99:    LDA  4,-27(1) 	Load address of base of array b
100:    SUB  3,4,3 	Compute offset of value 
101:     LD  3,0(3) 	Load the value 
102:     ST  3,-34(1) 	Store parameter 
103:    LDA  1,-32(1) 	Load address of new frame 
104:    LDA  3,1(7) 	Return address in ac 
105:    LDA  7,-88(7) 	CALL outputb
106:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
107:     ST  1,-32(1) 	Store old fp in ghost frame 
108:    LDA  1,-32(1) 	Load address of new frame 
109:    LDA  3,1(7) 	Return address in ac 
110:    LDA  7,-86(7) 	CALL outnl
111:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
112:    LDC  3,5(6) 	Load constant 
113:     ST  3,-32(1) 	Save index 
114:    LDC  3,333(6) 	Load constant 
115:     LD  4,-32(1) 	Restore index 
116:    LDA  5,-1(0) 	Load address of base of array gx
117:    SUB  5,5,4 	Compute offset of value 
118:     ST  3,0(5) 	Store variable gx
* EXPRESSION STMT
119:     ST  1,-32(1) 	Store old fp in ghost frame 
120:    LDC  3,5(6) 	Load constant 
121:    LDA  4,-1(0) 	Load address of base of array gx
122:    SUB  3,4,3 	Compute offset of value 
123:     LD  3,0(3) 	Load the value 
124:     ST  3,-34(1) 	Store parameter 
125:    LDA  1,-32(1) 	Load address of new frame 
126:    LDA  3,1(7) 	Return address in ac 
127:    LDA  7,-122(7) 	CALL output
128:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
129:    LDC  3,4(6) 	Load constant 
130:     ST  3,-32(1) 	Save index 
131:    LDC  3,444(6) 	Load constant 
132:     LD  4,-32(1) 	Restore index 
133:    LDA  5,-9(0) 	Load address of base of array gy
134:    SUB  5,5,4 	Compute offset of value 
135:     ST  3,0(5) 	Store variable gy
* EXPRESSION STMT
136:     ST  1,-32(1) 	Store old fp in ghost frame 
137:    LDC  3,4(6) 	Load constant 
138:    LDA  4,-9(0) 	Load address of base of array gy
139:    SUB  3,4,3 	Compute offset of value 
140:     LD  3,0(3) 	Load the value 
141:     ST  3,-34(1) 	Store parameter 
142:    LDA  1,-32(1) 	Load address of new frame 
143:    LDA  3,1(7) 	Return address in ac 
144:    LDA  7,-139(7) 	CALL output
145:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
146:    LDC  3,3(6) 	Load constant 
147:     ST  3,-32(1) 	Save index 
148:    LDC  3,0(6) 	Load constant 
149:     LD  4,-32(1) 	Restore index 
150:    LDA  5,-16(0) 	Load address of base of array ga
151:    SUB  5,5,4 	Compute offset of value 
152:     ST  3,0(5) 	Store variable ga
* EXPRESSION STMT
153:     ST  1,-32(1) 	Store old fp in ghost frame 
154:    LDC  3,3(6) 	Load constant 
155:    LDA  4,-16(0) 	Load address of base of array ga
156:    SUB  3,4,3 	Compute offset of value 
157:     LD  3,0(3) 	Load the value 
158:     ST  3,-34(1) 	Store parameter 
159:    LDA  1,-32(1) 	Load address of new frame 
160:    LDA  3,1(7) 	Return address in ac 
161:    LDA  7,-144(7) 	CALL outputb
162:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
163:    LDC  3,2(6) 	Load constant 
164:     ST  3,-32(1) 	Save index 
165:    LDC  3,1(6) 	Load constant 
166:     LD  4,-32(1) 	Restore index 
167:    LDA  5,-22(0) 	Load address of base of array gb
168:    SUB  5,5,4 	Compute offset of value 
169:     ST  3,0(5) 	Store variable gb
* EXPRESSION STMT
170:     ST  1,-32(1) 	Store old fp in ghost frame 
171:    LDC  3,2(6) 	Load constant 
172:    LDA  4,-22(0) 	Load address of base of array gb
173:    SUB  3,4,3 	Compute offset of value 
174:     LD  3,0(3) 	Load the value 
175:     ST  3,-34(1) 	Store parameter 
176:    LDA  1,-32(1) 	Load address of new frame 
177:    LDA  3,1(7) 	Return address in ac 
178:    LDA  7,-161(7) 	CALL outputb
179:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
180:     ST  1,-32(1) 	Store old fp in ghost frame 
181:    LDA  1,-32(1) 	Load address of new frame 
182:    LDA  3,1(7) 	Return address in ac 
183:    LDA  7,-159(7) 	CALL outnl
184:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
185:    LDC  3,5(6) 	Load constant 
186:     ST  3,-32(1) 	Save index 
187:    LDC  3,4(6) 	Load constant 
188:    LDA  4,-12(1) 	Load address of base of array y
189:    SUB  3,4,3 	Compute offset of value 
190:     LD  3,0(3) 	Load the value 
191:     LD  4,-32(1) 	Restore index 
192:    LDA  5,-3(1) 	Load address of base of array x
193:    SUB  5,5,4 	Compute offset of value 
194:     ST  3,0(5) 	Store variable x
* EXPRESSION STMT
195:     ST  1,-32(1) 	Store old fp in ghost frame 
196:    LDC  3,5(6) 	Load constant 
197:    LDA  4,-3(1) 	Load address of base of array x
198:    SUB  3,4,3 	Compute offset of value 
199:     LD  3,0(3) 	Load the value 
200:     ST  3,-34(1) 	Store parameter 
201:    LDA  1,-32(1) 	Load address of new frame 
202:    LDA  3,1(7) 	Return address in ac 
203:    LDA  7,-198(7) 	CALL output
204:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
205:    LDC  3,3(6) 	Load constant 
206:     ST  3,-32(1) 	Save index 
207:    LDC  3,2(6) 	Load constant 
208:    LDA  4,-27(1) 	Load address of base of array b
209:    SUB  3,4,3 	Compute offset of value 
210:     LD  3,0(3) 	Load the value 
211:     LD  4,-32(1) 	Restore index 
212:    LDA  5,-20(1) 	Load address of base of array a
213:    SUB  5,5,4 	Compute offset of value 
214:     ST  3,0(5) 	Store variable a
* EXPRESSION STMT
215:     ST  1,-32(1) 	Store old fp in ghost frame 
216:    LDC  3,3(6) 	Load constant 
217:    LDA  4,-20(1) 	Load address of base of array a
218:    SUB  3,4,3 	Compute offset of value 
219:     LD  3,0(3) 	Load the value 
220:     ST  3,-34(1) 	Store parameter 
221:    LDA  1,-32(1) 	Load address of new frame 
222:    LDA  3,1(7) 	Return address in ac 
223:    LDA  7,-206(7) 	CALL outputb
224:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
225:     ST  1,-32(1) 	Store old fp in ghost frame 
226:    LDA  1,-32(1) 	Load address of new frame 
227:    LDA  3,1(7) 	Return address in ac 
228:    LDA  7,-204(7) 	CALL outnl
229:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
230:    LDC  3,5(6) 	Load constant 
231:     ST  3,-32(1) 	Save index 
232:    LDC  3,4(6) 	Load constant 
233:    LDA  4,-9(0) 	Load address of base of array gy
234:    SUB  3,4,3 	Compute offset of value 
235:     LD  3,0(3) 	Load the value 
236:     LD  4,-32(1) 	Restore index 
237:    LDA  5,-1(0) 	Load address of base of array gx
238:    SUB  5,5,4 	Compute offset of value 
239:     ST  3,0(5) 	Store variable gx
* EXPRESSION STMT
240:     ST  1,-32(1) 	Store old fp in ghost frame 
241:    LDC  3,5(6) 	Load constant 
242:    LDA  4,-1(0) 	Load address of base of array gx
243:    SUB  3,4,3 	Compute offset of value 
244:     LD  3,0(3) 	Load the value 
245:     ST  3,-34(1) 	Store parameter 
246:    LDA  1,-32(1) 	Load address of new frame 
247:    LDA  3,1(7) 	Return address in ac 
248:    LDA  7,-243(7) 	CALL output
249:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
250:    LDC  3,3(6) 	Load constant 
251:     ST  3,-32(1) 	Save index 
252:    LDC  3,2(6) 	Load constant 
253:    LDA  4,-22(0) 	Load address of base of array gb
254:    SUB  3,4,3 	Compute offset of value 
255:     LD  3,0(3) 	Load the value 
256:     LD  4,-32(1) 	Restore index 
257:    LDA  5,-16(0) 	Load address of base of array ga
258:    SUB  5,5,4 	Compute offset of value 
259:     ST  3,0(5) 	Store variable ga
* EXPRESSION STMT
260:     ST  1,-32(1) 	Store old fp in ghost frame 
261:    LDC  3,3(6) 	Load constant 
262:    LDA  4,-16(0) 	Load address of base of array ga
263:    SUB  3,4,3 	Compute offset of value 
264:     LD  3,0(3) 	Load the value 
265:     ST  3,-34(1) 	Store parameter 
266:    LDA  1,-32(1) 	Load address of new frame 
267:    LDA  3,1(7) 	Return address in ac 
268:    LDA  7,-251(7) 	CALL outputb
269:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
270:     ST  1,-32(1) 	Store old fp in ghost frame 
271:    LDA  1,-32(1) 	Load address of new frame 
272:    LDA  3,1(7) 	Return address in ac 
273:    LDA  7,-249(7) 	CALL outnl
274:    LDA  3,0(2) 	Save the result in ac 
* RETURN
275:    LDA  2,0(3) 	Copy result to rt register 
276:     LD  3,-1(1) 	Load return address 
277:     LD  1,0(1) 	Adjust fp 
278:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
279:    LDC  2,0(6) 	Set return value to 0 
280:     LD  3,-1(1) 	Load return address 
281:     LD  1,0(1) 	Adjust fp 
282:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,282(7) 	Jump to init 
* BEGIN Init
283:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
284:    LDC  3,7(6) 	load size of array gx
285:     ST  3,0(0) 	save size of array gx
286:    LDC  3,6(6) 	load size of array gy
287:     ST  3,-8(0) 	save size of array gy
288:    LDC  3,5(6) 	load size of array ga
289:     ST  3,-15(0) 	save size of array ga
290:    LDC  3,4(6) 	load size of array gb
291:     ST  3,-21(0) 	save size of array gb
* END init of global array sizes
292:    LDA  1,-26(0) 	set first frame at end of globals 
293:     ST  1,0(1) 	store old fp (point to self) 
294:    LDA  3,1(7) 	Return address in ac 
295:    LDA  7,-266(7) 	Jump to main 
296:   HALT  0,0,0 	DONE! 
* END Init
