* C- compiler version C-F07
* Author: Heyan Huang
* Backend adapted from work by Jorge Williams (2001)
* File compiled:  mod.tm
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
* EXPRESSION STMT
 31:     ST  1,-2(1) 	Store old frame in ghost frame 
 32:    LDC  3,10(6) 	Load constant 
 33:     ST  3,-4(1) 	Save left side 
 34:    LDC  3,1(6) 	Load constant 
 35:     LD  4,-4(1) 	Load left into ac1 
 36:     ST  3,-4(1) 	Store parameter 
 37:    LDA  1,-2(1) 	Load address of new frame 
 38:    LDA  3,1(7) 	Return address in ac 
 39:    LDA  7,-34(7) 	CALL output
 40:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 41:     ST  1,-2(1) 	Store old frame in ghost frame 
 42:    LDC  3,10(6) 	Load constant 
 43:     ST  3,-4(1) 	Save left side 
 44:    LDC  3,2(6) 	Load constant 
 45:     LD  4,-4(1) 	Load left into ac1 
 46:     ST  3,-4(1) 	Store parameter 
 47:    LDA  1,-2(1) 	Load address of new frame 
 48:    LDA  3,1(7) 	Return address in ac 
 49:    LDA  7,-44(7) 	CALL output
 50:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 51:     ST  1,-2(1) 	Store old frame in ghost frame 
 52:    LDC  3,10(6) 	Load constant 
 53:     ST  3,-4(1) 	Save left side 
 54:    LDC  3,3(6) 	Load constant 
 55:     LD  4,-4(1) 	Load left into ac1 
 56:     ST  3,-4(1) 	Store parameter 
 57:    LDA  1,-2(1) 	Load address of new frame 
 58:    LDA  3,1(7) 	Return address in ac 
 59:    LDA  7,-54(7) 	CALL output
 60:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 61:     ST  1,-2(1) 	Store old frame in ghost frame 
 62:    LDC  3,10(6) 	Load constant 
 63:     ST  3,-4(1) 	Save left side 
 64:    LDC  3,4(6) 	Load constant 
 65:     LD  4,-4(1) 	Load left into ac1 
 66:     ST  3,-4(1) 	Store parameter 
 67:    LDA  1,-2(1) 	Load address of new frame 
 68:    LDA  3,1(7) 	Return address in ac 
 69:    LDA  7,-64(7) 	CALL output
 70:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 71:     ST  1,-2(1) 	Store old frame in ghost frame 
 72:    LDC  3,10(6) 	Load constant 
 73:     ST  3,-4(1) 	Save left side 
 74:    LDC  3,5(6) 	Load constant 
 75:     LD  4,-4(1) 	Load left into ac1 
 76:     ST  3,-4(1) 	Store parameter 
 77:    LDA  1,-2(1) 	Load address of new frame 
 78:    LDA  3,1(7) 	Return address in ac 
 79:    LDA  7,-74(7) 	CALL output
 80:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 81:     ST  1,-2(1) 	Store old frame in ghost frame 
 82:    LDA  1,-2(1) 	Load address of new frame 
 83:    LDA  3,1(7) 	Return address in ac 
 84:    LDA  7,-60(7) 	CALL outnl
 85:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 86:     ST  1,-2(1) 	Store old frame in ghost frame 
 87:    LDC  3,10(6) 	Load constant 
 88:     ST  3,-4(1) 	Save left side 
 89:    LDC  3,10(6) 	Load constant 
 90:     LD  4,-4(1) 	Load left into ac1 
 91:     ST  3,-4(1) 	Store parameter 
 92:    LDA  1,-2(1) 	Load address of new frame 
 93:    LDA  3,1(7) 	Return address in ac 
 94:    LDA  7,-89(7) 	CALL output
 95:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
 96:     ST  1,-2(1) 	Store old frame in ghost frame 
 97:    LDC  3,10(6) 	Load constant 
 98:     ST  3,-4(1) 	Save left side 
 99:    LDC  3,11(6) 	Load constant 
100:     LD  4,-4(1) 	Load left into ac1 
101:     ST  3,-4(1) 	Store parameter 
102:    LDA  1,-2(1) 	Load address of new frame 
103:    LDA  3,1(7) 	Return address in ac 
104:    LDA  7,-99(7) 	CALL output
105:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
106:     ST  1,-2(1) 	Store old frame in ghost frame 
107:    LDA  1,-2(1) 	Load address of new frame 
108:    LDA  3,1(7) 	Return address in ac 
109:    LDA  7,-85(7) 	CALL outnl
110:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
111:     ST  1,-2(1) 	Store old frame in ghost frame 
112:    LDC  3,0(6) 	Load constant 
113:     ST  3,-4(1) 	Save left side 
114:    LDC  3,1(6) 	Load constant 
115:     LD  4,-4(1) 	Load left into ac1 
116:     ST  3,-4(1) 	Store parameter 
117:    LDA  1,-2(1) 	Load address of new frame 
118:    LDA  3,1(7) 	Return address in ac 
119:    LDA  7,-114(7) 	CALL output
120:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
121:     ST  1,-2(1) 	Store old frame in ghost frame 
122:    LDA  1,-2(1) 	Load address of new frame 
123:    LDA  3,1(7) 	Return address in ac 
124:    LDA  7,-100(7) 	CALL outnl
125:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
126:     ST  1,-2(1) 	Store old frame in ghost frame 
127:    LDC  3,10(6) 	Load constant 
128:    LDC  4,0(6) 	Load 0 
129:    SUB  3,4,3 	Op unary - 
130:     ST  3,-4(1) 	Save left side 
131:    LDC  3,1(6) 	Load constant 
132:     LD  4,-4(1) 	Load left into ac1 
133:     ST  3,-4(1) 	Store parameter 
134:    LDA  1,-2(1) 	Load address of new frame 
135:    LDA  3,1(7) 	Return address in ac 
136:    LDA  7,-131(7) 	CALL output
137:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
138:     ST  1,-2(1) 	Store old frame in ghost frame 
139:    LDC  3,10(6) 	Load constant 
140:    LDC  4,0(6) 	Load 0 
141:    SUB  3,4,3 	Op unary - 
142:     ST  3,-4(1) 	Save left side 
143:    LDC  3,2(6) 	Load constant 
144:     LD  4,-4(1) 	Load left into ac1 
145:     ST  3,-4(1) 	Store parameter 
146:    LDA  1,-2(1) 	Load address of new frame 
147:    LDA  3,1(7) 	Return address in ac 
148:    LDA  7,-143(7) 	CALL output
149:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
150:     ST  1,-2(1) 	Store old frame in ghost frame 
151:    LDC  3,10(6) 	Load constant 
152:    LDC  4,0(6) 	Load 0 
153:    SUB  3,4,3 	Op unary - 
154:     ST  3,-4(1) 	Save left side 
155:    LDC  3,3(6) 	Load constant 
156:     LD  4,-4(1) 	Load left into ac1 
157:     ST  3,-4(1) 	Store parameter 
158:    LDA  1,-2(1) 	Load address of new frame 
159:    LDA  3,1(7) 	Return address in ac 
160:    LDA  7,-155(7) 	CALL output
161:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
162:     ST  1,-2(1) 	Store old frame in ghost frame 
163:    LDC  3,10(6) 	Load constant 
164:    LDC  4,0(6) 	Load 0 
165:    SUB  3,4,3 	Op unary - 
166:     ST  3,-4(1) 	Save left side 
167:    LDC  3,4(6) 	Load constant 
168:     LD  4,-4(1) 	Load left into ac1 
169:     ST  3,-4(1) 	Store parameter 
170:    LDA  1,-2(1) 	Load address of new frame 
171:    LDA  3,1(7) 	Return address in ac 
172:    LDA  7,-167(7) 	CALL output
173:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
174:     ST  1,-2(1) 	Store old frame in ghost frame 
175:    LDC  3,10(6) 	Load constant 
176:    LDC  4,0(6) 	Load 0 
177:    SUB  3,4,3 	Op unary - 
178:     ST  3,-4(1) 	Save left side 
179:    LDC  3,5(6) 	Load constant 
180:     LD  4,-4(1) 	Load left into ac1 
181:     ST  3,-4(1) 	Store parameter 
182:    LDA  1,-2(1) 	Load address of new frame 
183:    LDA  3,1(7) 	Return address in ac 
184:    LDA  7,-179(7) 	CALL output
185:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
186:     ST  1,-2(1) 	Store old frame in ghost frame 
187:    LDA  1,-2(1) 	Load address of new frame 
188:    LDA  3,1(7) 	Return address in ac 
189:    LDA  7,-165(7) 	CALL outnl
190:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
191:     ST  1,-2(1) 	Store old frame in ghost frame 
192:    LDC  3,10(6) 	Load constant 
193:    LDC  4,0(6) 	Load 0 
194:    SUB  3,4,3 	Op unary - 
195:     ST  3,-4(1) 	Save left side 
196:    LDC  3,10(6) 	Load constant 
197:     LD  4,-4(1) 	Load left into ac1 
198:     ST  3,-4(1) 	Store parameter 
199:    LDA  1,-2(1) 	Load address of new frame 
200:    LDA  3,1(7) 	Return address in ac 
201:    LDA  7,-196(7) 	CALL output
202:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
203:     ST  1,-2(1) 	Store old frame in ghost frame 
204:    LDC  3,10(6) 	Load constant 
205:    LDC  4,0(6) 	Load 0 
206:    SUB  3,4,3 	Op unary - 
207:     ST  3,-4(1) 	Save left side 
208:    LDC  3,11(6) 	Load constant 
209:     LD  4,-4(1) 	Load left into ac1 
210:     ST  3,-4(1) 	Store parameter 
211:    LDA  1,-2(1) 	Load address of new frame 
212:    LDA  3,1(7) 	Return address in ac 
213:    LDA  7,-208(7) 	CALL output
214:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
215:     ST  1,-2(1) 	Store old frame in ghost frame 
216:    LDA  1,-2(1) 	Load address of new frame 
217:    LDA  3,1(7) 	Return address in ac 
218:    LDA  7,-194(7) 	CALL outnl
219:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
220:     ST  1,-2(1) 	Store old frame in ghost frame 
221:    LDC  3,331(6) 	Load constant 
222:     ST  3,-4(1) 	Save left side 
223:    LDC  3,31(6) 	Load constant 
224:     LD  4,-4(1) 	Load left into ac1 
225:     ST  3,-4(1) 	Store parameter 
226:    LDA  1,-2(1) 	Load address of new frame 
227:    LDA  3,1(7) 	Return address in ac 
228:    LDA  7,-223(7) 	CALL output
229:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
230:     ST  1,-2(1) 	Store old frame in ghost frame 
231:    LDC  3,331(6) 	Load constant 
232:     ST  3,-4(1) 	Save left side 
233:    LDC  3,31(6) 	Load constant 
234:    LDC  4,0(6) 	Load 0 
235:    SUB  3,4,3 	Op unary - 
236:     LD  4,-4(1) 	Load left into ac1 
237:     ST  3,-4(1) 	Store parameter 
238:    LDA  1,-2(1) 	Load address of new frame 
239:    LDA  3,1(7) 	Return address in ac 
240:    LDA  7,-235(7) 	CALL output
241:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
242:     ST  1,-2(1) 	Store old frame in ghost frame 
243:    LDC  3,331(6) 	Load constant 
244:    LDC  4,0(6) 	Load 0 
245:    SUB  3,4,3 	Op unary - 
246:     ST  3,-4(1) 	Save left side 
247:    LDC  3,31(6) 	Load constant 
248:     LD  4,-4(1) 	Load left into ac1 
249:     ST  3,-4(1) 	Store parameter 
250:    LDA  1,-2(1) 	Load address of new frame 
251:    LDA  3,1(7) 	Return address in ac 
252:    LDA  7,-247(7) 	CALL output
253:    LDA  3,0(2) 	Save the result in ac 
* EXPRESSION STMT
254:     ST  1,-2(1) 	Store old frame in ghost frame 
255:    LDC  3,331(6) 	Load constant 
256:    LDC  4,0(6) 	Load 0 
257:    SUB  3,4,3 	Op unary - 
258:     ST  3,-4(1) 	Save left side 
259:    LDC  3,31(6) 	Load constant 
260:    LDC  4,0(6) 	Load 0 
261:    SUB  3,4,3 	Op unary - 
262:     LD  4,-4(1) 	Load left into ac1 
263:     ST  3,-4(1) 	Store parameter 
264:    LDA  1,-2(1) 	Load address of new frame 
265:    LDA  3,1(7) 	Return address in ac 
266:    LDA  7,-261(7) 	CALL output
267:    LDA  3,0(2) 	Save the result in ac 
* END compound statement
* Add standard closing in case there is no return statement
268:    LDC  2,0(6) 	Set return value to 0 
269:     LD  3,-1(1) 	Load return address 
270:     LD  1,0(1) 	Adjust fp 
271:    LDA  7,0(3) 	Return 
* END function main
  0:    LDA  7,271(7) 	Jump to init 
* BEGIN Init
272:     LD  0,0(0) 	Set the global pointer 
273:    LDA  1,0(0) 	set first frame at end of globals 
274:     ST  1,0(1) 	store old fp (point to self) 
275:    LDA  3,1(7) 	Return address in ac 
276:    LDA  7,-247(7) 	Jump to main 
277:   HALT  0,0,0 	DONE! 
* END Init
