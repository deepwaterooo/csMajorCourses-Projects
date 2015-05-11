* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  assign5.c-
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
* EXPRESSION STMT
 31:    LDC  3,333(6) 	Load constant 
 32:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
 33:    LDC  3,444(6) 	Load constant 
 34:     ST  3,-3(1) 	Store variable y
* EXPRESSION STMT
 35:    LDC  3,666(6) 	Load constant 
 36:     ST  3,-4(1) 	Store variable z
* EXPRESSION STMT
 37:     LD  3,-4(1) 	Load variable z
 38:     ST  3,-3(1) 	Store variable y
 39:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
 40:     ST  1,-5(1) 	Store old fp in ghost frame 
 41:     LD  3,-2(1) 	Load variable x
 42:     ST  3,-7(1) 	Store parameter 
 43:    LDA  1,-5(1) 	Load address of new frame 
 44:    LDA  3,1(7) 	Return address in ac 
 45:    LDA  7,-40(7) 	CALL output
 46:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 47:     ST  1,-5(1) 	Store old fp in ghost frame 
 48:     LD  3,-3(1) 	Load variable y
 49:     ST  3,-7(1) 	Store parameter 
 50:    LDA  1,-5(1) 	Load address of new frame 
 51:    LDA  3,1(7) 	Return address in ac 
 52:    LDA  7,-47(7) 	CALL output
 53:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 54:     ST  1,-5(1) 	Store old fp in ghost frame 
 55:     LD  3,-4(1) 	Load variable z
 56:     ST  3,-7(1) 	Store parameter 
 57:    LDA  1,-5(1) 	Load address of new frame 
 58:    LDA  3,1(7) 	Return address in ac 
 59:    LDA  7,-54(7) 	CALL output
 60:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 61:     ST  1,-5(1) 	Store old fp in ghost frame 
 62:    LDA  1,-5(1) 	Load address of new frame 
 63:    LDA  3,1(7) 	Return address in ac 
 64:    LDA  7,-40(7) 	CALL outnl
 65:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 66:     LD  3,-4(1) 	Load variable z
 67:     ST  3,-3(1) 	Store variable y
 68:     LD  4,-2(1) 	load lhs variable x
 69:    ADD  3,4,3 	op += 
 70:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
 71:     ST  1,-5(1) 	Store old fp in ghost frame 
 72:     LD  3,-2(1) 	Load variable x
 73:     ST  3,-7(1) 	Store parameter 
 74:    LDA  1,-5(1) 	Load address of new frame 
 75:    LDA  3,1(7) 	Return address in ac 
 76:    LDA  7,-71(7) 	CALL output
 77:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 78:     ST  1,-5(1) 	Store old fp in ghost frame 
 79:     LD  3,-3(1) 	Load variable y
 80:     ST  3,-7(1) 	Store parameter 
 81:    LDA  1,-5(1) 	Load address of new frame 
 82:    LDA  3,1(7) 	Return address in ac 
 83:    LDA  7,-78(7) 	CALL output
 84:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 85:     ST  1,-5(1) 	Store old fp in ghost frame 
 86:     LD  3,-4(1) 	Load variable z
 87:     ST  3,-7(1) 	Store parameter 
 88:    LDA  1,-5(1) 	Load address of new frame 
 89:    LDA  3,1(7) 	Return address in ac 
 90:    LDA  7,-85(7) 	CALL output
 91:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 92:     ST  1,-5(1) 	Store old fp in ghost frame 
 93:    LDA  1,-5(1) 	Load address of new frame 
 94:    LDA  3,1(7) 	Return address in ac 
 95:    LDA  7,-71(7) 	CALL outnl
 96:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 97:     LD  3,-4(1) 	Load variable z
 98:     LD  4,-3(1) 	load lhs variable y
 99:    ADD  3,4,3 	op += 
100:     ST  3,-3(1) 	Store variable y
101:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
102:     ST  1,-5(1) 	Store old fp in ghost frame 
103:     LD  3,-2(1) 	Load variable x
104:     ST  3,-7(1) 	Store parameter 
105:    LDA  1,-5(1) 	Load address of new frame 
106:    LDA  3,1(7) 	Return address in ac 
107:    LDA  7,-102(7) 	CALL output
108:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
109:     ST  1,-5(1) 	Store old fp in ghost frame 
110:     LD  3,-3(1) 	Load variable y
111:     ST  3,-7(1) 	Store parameter 
112:    LDA  1,-5(1) 	Load address of new frame 
113:    LDA  3,1(7) 	Return address in ac 
114:    LDA  7,-109(7) 	CALL output
115:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
116:     ST  1,-5(1) 	Store old fp in ghost frame 
117:     LD  3,-4(1) 	Load variable z
118:     ST  3,-7(1) 	Store parameter 
119:    LDA  1,-5(1) 	Load address of new frame 
120:    LDA  3,1(7) 	Return address in ac 
121:    LDA  7,-116(7) 	CALL output
122:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
123:     ST  1,-5(1) 	Store old fp in ghost frame 
124:    LDA  1,-5(1) 	Load address of new frame 
125:    LDA  3,1(7) 	Return address in ac 
126:    LDA  7,-102(7) 	CALL outnl
127:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
128:     LD  3,-4(1) 	Load variable z
129:     LD  4,-3(1) 	load lhs variable y
130:    ADD  3,4,3 	op += 
131:     ST  3,-3(1) 	Store variable y
132:     LD  4,-2(1) 	load lhs variable x
133:    ADD  3,4,3 	op += 
134:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
135:     ST  1,-5(1) 	Store old fp in ghost frame 
136:     LD  3,-2(1) 	Load variable x
137:     ST  3,-7(1) 	Store parameter 
138:    LDA  1,-5(1) 	Load address of new frame 
139:    LDA  3,1(7) 	Return address in ac 
140:    LDA  7,-135(7) 	CALL output
141:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
142:     ST  1,-5(1) 	Store old fp in ghost frame 
143:     LD  3,-3(1) 	Load variable y
144:     ST  3,-7(1) 	Store parameter 
145:    LDA  1,-5(1) 	Load address of new frame 
146:    LDA  3,1(7) 	Return address in ac 
147:    LDA  7,-142(7) 	CALL output
148:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
149:     ST  1,-5(1) 	Store old fp in ghost frame 
150:     LD  3,-4(1) 	Load variable z
151:     ST  3,-7(1) 	Store parameter 
152:    LDA  1,-5(1) 	Load address of new frame 
153:    LDA  3,1(7) 	Return address in ac 
154:    LDA  7,-149(7) 	CALL output
155:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
156:     ST  1,-5(1) 	Store old fp in ghost frame 
157:    LDA  1,-5(1) 	Load address of new frame 
158:    LDA  3,1(7) 	Return address in ac 
159:    LDA  7,-135(7) 	CALL outnl
160:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
161:     LD  3,-4(1) 	Load variable z
162:     ST  3,-3(1) 	Store variable y
163:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
164:     ST  1,-5(1) 	Store old fp in ghost frame 
165:     LD  3,-2(1) 	Load variable x
166:     ST  3,-7(1) 	Store parameter 
167:    LDA  1,-5(1) 	Load address of new frame 
168:    LDA  3,1(7) 	Return address in ac 
169:    LDA  7,-164(7) 	CALL output
170:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
171:     ST  1,-5(1) 	Store old fp in ghost frame 
172:     LD  3,-3(1) 	Load variable y
173:     ST  3,-7(1) 	Store parameter 
174:    LDA  1,-5(1) 	Load address of new frame 
175:    LDA  3,1(7) 	Return address in ac 
176:    LDA  7,-171(7) 	CALL output
177:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
178:     ST  1,-5(1) 	Store old fp in ghost frame 
179:     LD  3,-4(1) 	Load variable z
180:     ST  3,-7(1) 	Store parameter 
181:    LDA  1,-5(1) 	Load address of new frame 
182:    LDA  3,1(7) 	Return address in ac 
183:    LDA  7,-178(7) 	CALL output
184:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
185:     ST  1,-5(1) 	Store old fp in ghost frame 
186:    LDA  1,-5(1) 	Load address of new frame 
187:    LDA  3,1(7) 	Return address in ac 
188:    LDA  7,-164(7) 	CALL outnl
189:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
190:     LD  3,-4(1) 	Load variable z
191:     ST  3,-3(1) 	Store variable y
192:     LD  4,-2(1) 	load lhs variable x
193:    SUB  3,4,3 	op -= 
194:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
195:     ST  1,-5(1) 	Store old fp in ghost frame 
196:     LD  3,-2(1) 	Load variable x
197:     ST  3,-7(1) 	Store parameter 
198:    LDA  1,-5(1) 	Load address of new frame 
199:    LDA  3,1(7) 	Return address in ac 
200:    LDA  7,-195(7) 	CALL output
201:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
202:     ST  1,-5(1) 	Store old fp in ghost frame 
203:     LD  3,-3(1) 	Load variable y
204:     ST  3,-7(1) 	Store parameter 
205:    LDA  1,-5(1) 	Load address of new frame 
206:    LDA  3,1(7) 	Return address in ac 
207:    LDA  7,-202(7) 	CALL output
208:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
209:     ST  1,-5(1) 	Store old fp in ghost frame 
210:     LD  3,-4(1) 	Load variable z
211:     ST  3,-7(1) 	Store parameter 
212:    LDA  1,-5(1) 	Load address of new frame 
213:    LDA  3,1(7) 	Return address in ac 
214:    LDA  7,-209(7) 	CALL output
215:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
216:     ST  1,-5(1) 	Store old fp in ghost frame 
217:    LDA  1,-5(1) 	Load address of new frame 
218:    LDA  3,1(7) 	Return address in ac 
219:    LDA  7,-195(7) 	CALL outnl
220:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
221:     LD  3,-4(1) 	Load variable z
222:     LD  4,-3(1) 	load lhs variable y
223:    SUB  3,4,3 	op -= 
224:     ST  3,-3(1) 	Store variable y
225:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
226:     ST  1,-5(1) 	Store old fp in ghost frame 
227:     LD  3,-2(1) 	Load variable x
228:     ST  3,-7(1) 	Store parameter 
229:    LDA  1,-5(1) 	Load address of new frame 
230:    LDA  3,1(7) 	Return address in ac 
231:    LDA  7,-226(7) 	CALL output
232:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
233:     ST  1,-5(1) 	Store old fp in ghost frame 
234:     LD  3,-3(1) 	Load variable y
235:     ST  3,-7(1) 	Store parameter 
236:    LDA  1,-5(1) 	Load address of new frame 
237:    LDA  3,1(7) 	Return address in ac 
238:    LDA  7,-233(7) 	CALL output
239:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
240:     ST  1,-5(1) 	Store old fp in ghost frame 
241:     LD  3,-4(1) 	Load variable z
242:     ST  3,-7(1) 	Store parameter 
243:    LDA  1,-5(1) 	Load address of new frame 
244:    LDA  3,1(7) 	Return address in ac 
245:    LDA  7,-240(7) 	CALL output
246:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
247:     ST  1,-5(1) 	Store old fp in ghost frame 
248:    LDA  1,-5(1) 	Load address of new frame 
249:    LDA  3,1(7) 	Return address in ac 
250:    LDA  7,-226(7) 	CALL outnl
251:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
252:     LD  3,-4(1) 	Load variable z
253:     LD  4,-3(1) 	load lhs variable y
254:    SUB  3,4,3 	op -= 
255:     ST  3,-3(1) 	Store variable y
256:     LD  4,-2(1) 	load lhs variable x
257:    SUB  3,4,3 	op -= 
258:     ST  3,-2(1) 	Store variable x
* EXPRESSION STMT
259:     ST  1,-5(1) 	Store old fp in ghost frame 
260:     LD  3,-2(1) 	Load variable x
261:     ST  3,-7(1) 	Store parameter 
262:    LDA  1,-5(1) 	Load address of new frame 
263:    LDA  3,1(7) 	Return address in ac 
264:    LDA  7,-259(7) 	CALL output
265:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
266:     ST  1,-5(1) 	Store old fp in ghost frame 
267:     LD  3,-3(1) 	Load variable y
268:     ST  3,-7(1) 	Store parameter 
269:    LDA  1,-5(1) 	Load address of new frame 
270:    LDA  3,1(7) 	Return address in ac 
271:    LDA  7,-266(7) 	CALL output
272:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
273:     ST  1,-5(1) 	Store old fp in ghost frame 
274:     LD  3,-4(1) 	Load variable z
275:     ST  3,-7(1) 	Store parameter 
276:    LDA  1,-5(1) 	Load address of new frame 
277:    LDA  3,1(7) 	Return address in ac 
278:    LDA  7,-273(7) 	CALL output
279:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
280:     ST  1,-5(1) 	Store old fp in ghost frame 
281:    LDA  1,-5(1) 	Load address of new frame 
282:    LDA  3,1(7) 	Return address in ac 
283:    LDA  7,-259(7) 	CALL outnl
284:    LDA  3,0(2) 	Save the result in ac 
* RETURN
285:    LDA  2,0(3) 	Copy result to rt register 
286:     LD  3,-1(1) 	Load return address 
287:     LD  1,0(1) 	Adjust fp 
288:    LDA  7,0(3) 	Return 
* END compound statement
* Add standard closing in case there is no return statement
289:    LDC  2,0(6) 	Set return value to 0 
290:     LD  3,-1(1) 	Load return address 
291:     LD  1,0(1) 	Adjust fp 
292:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,292(7) 	Jump to init 
* BEGIN Init
293:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
294:    LDA  1,0(0) 	set first frame at end of globals 
295:     ST  1,0(1) 	store old fp (point to self) 
296:    LDA  3,1(7) 	Return address in ac 
297:    LDA  7,-268(7) 	Jump to main 
298:   HALT  0,0,0 	DONE! 
* END Init
