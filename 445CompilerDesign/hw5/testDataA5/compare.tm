* C- compiler version C-F10
* Built: Nov 27, 2010
* Author: Robert B. Heckendorn
* File compiled:  compare.c-
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
 31:     ST  1,-2(1) 	Store old fp in ghost frame 
 32:    LDC  3,1(6) 	Load constant 
 33:     ST  3,-4(1) 	Save left side 
 34:    LDC  3,2(6) 	Load constant 
 35:     LD  4,-4(1) 	Load left into ac1 
 36:    SUB  4,4,3 	Op < 
 37:    LDC  3,1(6) 	True case 
 38:    JLT  4,1(7) 	Jump if true 
 39:    LDC  3,0(6) 	False case 
 40:     ST  3,-4(1) 	Store parameter 
 41:    LDA  1,-2(1) 	Load address of new frame 
 42:    LDA  3,1(7) 	Return address in ac 
 43:    LDA  7,-26(7) 	CALL outputb
 44:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 45:     ST  1,-2(1) 	Store old fp in ghost frame 
 46:    LDC  3,2(6) 	Load constant 
 47:     ST  3,-4(1) 	Save left side 
 48:    LDC  3,2(6) 	Load constant 
 49:     LD  4,-4(1) 	Load left into ac1 
 50:    SUB  4,4,3 	Op < 
 51:    LDC  3,1(6) 	True case 
 52:    JLT  4,1(7) 	Jump if true 
 53:    LDC  3,0(6) 	False case 
 54:     ST  3,-4(1) 	Store parameter 
 55:    LDA  1,-2(1) 	Load address of new frame 
 56:    LDA  3,1(7) 	Return address in ac 
 57:    LDA  7,-40(7) 	CALL outputb
 58:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 59:     ST  1,-2(1) 	Store old fp in ghost frame 
 60:    LDC  3,3(6) 	Load constant 
 61:     ST  3,-4(1) 	Save left side 
 62:    LDC  3,2(6) 	Load constant 
 63:     LD  4,-4(1) 	Load left into ac1 
 64:    SUB  4,4,3 	Op < 
 65:    LDC  3,1(6) 	True case 
 66:    JLT  4,1(7) 	Jump if true 
 67:    LDC  3,0(6) 	False case 
 68:     ST  3,-4(1) 	Store parameter 
 69:    LDA  1,-2(1) 	Load address of new frame 
 70:    LDA  3,1(7) 	Return address in ac 
 71:    LDA  7,-54(7) 	CALL outputb
 72:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 73:     ST  1,-2(1) 	Store old fp in ghost frame 
 74:    LDC  3,1(6) 	Load constant 
 75:     ST  3,-4(1) 	Save left side 
 76:    LDC  3,2(6) 	Load constant 
 77:     LD  4,-4(1) 	Load left into ac1 
 78:    SUB  4,4,3 	Op == 
 79:    LDC  3,1(6) 	True case 
 80:    JEQ  4,1(7) 	Jump if true 
 81:    LDC  3,0(6) 	False case 
 82:     ST  3,-4(1) 	Store parameter 
 83:    LDA  1,-2(1) 	Load address of new frame 
 84:    LDA  3,1(7) 	Return address in ac 
 85:    LDA  7,-68(7) 	CALL outputb
 86:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 87:     ST  1,-2(1) 	Store old fp in ghost frame 
 88:    LDC  3,2(6) 	Load constant 
 89:     ST  3,-4(1) 	Save left side 
 90:    LDC  3,2(6) 	Load constant 
 91:     LD  4,-4(1) 	Load left into ac1 
 92:    SUB  4,4,3 	Op == 
 93:    LDC  3,1(6) 	True case 
 94:    JEQ  4,1(7) 	Jump if true 
 95:    LDC  3,0(6) 	False case 
 96:     ST  3,-4(1) 	Store parameter 
 97:    LDA  1,-2(1) 	Load address of new frame 
 98:    LDA  3,1(7) 	Return address in ac 
 99:    LDA  7,-82(7) 	CALL outputb
100:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
101:     ST  1,-2(1) 	Store old fp in ghost frame 
102:    LDC  3,3(6) 	Load constant 
103:     ST  3,-4(1) 	Save left side 
104:    LDC  3,2(6) 	Load constant 
105:     LD  4,-4(1) 	Load left into ac1 
106:    SUB  4,4,3 	Op == 
107:    LDC  3,1(6) 	True case 
108:    JEQ  4,1(7) 	Jump if true 
109:    LDC  3,0(6) 	False case 
110:     ST  3,-4(1) 	Store parameter 
111:    LDA  1,-2(1) 	Load address of new frame 
112:    LDA  3,1(7) 	Return address in ac 
113:    LDA  7,-96(7) 	CALL outputb
114:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
115:     ST  1,-2(1) 	Store old fp in ghost frame 
116:    LDC  3,1(6) 	Load constant 
117:     ST  3,-4(1) 	Save left side 
118:    LDC  3,2(6) 	Load constant 
119:     LD  4,-4(1) 	Load left into ac1 
120:    SUB  4,4,3 	Op > 
121:    LDC  3,1(6) 	True case 
122:    JGT  4,1(7) 	Jump if true 
123:    LDC  3,0(6) 	False case 
124:     ST  3,-4(1) 	Store parameter 
125:    LDA  1,-2(1) 	Load address of new frame 
126:    LDA  3,1(7) 	Return address in ac 
127:    LDA  7,-110(7) 	CALL outputb
128:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
129:     ST  1,-2(1) 	Store old fp in ghost frame 
130:    LDC  3,2(6) 	Load constant 
131:     ST  3,-4(1) 	Save left side 
132:    LDC  3,2(6) 	Load constant 
133:     LD  4,-4(1) 	Load left into ac1 
134:    SUB  4,4,3 	Op > 
135:    LDC  3,1(6) 	True case 
136:    JGT  4,1(7) 	Jump if true 
137:    LDC  3,0(6) 	False case 
138:     ST  3,-4(1) 	Store parameter 
139:    LDA  1,-2(1) 	Load address of new frame 
140:    LDA  3,1(7) 	Return address in ac 
141:    LDA  7,-124(7) 	CALL outputb
142:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
143:     ST  1,-2(1) 	Store old fp in ghost frame 
144:    LDC  3,3(6) 	Load constant 
145:     ST  3,-4(1) 	Save left side 
146:    LDC  3,2(6) 	Load constant 
147:     LD  4,-4(1) 	Load left into ac1 
148:    SUB  4,4,3 	Op > 
149:    LDC  3,1(6) 	True case 
150:    JGT  4,1(7) 	Jump if true 
151:    LDC  3,0(6) 	False case 
152:     ST  3,-4(1) 	Store parameter 
153:    LDA  1,-2(1) 	Load address of new frame 
154:    LDA  3,1(7) 	Return address in ac 
155:    LDA  7,-138(7) 	CALL outputb
156:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
157:     ST  1,-2(1) 	Store old fp in ghost frame 
158:    LDC  3,1(6) 	Load constant 
159:     ST  3,-4(1) 	Save left side 
160:    LDC  3,2(6) 	Load constant 
161:     LD  4,-4(1) 	Load left into ac1 
162:    SUB  4,4,3 	Op <= 
163:    LDC  3,1(6) 	True case 
164:    JLE  4,1(7) 	Jump if true 
165:    LDC  3,0(6) 	False case 
166:     ST  3,-4(1) 	Store parameter 
167:    LDA  1,-2(1) 	Load address of new frame 
168:    LDA  3,1(7) 	Return address in ac 
169:    LDA  7,-152(7) 	CALL outputb
170:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
171:     ST  1,-2(1) 	Store old fp in ghost frame 
172:    LDC  3,2(6) 	Load constant 
173:     ST  3,-4(1) 	Save left side 
174:    LDC  3,2(6) 	Load constant 
175:     LD  4,-4(1) 	Load left into ac1 
176:    SUB  4,4,3 	Op <= 
177:    LDC  3,1(6) 	True case 
178:    JLE  4,1(7) 	Jump if true 
179:    LDC  3,0(6) 	False case 
180:     ST  3,-4(1) 	Store parameter 
181:    LDA  1,-2(1) 	Load address of new frame 
182:    LDA  3,1(7) 	Return address in ac 
183:    LDA  7,-166(7) 	CALL outputb
184:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
185:     ST  1,-2(1) 	Store old fp in ghost frame 
186:    LDC  3,3(6) 	Load constant 
187:     ST  3,-4(1) 	Save left side 
188:    LDC  3,2(6) 	Load constant 
189:     LD  4,-4(1) 	Load left into ac1 
190:    SUB  4,4,3 	Op <= 
191:    LDC  3,1(6) 	True case 
192:    JLE  4,1(7) 	Jump if true 
193:    LDC  3,0(6) 	False case 
194:     ST  3,-4(1) 	Store parameter 
195:    LDA  1,-2(1) 	Load address of new frame 
196:    LDA  3,1(7) 	Return address in ac 
197:    LDA  7,-180(7) 	CALL outputb
198:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
199:     ST  1,-2(1) 	Store old fp in ghost frame 
200:    LDC  3,1(6) 	Load constant 
201:     ST  3,-4(1) 	Save left side 
202:    LDC  3,2(6) 	Load constant 
203:     LD  4,-4(1) 	Load left into ac1 
204:    SUB  4,4,3 	Op >= 
205:    LDC  3,1(6) 	True case 
206:    JGE  4,1(7) 	Jump if true 
207:    LDC  3,0(6) 	False case 
208:     ST  3,-4(1) 	Store parameter 
209:    LDA  1,-2(1) 	Load address of new frame 
210:    LDA  3,1(7) 	Return address in ac 
211:    LDA  7,-194(7) 	CALL outputb
212:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
213:     ST  1,-2(1) 	Store old fp in ghost frame 
214:    LDC  3,2(6) 	Load constant 
215:     ST  3,-4(1) 	Save left side 
216:    LDC  3,2(6) 	Load constant 
217:     LD  4,-4(1) 	Load left into ac1 
218:    SUB  4,4,3 	Op >= 
219:    LDC  3,1(6) 	True case 
220:    JGE  4,1(7) 	Jump if true 
221:    LDC  3,0(6) 	False case 
222:     ST  3,-4(1) 	Store parameter 
223:    LDA  1,-2(1) 	Load address of new frame 
224:    LDA  3,1(7) 	Return address in ac 
225:    LDA  7,-208(7) 	CALL outputb
226:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
227:     ST  1,-2(1) 	Store old fp in ghost frame 
228:    LDC  3,3(6) 	Load constant 
229:     ST  3,-4(1) 	Save left side 
230:    LDC  3,2(6) 	Load constant 
231:     LD  4,-4(1) 	Load left into ac1 
232:    SUB  4,4,3 	Op >= 
233:    LDC  3,1(6) 	True case 
234:    JGE  4,1(7) 	Jump if true 
235:    LDC  3,0(6) 	False case 
236:     ST  3,-4(1) 	Store parameter 
237:    LDA  1,-2(1) 	Load address of new frame 
238:    LDA  3,1(7) 	Return address in ac 
239:    LDA  7,-222(7) 	CALL outputb
240:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
241:     ST  1,-2(1) 	Store old fp in ghost frame 
242:    LDC  3,1(6) 	Load constant 
243:     ST  3,-4(1) 	Save left side 
244:    LDC  3,2(6) 	Load constant 
245:     LD  4,-4(1) 	Load left into ac1 
246:    SUB  3,4,3 	Op != 
247:    JEQ  3,1(7) 	Jump if true 
248:    LDC  3,1(6) 	True case 
249:     ST  3,-4(1) 	Store parameter 
250:    LDA  1,-2(1) 	Load address of new frame 
251:    LDA  3,1(7) 	Return address in ac 
252:    LDA  7,-235(7) 	CALL outputb
253:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
254:     ST  1,-2(1) 	Store old fp in ghost frame 
255:    LDC  3,2(6) 	Load constant 
256:     ST  3,-4(1) 	Save left side 
257:    LDC  3,2(6) 	Load constant 
258:     LD  4,-4(1) 	Load left into ac1 
259:    SUB  3,4,3 	Op != 
260:    JEQ  3,1(7) 	Jump if true 
261:    LDC  3,1(6) 	True case 
262:     ST  3,-4(1) 	Store parameter 
263:    LDA  1,-2(1) 	Load address of new frame 
264:    LDA  3,1(7) 	Return address in ac 
265:    LDA  7,-248(7) 	CALL outputb
266:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
267:     ST  1,-2(1) 	Store old fp in ghost frame 
268:    LDC  3,3(6) 	Load constant 
269:     ST  3,-4(1) 	Save left side 
270:    LDC  3,2(6) 	Load constant 
271:     LD  4,-4(1) 	Load left into ac1 
272:    SUB  3,4,3 	Op != 
273:    JEQ  3,1(7) 	Jump if true 
274:    LDC  3,1(6) 	True case 
275:     ST  3,-4(1) 	Store parameter 
276:    LDA  1,-2(1) 	Load address of new frame 
277:    LDA  3,1(7) 	Return address in ac 
278:    LDA  7,-261(7) 	CALL outputb
279:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
280:    LDC  2,0(6) 	Set return value to 0 
281:     LD  3,-1(1) 	Load return address 
282:     LD  1,0(1) 	Adjust fp 
283:    LDA  7,0(3) 	Return 
* END of function main
  0:    LDA  7,283(7) 	Jump to init 
* BEGIN Init
284:     LD  0,0(0) 	Set the global pointer 
* BEGIN init of global array sizes
* END init of global array sizes
285:    LDA  1,0(0) 	set first frame at end of globals 
286:     ST  1,0(1) 	store old fp (point to self) 
287:    LDA  3,1(7) 	Return address in ac 
288:    LDA  7,-259(7) 	Jump to main 
289:   HALT  0,0,0 	DONE! 
* END Init
